import matplotlib.pyplot as plt
import numpy as np
from flask._compat import iteritems
from collections import OrderedDict


def get_dict_tree(dict_flat, sep='_'):
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


def sum_dict(dictionary):
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
            val += sum_dict(dictionary=dictionary[k])
            
        return val


def count_elements(dictionary):
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
                n += count_elements(dictionary=dictionary[k])
            except:
                pass
        return n
    
    
def parse_color_indexes(dictionary, min_index=0, max_index=260):
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
    
    n = count_elements(dictionary)
    
    return np.linspace(min_index, max_index, n+1).astype(int)
    

def plot_nested_pie(dictionary,ax=None,radius=1.,delta_radius=0.2):
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
    delta_radius: float
        desired difference between the radius of two 
        consecutive pie plot layers
    """
    
    # Initialize the pie plot if not initialized yet
    if ax is None:
        _, ax = plt.subplots()
    # Get the color map to be used in this pie
    cmap = plt.get_cmap('rainbow')
    # Parse the color indexes to be used in this pie
    color_indexes  = parse_color_indexes(dictionary)
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
        vals.append(sum_dict(v_outer))
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
        n = count_elements(v_outer)
        # Append the index of this component according to its
        # number of components in order to follow a progressive
        # chromatic circle
        cindexes_layer.append(cindexes_layer[-1]+n)
        # Make a shift if this is not an end point to do not use
        # the same color as the underlying end points. Make this
        # shift something characteristic of this layer by making
        # use of its radius 
        shift[i] = 0 if n==1 else 60*radius
        # Append the new label if it  
        # Increase counter
        i+=1
        
    # Append the obtained slice values of this layer to the axes
    ax.pie(np.array(vals), radius=radius, labels=dictionary.keys(), labeldistance=radius*0.9,
           colors=cmap((color_indexes[[cindexes_layer[:-1]]] + shift).astype(int)),
           wedgeprops=dict(width=0.2, edgecolor='w', linewidth=0))
    
    # Keep nesting if there is still any dictionary between the values
    if not all(isinstance(v, float) for v in dictionary.values()):
        plot_nested_pie(new_dict, ax, radius=radius-delta_radius)
    # Don't continue nesting if all components were float end points 
    else:
        pass
    
    # Equal aspect ratio ensures that pie is drawn as a circle
    ax.axis('equal')
    plt.show()
   
    
power_usage = {'HVAC_damper_y':50.,
               'HVAC_HP_component1_y':160.,
               'HVAC_pump_y':25.,
               'Distrib_component1_y':80.,
               'HVAC_HP_component2_y':30.,
               'Distrib_component2_y':80.,
               'Lighting_floor1_lamp1_coponent1_y':15.,
               'Lighting_floor1_lamp1_coponent2_y':23.,
               'Lighting_floor1_lamp2_y':87.,
               'Lighting_floor2_y':37.}    

power_tree = get_dict_tree(power_usage)
plot_nested_pie(power_tree)

