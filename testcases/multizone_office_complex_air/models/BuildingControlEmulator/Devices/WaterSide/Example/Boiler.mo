within BuildingControlEmulator.Devices.WaterSide.Example;
model Boiler
  import BuildingControlEmulator;

  extends Modelica.Icons.Example;
 package MediumHW = Buildings.Media.Water "Medium model";
  parameter Modelica.SIunits.TemperatureDifference
                                           dTHW_nominal = 20
    "Temperature difference at chilled water side";
  parameter Modelica.SIunits.Pressure dPHW_nominal = 6000
    "Pressure difference at chilled water side";
  parameter Modelica.SIunits.Temperature THW_nominal = 273.15 + 80
    "Temperature at chilled water side";
  parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal = 3000000/dTHW_nominal/4200
    "Nominal mass flow rate at chilled water side";
  parameter Real BoilerCurve[:] = {0.8}
    "Chiller operation Curve(need p(a=ChillerCurve, y=1)=1)";
  parameter Real k = 1 "Gain of the PID controller";
  parameter Real Ti = 60 "Integration time of the PID controller";

  BuildingControlEmulator.Devices.WaterSide.Boiler boi(
    redeclare package MediumHW = MediumHW,
    dPHW_nominal=dPHW_nominal,
    mHW_flow_nominal=mHW_flow_nominal,
    THW=THW_nominal,
    dTHW_nominal=dTHW_nominal,
    GaiPi=k,
    tIntPi=Ti,
    eta=BoilerCurve)                                                                                   "Compressor"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));

  Buildings.Fluid.Sources.MassFlowSource_T souHW(
    nPorts=1,
    use_T_in=true,
    T=273.15 + 11.11,
    redeclare package Medium = MediumHW,
    m_flow=mHW_flow_nominal) "Source for CHW"
    annotation (Placement(transformation(extent={{48,10},{28,30}})));
  Buildings.Fluid.Sources.Boundary_pT sinHW(nPorts=1, redeclare package Medium = MediumHW)
    "Sink for HW"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,-28})));
  Modelica.Blocks.Sources.Constant TCHWSet(k=273.15 + 80)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Sine THWEntcom(
    freqHz=1/86400,
    amplitude=10,
    offset=273.15 + 70) annotation (Placement(transformation(extent={{80,14},{60,34}})));
  Modelica.Blocks.Sources.Step On(height=1, startTime=3600)
    annotation (Placement(transformation(extent={{-80,22},{-60,42}})));
equation

  connect(sinHW.ports[1],boi. port_b_CHW)
    annotation (Line(
      points={{60,-28},{10,-28}},
      color={255,0,0},
      thickness=1));
  connect(THWEntcom.y, souHW.T_in)
    annotation (Line(
      points={{59,24},{50,24}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(On.y,boi. On) annotation (Line(
      points={{-59,32},{-54,32},{-54,-26},{-30,-26},{-30,-25},{-12,-25}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(souHW.ports[1],boi. port_a_HW)
    annotation (Line(
      points={{28,20},{10,20},{10,-12}},
      color={255,0,0},
      thickness=1));
  connect(TCHWSet.y,boi. THWSet)
    annotation (Line(
      points={{-59,70},{-20,70},{-20,-17},{-12,-17}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/BaseClasses/Components/Example/Compressor.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>This model is designed to test how the compressor module works under different load condition. In this test, the temperature of condenser water entering the compressor is fixed as 29.44 C while the temperature of chilled water would be changed by time(sine function).</p>
</html>"),
Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StartTime=1.62981e+007, StopTime=1.70751e+007),
    __Dymola_experimentSetupOutput);
end Boiler;
