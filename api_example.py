import requests
import pprint
pp = pprint.PrettyPrinter(indent=4)

# Set URL for testcase
url = 'http://127.0.0.1:5000'


# DEMONSTRATE API FOR GETTING TEST CASE INFORMATION
# --------------------------------------------
pp.pprint('\nTEST CASE INFORMATION\n---------------------')
# Get the test case name
name = requests.get('{0}/name'.format(url)).json()
print('\nName is:')
pp.pprint(name)
# Inputs available
inputs = requests.get('{0}/inputs'.format(url)).json()
print('\nControl Inputs are:')
pp.pprint(inputs)
# Measurements available
measurements = requests.get('{0}/measurements'.format(url)).json()
print('\nMeasurements are:')
pp.pprint(measurements)
# Default simulation step
step_def = requests.get('{0}/step'.format(url)).json()
print('\nDefault Simulation Step is:\t{0}'.format(step_def))

# DEMONSTRATE API FOR SIMULATING TEST CASE
# ----------------------------------------
# Set simulation step
print('\nSetting simulation step to 3600.')
res = requests.put('{0}/step'.format(url), data={'step':3600})
print(res)
# Advance simulation
print('\nAdvancing emulator one step...')
y = requests.post('{0}/advance'.format(url), data={}).json()
print('\nMeasurements at next step are:')
pp.pprint(y)
# Get a forecast of boundary conditions
print('\nAdvancing emulator one step...')
w = requests.get('{0}/forecast'.format(url)).json()
print('Forecast is:')
pp.pprint(w)

# DEMONSTRATE API FOR VIEWING RESULTS
# -----------------------------------
# Get all simulation results
data = requests.get('{0}/results'.format(url)).json()
print('\nSimulation results are:')
pp.pprint(data)
# Report KPIs
kpi = requests.get('{0}/kpi'.format(url)).json()
print('\nKPIs are:')
pp.pprint(kpi)

# Reset test case
print('\nResetting test case to beginning.')
res = requests.put('{0}/reset'.format(url))
print(res)
