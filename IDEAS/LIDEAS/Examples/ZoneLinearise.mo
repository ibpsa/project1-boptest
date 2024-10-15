within IDEAS.LIDEAS.Examples;
model ZoneLinearise "Test for linearisation"
  extends LIDEAS.Components.LinearisationInterface(sim(nWindow=1));
  parameter Integer nZones=2 "Number of zone";
  parameter Integer nEmb=1 "Number of embbed systems";
  package Medium = IDEAS.Media.Specialized.DryAir;
  extends Modelica.Icons.Example;
  LIDEAS.Components.LinZone groFlo(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    V=20,
    nSurf=5) "Ground floor"
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  IDEAS.Buildings.Components.BoundaryWall commonWall(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    A=10,
    use_T_in=true,
    azi=IDEAS.Types.Azimuth.S,
    inc=IDEAS.Types.Tilt.Wall)
                   "Common wall model"
    annotation (Placement(transformation(extent={{-54,-2},{-44,18}})));
  IDEAS.Buildings.Components.InternalWall floor(
    A=10,
    azi=0,
    inc=IDEAS.Types.Tilt.Floor,
    redeclare IDEAS.Buildings.Data.Constructions.TABS constructionType)
    "TABS Floor between the two zones." annotation (Placement(transformation(
        extent={{5,-10},{-5,10}},
        rotation=90,
        origin={9,-38})));

  LIDEAS.Components.LinWindow window(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Components.Shading.Screen shaType,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    indexWindow=1) "Window model"
    annotation (Placement(transformation(extent={{-54,-82},{-44,-62}})));
  IDEAS.Buildings.Components.SlabOnGround slabOnGround(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.LightWall
      constructionType,
    A=20,
    PWall=3,
    inc=IDEAS.Types.Tilt.Floor,
    azi=0) "Floor model"
    annotation (Placement(transformation(extent={{-54,20},{-44,40}})));
  IDEAS.Buildings.Components.OuterWall outerWall(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    A=10,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S)
                         "Outer wall model"
    annotation (Placement(transformation(extent={{-54,-58},{-44,-38}})));
  LIDEAS.Components.LinZone firFlo(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    V=20,
    nSurf=4) "First floor"
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  IDEAS.Buildings.Components.Shading.ShadingControl shadingControl
    "Shading control model"
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  IDEAS.Buildings.Components.BoundaryWall commonWall1(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    A=10,
    use_T_in=false,
    use_Q_in=true,
    azi=IDEAS.Types.Azimuth.S,
    inc=IDEAS.Types.Tilt.Wall)
                   "Common wall model"
    annotation (Placement(transformation(extent={{-54,-26},{-44,-6}})));

  Modelica.Blocks.Sources.Constant TCom(k=273.15 + 20)
    "Temperature at one side of the common wall"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant QCom(k=10)
    "Constant heat flow at one side of the common wall 1"
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  IDEAS.Buildings.Components.OuterWall outerWall1(
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    A=10,
    azi=IDEAS.Types.Azimuth.S,
    inc=IDEAS.Types.Tilt.Wall)
                         "Outer wall model"
    annotation (Placement(transformation(extent={{-30,-100},{-20,-80}})));
  IDEAS.Buildings.Components.OuterWall Roof(
    azi=0,
    A=10,
    redeclare Buildings.Validation.Data.Constructions.LightRoof
      constructionType,
    inc=IDEAS.Types.Tilt.Ceiling) "Outer wall model"
    annotation (Placement(transformation(extent={{-2,-100},{8,-80}})));
