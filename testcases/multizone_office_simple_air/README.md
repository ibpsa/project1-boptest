## Semantic Model Extraction

* First, set up MODELICAPATH and MODELICAJSONPATH environment variables.
For example, add following lines to the end of ~/.bashrc in Ubuntu or ~/.bash_profile in MacOS:
```
export MODELICAPATH="/path/to/modelica-buildings:$MODELICAPATH"
export MODELICAJSONPATH="/path/to/modelica-json"
```

* Run the following command to extract a semantic model from the BOPTEST testcase:
```
cd /path/to/project1-boptest/testcases/multizone_office_simple_air/models
node $MODELICAJSONPATH/app.js -f MultiZoneOfficeSimpleAir/TestCases/TestCase.mo -o semantic -m modelica -d m2j_output
```

* For the purposes of this development, we have added semantic annotations to the following files in the `testcases/multizone_office_simple_air/models/MultiZoneOfficeSimpleAir` directory (keep this list updated):
  * `TestCases/TestCase.mo`

* For the current testcase, the JSON output should be present in `multizone_office_simple_air/m2j_output/json`. 
* For the current testcase, the semantic output should be present in `multizone_office_simple_air/m2j_output/objects/Brick/1.3/testcases/multizone_office_simple_air/models/MultiZoneOfficeSimpleAir/TestCases/TestCase.ttl`. 
