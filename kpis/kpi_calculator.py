# -*- coding: utf-8 -*-
"""
This class includes the basic functions for processing the results 
for BOPTEST simulations and generating the corresponding key performance 
indicators.

"""
# GENERAL PACKAGE IMPORT
# ----------------------
import matplotlib.pyplot as plt
import numpy as np
from alias import alias, aliased
from scipy.integrate import trapz
from flask._compat import iteritems
from collections import OrderedDict


@aliased
class KPI_calculator(object):
    '''
    This class calculates the KPIs as a post-process after 
    a test is complete. Upon deployment of the test case, 
    the module first uses the KPI JSON (kpis.json) to 
    associate model output names with the appropriate KPIs 
    through the specified KPI annotations. Upon called to 
    do so, the module is able to calculate and return the 
    KPIs using data stored from the test case run.
    The core KPIs are a subset of the KPIs that can be 
    obtained using this class and that are considered 
    essential for the comparison between two or more 
    test cases. This class also supports other methods for
    evaluation, plotting and post-processing of an already
    deployed test case.  
    This class is able to handle multiple test cases to
    enable an easier comparison between them. The test 
    cases handled by the class are stored in the 
    self.cases dictionary. 

    ''' 

    def __init__(self, testcase):
        """
        Initialize the KPI_calculator class
        
        Parameters
        ----------
        testcase: BOPTEST TestCase object
            object of an already deployed test case that
            contains the data stored from the test case run
        
        """
        
        # Keep track of the test cases cn in the KPI_calculator 
        # Object. The very first case will have cn=0.
        self.cn = None
        # self.cases is a dictionary with TestCase objects
        self.cases = OrderedDict()
        self.open_new_case(testcase)


    @alias('onc')
    def open_new_case(self, testcase):
        """
        Start a new case with the data from a deployed TestCase 
        object
        
        Parameters
        ----------
        testcase: BOPTEST TestCase object
            object of an already deployed test case that
            contains the data stored from the test case run
        """
        
        if self.cn is None:
            self.cn = 0
        else:
            self.cn += 1  
                
        self.cases[self.cn] = testcase
    
    
    @alias('ckpis')
    def get_core_kpis(self, cn=None):
        """
        Return the core KPIs of a test case.
        
        Parameters
        ----------
        cn: int, optional
            test case number, default = self.cn
        
        Returns 
        -------
        ckpis = dict
            Dictionary with the core KPIs, i.e., the KPIs
            that are considered essential for the comparison between
            two test cases
        """
        
        # cn = case number (int), tc = TestCase object
        if cn is None:
            cn = self.cn 
        
        ckpis = OrderedDict()
        ckpis['dis_tot'] = self.get_discomfort(cn=cn)
        ckpis['ene_tot'] = self.get_energy(cn=cn)
        
        return ckpis
        
    
    @alias('dis')
    def get_discomfort(self, lowersetp=273.15+20, uppersetp=273.15+26,
                       plot=False, cn=None):
        """
        The thermal discomfort is the integral of the deviation 
        of the temperature with respect to the predefined comfort 
        setpoint. Its units are of K*h.
        
        Parameters
        ----------
        setpoint: float
            temperature set point from which deviations are 
            penalized
        plot: boolean
            True if it it is desired to make plots related with
            the energy usage metrics
        cn: int, optional
            test case number, default = self.cn
            
        Returns
        -------
        dis_tot: float
            total discomfort accounted in this test case

        """
        
        # cn = case number (int), tc = TestCase object
        if cn is None:
            cn = self.cn 
        tc = self.cases[self.cn]
        
        if not hasattr(tc, 'dis_tree'):
            dis_tot = 0
            dis_dict = OrderedDict()
            for signal in tc.kpi_json['comfort']:
                data = np.array(tc.y_store[signal])
                dT_lower = lowersetp - data
                dT_lower[dT_lower<0]=0
                dT_upper = data - uppersetp
                dT_upper[dT_upper<0]=0
                dis_dict[signal[:-1]+'dTlower_y'] = \
                    trapz(dT_lower,tc.y_store['time'])/3600.
                dis_dict[signal[:-1]+'dTupper_y'] = \
                    trapz(dT_upper,tc.y_store['time'])/3600.
                dis_tot = dis_tot + \
                          dis_dict[signal[:-1]+'dTlower_y'] + \
                          dis_dict[signal[:-1]+'dTupper_y']
            
            tc.dis_tot  = dis_tot
            tc.dis_tree = self.get_dict_tree(dis_dict)
        
        else:
            dis_tot = tc.dis_tot
            
        if plot:
            self.plot_nested_pie(tc.dis_tree, metric='discomfort',
                                 units='K*h')
        
        return dis_tot
    

    @alias('ene')
    def get_energy(self, from_power=True, plot=False, cn=None):
        """
        This method returns the measure of the total building 
        energy use in kW*h when accounting for the sum of all 
        energy vectors present in the test case. The scenarios 
        defined in each test case determine which components 
        are added and the source data for the conversion 
        factors if required.
        
        Parameters
        ----------
        from_power: boolean
            True if we want to calculate the energy by 
            integrating the power. False if we want to get the
            energy as the sum of the energy read blocks in the
            model
        plot: boolean
            True if it it is desired to make plots related with
            the energy usage metrics
        cn: int, optional
            test case number, default = self.cn
        """
        
        # cn = case number (int), tc = TestCase object
        if cn is None:
            cn = self.cn 
        tc = self.cases[self.cn]
        
        if not hasattr(tc, 'ene_tree'):
            ene_tot = 0
            ene_dict = OrderedDict()
            if from_power:
                # Calculate total energy from power 
                # [returns KWh - assumes power measured in Watts]
                for signal in tc.kpi_json['power']:
                    pow_data = np.array(tc.y_store[signal])
                    ene_dict[signal] = \
                    trapz(pow_data,tc.y_store['time'])*2.77778e-7 # Convert to kWh
                    ene_tot = ene_tot + ene_dict[signal]
            else:
                # Calculate total energy 
                # [returns KWh - assumes energy measured in J]
                for signal in tc.kpi_json['energy']:
                    ene_dict[signal] = \
                    tc.y_store[signal][-1]*2.77778e-7 # Convert to kWh
                    ene_tot = ene_tot + ene_dict[signal]
                    
            tc.ene_tot  = ene_tot
            tc.ene_tree = self.get_dict_tree(ene_dict) 
            
        else:
            ene_tot = tc.ene_tot
            
        if plot:
            self.plot_nested_pie(tc.ene_tree, metric='energy use',
                                 units='kW*h')
        
        return ene_tot


    @alias('lfs')
    def get_load_factors(self, cn=None):
        """
        Calculate the load factor for every power signal
        
        Parameters
        ----------
        cn: int, optional
            test case number, default = self.cn
        """
        
        # cn = case number (int), tc = TestCase object
        if cn is None:
            cn = self.cn 
        tc = self.cases[self.cn]
        
        if not hasattr(tc, 'lfs'):
            lfs = OrderedDict()
            
            for signal in tc.kpi_json['power']:
                pow_data = np.array(tc.y_store[signal])
                avg_pow = pow_data.mean()
                max_pow = pow_data.max()
                try:
                    lfs[signal]=avg_pow/max_pow
                except ZeroDivisionError as err:
                    print("Error: {0}".format(err))
                    return
            
            tc.lfs = lfs
                
        else:
            lfs = tc.lfs
        
        return lfs

    
    @alias('pps')
    def get_power_peaks(self, cn=None):
        """
        Calculate the power peak for every power signal
        
        Parameters
        ----------
        cn: int, optional
            test case number, default = self.cn
        """
        
        # cn = case number (int), tc = TestCase object
        if cn is None:
            cn = self.cn 
        tc = self.cases[self.cn]
        
        if not hasattr(tc, 'pps'):
        
            pps = OrderedDict()
            
            for signal in tc.kpi_json['power']:
                pow_data = np.array(tc.y_store[signal])
                max_pow = pow_data.max()
                pps[signal]=max_pow
            
            tc.pps = pps
        
        else:
            pps = tc.pps
            
        return pps
                            
                            
    def get_dict_tree(self, dict_flat, sep='_'):
        """
        This method creates a dictionary tree from a 
        flat dictionary. A dictionary tree is a nested
        dictionary where each element contains other
        dictionaries which keys are the following 
        names of the strings in the keys of the 
        original dictionary and that are separated
        from each other with a 'sep' string case that
        can be specified.
        
        Parameters
        ----------
        dict_flat: dict
            dictionary containing only one layer of
            complexity. This means that the values of
            the dictionary do not contain any other
            dictionaries
        sep: string
            string that indicates different layers in 
            the keys of the original dictionary
            
        Returns
        -------
        dict_tree: dict
            nested dictionary with the different layers
            of complexity indicated by the 'sep' string
            in the keys of the original dictionary
        """
        
        # Initialize the dictionary tree
        dict_tree = OrderedDict()
        # Each element of the flat dictionary is a branch of the tree
        for element in dict_flat.keys():
            # Create an auxiliary variable to go through the branches of the tree
            actual_layer = dict_tree
            # Read every component in the branch except the last '_y' term
            components = element.split(sep)[:-1]
            # Grow the branch with a new dictionary if not the last component
            for component in components[:-1]:
                # Check if this component is already in this layer
                if component not in actual_layer.keys():
                    # Create a dictionary in this layer to keep growing the branch
                    actual_layer[component]=OrderedDict()
                # Shift the actual layer by one component
                actual_layer = actual_layer[component]
            # If last component, assign the flat dictionary value
            actual_layer[components[-1]] = dict_flat[element]
            
        return dict_tree
    
    
    def sum_dict(self, dictionary):
        """
        This method returns the sum of all values within a 
        nested dictionary that can contain float numbers 
        and/or other dictionaries containing the same type 
        of elements. It works in a recursive way.
        
        Parameters
        ----------
        dictionary: dict or float
            dictionary containing other dictionaries and/or
            float numbers. If it's a float it will return
            its value directly
            
        Returns
        -------    
        val: float
            value of the sum of all values within the 
            nested dictionary
        """
        
        # Initialize the sum
        val=0.
        # If dictionary is a float we have arrived to an
        # end point and we want to return its value
        if isinstance(dictionary, float):
            
            return dictionary
        
        # If dictionary is still a dictionary we should 
        # keep searching for an end point with a float
        elif isinstance(dictionary, dict):
            for k in dictionary.keys():
                # Sum the values within this dictionary
                val += self.sum_dict(dictionary=dictionary[k])
                
            return val
    
    
    def count_elements(self, dictionary):
        """
        This methods counts the number of end points in 
        a nested dictionary. An end point is considered
        to be a float number instead of a new dictionary
        layer.
        
        Parameters
        ----------
        dictionary: dict
            dictionary for which we want to count the 
            
        Returns
        -------
        n: integer
            number of total end points within the nested
            dictionary
        """
        
        # Initialize the counter
        n=0
        # If dictionary is a float we have arrived to an
        # end point and we want to sum one element
        if isinstance(dictionary, float):
            
            return 1
        
        # If dictionary is still a dictionary we should 
        # keep searching for an end point 
        elif isinstance(dictionary, dict):
            for k in dictionary.keys():
                # Count the elements within this dictionary
                try:
                    n += self.count_elements(dictionary=dictionary[k])
                except:
                    pass
            return n
        
        
    def parse_color_indexes(self, dictionary, min_index=0, max_index=260):
        """
        This method parses the color indexes for a nested pie chart
        and according to the number of elements within the dictionary
        that is going to be plotted. It will provide an equally 
        distributed range of color indexes between a minimum value
        and a maximum value. These indexes can then be used for a 
        matplotlib color map in order to provide an smooth color 
        variation within the chromatic circle. Notice that with 
        min_index and max_index it can be customized the color range
        to be used in the chart. These indexes must lay between the 
        minimum and maximum indexes of the color map used.
        
        Parameters
        ----------
        dictionary: dict
            dictionary for which the pie chart is going to be 
            plotted
        min_index: integer
            minimum value of the index that is going to be used
        max_index: integer
            maximum value of the index that is going to be used
        
        """
        
        n = self.count_elements(dictionary)
        
        return np.linspace(min_index, max_index, n+1).astype(int)
        
        
    @alias('pie')
    def plot_nested_pie(self, dictionary, ax=None, radius=1., delta=0.2,
                        dontlabel=None, breakdonut=True, 
                        metric = 'energy use', units = 'kW*h'):
        """
        This method appends a pie plot from a nested dictionary
        to an axes of matplotlib object. If all the elements
        of the dictionary are float values it will make a simple
        pie plot with those values. If there are other nested
        dictionaries it will continue plotting them in a nested
        pie plot.
         
        Parameters
        ----------
        dictionary: dict
            dictionary containing other dictionaries and/or
            float numbers for which the pie plot is going to be
            created
        ax: matplotlib axes object
            axes object where the plot is going to be appended
        radius: float
            radius of the outer layer of the pie plot
        delta: float
            desired difference between the radius of two 
            consecutive pie plot layers
        dontlabel: list
            list of items to not be labeled for more clarity
        breakdonut: boolean
            if true it will not show the non labeled slices
        metric: string
            indicates the metric that is being plotted. Notice that
            this is only used for the title of the plot
        units: string
            indicates the units used for the metric. Notice that
            this is only used for the title of the plot
        """
        
        # Initialize the pie plot if not initialized yet
        if ax is None:
            _, ax = plt.subplots()
        if dontlabel is None:
            dontlabel = []
        # Get the color map to be used in this pie
        cmap = plt.get_cmap('rainbow')
        labels=[]
        # Parse the color indexes to be used in this pie
        color_indexes  = self.parse_color_indexes(dictionary)
        # Initialize the color indexes to be used in this layer
        cindexes_layer = [0]
        # Initialize the list of values to plot in this layer
        vals = []
        # Initialize a new dictionary for the next inner layer
        new_dict = OrderedDict()
        # Initialize the shifts for the required indices
        shift = np.zeros(len(dictionary.keys()))
        # Initialize a counter for the loop
        i=0
        # Go through every component in this layer
        for k_outer,v_outer in iteritems(dictionary):
            # Calculate the slice size of this component 
            vals.append(self.sum_dict(v_outer))
            # Append the new label if not end point
            last_key = k_outer.split('_')[-1]
            label = last_key if not any(k_outer.startswith(dntlbl) \
                                        for dntlbl in dontlabel) else ''
            labels.append(label)
            # Check if this component has nested dictionaries
            if isinstance(v_outer, dict):
                # If it has, add them to the new dictionary
                for k_inner,v_inner in iteritems(v_outer):
                    # Give a unique nested key name to it
                    new_dict[k_outer+'_'+k_inner] = v_inner
            # Check if this component is already a float end point 
            elif isinstance(v_outer, float):
                # If it is, add it to the new dictionary
                new_dict[k_outer] = v_outer
            # Count the number of elements in this component
            n = self.count_elements(v_outer)
            # Append the index of this component according to its
            # number of components in order to follow a progressive
            # chromatic circle
            cindexes_layer.append(cindexes_layer[-1]+n)
            # Make a shift if this is not an end point to do not use
            # the same color as the underlying end points. Make this
            # shift something characteristic of this layer by making
            # use of its radius 
            shift[i] = 0 if n==1 else 60*radius
            # Do not label this slice in the next layer if this was
            # already an end point
            if n==1: 
                dontlabel.append(k_outer) 
            # Increase counter
            i+=1
        
        # Assign the colors to every component in this layer
        colors = cmap((color_indexes[[cindexes_layer[:-1]]] + \
                       shift).astype(int))
        
        # If breakdonut=True show a blank in the unlabeled items
        if breakdonut:
            for j,l in enumerate(labels):
                if l is '': colors[j]=[0., 0., 0., 0.]   
                
        # Append the obtained slice values of this layer to the axes
        ax.pie(np.array(vals), radius=radius, labels=labels, 
               labeldistance=radius, colors=colors,
               wedgeprops=dict(width=0.2, edgecolor='w', linewidth=0.3))
        
        # Keep nesting if there is still any dictionary between the values
        if not all(isinstance(v, float) for v in dictionary.values()):
            self.plot_nested_pie(new_dict, ax, radius=radius-delta,
                                 dontlabel=dontlabel, metric=metric, 
                                 units=units)
        # Don't continue nesting if all components were float end points 
        else:
            plt.title('Total {metric} = {value:.2f} {units}'.format(\
                metric=metric, value=self.sum_dict(dictionary), units=units))
            # Equal aspect ratio ensures that pie is drawn as a circle
            ax.axis('equal')
            plt.show()
            
            
if __name__ == "__main__":
    """Nested pie chart example"""
    ene_dict = {'HVAC_damper_y':50.,
                'HVAC_HP_component1_y':160.,
                'HVAC_pump_y':25.,
                'Distrib_component1_y':80.,
                'HVAC_HP_component2_y':30.,
                'Distrib_component2_y':80.,
                'Lighting_floor1_lamp1_coponent1_y':15.,
                'Lighting_floor1_lamp1_coponent2_y':23.,
                'Lighting_floor1_lamp2_y':87.,
                'Lighting_floor2_y':37.}  
    
    cal = KPI_calculator(testcase=None)
    ene_tree = cal.get_dict_tree(ene_dict)
    cal.pie(ene_tree)