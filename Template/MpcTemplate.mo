within ;
model MpcTemplate
  parameter Integer nOptReal "Number of real control variables";
  parameter Integer nOptInt "Number of integer control variables";
  parameter Integer nOptBool "Number of boolean control variables";

  parameter Integer nMeasReal "Number of real measurements";
  parameter Integer nMeasInt "Number of integer measurements";
  parameter Integer nMeasBool "Number of boolean measurements";

  parameter String[nMeasReal] descrMeasReal "Descriptions of real output signals";
  parameter String[nMeasInt] descrMeasInt "Descriptions of integer output signals";
  parameter String[nMeasBool] descrMeasBool "Descriptions of boolean output signals";

  Modelica.Blocks.Interfaces.RealOutput[nMeasReal] measReal "Real measurements"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.IntegerOutput[nMeasInt] measInt "Integer measurements"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.BooleanOutput[nMeasBool] measBool "Boolean measurements"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));

  Modelica.Blocks.Interfaces.RealOutput EEl "Electrical energy use"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput PEl "Electrical power"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput KPI3 "The value of KPI 3"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput KPI4 "The value of KPI 4"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));

  Modelica.Blocks.Continuous.Integrator EElInt(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0) "Integrator for electrical power"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
equation
  connect(EElInt.y, EEl)
    annotation (Line(points={{81,80},{110,80}}, color={0,0,127}));
  connect(EElInt.u, PEl)
    annotation (Line(points={{58,80},{58,60},{110,60}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    uses(Modelica(version="3.2.2")));
end MpcTemplate;
