within IDEAS.Airflow.AHU.BaseClasses;
model SimpleCompressorTable
  "Model of a simple compressor using tables"
  extends IDEAS.Airflow.AHU.BaseClasses.SimpleCompressorInterface(
    Qh_exp(y=tempMod*(P_refrig.y)*mod*onInt.y + P_exp.y),
    Qc_exp(y=-tempMod*P_refrig.y*mod*onInt.y),
    P_exp(y=tempMod*P_comp.y*(fraPmin + mod*(1 - fraPmin))*onInt.y));
  parameter Modelica.SIunits.Temperature T_max = 273.15+50
    "Maximum temperature at condensor";
  parameter Modelica.SIunits.Temperature T_min = 273.15-20
    "Minimum temperature at evaporator";
  parameter Real fraPmin = 0.1;
  parameter Boolean modulatingCompressor = true
    "Simulate the compressor as if it were modulating: non-physical but less events";
  parameter Modelica.SIunits.Temperature modulatingRange = 5
    "Range from temperature bounds where modulation starts";
  parameter Boolean smoothTmpPro = false
    "if true, use smooth temperature protection";
  parameter Modelica.SIunits.TemperatureDifference dT_nom_eva = 10.6
    "Nominal temperature difference between evaporator air inlet and refrigerant";
  parameter Modelica.SIunits.HeatCapacity C "Heat capacity of at condensor heat port";
  Real tempMod = if smoothTmpPro then
                  IDEAS.Utilities.Math.Functions.spliceFunction(x=min(limit1.y,limit2.y)/modulatingRange-1, pos=1, neg=0, deltax=1)
                 else 1
    "Modulation due to temperature bounds without causing events";
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_cond
    annotation (Placement(transformation(extent={{80,-44},{60,-24}})));
  Modelica.Blocks.Interfaces.RealOutput P "Electricity consumption" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,102}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,98})));
  Modelica.Blocks.Interfaces.BooleanInput on "True if compressor is on"
    annotation (Placement(transformation(extent={{-126,30},{-86,70}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-32,90})));
  Modelica.Blocks.Math.BooleanToReal onInt(realTrue=1, realFalse=0)
    annotation (Placement(transformation(extent={{-48,46},{-36,58}})));
protected
  Modelica.Blocks.Logical.Hysteresis hystMax(
    pre_y_start=true,
    uLow=0,
    uHigh=5) annotation (Placement(transformation(extent={{-72,80},{-60,92}})));
  Modelica.Blocks.Sources.RealExpression limit1(y=T_max - T_cond.T)
    annotation (Placement(transformation(extent={{-98,76},{-78,96}})));
  Modelica.Blocks.Logical.Hysteresis hystMin(
    pre_y_start=true,
    uLow=0,
    uHigh=5) annotation (Placement(transformation(extent={{-72,66},{-60,78}})));
  Modelica.Blocks.Sources.RealExpression limit2(y=T_evap.y - T_min)
    annotation (Placement(transformation(extent={{-98,62},{-78,82}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-68,46},{-56,58}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-54,78},{-46,86}})));
public
  Modelica.Blocks.Interfaces.RealInput mod annotation (Placement(transformation(
          extent={{-126,-80},{-86,-40}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-84,90})));
  Modelica.Blocks.Tables.CombiTable2D P_refrig(                         table=[0,
        253.15,258.15,263.15,268.15,273.15,278.15,280.15,283.15,295.65; 303.15,11750,
        15400,19650,24450,29700,35250,37550,41050,44000; 313.15,10300,13200,16900,
        21300,26300,31750,34050,37600,40600; 323.15,10,100,14300,18050,22550,27650,
        29850,33300,36300], smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    "Combitable for refrigeration powers"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Tables.CombiTable2D P_comp(                                                                      table=[0,
        253.15,258.15,263.15,268.15,273.15,278.15,280.15,283.15,295.65; 303.15,4800,
        4870,4920,4980,5050,5170,5240,5350,5470; 313.15,6410,6510,6580,6630,6690,
        6780,6820,6900,6990; 323.15,10,100,8200,8290,8360,8440,8480,8550,8610],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    "Combitable for compressor powers"
    annotation (Placement(transformation(extent={{-20,-82},{0,-62}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=C, T(fixed=
          true))
    annotation (Placement(transformation(extent={{80,18},{100,38}})));
  Modelica.Blocks.Math.Add T_evap(k1=-1) "Refrigerant temperature"
    annotation (Placement(transformation(extent={{-68,-80},{-48,-58}})));
  Modelica.Blocks.Sources.Constant const(k=dT_nom_eva)
    annotation (Placement(transformation(extent={{-104,-36},{-84,-16}})));

equation
  connect(T_cond.port, port_b) annotation (Line(
      points={{80,-34},{90,-34},{90,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(limit1.y, hystMax.u) annotation (Line(
      points={{-77,86},{-73.2,86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(limit2.y, hystMin.u) annotation (Line(
      points={{-77,72},{-73.2,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hystMax.y, and2.u1) annotation (Line(
      points={{-59.4,86},{-56,86},{-56,82},{-54.8,82}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(hystMin.y, and2.u2) annotation (Line(
      points={{-59.4,72},{-56,72},{-56,78.8},{-54.8,78.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and2.y, and1.u1) annotation (Line(
      points={{-45.6,82},{-40,82},{-40,62},{-69.2,62},{-69.2,52}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and1.u2, on) annotation (Line(
      points={{-69.2,47.2},{-70,47.2},{-70,48},{-72,48},{-72,50},{-106,50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and1.y, onInt.u) annotation (Line(
      points={{-55.4,52},{-49.2,52}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(P_comp.u2, P_refrig.u2) annotation (Line(
      points={{-22,-78},{-40,-78},{-40,-56},{-22,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P_comp.u1, P_refrig.u1) annotation (Line(
      points={{-22,-66},{-34,-66},{-34,-44},{-22,-44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P_refrig.u1, T_cond.T) annotation (Line(
      points={{-22,-44},{-34,-44},{-34,-34},{60,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatCapacitor.port, preHeaFloCon.port)
    annotation (Line(points={{90,18},{90,0},{82,0}}, color={191,0,0}));
  connect(T_evap.u2, TinEva) annotation (Line(points={{-70,-75.6},{-74,-75.6},{
          -74,-76},{-80,-76},{-80,-90},{-106,-90}}, color={0,0,127}));
  connect(T_evap.u1, const.y) annotation (Line(points={{-70,-62.4},{-70,-26},{
          -83,-26}}, color={0,0,127}));
  connect(T_evap.y, P_comp.u2) annotation (Line(points={{-47,-69},{-44,-69},{
          -44,-78},{-22,-78}}, color={0,0,127}));
  connect(T_evap.y, Teva)
    annotation (Line(points={{-47,-69},{20,-69},{20,102}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-38,46},{-38,-46},{60,0},{-38,46}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<ul>
<li>
April 27, 2017, by Filip Jorissen:<br/>
Now extending from interface.
See <a href=https://github.com/open-ideas/IDEAS/issues/719>#719</a>.
</li>
<li>
October 11, 2016, by Filip Jorissen:<br/>
Added first implementation.
</li>
</ul>
</html>", info="<html>
<p>
Compressor that uses table interpolation using 
temperature of condensor and evaporator to compute heat flow rates.
</p>
</html>"));
end SimpleCompressorTable;
