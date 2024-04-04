within MultiZoneResidentialHydronic.Building.Ventilation;
model GenCO2 "CO2 generation in a zone"

  parameter Modelica.SIunits.MassFlowRate co2gen=0.004*1.8/1000 "CO2 generation per person in KgCO2/(s*person)";
  parameter Modelica.SIunits.DimensionlessRatio nOcc "Number of occupants in the zone";

  Modelica.Blocks.Interfaces.RealInput occFrac
    "Occupancy fraction from 0 to 1. If 1, there are n_occ in the zone. "
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y "CO2 production from occupancy"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant nOccCnt(k=nOcc)
    "Constant for number of occupants"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.Constant co2genCnt(k=co2gen)
    "Constant for CO2 generation"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
equation
  connect(co2genCnt.y, multiProduct.u[1]) annotation (Line(points={{-19,70},{20,
          70},{20,14.6667},{40,14.6667}}, color={0,0,127}));
  connect(nOccCnt.y, multiProduct.u[2]) annotation (Line(points={{-19,30},{10,30},
          {10,10},{40,10}}, color={0,0,127}));
  connect(occFrac, multiProduct.u[3]) annotation (Line(points={{-120,0},{16,0},{
          16,5.33333},{40,5.33333}}, color={0,0,127}));
  connect(multiProduct.y, y) annotation (Line(points={{61.7,10},{82,10},{82,0},{
          110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
Models CO2 generation in a zone based on number of occupants in that zone
<code>nOcc</code> and the CO2 generation per person.
CO2 generation is 0.004 L/s per person (Table 5, Persily and De Jonge 2017)
and density of CO2 assumed to be 1.8 kg/m^3, making CO2 generation 7.2e-6 kg/s per person.
Outside air CO2 concentration is 400 ppm. However, CO2 concentration is not controlled for in the model.

The number of occupants of the room is multiplied by the occupancy fraction
<code>occFrac</code>, which follows the building occupancy schedules.

<p>
Persily, A. and De Jonge, L. (2017).
Carbon dioxide generation rates for building occupants.
Indoor Air, 27, 868–879.  https://doi.org/10.1111/ina.12383.
</p>

</html>"));
end GenCO2;
