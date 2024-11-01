within FRP.RTUVAV.Component;
model outdoorAirCon "Outdoor air control"
  Modelica.Blocks.Sources.RealExpression oA_DamSet(y=0)
    annotation (Placement(transformation(extent={{-196,-38},{-120,24}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveOADam(description=
        "OA Damper position", u(
      unit="1",
      min=0,
      max=1)) "OA damper position setpoint"
    annotation (Placement(transformation(extent={{-62,-18},{-40,4}})));
  Modelica.Blocks.Interfaces.RealOutput oAactuator
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{156,-18},{178,4}})));
equation
  connect(oA_DamSet.y, oveOADam.u)
    annotation (Line(points={{-116.2,-7},{-64.2,-7}}, color={0,0,127}));
  connect(oveOADam.y, oAactuator)
    annotation (Line(points={{-38.9,-7},{167,-7}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -80},{160,60}}), graphics={Rectangle(
          extent={{-200,60},{160,-78}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid), Text(
          extent={{-154,56},{122,-68}},
          lineColor={255,255,255},
          fillColor={102,44,145},
          fillPattern=FillPattern.None,
          textStyle={TextStyle.Bold},
          textString="OADamCon")}),      Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-200,-80},{160,60}})));
end outdoorAirCon;
