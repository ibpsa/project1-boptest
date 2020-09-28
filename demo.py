from boptest_client import BoptestClient
import requests

url = 'http://localhost'
client = BoptestClient(url)

modelid = client.submit('testcases/testcase1/models/wrapped.fmu')

requests.put('{0}/initialize/{1}'.format(url, modelid))

for i in range(6):
    u = {'oveTSetRooHea_u':22+273.15, 
         'oveTSetRooHea_activate':1,
         'oveTSetRooCoo_u':23+273.15,
         'oveTSetRooCoo_activate':1}
    
    requests.post('{0}/advance/{1}'.format(url, modelid), json=u)

