within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal;
package Control

  model ZonCon "Zone terminal VAV controller"
    parameter Real MinFlowRateSetPoi "Minimum flow rate ratio";
    parameter Real HeatingFlowRateSetPoi "constant flow rate ratio during heating mode";
    Buildings.Controls.Continuous.LimPID cooCon(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=60,
      yMin=MinFlowRateSetPoi,
      reverseActing=false)
             annotation (Placement(transformation(extent={{-10,50},{10,70}})));
    Buildings.Controls.Continuous.LimPID heaCon(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=60,
      k=0.01,
      reverseActing=true)
             annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
    Modelica.Blocks.Interfaces.RealInput T
      "Connector of measurement input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput TCooSet
      "Connector of setpoint input signal" annotation (Placement(
          transformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealInput THeaSet
      "Connector of setpoint input signal" annotation (Placement(
          transformation(extent={{-140,-80},{-100,-40}})));
    Modelica.Blocks.Interfaces.RealOutput yAirFlowSet
      "Connector of actuator output signal" annotation (Placement(
          transformation(extent={{100,50},{120,70}}),
          iconTransformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput yValPos
      "Connector of actuator output signal"
      annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
          iconTransformation(extent={{100,-70},{120,-50}})));
    Modelica.Blocks.Logical.Switch swi
      "Switch between external signal and direct feedthrough signal"
      annotation (Placement(transformation(extent={{50,10},{70,30}})));
    Modelica.Blocks.Sources.Constant const(k=HeatingFlowRateSetPoi)
      annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0, uHigh=0.5)
      annotation (Placement(transformation(extent={{-26,10},{-6,30}})));
    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{-56,10},{-36,30}})));
  equation
    connect(cooCon.y, swi.u1) annotation (Line(points={{11,60},{34,60},
            {34,28},{48,28}},
                  color={0,0,127}));
    connect(const.y, swi.u3) annotation (Line(
        points={{21,-20},{34,-20},{34,12},{48,12}},
        color={0,0,127}));
    connect(add.y, hysteresis.u) annotation (Line(
        points={{-35,20},{-28,20}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(hysteresis.y, swi.u2) annotation (Line(
        points={{-5,20},{48,20}},
        color={255,0,255}));
    connect(TCooSet, cooCon.u_s)
      annotation (Line(points={{-120,60},{-12,60}}, color={0,0,127}));
    connect(T, add.u1) annotation (Line(points={{-120,0},{-80,0},{-80,
            26},{-58,26}}, color={0,0,127}));
    connect(T, cooCon.u_m) annotation (Line(points={{-120,0},{0,0},{0,
            48}}, color={0,0,127}));
    connect(T, heaCon.u_m) annotation (Line(points={{-120,0},{-40,0},{-40,-80},
            {60,-80},{60,-72}},          color={0,0,127}));
    connect(THeaSet, heaCon.u_s)
      annotation (Line(points={{-120,-60},{48,-60}}, color={0,0,127}));
    connect(THeaSet, add.u2) annotation (Line(points={{-120,-60},{-72,-60},
            {-72,14},{-58,14}}, color={0,0,127}));
    connect(heaCon.y, yValPos)
      annotation (Line(points={{71,-60},{110,-60}}, color={0,0,127}));
    connect(swi.y, yAirFlowSet) annotation (Line(points={{71,20},{80,20},{80,60},
            {110,60}},           color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-154,112},{146,152}},
            textString="%name",
            textColor={0,0,255})}),           Diagram(coordinateSystem(
            preserveAspectRatio=false)),
      Documentation(info="<html>
<p>This is the zone terminal VAV controller. It takes the temperature measurements and cooling/heating setpoints as inputs. It takes the zone heating/cooling mode, discharge airflow setpoint, VAV damper position as the output.</p>
</html>",   revisions = "<html>
<ul>
<li> August 17, 2023, by Xing Lu, Sen Huang, Lingzhe Wang:
<p> First implementation.</p>
</ul>
</html>"));
  end ZonCon;

end Control;
