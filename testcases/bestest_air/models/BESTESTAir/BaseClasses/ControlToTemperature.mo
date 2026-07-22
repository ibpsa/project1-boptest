within BESTESTAir.BaseClasses;
model ControlToTemperature
  "Convert control signals to temperature setpoints"
  parameter Modelica.Units.SI.Temperature THig "High temperature";
  parameter Modelica.Units.SI.Temperature TLow "Low temperature";
  parameter Boolean reverseAction = false "True in the case of cooling";
  Modelica.Blocks.Interfaces.RealInput u "Control signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput T "Supply air temperature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Gain gain(k=THig - TLow)
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Blocks.Math.Add add(k1=if reverseAction then -1 else 1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant const(k=if reverseAction then THig else TLow)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
equation
  connect(gain.y, add.u1)
    annotation (Line(points={{1,20},{10,20},{10,6},{18,6}}, color={0,0,127}));
  connect(add.y, T) annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
  connect(const.y, add.u2) annotation (Line(points={{1,-20},{10,-20},{10,-6},{18,
          -6}}, color={0,0,127}));
  connect(u, gain.u) annotation (Line(points={{-120,0},{-40,0},{-40,20},{-22,20}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ControlToTemperature;
