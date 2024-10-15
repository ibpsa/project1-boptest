within IDEAS.Buildings.Components.Occupants;
block Table "Number of occupants read from CombiTimeTable"
 extends BaseClasses.PartialOccupants(final useInput=false);
 parameter Boolean tableOnFile=false
   "= true, if table is defined on file or in function usertab"
   annotation (Dialog(group="Table data definition"));
 parameter Real table[:, :] = fill(0.0, 0, 2)
   "Table matrix (time = first column; e.g., table=[0,2])"
   annotation (Dialog(group="Table data definition",enable=not tableOnFile));
 parameter String tableName="NoName"
   "Table name on file or in function usertab (see docu)"
   annotation (Dialog(group="Table data definition",enable=tableOnFile));
 parameter String fileName="NoName" "File where matrix is stored"
   annotation (Dialog(
     group="Table data definition",
     enable=tableOnFile,
     loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
         caption="Open file in which table is present")));
 parameter Boolean verboseRead=true
   "= true, if info message that file is loading is to be printed"
   annotation (Dialog(group="Table data definition",enable=tableOnFile));
 parameter Integer column
   "Column of table that is used"
   annotation (Dialog(group="Table data interpretation"));
 parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
   "Smoothness of table interpolation"
   annotation (Dialog(group="Table data interpretation"));
 parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
   "Extrapolation of data outside the definition range"
   annotation (Dialog(group="Table data interpretation"));
 parameter Real offset[:]={0} "Offsets of output signals"
   annotation (Dialog(group="Table data interpretation"));
 parameter Modelica.SIunits.Time startTime=0
   "Output = offset for time < startTime"
   annotation (Dialog(group="Table data interpretation"));
 parameter Modelica.SIunits.Time timeScale(
   min=Modelica.Constants.eps)=1 "Time scale of first table column"
   annotation (Dialog(group="Table data interpretation"), Evaluate=true);

 Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
   tableOnFile=tableOnFile,
   table=table,
   tableName=tableName,
   fileName=fileName,
   verboseRead=verboseRead,
   smoothness=smoothness,
   extrapolation=extrapolation,
   offset=offset,
   startTime=startTime,
   timeScale=timeScale,
   columns={column}) "Table for reading number of occupants from file"
   annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
 assert(not linearise, "In " + getInstanceName() + ": Number of occupant can not 
   be defined by a table when the model is linearized. Change the occupancy type.");
 connect(combiTimeTable.y[1], nOcc)
   annotation (Line(points={{11,0},{120,0}}, color={0,0,127}));
 annotation (Documentation(revisions="<html>
<ul>
<li>
August 21, 2018 by Damien Picard: <br/> 
Added assert statement such that this model cannot be 
used when linearizing as it would lead to an error.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/812\">#812</a>.
</li>
<li>
July 26, 2018 by Filip Jorissen:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
</ul>
</html>"));
end Table;