equation
  connect(commonWall.propsBus_a, groFlo.propsBus[1]) annotation (Line(
      points={{-44.8333,10},{-12,10},{-12,-4.4},{20,-4.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(window.propsBus_a, firFlo.propsBus[2]) annotation (Line(
      points={{-44.8333,-70},{6,-70},{6,-55.5},{20,-55.5}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(outerWall.propsBus_a, groFlo.propsBus[4]) annotation (Line(
      points={{-44.8333,-46},{-12,-46},{-12,-6.8},{20,-6.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(slabOnGround.propsBus_a, groFlo.propsBus[3]) annotation (Line(
      points={{-44.8333,32},{-12,32},{-12,-6},{20,-6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(shadingControl.y, window.Ctrl) annotation (Line(
      points={{-60,-84},{-58,-84},{-58,-86},{-52.3333,-86},{-52.3333,-82}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(commonWall1.propsBus_a, groFlo.propsBus[5]) annotation (Line(
      points={{-44.8333,-14},{-12,-14},{-12,-7.6},{20,-7.6}},
      color={255,204,51},
      thickness=0.5));
  connect(TCom.y, commonWall.T)
    annotation (Line(points={{-79,10},{-57.8333,10}}, color={0,0,127}));
  connect(QCom.y, commonWall1.Q_flow) annotation (Line(points={{-79,-20},{
          -57.8333,-20},{-57.8333,-18}}, color={0,0,127}));
  connect(outerWall1.propsBus_a, firFlo.propsBus[3]) annotation (Line(
      points={{-20.8333,-88},{-14,-88},{-14,-72},{8,-72},{8,-56.5},{20,-56.5}},
      color={255,204,51},
      thickness=0.5));

  connect(Roof.propsBus_a, firFlo.propsBus[4]) annotation (Line(
      points={{7.16667,-88},{20,-88},{20,-57.5}},
      color={255,204,51},
      thickness=0.5));
  connect(floor.propsBus_b, groFlo.propsBus[2]) annotation (Line(
      points={{7,-33.8333},{7,-5.2},{20,-5.2}},
      color={255,204,51},
      thickness=0.5));
  connect(floor.propsBus_a, firFlo.propsBus[1]) annotation (Line(
      points={{7,-42.1667},{7,-54.5},{20,-54.5}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Scripts/linearize_ZoneLinearise.mos" "Linearise"),
    Documentation(revisions="<html>
<ul>
<li>August 21, 2018 by Damien Picard: <br/>Change medium to <code>IDEAS.Media.Specialized.DryAir</code>.</li>
<li>April 10, 2018 by Damien Picard: <br/>Add documentation.</li>
<li>July 18, 2016 by Filip Jorissen:<br/>Cleaned up code and implementation. </li>
<li>By Filip Jorissen:<br/>First implementation. </li>
</ul>
</html>", info="<html>
<p>This model represents a very simple two-zone building. The model can be linearised by executing the command <i>Linearise</i> 
in the <i>Commands</i> menu of Dymola. This executes the script at LIDEAS/LIDEAS/Resources/Scripts/linearize.mos, 
which contains the following code:</p>
<p>
<br/>OutputCPUtime:=false;    
<br/>  
<br/>// linearise model and save results in \"re\" 
<br/>re=Modelica_LinearSystems2.ModelAnalysis.Linearize(\"IDEAS.LIDEAS.Examples.ZoneLinearise\"); 
<br/>  
<br/>// extract state space matrices from 're' and save them to a mat file in the current working directory
<br/>writeMatrix(fileName=\"ssm_ZoneLinearise.mat\",matrixName=\"A\",matrix=re.A);        
<br/>writeMatrix(fileName=\"ssm_ZoneLinearise.mat\",matrixName=\"B\",matrix=re.B, append=true);     
<br/>writeMatrix(fileName=\"ssm_ZoneLinearise.mat\",matrixName=\"C\",matrix=re.C, append=true);     
<br/>writeMatrix(fileName=\"ssm_ZoneLinearise.mat\",matrixName=\"D\",matrix=re.D, append=true);     
<br/>  
<br/>// save the variable names of the inputs, outputs and states in the current working directory      
<br/>Modelica.Utilities.Files.remove(\"uNames_ZoneLinearise.txt\");
<br/>for i in 1:size(re.uNames,1) loop Modelica.Utilities.Streams.print(re.uNames[i], \"uNames_ZoneLinearise.txt\"); end for;     
<br/>Modelica.Utilities.Files.remove(\"yNames_ZoneLinearise.txt\");
<br/>for i in 1:size(re.yNames,1) loop Modelica.Utilities.Streams.print(re.yNames[i], \"yNames_ZoneLinearise.txt\"); end for;     
<br/>Modelica.Utilities.Files.remove(\"xNames_ZoneLinearise.txt\");
<br/>for i in 1:size(re.xNames,1) loop Modelica.Utilities.Streams.print(re.xNames[i], \"xNames_ZoneLinearise.txt\"); end for;      
<br/>  
<br/>OutputCPUtime:=true;     
</p> 
<p>The first and last line of the code avoid that the CPU time is also linearised. 
The second line performs the actual linearisation and stores the resulting state space model in variable 
<i>re</i>. The next four lines are used to save the four state space matrices contained by <i>re</i> 
to a file <i>ssm.mat</i>. The remaining four lines of code also export the variable names of the 
state space inputs (u), states (x) and outputs (y) to three .txt files, which can then be used externally.</p>
</html> "));
end ZoneLinearise;
