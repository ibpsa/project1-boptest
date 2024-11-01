within FRP.RTUVAV.Component;
model readZone
  Buildings.Utilities.IO.SignalExchange.Read TSupZone(
    description="Discharge air temperature to zone measurement for zone",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply air temperature to zone measurement"
    annotation (Placement(transformation(extent={{-6,-14},{14,6}})));

  Buildings.Utilities.IO.SignalExchange.Read V_flow(
    description="Discharge air flowrate to zone measurement for zone",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply air flowrate to zone measurement"
    annotation (Placement(transformation(extent={{-4,-64},{16,-44}})));

  Buildings.Utilities.IO.SignalExchange.Read DamPosition(
    description="VAV zone damper position",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="1")) "VAV zone damper position"
    annotation (Placement(transformation(extent={{-6,26},{14,46}})));

  Modelica.Blocks.Interfaces.RealInput TSupZone_in
    "Connector of Real input signal" annotation (Placement(transformation(
          extent={{-142,-24},{-102,16}}), iconTransformation(extent={{-142,-24},
            {-102,16}})));
  Modelica.Blocks.Interfaces.RealInput VflowSupply_in
    "Connector of Real input signal" annotation (Placement(transformation(
          extent={{-140,-74},{-100,-34}}), iconTransformation(extent={{-140,-74},
            {-100,-34}})));
  Modelica.Blocks.Interfaces.RealInput DamPosition_in
    "Connector of Real input signal" annotation (Placement(transformation(
          extent={{-142,16},{-102,56}}), iconTransformation(extent={{-142,16},{
            -102,56}})));
equation
  connect(TSupZone.u, TSupZone_in)
    annotation (Line(points={{-8,-4},{-122,-4}}, color={0,0,127}));
  connect(V_flow.u, VflowSupply_in)
    annotation (Line(points={{-6,-54},{-120,-54}}, color={0,0,127}));
  connect(DamPosition.u, DamPosition_in)
    annotation (Line(points={{-8,36},{-122,36}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-102,100},{100,-98}},
          lineColor={0,0,127},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid), Text(
          extent={{-88,52},{92,-60}},
          lineColor={255,255,255},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          textString="ReadZone",
          textStyle={TextStyle.Bold})}),
                                    Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end readZone;
