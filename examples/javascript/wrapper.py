from splinter.browser import Browser
import os.path
import time
import sys
import pandas as pd

########## running the browser in a headless mode ##########

browser = Browser('firefox', headless=True)

########## execute individual html file ##########

browser.visit('file://' + os.path.realpath('/home/{}.html'.format(sys.argv[1])))

testcase = sys.argv[1]

sim_tim = 0

sim_length = 48*3600

while sim_tim < sim_length:

  ########## record the data for simulation output ##########

  elements = browser.find_by_id("output")

  ########## extract the simulation time ##########

  div = elements[0]
  if div.value !='':
     result= eval(div.value)
     sim_tim = result['time']

########## extract the final simulation output ##########

try_results = True
while try_results:
    try:
        results = browser.find_by_id("result")
        div = results[0]
        if div.value !='':
             result= eval(div.value)
        tab=pd.DataFrame(result['u'])        
        try_results = False        
    except:
        try_results = True

tab_y = pd.DataFrame(result['y'])
tab = tab.merge(tab_y, on=['time'], how='inner')
tab = tab.set_index('time')
tab.to_csv('/home/result_{}.csv'.format(testcase))

########## extract the kpi output ##########

kpis = browser.find_by_id("kpi")

div = kpis[0]

if div.value !='':
     kpis= eval(div.value)

tab_kpi = pd.DataFrame.from_dict(kpis, orient='index', columns=['value'])
tab_kpi.index.name = 'keys'
tab_kpi.to_csv('/home/kpi_testcase{}.csv'.format(testcase))

########## kill the browser process ##########

browser.quit()