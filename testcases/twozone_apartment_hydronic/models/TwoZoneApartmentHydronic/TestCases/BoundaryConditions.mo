within TwoZoneApartmentHydronic.TestCases;
model BoundaryConditions "BoundaryGenerator"
    extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Area Afloor=22;
  parameter Modelica.Units.SI.Temperature T_start=21 + 273.15;
  parameter Modelica.Units.SI.MassFlowRate mflow_n=2480/3600/4
    "nominal flow rate";
    parameter Real qint=1 "Presence or not of Internal gains";
  TwoZoneApartmentHydronic.Components.Thermostat_T thermostatNigZon(
    occSta=8*3600,
    occEnd=20*3600,
    TSetHeaUno=294.15,
    TSetHeaOcc=290.15,
    TSetHeaWee=290.15)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-78,52},{-38,92}}),   iconTransformation(extent=
           {{-268,-10},{-248,10}})));
  TwoZoneApartmentHydronic.Components.Thermostat_T thermostatDayZon(
    occSta=16*3600,
    occEnd=20*3600,
    TSetHeaUno=290.15,
    TSetHeaOcc=294.15,
    TSetHeaWee=290.15)
    annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
  inner IDEAS.BoundaryConditions.SimInfoManager
                       sim(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://TwoZoneApartmentHydronic/Resources/IT-Milano-Linate-160800TM2.mos"))
    annotation (Placement(transformation(extent={{-102,60},{-80,82}})));
  Modelica.Blocks.Sources.Constant DumTem(k=300) "Dummy zone temperature"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Components.BaseClasses.InternalLoad equDay(
    latPower_nominal=0,
    senPower_nominal=4,
    radFraction=0.5)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Components.BaseClasses.OccupancyLoad occDay(
    radFraction=0.5,
    co2Gen=8.64e-6,
    occ_density=1/Afloor,
    senPower=60,
    latPower=20)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Components.BaseClasses.InternalLoad ligDay(
    radFraction=0.5,
    latPower_nominal=0,
    senPower_nominal=1.5)
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Components.BaseClasses.InternalLoad equNig(
    latPower_nominal=0,
    senPower_nominal=4,
    radFraction=0.5)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Components.BaseClasses.OccupancyLoad occNig(
    radFraction=0.5,
    co2Gen=8.64e-6,
    occ_density=1/Afloor,
    senPower=60,
    latPower=20) annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Components.BaseClasses.InternalLoad ligNig(
    radFraction=0.5,
    latPower_nominal=0,
    senPower_nominal=1.5)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Math.MultiSum sumRadDayZon(k=fill(Afloor, 3), nu=3)
    "Sum of radiant internal gains day zone"
    annotation (Placement(transformation(extent={{60,56},{78,74}})));
  Modelica.Blocks.Math.MultiSum sumConDayZon(k=fill(Afloor, 3), nu=3)
    "Sum of convective internal gains"
    annotation (Placement(transformation(extent={{60,26},{78,44}})));
  Modelica.Blocks.Math.MultiSum sumLatDayZon(k=fill(Afloor, 3), nu=3)
    "Sum of latent internal gains"
    annotation (Placement(transformation(extent={{60,-4},{78,14}})));
  Modelica.Blocks.Math.MultiSum sumRadNigZon(k=fill(Afloor, 3), nu=3)
    "Sum of radiant internal gains"
    annotation (Placement(transformation(extent={{62,-38},{78,-22}})));
  Modelica.Blocks.Math.MultiSum sumConNigZon(k=fill(Afloor, 3), nu=3)
    "Sum of convective internal gains"
    annotation (Placement(transformation(extent={{62,-68},{78,-52}})));
  Modelica.Blocks.Math.MultiSum sumLatNigZon(k=fill(Afloor, 3), nu=3)
    "Sum of latent internal gains"
    annotation (Placement(transformation(extent={{62,-98},{78,-82}})));
equation
  connect(sim.weaDatBus, weaBus) annotation (Line(
      points={{-80.11,71},{-72,71},{-72,72},{-58,72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(DumTem.y, thermostatNigZon.TZon) annotation (Line(points={{-79,-30},{
          -72,-30},{-72,-60},{-62,-60}},
                                       color={0,0,127}));
  connect(DumTem.y, thermostatDayZon.TZon) annotation (Line(points={{-79,-30},{
          -70,-30},{-70,28},{-60,28}},   color={0,0,127}));
  connect(equNig.rad, sumRadDayZon.u[1]) annotation (Line(points={{21,54},{52,
          54},{52,62.9},{60,62.9}}, color={0,0,127}));
  connect(occNig.rad, sumRadDayZon.u[2]) annotation (Line(points={{21,34},{52,
          34},{52,65},{60,65}}, color={0,0,127}));
  connect(ligNig.rad, sumRadDayZon.u[3]) annotation (Line(points={{21,14},{52,
          14},{52,61.85},{60,61.85},{60,67.1}}, color={0,0,127}));
  connect(equNig.con, sumConDayZon.u[1]) annotation (Line(points={{21,50},{40,
          50},{40,32.9},{60,32.9}}, color={0,0,127}));
  connect(occNig.con, sumConDayZon.u[2]) annotation (Line(points={{21,30},{40,
          30},{40,36},{60,36},{60,35}}, color={0,0,127}));
  connect(ligNig.con, sumConDayZon.u[3]) annotation (Line(points={{21,10},{40,
          10},{40,30},{60,30},{60,37.1}}, color={0,0,127}));
  connect(equNig.lat, sumLatDayZon.u[1]) annotation (Line(points={{21,46},{34,
          46},{34,2.9},{60,2.9}}, color={0,0,127}));
  connect(occNig.lat, sumLatDayZon.u[2])
    annotation (Line(points={{21,26},{28,26},{28,5},{60,5}}, color={0,0,127}));
  connect(ligNig.lat, sumLatDayZon.u[3]) annotation (Line(points={{21,6},{24,6},
          {24,7.1},{60,7.1}}, color={0,0,127}));
  connect(equDay.rad, sumRadNigZon.u[1]) annotation (Line(points={{21,-46},{50,
          -46},{50,-31.8667},{62,-31.8667}}, color={0,0,127}));
  connect(occDay.rad, sumRadNigZon.u[2]) annotation (Line(points={{21,-66},{50,
          -66},{50,-30},{62,-30}}, color={0,0,127}));
  connect(ligDay.rad, sumRadNigZon.u[3]) annotation (Line(points={{21,-86},{36,
          -86},{36,-82},{50,-82},{50,-32.8},{62,-32.8},{62,-28.1333}}, color={0,
          0,127}));
  connect(equDay.con, sumConNigZon.u[1]) annotation (Line(points={{21,-50},{40,
          -50},{40,-61.8667},{62,-61.8667}}, color={0,0,127}));
  connect(occDay.con, sumConNigZon.u[2]) annotation (Line(points={{21,-70},{40,
          -70},{40,-60},{62,-60}}, color={0,0,127}));
  connect(ligDay.con, sumConNigZon.u[3]) annotation (Line(points={{21,-90},{40,
          -90},{40,-62.8},{62,-62.8},{62,-58.1333}}, color={0,0,127}));
  connect(ligDay.lat, sumLatNigZon.u[1]) annotation (Line(points={{21,-94},{46,
          -94},{46,-91.8667},{62,-91.8667}}, color={0,0,127}));
  connect(occDay.lat, sumLatNigZon.u[2]) annotation (Line(points={{21,-74},{30,
          -74},{30,-94},{46,-94},{46,-90},{62,-90}}, color={0,0,127}));
  connect(equDay.lat, sumLatNigZon.u[3]) annotation (Line(points={{21,-54},{30,
          -54},{30,-94},{46,-94},{46,-92.8},{62,-92.8},{62,-88.1333}}, color={0,
          0,127}));
  connect(thermostatDayZon.Occ, equNig.occupation) annotation (Line(points={{
          -37,28},{-10,28},{-10,50},{-0.2,50}}, color={0,0,127}));
  connect(thermostatDayZon.Occ, occNig.occupation) annotation (Line(points={{
          -37,28},{-10,28},{-10,29.8},{-0.2,29.8}}, color={0,0,127}));
  connect(thermostatDayZon.Occ, ligNig.occupation) annotation (Line(points={{
          -37,28},{-10,28},{-10,10},{-0.2,10}}, color={0,0,127}));
  connect(thermostatNigZon.Occ, equDay.occupation) annotation (Line(points={{
          -39,-60},{-10,-60},{-10,-50},{-0.2,-50}}, color={0,0,127}));
  connect(thermostatNigZon.Occ, occDay.occupation) annotation (Line(points={{
          -39,-60},{-10,-60},{-10,-70.2},{-0.2,-70.2}}, color={0,0,127}));
  connect(thermostatNigZon.Occ, ligDay.occupation) annotation (Line(points={{
          -39,-60},{-10,-60},{-10,-90},{-0.2,-90}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=900,
      Tolerance=1e-06,
      __Dymola_Algorithm="Radau"),
    Documentation(revisions="<html>
<ul>
<li>
November 4, 2025, by Ettore Zanetti:<br/>
Updated model to Modelica 4.0, fixed occupancy profile, door opening 
and ventilation. This is for This is for <a href=https://github.com/ibpsa/project1-boptest/issues/422>
BOPTEST issue #422</a>.
</li>
<li>
August 5, 2022, by Ettore Zanetti:<br/>
Revision after comments
</li>
<li>
August 6, 2021, by Ettore Zanetti:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This test model is used to quickly generate weather, rooms setpoints and internal heat gains for forecast purposes.
</p>
</html>
"));
end BoundaryConditions;
