within IDEAS.BoundaryConditions.Occupants.Standards;
model None "No occupants, constant set point temperature."
  extends IDEAS.Templates.Interfaces.BaseClasses.Occupant(
                                                final nLoads=0, nZones=1);
  parameter Modelica.SIunits.Temperature TSet_val[nZones] = fill(273.15 + 17, nZones)
    "Set point temperature";
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow prescribedHeatFlow[nZones](
     each Q_flow=0)
    annotation (Placement(transformation(extent={{-54,-30},{-74,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow prescribedHeatFlow1[
    nZones](each Q_flow=0)
    annotation (Placement(transformation(extent={{-54,10},{-74,30}})));
equation
  TSet = TSet_val;
  mDHW60C = 0;
  connect(prescribedHeatFlow1.port, heatPortCon) annotation (Line(
      points={{-74,20},{-200,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port, heatPortRad) annotation (Line(
      points={{-74,-20},{-200,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics), Icon(coordinateSystem(extent={{-200,
            -100},{200,100}})));
end None;
