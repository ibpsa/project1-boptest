within MultiZoneResidentialHydronic.Building.Control;
model ConCoo "Controller for cooling"

  Buildings.Controls.Continuous.LimPID conCoo(
    Ni=0.1,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    Td=1e4,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=180,
    reverseActing=false,
    k=1e-2) "Controller for cooling"
    annotation (Placement(transformation(extent={{-68,16},{-60,24}})));
  Modelica.Blocks.Interfaces.RealInput T annotation (Placement(transformation(
        rotation=0,
        extent={{-16,-16},{16,16}},
        origin={-116,10}), iconTransformation(extent={{-8,-8},{8,8}}, origin=
            {-108,10})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow for heating and cooling"
    annotation (Placement(transformation(extent={{-24,4},{-12,16}})));
  Modelica.Blocks.Math.Gain gaiCoo(k=-Kcoo)
    annotation (Placement(transformation(extent={{-54,16},{-46,24}})));
  Modelica.Blocks.Interfaces.RealInput TSet
    "Connector of setpoint input signal" annotation (Placement(transformation(
          extent={{-132,-34},{-100,-2}}), iconTransformation(extent={{-116,-18},
            {-100,-2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b P annotation (Placement(
        transformation(rotation=0, extent={{-6,4},{6,16}})));
  parameter Real Kcoo=1e3 "Gain value for the cooling controller";

  parameter String zone="1" "Zone designation";

  IBPSA.Utilities.IO.SignalExchange.Overwrite oveTSetCoo(u(
      min=273.15 + 10,
      max=273.15 + 30,
      unit="K"), description="Air temperature cooling setpoint for " + zone)
    annotation (Placement(transformation(extent={{-84,16},{-76,24}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaPCoo(
    description="Cooling electrical power use in zone " + zone,
                                                KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))
    annotation (Placement(transformation(extent={{-8,26},{0,34}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite ovePCoo(description=
        "Prescribed cooling power for " + zone,
                                   u(
      min=-1e4,
      max=0,
      unit="W"))
    annotation (Placement(transformation(extent={{-40,16},{-32,24}})));
  Modelica.Blocks.Math.Gain HeaToPowFactor(k=-1/3)
    "Heating to power factor related to the energy efficiency of the air conditioner"
    annotation (Placement(transformation(extent={{-22,26},{-14,34}})));
equation
  connect(T,conCoo. u_m) annotation (Line(points={{-116,10},{-64,10},{-64,15.2}},
        color={0,0,127}));
  connect(conCoo.y, gaiCoo.u)
    annotation (Line(points={{-59.6,20},{-54.8,20}}, color={0,0,127}));
  connect(conCoo.u_s,oveTSetCoo. y)
    annotation (Line(points={{-68.8,20},{-75.6,20}}, color={0,0,127}));
  connect(oveTSetCoo.u, TSet) annotation (Line(points={{-84.8,20},{-96,20},{-96,
          -18},{-116,-18}}, color={0,0,127}));
  connect(gaiCoo.y, ovePCoo.u)
    annotation (Line(points={{-45.6,20},{-40.8,20}}, color={0,0,127}));
  connect(ovePCoo.y, preHea.Q_flow) annotation (Line(points={{-31.6,20},{-28,20},
          {-28,10},{-24,10}}, color={0,0,127}));
  connect(reaPCoo.u, HeaToPowFactor.y)
    annotation (Line(points={{-8.8,30},{-13.6,30}}, color={0,0,127}));
  connect(HeaToPowFactor.u, preHea.Q_flow) annotation (Line(points={{-22.8,30},
          {-28,30},{-28,10},{-24,10}}, color={0,0,127}));
  connect(preHea.port, P)
    annotation (Line(points={{-12,10},{0,10}}, color={191,0,0}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-20},{0,40}},   preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-100,-20},{0,40}})),
    Documentation(info="<html>
<h4>Control</h4>
<p>PID cooling control to match a setpoint of temperature.</p>
</html>"));
end ConCoo;
