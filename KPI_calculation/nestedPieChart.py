import matplotlib.pyplot as plt
import numpy as np
from flask._compat import iteritems
from collections import OrderedDict


power_usage = {'HVAC_damper_y':50.,
               'HVAC_HP_component1_y':160.,
               'HVAC_HP_component2_y':30.,
               'HVAC_pump_y':25.,
               'Distrib_component1_y':80.,
               'Distrib_component2_y':80.}

# Initialize the power tree
power_tree = OrderedDict()
# Each element of the power usage dictionary is a branch of the tree
for element in power_usage.keys():
    # Create an auxiliary variable to go through the branches of the tree
    actual_layer = power_tree
    # Read every component in the branch except the last '_y' term
    components = element.split('_')[:-1]
    # Grow the branch with a new dictionary if not the last component
    for component in components[:-1]:
        # Check if this component is already in this layer
        if component not in actual_layer.keys():
            # Create a dictionary in this layer to keep growing the branch
            actual_layer[component]=OrderedDict()
        # Shift the actual layer by one component
        actual_layer = actual_layer[component]
    # If last component, assign the power_usage value
    actual_layer[components[-1]] = power_usage[element]


def sumdict(dictionary):
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
            val += sumdict(dictionary=dictionary[k])
        return val


def count_elements(dictionary):
    
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
            n += count_elements(dictionary=dictionary[k])
        return n
    
def parse_color_points(dictionary):
    n = count_elements(dictionary)
    return np.linspace(0, 250, n+1).astype(int)
    

def plot_pie(dictionary,ax,radius=1.,delta_radius=0.2):
    """
    This method appends a pie plot from a nested dictionary
    to an axes of matplotlib object. If all the elements
    of the dictionary are float values it will make a simple
    pie plot with those values. If there are other nested
    dictionaries it will continue ploting them in a nested
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
        radius of the outer layer pie plot
    delta_radius: float
        desired difference between the radius of two 
        consecutive pie plot layers
    """
    
    color_points  = parse_color_points(dictionary)
    color_index = [0]
    cmap = plt.get_cmap('rainbow')
    # Initialize the list of values to plot in this layer
    vals = []
    # Initialize a new dictionary for the next inner layer
    newdict = OrderedDict()
    # Go through every component in this layer
    for k_outer,v_outer in iteritems(dictionary):
        # Calculate the slice size of this component 
        vals.append(sumdict(v_outer))
        # Check if this component has nested dictionaries
        if isinstance(v_outer, dict):
            # If it has, add them to the new dictionary
            for k_inner,v_inner in iteritems(v_outer):
                # Give a unique nested key name to it
                newdict[k_outer+'_'+k_inner] = v_inner
        # Check if this component is already a float end point 
        elif isinstance(v_outer, float):
            # If it is, add it to the new dictionary
            newdict[k_outer] = v_outer
        n = count_elements(v_outer)
        if n == 1:
            shift = 0
        else:
            shift = 80
        color_index.append(color_index[-1]+n)
    # Append the obtained values in this layer to the axes
    ax.pie(np.array(vals), radius=radius, colors=cmap(color_points[[color_index[:-1]]]+shift ),
           wedgeprops=dict(width=0.3, edgecolor='w'))
    
    # If all components were float end points don't continue nesting 
    if not all(isinstance(v, float) for v in dictionary.values()):
        # If still any dictionary keep nesting
        plot_pie(newdict, ax, radius=radius-delta_radius)

    
    
fig, ax = plt.subplots()
plot_pie(power_tree, ax)
plt.show()





cmaps = [('Perceptually Uniform Sequential', [
            'viridis', 'plasma', 'inferno', 'magma']),
         ('Sequential', [
            'Greys', 'Purples', 'Blues', 'Greens', 'Oranges', 'Reds',
            'YlOrBr', 'YlOrRd', 'OrRd', 'PuRd', 'RdPu', 'BuPu',
            'GnBu', 'PuBu', 'YlGnBu', 'PuBuGn', 'BuGn', 'YlGn']),
         ('Sequential (2)', [
            'binary', 'gist_yarg', 'gist_gray', 'gray', 'bone', 'pink',
            'spring', 'summer', 'autumn', 'winter', 'cool', 'Wistia',
            'hot', 'afmhot', 'gist_heat', 'copper']),
         ('Diverging', [
            'PiYG', 'PRGn', 'BrBG', 'PuOr', 'RdGy', 'RdBu',
            'RdYlBu', 'RdYlGn', 'Spectral', 'coolwarm', 'bwr', 'seismic']),
         ('Qualitative', [
            'Pastel1', 'Pastel2', 'Paired', 'Accent',
            'Dark2', 'Set1', 'Set2', 'Set3',
            'tab10', 'tab20', 'tab20b', 'tab20c']),
         ('Miscellaneous', [
            'flag', 'prism', 'ocean', 'gist_earth', 'terrain', 'gist_stern',
            'gnuplot', 'gnuplot2', 'CMRmap', 'cubehelix', 'brg', 'hsv',
            'gist_rainbow', 'rainbow', 'jet', 'nipy_spectral', 'gist_ncar'])]


nrows = max(len(cmap_list) for cmap_category, cmap_list in cmaps)
gradient = np.linspace(0, 1, 256)
gradient = np.vstack((gradient, gradient))


def plot_color_gradients(cmap_category, cmap_list, nrows):
    fig, axes = plt.subplots(nrows=nrows)
    fig.subplots_adjust(top=0.95, bottom=0.01, left=0.2, right=0.99)
    axes[0].set_title(cmap_category + ' colormaps', fontsize=14)

    for ax, name in zip(axes, cmap_list):
        ax.imshow(gradient, aspect='auto', cmap=plt.get_cmap(name))
        pos = list(ax.get_position().bounds)
        x_text = pos[0] - 0.01
        y_text = pos[1] + pos[3]/2.
        fig.text(x_text, y_text, name, va='center', ha='right', fontsize=10)

    # Turn off *all* ticks & spines, not just the ones with colormaps.
    for ax in axes:
        ax.set_axis_off()


for cmap_category, cmap_list in cmaps:
    plot_color_gradients(cmap_category, cmap_list, nrows)

plt.show()











fig, ax = plt.subplots()

size = 0.3
vals = np.array([[60., 32.], [37., 40.], [29., 10.]])

cmap = plt.get_cmap("tab20c")
outer_colors = cmap(np.arange(3)*4)
inner_colors = cmap(np.array([1, 2, 5, 6, 9, 10]))

ax.pie(vals.sum(axis=1), radius=1, colors=outer_colors,
       wedgeprops=dict(width=size, edgecolor='w'))

ax.pie(vals.flatten(), radius=1-size, colors=inner_colors,
       wedgeprops=dict(width=size, edgecolor='w'))

ax.set(aspect="equal", title='Pie plot with `ax.pie`')
plt.show()