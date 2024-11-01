within FRP.RTUVAV.Component;
model VAVReHeat_withCtrl_TRooCon
  "This model includes VAV damper controller. Heater controlls room air temperature.Updated to V8.1"
   replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
   parameter Modelica.SIunits.MassFlowRate m_flow_nominal=m_flow_nominal;
   parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal=Q_flow_nominal;
   parameter Modelica.SIunits.PressureDifference dp_nominal=dp_nominal;

  Buildings.Fluid.Actuators.Dampers.Exponential       vavDam(
    redeclare package Medium =Medium,
    m_flow_nominal=m_flow_nominal,
    dpDamper_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{44,-36},{100,42}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u
                                          ReHeat(
    redeclare package Medium =Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0,
    tau=300,
    Q_flow_nominal=Q_flow_nominal)
    annotation (Placement(transformation(extent={{-68,-26},{-18,34}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{208,-10},{228,12}}),
        iconTransformation(extent={{208,-10},{228,12}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-188,-6},{-168,14}})));
  Modelica.Blocks.Interfaces.RealInput TRooHeaSet
    "Room air heating temperature set point" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-172,124}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-120,120})));
  Modelica.Blocks.Interfaces.RealInput TRoo "room air temperature"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-68,124}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-30,120})));
  Modelica.Blocks.Interfaces.RealInput TRooCooSet
    "zone air temperature cooling setpoint" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-30,124}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,120})));
  Buildings.Controls.Continuous.LimPID conCoo(
    yMax=1,
    Td=60,
    k=0.1,
    Ti=120,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    yMin=0.5,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reverseActing=false)
    "Controller for cooling (acts on damper)"
    annotation (Placement(transformation(extent={{4,72},{20,88}})));
  Buildings.Controls.Continuous.LimPID         conHea(
    yMax=1,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    xi_start=0,
    Td=60,
    yMin=0,
    k=0.01,
    Ti=240,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI)
            "Controller for heating"
    annotation (Placement(transformation(extent={{-138,72},{-122,88}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite yDam(description="Damper position setpoint for zone",
      u(
      unit="1",
      min=0,
      max=1)) "Damper position setpoint"
    annotation (Placement(transformation(extent={{38,70},{58,90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite yReaHea(description="Reheat control signal for zone",
      u(
      unit="1",
      min=0,
      max=1)) "Reheat control signal"
    annotation (Placement(transformation(extent={{-106,72},{-90,88}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemp(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "supply air tempearature - VAV"
    annotation (Placement(transformation(extent={{136,18},{156,-12}})));
  Buildings.Fluid.Sensors.VolumeFlowRate
                               senVolFlo(
    redeclare package Medium = Medium,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false)
    "Supply Air Volumetric Flow Rate Sensor"
    annotation (Placement(
        transformation(
        extent={{-13,13},{13,-13}},
        rotation=0,
        origin={181,3})));
  Modelica.Blocks.Interfaces.RealOutput V_flow1
    "Volume flow rate from port_a to port_b" annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={180,-108})));
  Modelica.Blocks.Interfaces.RealOutput T1
    "Temperature of the passing fluid" annotation (Placement(transformation(
        extent={{-13,-13},{13,13}},
        rotation=-90,
        origin={147,-109}), iconTransformation(
        extent={{-13,-13},{13,13}},
        rotation=-90,
        origin={150,-108})));
  Modelica.Blocks.Interfaces.RealOutput y_damper_actual
    "Actual actuator position" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={116,-108})));
equation
  connect(ReHeat.port_a, port_a)
    annotation (Line(points={{-68,4},{-178,4}}, color={0,127,255}));
  connect(TRoo, conCoo.u_m) annotation (Line(points={{-68,124},{-68,56},{12,56},
          {12,70.4}},
                    color={0,0,127}));
  connect(TRoo, conHea.u_m) annotation (Line(points={{-68,124},{-68,56},{-130,
          56},{-130,70.4}},    color={0,0,127}));
  connect(TRooHeaSet, conHea.u_s) annotation (Line(points={{-172,124},{-172,80},
          {-139.6,80}}, color={0,0,127}));
  connect(TRooCooSet, conCoo.u_s) annotation (Line(points={{-30,124},{-30,80},{2.4,
          80}},                color={0,0,127}));
  connect(conCoo.y, yDam.u)
    annotation (Line(points={{20.8,80},{36,80}}, color={0,0,127}));
  connect(yDam.y, vavDam.y)
    annotation (Line(points={{59,80},{72,80},{72,49.8}},   color={0,0,127}));
  connect(conHea.y, yReaHea.u) annotation (Line(points={{-121.2,80},{-116,80},{-116,
          80},{-107.6,80}}, color={0,0,127}));
  connect(yReaHea.y, ReHeat.u) annotation (Line(points={{-89.2,80},{-86,80},{-86,
          20},{-73,20},{-73,22}}, color={0,0,127}));
  connect(ReHeat.port_b, vavDam.port_a) annotation (Line(points={{-18,4},{0,4},
          {0,3},{44,3}},  color={0,127,255}));
  connect(vavDam.port_b, senTemp.port_a) annotation (Line(points={{100,3},{136,
          3}},              color={0,127,255}));
  connect(senTemp.port_b, senVolFlo.port_a)
    annotation (Line(points={{156,3},{168,3}}, color={0,127,255}));
  connect(senVolFlo.port_b, port_b)
    annotation (Line(points={{194,3},{194,1},{218,1}}, color={0,127,255}));
  connect(senVolFlo.V_flow, V_flow1) annotation (Line(points={{181,-11.3},{181,
          -108},{180,-108}}, color={0,0,127}));
  connect(senTemp.T, T1) annotation (Line(points={{146,-13.5},{147,-13.5},{147,
          -109}}, color={0,0,127}));
  connect(vavDam.y_actual, y_damper_actual) annotation (Line(points={{86,30.3},
          {116,30.3},{116,-108}}, color={0,0,127}));
  connect(T1, T1)
    annotation (Line(points={{147,-109},{147,-109}}, color={0,0,127}));
  connect(port_b, port_b)
    annotation (Line(points={{218,1},{218,1}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
            -100},{220,120}}),                                  graphics={
          Rectangle(
          extent={{-178,120},{222,-100}},
          lineColor={0,0,0},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid), Text(
          extent={{-140,86},{180,-74}},
          lineColor={255,255,255},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="VAVReHeat")}),                             Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{220,
            120}})));
end VAVReHeat_withCtrl_TRooCon;
