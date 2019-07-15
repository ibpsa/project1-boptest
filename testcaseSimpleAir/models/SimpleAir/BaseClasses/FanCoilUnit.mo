within SimpleAir.BaseClasses;
model FanCoilUnit "Four-pipe fan coil unit model"
  package Medium1 = Buildings.Media.Water;
  package Medium2 = Buildings.Media.Air;
  Modelica.Fluid.Interfaces.FluidPort_a returnAir(redeclare final package
      Medium = Medium2) "Return air" annotation (Placement(transformation(
          extent={{90,-90},{110,-70}}), iconTransformation(extent={{90,-90},{
            110,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b supplyAir(redeclare final package
      Medium = Medium2) "Supply air"
    annotation (Placement(transformation(extent={{90,70},{110,90}}),
        iconTransformation(extent={{90,70},{110,90}})));
  Buildings.Fluid.Movers.SpeedControlled_y     fan annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,-60})));
  Buildings.Fluid.HeatExchangers.WetCoilDiscretized cooCoi(redeclare package
      Medium1 = Medium1, redeclare package Medium2 = Medium2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,30})));
  Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU hex(redeclare package
      Medium1 = Medium1, redeclare package Medium2 = Medium2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-30})));
  Buildings.Fluid.Sources.FixedBoundary sinHea(
    p=300000,
    T=318.15,
    nPorts=1,
    redeclare package Medium = Medium1)
              "Sink for heating coil" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,-40})));
  Buildings.Fluid.Sources.FixedBoundary sinCoo(
    p=300000,
    T=285.15,
    nPorts=1,
    redeclare package Medium = Medium1) "Sink for cooling coil"
                                      annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,20})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage cooVal(redeclare
      package Medium = Medium1)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage heaVal(redeclare
      package Medium = Medium1)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Buildings.Fluid.Sources.FixedBoundary souCoo(
    nPorts=1,
    redeclare package Medium = Medium1,
    p=300000,
    T=279.15) "Source for cooling coil" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,50})));
  Buildings.Fluid.Sources.FixedBoundary souHea(
    nPorts=1,
    redeclare package Medium = Medium1,
    p=300000,
    T=318.15) "Source for heating coil" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,-10})));
  Modelica.Blocks.Interfaces.RealInput yCooVal "Cooling coil valve position"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput yHeaVal "Heating coil valve position"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput yFan "Fan speed signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
equation
  connect(fan.port_b, hex.port_a2)
    annotation (Line(points={{-16,-50},{-16,-40}}, color={0,127,255}));
  connect(hex.port_b2, cooCoi.port_a1)
    annotation (Line(points={{-16,-20},{-16,20}}, color={0,127,255}));
  connect(cooCoi.port_b2, sinCoo.ports[1])
    annotation (Line(points={{-4,20},{50,20}}, color={0,127,255}));
  connect(sinHea.ports[1], hex.port_b1)
    annotation (Line(points={{50,-40},{-4,-40}}, color={0,127,255}));
  connect(cooCoi.port_a2, cooVal.port_a)
    annotation (Line(points={{-4,40},{20,40}}, color={0,127,255}));
  connect(heaVal.port_a, hex.port_a1)
    annotation (Line(points={{20,-20},{-4,-20}}, color={0,127,255}));
  connect(souHea.ports[1], heaVal.port_b) annotation (Line(points={{50,-10},{44,
          -10},{44,-20},{40,-20}}, color={0,127,255}));
  connect(souCoo.ports[1], cooVal.port_b) annotation (Line(points={{50,50},{44,
          50},{44,40},{40,40}}, color={0,127,255}));
  connect(cooVal.y, yCooVal)
    annotation (Line(points={{30,52},{30,60},{-120,60}}, color={0,0,127}));
  connect(yHeaVal, heaVal.y)
    annotation (Line(points={{-120,0},{30,0},{30,-8}}, color={0,0,127}));
  connect(fan.y, yFan)
    annotation (Line(points={{-28,-60},{-120,-60}}, color={0,0,127}));
  connect(cooCoi.port_b1, supplyAir)
    annotation (Line(points={{-16,40},{-16,80},{100,80}}, color={0,127,255}));
  connect(returnAir, fan.port_a) annotation (Line(points={{100,-80},{-16,-80},{
          -16,-70}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanCoilUnit;
