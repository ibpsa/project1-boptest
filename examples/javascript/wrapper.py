from splinter.browser import Browser
import os.path
import time
import sys
import pandas as pd


########## running the browser in a headless mode ##########

browser = Browser('firefox', headless=True)

########## execute individual html file ##########

browser.visit('file://' + os.path.realpath(sys.argv[1]))


if sys.argv[1].find('testcase2')!=-1:
    testcase = 2
else:
    testcase = 1

sim_tim=0

while sim_tim < 3600*48:

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

tab2=pd.DataFrame(result['y'])

tab=tab.merge(tab2, on=['time'], how='inner')
tab = tab.set_index('time')
tab.to_csv('/home/result_testcase{}.csv'.format(testcase))


kpis = browser.find_by_id("kpi")

div = kpis[0]

if div.value !='':
     kpis= eval(div.value)

print kpis
tab = pd.DataFrame.from_dict(kpis, orient='index', columns=['value'])
tab.index.name = 'keys'

tab.to_csv('/home/kpi_testcase{}.csv'.format(testcase))




########## kill the browser process ##########


browser.quit()
