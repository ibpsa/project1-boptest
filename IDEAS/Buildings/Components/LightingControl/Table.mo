within IDEAS.Buildings.Components.LightingControl;
block Table "Lighting control read from CombiTimeTable"
  extends IDEAS.Buildings.Components.LightingControl.BaseClasses.PartialLightingControl(
    final useCtrInput=false,
    final useOccInput=false);

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
  assert(not linearise, "In " + getInstanceName() + ": Lighting control can 
    not be defined by a table when the model is linearized. Change the control type.");
  connect(combiTimeTable.y[1], ctrl)
    annotation (Line(points={{11,0},{120,0}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
August 28, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>", info="<html>
<p>
This block defines a lighting control using a schedule (CombiTable).
</p>
</html>"));
end Table;
