within MultiZoneResidentialHydronic.Building.Control;
block ConVentilation "Control block for global mechanical ventilation"

  parameter Modelica.SIunits.Density d_air = 1.184 "Air density";
  parameter Modelica.SIunits.Pressure dp=100 "Assumed extraction air pressure head";
  parameter Real etaHyd(final quantity="Efficiency",
      final unit="1")=0.7 "Hydraulic efficiency";

  parameter Real etaMot(final quantity="Efficiency",
      final unit="1")=0.7 "Motor efficiency";

  Modelica.Blocks.Interfaces.RealOutput m_flow_extraction(unit="kg/s")
    "Extraction mass flow rate for mechanical ventilation"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant m_flow_extraction_const(k=113.4/3600*d_air)
    "Global mechanical ventilation airflow"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveMVen(description=
        "Global mechanical ventilation air flow", u(
      min=0,
      max=1,
      unit="kg/s")) "Overwrites global mechanical ventilation air flow"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaMVen(
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="kg/s"),
    description="Mechanical ventilation air flow") "Reads mechanical ventilation air flow"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaPFan(
    y(unit="W"),
    description="Extraction fan electrical power use",
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
    "Read power for extraction fan"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=dp*m_flow_extraction/
        d_air/etaHyd/etaMot)
    "Expression to compute fan power use"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
equation
  connect(m_flow_extraction_const.y, oveMVen.u)
    annotation (Line(points={{-59,0},{-42,0}}, color={0,0,127}));
  connect(oveMVen.y, reaMVen.u)
    annotation (Line(points={{-19,0},{-2,0}}, color={0,0,127}));
  connect(reaMVen.y, m_flow_extraction)
    annotation (Line(points={{21,0},{110,0}}, color={0,0,127}));
  connect(realExpression.y, reaPFan.u)
    annotation (Line(points={{21,50},{58,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ConVentilation;
