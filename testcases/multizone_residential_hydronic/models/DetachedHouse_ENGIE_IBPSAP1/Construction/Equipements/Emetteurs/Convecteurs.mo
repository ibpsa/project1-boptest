within DetachedHouse_ENGIE_IBPSAP1.Construction.Equipements.Emetteurs;
model Convecteurs

  parameter Modelica.SIunits.HeatFlux Khea=50 "Maximal gain value for the heating controller";
  parameter Modelica.SIunits.Area S=1 "Surface of the heated room";
  parameter Real ConvecteurOn=1 "Convector ON/OFF";

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{22,-8},{38,8}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ConvectifHeatPort
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Math.Gain gai(k=ConvecteurOn)
    annotation (Placement(transformation(extent={{-2,-4},{6,4}})));
  Modelica.Blocks.Interfaces.RealInput T
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-100,0},{-60,40}})));
  Modelica.Blocks.Interfaces.RealInput ConsigneCh
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-100,-40},{-60,0}})));
  Regulation.Regul_Ch_1_bis regul_Ch(Khea=Khea*S)
    annotation (Placement(transformation(extent={{-36,-4},{-22,4}})));
equation
  connect(prescribedHeatFlow.port, ConvectifHeatPort)
    annotation (Line(points={{38,0},{60,0}}, color={191,0,0}));
  connect(gai.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{6.4,0},{22,0}}, color={0,0,127}));
  connect(regul_Ch.ConsigneCh, ConsigneCh) annotation (Line(points={{-37.12,
          2.66667},{-54,2.66667},{-54,-20},{-80,-20}},
                                              color={0,0,127}));
  connect(regul_Ch.T, T) annotation (Line(points={{-37.12,0},{-52,0},{-52,20},{-80,
          20}}, color={0,0,127}));
  connect(regul_Ch.yHea, gai.u) annotation (Line(points={{-20.6,0},{-2.8,
          0},{-2.8,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-60,-40},{60,40}})), Icon(
        coordinateSystem(extent={{-60,-40},{60,40}})),
    Documentation(info="<html>
<h4>Emetteurs</h4>
<p>Une r&eacute;gulation classique est coupl&eacute;e &agrave; un port de chaleur convectif. </p>
</html>"));
end Convecteurs;
