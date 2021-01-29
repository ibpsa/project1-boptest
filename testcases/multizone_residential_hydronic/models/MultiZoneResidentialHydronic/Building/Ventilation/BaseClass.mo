within MultiZoneResidentialHydronic.Building.Ventilation;
model BaseClass "Base class for ventilation"
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}),
                                                    iconTransformation(extent={{-110,
            -10},{-90,10}})));
  parameter Integer nPorts=2 "Number of ports";
  parameter String zone="1" "Zone designation";
  parameter Boolean isConditionedZone=true "True if the zone is conditioned";

  Modelica.Fluid.Interfaces.FluidPorts_b ports_b[nPorts](redeclare package
      Medium = MediumA)
    annotation (Placement(transformation(extent={{80,40},{100,-40}})));
  Modelica.Fluid.Sensors.TraceSubstances senCO2(redeclare package Medium =
        MediumA, substanceName="CO2") "CO2 sensor for room 1"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Fluid.Interfaces.FluidPort_a venPort(redeclare package Medium =
        MediumA) "Ventilation port to plug any infiltration or extraction"
    annotation (Placement(transformation(extent={{50,-30},{70,-10}}),
        iconTransformation));
  Buildings.Fluid.Sensors.Conversions.To_VolumeFraction conMasVolFra(MMMea=
        Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM)
    "Conversion from mass fraction CO2 to volume fraction CO2"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Math.Gain gaiPPM(k=1e6) "Convert mass fraction to PPM"
    annotation (Placement(transformation(extent={{50,60},{70,80}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaCO2RooAir(
    description="Air CO2 concentration of zone " + zone,
    KPIs=if isConditionedZone then IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration else IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="ppm"),
    zone=zone) "Read room air CO2 concentration"
    annotation (Placement(transformation(extent={{80,60},{100,80}})));

  Modelica.Blocks.Interfaces.RealInput m_flow
    "Ventilation airflow that is infiltrated or extracted"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
equation
  connect(ports_b[1], senCO2.port) annotation (Line(points={{90,20},{17,20},{17,
          60},{-10,60}},
                       color={0,127,255}));
  connect(venPort, ports_b[2])
    annotation (Line(points={{60,-20},{90,-20}}, color={0,127,255}));
  connect(senCO2.C, conMasVolFra.m)
    annotation (Line(points={{1,70},{19,70}}, color={0,0,127}));
  connect(conMasVolFra.V, gaiPPM.u)
    annotation (Line(points={{41,70},{48,70}}, color={0,0,127}));
  connect(gaiPPM.y, reaCO2RooAir.u)
    annotation (Line(points={{71,70},{78,70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseClass;
