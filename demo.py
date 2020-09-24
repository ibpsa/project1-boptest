from boptest_client import BoptestClient
import requests

url = 'http://localhost'
client = BoptestClient(url)

modelid = client.submit('testcases/testcase1/models/wrapped.fmu')

requests.post('{0}/initialize/{1}'.format(url, modelid))

for i in range(6):
    requests.post('{0}/advance/{1}'.format(url, modelid))

