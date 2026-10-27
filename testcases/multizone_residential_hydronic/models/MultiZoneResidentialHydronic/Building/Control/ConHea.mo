within MultiZoneResidentialHydronic.Building.Control;
model ConHea "General controller for heating system"
  parameter Real Khea=1e6 "Gain value for the heating controller";
  parameter Real k=1e-2 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti=300
    "Time constant of Integrator block";
  Buildings.Controls.Continuous.LimPID conHea(
    Ni=0.1,
    Td=1e4,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    k=k,
    Ti=Ti)
         "Controller for heating"
    annotation (Placement(transformation(extent={{-60,16},{-52,24}})));
  Modelica.Blocks.Math.Gain gaiHea(k=Khea)
    annotation (Placement(transformation(extent={{-28,16},{-20,24}})));

  Modelica.Blocks.Interfaces.RealInput T annotation (Placement(transformation(
        rotation=0,
        extent={{-8,-8},{8,8}},
        origin={-108,12}), iconTransformation(extent={{-116,4},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput yHea
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Interfaces.RealInput TSet annotation (Placement(
        transformation(
        rotation=0,
        extent={{-8,-8},{8,8}},
        origin={-108,30}), iconTransformation(extent={{-116,22},{-100,38}})));
equation
  connect(gaiHea.y,yHea)  annotation (Line(points={{-19.6,20},{-14,20},{-14,10},
          {10,10}}, color={0,0,127}));
  connect(T,conHea. u_m)
    annotation (Line(points={{-108,12},{-56,12},{-56,15.2}}, color={0,0,127}));
  connect(TSet, conHea.u_s) annotation (Line(points={{-108,30},{-80,30},{-80,20},
          {-60.8,20}}, color={0,0,127}));
  connect(conHea.y, gaiHea.u)
    annotation (Line(points={{-51.6,20},{-28.8,20}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-20},{0,40}})), Icon(
        coordinateSystem(extent={{-100,-20},{0,40}})));
end ConHea;
