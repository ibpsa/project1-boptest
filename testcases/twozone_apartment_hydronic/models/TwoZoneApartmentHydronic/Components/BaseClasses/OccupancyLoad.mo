within TwoZoneApartmentHydronic.Components.BaseClasses;
model OccupancyLoad
  "A model for occupancy and resulting internal loads"
  parameter Modelica.SIunits.Power senPower "Sensible heat gain per person";
  parameter Modelica.SIunits.DimensionlessRatio radFraction "Fraction of sensible gain that is radiant";
  parameter Modelica.SIunits.Power latPower "Latent heat gain per person";
  parameter Modelica.SIunits.MassFlowRate co2Gen "CO2 generation per person";
  parameter Modelica.SIunits.DimensionlessRatio occ_density "Number of occupants per m^2";
  Modelica.Blocks.Interfaces.RealOutput rad "Radiant load in W/m^2"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput con "Convective load in W/m^2"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput lat "Latent load in W/m^2"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Math.Gain gaiRad(k=senPower*radFraction*occ_density)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Modelica.Blocks.Math.Gain gaiCon(k=senPower*(1 - radFraction)*occ_density)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Math.Gain gaiLat(k=latPower*occ_density)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Blocks.Math.Gain gaiCO2(k=co2Gen*occ_density)
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  Modelica.Blocks.Interfaces.RealOutput co2 "CO2 generation in kg/s/m^2"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealInput occupation
    annotation (Placement(transformation(extent={{-122,-22},{-82,18}})));
equation
  connect(gaiRad.y, rad)
    annotation (Line(points={{61,40},{110,40}}, color={0,0,127}));
  connect(gaiCon.y, con)
    annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(gaiLat.y, lat)
    annotation (Line(points={{61,-40},{110,-40}}, color={0,0,127}));
  connect(gaiCO2.y, co2)
    annotation (Line(points={{61,-80},{110,-80}}, color={0,0,127}));
  connect(occupation, gaiRad.u) annotation (Line(points={{-102,-2},{-32,-2},{-32,
          40},{38,40}}, color={0,0,127}));
  connect(occupation, gaiCon.u) annotation (Line(points={{-102,-2},{-32,-2},{-32,
          0},{38,0}}, color={0,0,127}));
  connect(occupation, gaiLat.u) annotation (Line(points={{-102,-2},{-32,-2},{-32,
          -40},{38,-40}}, color={0,0,127}));
  connect(occupation, gaiCO2.u) annotation (Line(points={{-102,-2},{-33,-2},{-33,
          -80},{38,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<ul>
<li>
August 6, 2021, by Ettore Zanetti:<br/>
First implementation.
</li>
</ul>
</html>"));
end OccupancyLoad;
