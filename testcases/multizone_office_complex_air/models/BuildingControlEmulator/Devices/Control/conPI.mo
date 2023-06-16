within BuildingControlEmulator.Devices.Control;
model conPI "\"PI Controller\""

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
  Modelica.Blocks.Interfaces.RealInput SetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Mea
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Continuous.Switch swi
    annotation (Placement(transformation(extent={{40,10},{60,-10}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zerSpe(k=0)
    "Zero fan speed when it becomes OFF"
    annotation (Placement(transformation(extent={{-10,26},{10,46}})));
equation
  connect(conPID.u_s, SetPoi) annotation (Line(
      points={{-10,-20},{-66,-20},{-66,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(swi.y, y) annotation (Line(
      points={{62,0},{110,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Mea, conPID.u_m) annotation (Line(
      points={{-120,-60},{-60,-60},{2,-60},{2,-32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(On, swi.u2) annotation (Line(points={{-120,60},{-40,60},{-40,0},{38,0}},
        color={255,0,255}));
  connect(conPID.y, swi.u1) annotation (Line(points={{14,-20},{20,-20},{20,-8},{
          38,-8}}, color={0,0,127}));
  connect(zerSpe.y, swi.u3)
    annotation (Line(points={{12,36},{30,36},{30,8},{38,8}}, color={0,0,127}));
  connect(On, conPID.trigger) annotation (Line(points={{-120,60},{-60,60},{-60,-40},
          {-4,-40},{-4,-32}}, color={255,0,255}));
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
          textString="PI")}),            Diagram(coordinateSystem(
          preserveAspectRatio=false), graphics={Line(points={{32,-16}}, color={28,
              108,200})}));
end conPI;
