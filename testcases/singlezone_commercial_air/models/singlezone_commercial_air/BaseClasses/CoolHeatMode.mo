within singlezone_commercial_air.BaseClasses;
model CoolHeatMode "Determines low or high heating or cooling mode"
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 1.51 "Nominal flow through supply fan";
  parameter Real stage_ratio_airflow = 0.66 "No load or cooling speed 1 airflow ratio";
  /* control & auxiliaries */

  Modelica.Blocks.Interfaces.RealInput TZon "Zone temperature measurement"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Math.BooleanToInteger cooHigOn(integerTrue=1)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput cooDem
    "Cooling demand [0=none, 1=low, 2=high]" annotation (Placement(
        transformation(extent={{100,30},{120,50}}), iconTransformation(extent={
            {100,30},{120,50}})));
  Modelica.Blocks.Math.BooleanToInteger cooLowOn(integerTrue=1)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Blocks.MathInteger.Sum sumSta(nu=2)
    annotation (Placement(transformation(extent={{34,34},{46,46}})));
  Modelica.Blocks.Math.Add conCooLow(k2=-1)
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis cooHysLow(uLow=0.25, uHigh=
        0.5) "Hysteresis to switch on low cooling"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Interfaces.RealInput TSetCoo
    "Zone cooling temperature set point"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput TSetHea
    "Zone heating temperature set point"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Math.Add conCooHig(k2=-1)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis cooHysHig(uLow=0.25 + 0.25,
      uHigh=0.5 + 0.5) "Hysteresis to switch on high cooling"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Math.Add conHea(k2=-1)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Hysteresis heaSta(uLow=-0.5, uHigh=0.5)
    "Hysteresis to switch on heating stage 1"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput heaEna "Heating status"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}}),
        iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput cooEna "Cooling status"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
equation
  connect(sumSta.y, cooDem)
    annotation (Line(points={{46.9,40},{110,40}}, color={255,127,0}));
  connect(cooHigOn.y, sumSta.u[1]) annotation (Line(points={{21,0},{30,0},{30,
          42.1},{34,42.1}}, color={255,127,0}));
  connect(cooLowOn.y, sumSta.u[2]) annotation (Line(points={{21,30},{28,30},{28,
          37.9},{34,37.9}}, color={255,127,0}));
  connect(conCooLow.y, cooHysLow.u)
    annotation (Line(points={{-49,30},{-42,30}}, color={0,0,127}));
  connect(TZon, conCooLow.u1) annotation (Line(points={{-120,60},{-92,60},{-92,
          36},{-72,36}}, color={0,0,127}));
  connect(TSetCoo, conCooLow.u2) annotation (Line(points={{-120,0},{-88,0},{-88,
          24},{-72,24}}, color={0,0,127}));
  connect(cooHysLow.y, cooLowOn.u)
    annotation (Line(points={{-18,30},{-2,30}}, color={255,0,255}));
  connect(TZon, conCooHig.u1) annotation (Line(points={{-120,60},{-92,60},{-92,
          6},{-72,6}}, color={0,0,127}));
  connect(TSetCoo, conCooHig.u2) annotation (Line(points={{-120,0},{-88,0},{-88,
          -6},{-72,-6}}, color={0,0,127}));
  connect(conCooHig.y, cooHysHig.u)
    annotation (Line(points={{-49,0},{-42,0}}, color={0,0,127}));
  connect(cooHysHig.y, cooHigOn.u)
    annotation (Line(points={{-18,0},{-2,0}}, color={255,0,255}));
  connect(TSetHea, conHea.u1) annotation (Line(points={{-120,-60},{-78,-60},{
          -78,-34},{-72,-34}}, color={0,0,127}));
  connect(conHea.u2, conCooHig.u1) annotation (Line(points={{-72,-46},{-92,-46},
          {-92,6},{-72,6}}, color={0,0,127}));
  connect(conHea.y, heaSta.u)
    annotation (Line(points={{-49,-40},{-42,-40}}, color={0,0,127}));
  connect(heaSta.y, heaEna)
    annotation (Line(points={{-18,-40},{110,-40}}, color={255,0,255}));
  connect(integerToReal.y, greaterThreshold.u)
    annotation (Line(points={{61,0},{68,0}}, color={0,0,127}));
  connect(greaterThreshold.y, cooEna)
    annotation (Line(points={{91,0},{110,0}}, color={255,0,255}));
  connect(sumSta.y, integerToReal.u) annotation (Line(points={{46.9,40},{60,40},
          {60,20},{34,20},{34,0},{38,0}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-100,140},{100,100}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end CoolHeatMode;
