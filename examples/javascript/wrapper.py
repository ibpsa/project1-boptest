from splinter.browser import Browser
import os.path
import time
import sys

browser = Browser('firefox', headless=True)

browser.visit('file://' + os.path.realpath(sys.argv[1]))

sim_tim=0

while sim_tim < 3600*48:
  
  elements = browser.find_by_id("output")

  div = elements[0]

  if div.value !='':
     result= eval(div.value) 
     sim_tim = result['time']
  time.sleep(1)



results = browser.find_by_id("result")

div = results[0]

if div.value !='':
     result= eval(div.value) 

browser.quit()