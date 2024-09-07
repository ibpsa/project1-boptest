within FRP.RTUVAV.Component;
model staticPressureCon
  Modelica.Blocks.Sources.RealExpression staPre_SP(y=124)
    "Static pressure setpoint [pa]"
    annotation (Placement(transformation(extent={{-112,-52},{-34,18}})));
  Modelica.Blocks.Math.Add minus(k2=-1)
    annotation (Placement(transformation(extent={{66,-142},{108,-100}})));
  Modelica.Blocks.Sources.RealExpression pat(y=101325)
    "atmospheric pressure [pa]"
    annotation (Placement(transformation(extent={{-114,-184},{14,-110}})));
  Buildings.Controls.Continuous.LimPID confan(
    yMax=1,
    Td=60,
    k=0.1,
    Ti=60,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    yMin=0.5,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reverseActing=true)  "Controller for fan"
    annotation (Placement(transformation(extent={{184,-70},{256,2}})));
  Modelica.Blocks.Interfaces.RealOutput staticPressure_out
    "Connector of actuator output signal"
    annotation (Placement(transformation(extent={{344,-112},{364,-92}})));
  Modelica.Blocks.Interfaces.RealInput senPreSup_in
    "Connector of Real input signal 1"
    annotation (Placement(transformation(extent={{-150,-100},{-110,-60}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveTSup(description=
        "Static Pressure Setpoint", u(unit="Pa"))
                 "Overwrite for supply air temperature signal"
    annotation (Placement(transformation(extent={{48,-36},{86,2}})));
equation
  connect(pat.y,minus. u2) annotation (Line(
      points={{20.4,-147},{49.2,-147},{49.2,-133.6},{61.8,-133.6}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(minus.y,confan. u_m) annotation (Line(
      points={{110.1,-121},{169.05,-121},{169.05,-77.2},{220,-77.2}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(confan.y, staticPressure_out) annotation (Line(points={{259.6,-34},{
          302,-34},{302,-102},{354,-102}}, color={0,0,127}));
  connect(minus.u1, senPreSup_in) annotation (Line(points={{61.8,-108.4},{50,
          -108.4},{50,-80},{-130,-80}}, color={0,0,127}));
  connect(oveTSup.y, confan.u_s) annotation (Line(points={{87.9,-17},{128.95,
          -17},{128.95,-34},{176.8,-34}}, color={0,0,127}));
  connect(staPre_SP.y, oveTSup.u) annotation (Line(points={{-30.1,-17},{5.95,
          -17},{5.95,-17},{44.2,-17}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -240},{340,80}}), graphics={Rectangle(
          extent={{-118,78},{344,-240}},
          lineColor={255,255,255},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid), Text(
          extent={{-66,14},{290,-156}},
          lineColor={255,255,255},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          textString="StaticPressureCon",
          textStyle={TextStyle.Bold})}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-120,-240},{340,80}})));
end staticPressureCon;
