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
    annotation (Placement(transformation(extent={{-76,16},{-68,24}})));
  Modelica.Blocks.Interfaces.RealInput T annotation (Placement(transformation(
        rotation=0,
        extent={{-16,-16},{16,16}},
        origin={-116,10}), iconTransformation(extent={{-8,-8},{8,8}}, origin=
            {-108,10})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow for heating and cooling"
    annotation (Placement(transformation(extent={{-24,4},{-12,16}})));
  Modelica.Blocks.Math.Gain gaiCoo(k=-Kcoo)
    annotation (Placement(transformation(extent={{-40,16},{-32,24}})));
  Modelica.Blocks.Interfaces.RealInput TSet
    "Connector of setpoint input signal" annotation (Placement(transformation(
          extent={{-132,-34},{-100,-2}}), iconTransformation(extent={{-116,-18},
            {-100,-2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b P annotation (Placement(
        transformation(rotation=0, extent={{-6,4},{6,16}})));
  parameter Real Kcoo=1e3 "Gain value for the cooling controller";

  parameter String zone="1" "Zone designation";

  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo(u(
      min=273.15 + 10,
      max=273.15 + 30,
      unit="K"), description="Air temperature cooling setpoint for zone " +
        zone)
    annotation (Placement(transformation(extent={{-92,16},{-84,24}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPCoo(
    description="Cooling electrical power use in zone " + zone,
                                                KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))
    annotation (Placement(transformation(extent={{-8,26},{0,34}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveCoo(description=
        "Cooling control signal as fraction of maximum for zone " + zone, u(
      min=0,
      max=1,
      unit="1"))
    annotation (Placement(transformation(extent={{-64,16},{-56,24}})));
  Modelica.Blocks.Math.Gain HeaToPowFactor(k=-1/3)
    "Heating to power factor related to the energy efficiency of the air conditioner"
    annotation (Placement(transformation(extent={{-22,26},{-14,34}})));

equation
  connect(T,conCoo. u_m) annotation (Line(points={{-116,10},{-72,10},{-72,15.2}},
        color={0,0,127}));
  connect(conCoo.u_s,oveTSetCoo. y)
    annotation (Line(points={{-76.8,20},{-83.6,20}}, color={0,0,127}));
  connect(oveTSetCoo.u, TSet) annotation (Line(points={{-92.8,20},{-96,20},{-96,
          -18},{-116,-18}}, color={0,0,127}));
  connect(reaPCoo.u, HeaToPowFactor.y)
    annotation (Line(points={{-8.8,30},{-13.6,30}}, color={0,0,127}));
  connect(preHea.port, P)
    annotation (Line(points={{-12,10},{0,10}}, color={191,0,0}));
  connect(gaiCoo.y, HeaToPowFactor.u) annotation (Line(points={{-31.6,20},{-28,
          20},{-28,30},{-22.8,30}}, color={0,0,127}));
  connect(gaiCoo.y, preHea.Q_flow) annotation (Line(points={{-31.6,20},{-28,20},
          {-28,10},{-24,10}}, color={0,0,127}));
  connect(conCoo.y, oveCoo.u)
    annotation (Line(points={{-67.6,20},{-64.8,20}}, color={0,0,127}));
  connect(oveCoo.y, gaiCoo.u)
    annotation (Line(points={{-55.6,20},{-40.8,20}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-20},{0,40}},   preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-100,-20},{0,40}})),
    Documentation(info="<html>
<h4>Control</h4>
<p>PID cooling control to match a setpoint of temperature.</p>
</html>"));
end ConCoo;
