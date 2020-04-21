within DetachedHouse_ENGIE_IBPSAP1.Construction.Regulation;
model Regul_Clim_1

  Buildings.Controls.Continuous.LimPID conCoo(
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    Td=1e4,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=300,
    reverseAction=true,
    k=5e-2) "Controller for cooling"
    annotation (Placement(transformation(extent={{-62,16},{-54,24}})));
  Modelica.Blocks.Interfaces.RealInput T annotation (Placement(transformation(
        rotation=0,
        extent={{-16,-16},{16,16}},
        origin={-116,10}), iconTransformation(extent={{-8,-8},{8,8}}, origin=
            {-108,10})));
  Modelica.Blocks.Continuous.Integrator ECoo(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    u(unit="W"),
    y(unit="J")) "Cooling energy in Joules"
    annotation (Placement(transformation(extent={{-24,26},{-16,34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow for heating and cooling"
    annotation (Placement(transformation(extent={{-26,4},{-14,16}})));
  Modelica.Blocks.Math.Gain gaiCoo(k=-Kcoo)
    annotation (Placement(transformation(extent={{-46,16},{-38,24}})));
  Modelica.Blocks.Interfaces.RealInput ConsigneClim
    "Connector of setpoint input signal" annotation (Placement(transformation(
          extent={{-132,-34},{-100,-2}}), iconTransformation(extent={{-116,
            -18},{-100,-2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b P annotation (Placement(
        transformation(rotation=0, extent={{-10,7},{10,13}})));
  parameter Real Kcoo=1e6 "Gain value for the cooling controller";
equation
  connect(T,conCoo. u_m) annotation (Line(points={{-116,10},{-58,10},{-58,
          15.2}},
        color={0,0,127}));
  connect(conCoo.y, gaiCoo.u)
    annotation (Line(points={{-53.6,20},{-46.8,20}}, color={0,0,127}));
  connect(gaiCoo.y, ECoo.u) annotation (Line(points={{-37.6,20},{-32,20},{-32,
          30},{-24.8,30}}, color={0,0,127}));
  connect(preHea.Q_flow, gaiCoo.y) annotation (Line(points={{-26,10},{-32,
          10},{-32,20},{-37.6,20}},
                                color={0,0,127}));
  connect(conCoo.u_s, ConsigneClim) annotation (Line(points={{-62.8,20},{-82,
          20},{-82,-18},{-116,-18}}, color={0,0,127}));
  connect(preHea.port, P)
    annotation (Line(points={{-14,10},{0,10}}, color={191,0,0}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-20},{0,40}},   preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-100,-20},{0,40}})),
    Documentation(info="<html>
<h4>R&eacute;gulations</h4>
<p>R&eacute;gulation sur la climatisation pour respecter une temp&eacute;rature de consigne, &agrave; l&apos;aide d&apos;un PID.</p>
</html>"));
end Regul_Clim_1;
