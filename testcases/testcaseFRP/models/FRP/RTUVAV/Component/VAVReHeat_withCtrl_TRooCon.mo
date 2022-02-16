within FRP.RTUVAV.Component;
model VAVReHeat_withCtrl_TRooCon
  "This model includes VAV damper controller. Heater controlls room air temperature."
   replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
   parameter Modelica.SIunits.MassFlowRate m_flow_nominal=m_flow_nominal;
   parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal=Q_flow_nominal;
   parameter Modelica.SIunits.PressureDifference dp_nominal=dp_nominal;

  Buildings.Fluid.Actuators.Dampers.VAVBoxExponential vavDam(
    redeclare package Medium =Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{28,-34},{84,44}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u
                                          ReHeat(
    redeclare package Medium =Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    tau=300,
    Q_flow_nominal=Q_flow_nominal)
    annotation (Placement(transformation(extent={{-68,-26},{-18,34}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-6},{110,14}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-150,-6},{-130,14}})));
  Modelica.Blocks.Interfaces.RealInput TRooHeaSet
    "Room air heating temperature set point" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-126,110})));
  Modelica.Blocks.Interfaces.RealInput TRoo "room air temperature"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-52,114})));
  Modelica.Blocks.Interfaces.RealInput TRooCooSet
    "zone air temperature cooling setpoint" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,112})));
  Buildings.Controls.Continuous.LimPID conCoo(
    yMax=1,
    Td=60,
    k=0.1,
    Ti=120,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reverseAction=true)
    "Controller for cooling (acts on damper)"
    annotation (Placement(transformation(extent={{14,58},{34,78}})));
  Buildings.Controls.OBC.CDL.Continuous.LimPID conHea(
    yMax=1,
    initType=Buildings.Controls.OBC.CDL.Types.Init.NoInit,
    xi_start=0,
    Td=60,
    yMin=0,
    k=0.1,
    Ti=120,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI)
            "Controller for heating"
    annotation (Placement(transformation(extent={{-116,56},{-96,76}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort ReheatT(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Temperature after Reheat"
    annotation (Placement(transformation(extent={{-6,-10},{14,20}})));
equation
  connect(vavDam.port_b, port_b) annotation (Line(points={{84,5},{84,4},{100,4}},
                    color={0,127,255}));
  connect(ReHeat.port_a, port_a)
    annotation (Line(points={{-68,4},{-140,4}}, color={0,127,255}));
  connect(TRooCooSet, conCoo.u_s) annotation (Line(points={{0,112},{0,68},{12,
          68}},         color={0,0,127}));
  connect(TRoo, conCoo.u_m) annotation (Line(points={{-52,114},{-52,48},{24,48},
          {24,56}}, color={0,0,127}));
  connect(TRooHeaSet, conHea.u_s) annotation (Line(points={{-126,110},{-126,66},
          {-118,66}}, color={0,0,127}));
  connect(TRoo, conHea.u_m) annotation (Line(points={{-52,114},{-52,48},{-106,
          48},{-106,54}},      color={0,0,127}));
  connect(conHea.y, ReHeat.u) annotation (Line(points={{-95,66},{-90,66},{-90,22},
          {-73,22}}, color={0,0,127}));
  connect(conCoo.y, vavDam.y)
    annotation (Line(points={{35,68},{56,68},{56,51.8}}, color={0,0,127}));
  connect(ReHeat.port_b, ReheatT.port_a) annotation (Line(points={{-18,4},{-12,4},
          {-12,5},{-6,5}}, color={0,127,255}));
  connect(ReheatT.port_b, vavDam.port_a)
    annotation (Line(points={{14,5},{28,5}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{100,100}}),                                  graphics={
          Rectangle(
          extent={{-98,94},{88,-64}},
          lineColor={0,0,0},
          fillColor={75,156,217},
          fillPattern=FillPattern.Solid), Text(
          extent={{-68,46},{58,-18}},
          lineColor={0,0,0},
          fillColor={75,156,217},
          fillPattern=FillPattern.Solid,
          textString="VAVReHeat",
          textStyle={TextStyle.Bold})}),                         Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{100,
            100}})));
end VAVReHeat_withCtrl_TRooCon;
