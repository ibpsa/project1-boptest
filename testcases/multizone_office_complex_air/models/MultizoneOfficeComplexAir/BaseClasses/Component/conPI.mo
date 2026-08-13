within MultizoneOfficeComplexAir.BaseClasses.Component;
model conPI "PI Controller with ON/OFF Signal"

  parameter Real yMin(min=0, max=1, unit="1") = 0
    "Lowest y output";
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.5
    "Time constant of Integrator block";
  parameter Boolean reverseActing=true
    "Set to true for reverse acting, or false for direct acting control action";
  Modelica.Blocks.Interfaces.BooleanInput On
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Buildings.Controls.OBC.CDL.Continuous.PIDWithReset
                                   conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=yMin,
    xi_start=0,
    k=k,
    Ti=Ti,
    reverseActing=reverseActing,
    y_reset=yMin)
    annotation (Placement(transformation(extent={{-8,-30},{12,-10}})));
  Modelica.Blocks.Interfaces.RealInput set
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput mea
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));

  Buildings.Controls.OBC.CDL.Continuous.Multiply mul
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
equation
  connect(conPID.u_s, set) annotation (Line(points={{-10,-20},{-66,-20},{
          -66,0},{-120,0}}, color={0,0,127}));
  connect(mea, conPID.u_m) annotation (Line(
      points={{-120,-60},{-60,-60},{2,-60},{2,-32}},
      color={0,0,127}));
  connect(On, conPID.trigger) annotation (Line(points={{-120,60},{-60,60},{-60,-40},
          {-4,-40},{-4,-32}}, color={255,0,255}));
  connect(mul.y, y) annotation (Line(points={{62,0},{110,0}}, color={0,0,127}));
  connect(conPID.y, mul.u2) annotation (Line(points={{14,-20},{26,-20},{26,-6},
          {38,-6}}, color={0,0,127}));
  connect(On, booToRea.u) annotation (Line(points={{-120,60},{-66,60},{-66,60},
          {-12,60}}, color={255,0,255}));
  connect(booToRea.y, mul.u1)
    annotation (Line(points={{12,60},{26,60},{26,6},{38,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-66,50},{62,-48}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="PI"),
        Text(
          extent={{-152,110},{148,150}},
          textString="%name",
          textColor={0,0,255})}),        Diagram(coordinateSystem(
          preserveAspectRatio=false), graphics={Line(points={{32,-16}}, color={28,
              108,200})}),
    Documentation(info="<html>
<p>This model is a PI controller with an external boolean signal. When the boolean signal is true, the model outputs the PI controller output. When it is false, the model outputs zero.</p>
</html>"));
end conPI;
