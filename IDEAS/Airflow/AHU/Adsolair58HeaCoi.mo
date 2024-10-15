within IDEAS.Airflow.AHU;
model Adsolair58HeaCoi
  "Adsolair 58 with additional heating coil model"
  extends IDEAS.Airflow.AHU.Adsolair58(
    redeclare Fluid.HeatExchangers.ConstantEffectiveness
      hexSupOut(
      m1_flow_nominal=m1_flow_nominal,
      m2_flow_nominal=m2_flow_nominal,
      dp1_nominal=0,
      eps=per.epsHeating,
      redeclare package Medium1 = MediumAir,
      dp2_nominal=per.dp2_nominal_heater,
      redeclare package Medium2 = MediumHeating,
      allowFlowReversal1=false,
      allowFlowReversal2=true,
      show_T=true), redeclare BaseClasses.AdsolairControllerHeaCoi adsCon);
  replaceable package MediumHeating =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = MediumHeating)
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = MediumHeating)
    annotation (Placement(transformation(extent={{-90,-110},{-70,-90}})));
  Modelica.Blocks.Sources.RealExpression THeaExp(y=Medium1.temperature(
        Medium1.setState_phX(
        hexSupOut.port_b1.p,
        hexSupOut.port_b1.h_outflow,
        hexSupOut.port_b1.Xi_outflow))) "Heater outlet temperature"
    annotation (Placement(transformation(extent={{-86,56},{-60,40}})));
  Modelica.Blocks.Interfaces.RealOutput yHea "Control signal for heating coil"
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
equation
  connect(hexSupOut.port_a2, port_a) annotation (Line(points={{-92,-32},{-92,-46},
          {-80,-46},{-80,-100}}, color={0,127,255}));
  connect(hexSupOut.port_b2, port_b) annotation (Line(points={{-72,-32},{-72,-32},
          {-72,-46},{-72,-46},{-20,-46},{-20,-100}}, color={0,127,255}));
  connect(THeaExp.y, adsCon.THeaOut) annotation (Line(points={{-58.7,48},{-52,
          48},{-52,53.2},{-44.6,53.2}}, color={0,0,127}));
  connect(yHea, adsCon.yHea) annotation (Line(
      points={{106,0},{-23,0},{-23,55.6}},
      color={0,0,127},
      visible=false));
  annotation (Documentation(revisions="<html>
<ul>
<li>
January 26, 2018, by Filip Jorissen:<br/>
Improved adsolair controller performance.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/751\">#751</a>,
<a href=\"https://github.com/open-ideas/IDEAS/issues/730\">#730</a>,
<a href=\"https://github.com/open-ideas/IDEAS/issues/729\">#729</a>,
<a href=\"https://github.com/open-ideas/IDEAS/issues/754\">#754</a>.
</li>
<li>
October 11, 2016, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Example model of Menerga type 58 air handling unit with 
additional heating coil and corresponding controller model.
It demonstrates how the original model can easily 
be extended to support additional functionality
and a new controller.
The <code>yHea</code> output should be connected to an external valve 
that controls the secondary mass flow rate of the heating coil.
</p>
</html>"), Icon(graphics={
        Rectangle(
          extent={{-80,-40},{-70,-80}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-80,-100}}, color={255,0,0}),
        Line(points={{-70,-80},{-20,-80},{-20,-98}}, color={255,128,0})}));
end Adsolair58HeaCoi;
