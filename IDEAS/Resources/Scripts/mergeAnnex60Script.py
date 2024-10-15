
import buildingspy.development.merger as m
import os
import io,json

fileName = "Resources/Scripts/mergePaths.txt"
if os.path.isfile(fileName):
    with open(fileName, 'r') as dataFile:
        data = json.loads(dataFile.read())
        annex60_dir = data['annex60_dir']
        dest_dir = data['dest_dir']
        
else:
    print(fileName + " could not be found in your current working directory, please enter source and destination paths. \nThey will be saved for next time. Remove " + fileName + " to reset the paths.")
    annex60_dir = raw_input("Enter annex60 directory path: \n")
    dest_dir = raw_input("Enter destination directory path: \n")
    data = {"annex60_dir":annex60_dir, "dest_dir":dest_dir}
    with open(fileName, 'w') as dataFile:
        json.dump(data, dataFile)

mer = m.IBPSA(annex60_dir, dest_dir) 
mer.set_excluded_packages(["Experimental", "Obsolete"])
mer.merge(overwrite_reference_results=True)
