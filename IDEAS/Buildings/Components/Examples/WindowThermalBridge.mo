within IDEAS.Buildings.Components.Examples;
model WindowThermalBridge "Comparison of three window thermal bridge options"
  package Medium = IDEAS.Media.Air;
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager sim "Weather data reader"
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    nPorts=1)
    "Pressure boundary"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));

  IDEAS.Buildings.Components.OuterWall floor(
    azi=IDEAS.Types.Azimuth.S,
    redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    A=10,
    inc=IDEAS.Types.Tilt.Floor)
    "Serves as floor for the incident solar irradiation"
    annotation (Placement(transformation(extent={{-54,20},{-44,40}})));
  IDEAS.Buildings.Components.Zone zone(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    V=20,
    nSurf=3)
    "Zone model"
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  IDEAS.Buildings.Components.Window win(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    redeclare IDEAS.Buildings.Data.Frames.Pvc fraType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S)
    "Window without thermal losses"
    annotation (Placement(transformation(extent={{-54,-20},{-44,0}})));
  IDEAS.Buildings.Components.Window winLinLos(
    A=1,
    redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    redeclare IDEAS.Buildings.Data.Frames.PvcLineLoss fraType(briTyp(len=4)))
    "Window with line losses"
    annotation (Placement(transformation(extent={{-54,-60},{-44,-40}})));
equation
  connect(zone.propsBus[1], floor.propsBus_a) annotation (Line(
      points={{20,-54.6667},{20,-54.6667},{20,-6},{20,32},{-44.8333,32}},
      color={255,204,51},
      thickness=0.5));
  connect(win.propsBus_a, zone.propsBus[2]) annotation (Line(
      points={{-44.8333,-8},{20,-8},{20,-56}},
      color={255,204,51},
      thickness=0.5));
  connect(winLinLos.propsBus_a, zone.propsBus[3]) annotation (Line(
      points={{-44.8333,-48},{-44.8333,-48},{20,-48},{20,-57.3333}},
      color={255,204,51},
      thickness=0.5));
  connect(zone.port_a, bou.ports[1])
    annotation (Line(points={{32,-50},{32,90},{-40,90}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/WindowThermalBridge.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
December 19, 2016 by Filip Jorissen:<br/>
Revised implementation.
</li>
</ul>
</html>", info="<html>
<p>
Model that demonstrates the heat flow rate difference 
for a window with or without line losses.
</p>
</html>"),
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end WindowThermalBridge;
