within TwoZoneApartmentHydronic.TestCases;
model BoundaryConditions "BoundaryGenerator"
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.Area Afloor = 22;
    parameter Modelica.SIunits.Temperature T_start = 21+273.15;
    parameter Modelica.SIunits.MassFlowRate mflow_n=2480/3600/4
    "nominal flow rate";
    parameter Real qint=1 "Presence or not of Internal gains";
  TwoZoneApartmentHydronic.Components.Thermostat_T thermostatNigZ(
    occSta=8*3600,
    occEnd=20*3600,
    TSetHeaUno=294.15,
    TSetHeaOcc=289.15,
    TSetHeaWee=289.15)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-80,10},{-40,50}}),   iconTransformation(extent=
           {{-268,-10},{-248,10}})));
  TwoZoneApartmentHydronic.Components.Thermostat_T thermostatDayZ(
    occSta=8*3600,
    occEnd=20*3600,
    TSetHeaUno=294.15,
    TSetHeaOcc=289.15,
    TSetHeaWee=289.15)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  inner IDEAS.BoundaryConditions.SimInfoManager
                       sim(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://TwoZoneApartmentHydronic/Resources/ITA_Milano-Linate.160800_IGDG.mos"))
    annotation (Placement(transformation(extent={{-104,18},{-82,40}})));
  Modelica.Blocks.Sources.Constant DumTem(k=300) "Dummy zone temperature"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Components.BaseClasses.InternalLoad equDay(
    latPower_nominal=0,
    senPower_nominal=4,
    radFraction=0.5)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Components.BaseClasses.OccupancyLoad occDay(
    radFraction=0.5,
    co2Gen=0,
    occ_density=1/Afloor,
    senPower=60,
    latPower=20)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Components.BaseClasses.InternalLoad ligDay(
    radFraction=0.5,
    latPower_nominal=0,
    senPower_nominal=4)
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Components.BaseClasses.InternalLoad equNig(
    latPower_nominal=0,
    senPower_nominal=4,
    radFraction=0.5)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Components.BaseClasses.OccupancyLoad occNig(
    radFraction=0.5,
    co2Gen=0,
    occ_density=1/Afloor,
    senPower=60,
    latPower=20) annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Components.BaseClasses.InternalLoad ligNig(
    radFraction=0.5,
    latPower_nominal=0,
    senPower_nominal=4)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(sim.weaDatBus, weaBus) annotation (Line(
      points={{-82.11,29},{-72,29},{-72,30},{-60,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(DumTem.y, thermostatNigZ.TZon) annotation (Line(points={{-79,-30},{
          -72,-30},{-72,-10},{-62,-10}}, color={0,0,127}));
  connect(DumTem.y, thermostatDayZ.TZon) annotation (Line(points={{-79,-30},{
          -72,-30},{-72,-50},{-62,-50}}, color={0,0,127}));
  connect(thermostatNigZ.Occ, equNig.occupation) annotation (Line(points={{-39,
          -10},{-20,-10},{-20,10},{-0.2,10}}, color={0,0,127}));
  connect(thermostatNigZ.Occ, occNig.occupation) annotation (Line(points={{-39,
          -10},{-20,-10},{-20,-10.2},{-0.2,-10.2}}, color={0,0,127}));
  connect(thermostatNigZ.Occ, ligNig.occupation) annotation (Line(points={{-39,
          -10},{-20,-10},{-20,-30},{-0.2,-30}}, color={0,0,127}));
  connect(thermostatDayZ.Occ, equDay.occupation)
    annotation (Line(points={{-39,-50},{-0.2,-50}}, color={0,0,127}));
  connect(thermostatDayZ.Occ, occDay.occupation) annotation (Line(points={{-39,
          -50},{-20,-50},{-20,-70.2},{-0.2,-70.2}}, color={0,0,127}));
  connect(ligDay.occupation, occDay.occupation) annotation (Line(points={{-0.2,
          -90},{-20,-90},{-20,-70.2},{-0.2,-70.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Radau"),
    Documentation(revisions="<html>
<ul>
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
