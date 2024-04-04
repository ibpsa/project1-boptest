within BESTESTAir.BaseClasses;
model OccupancyLoad
  "A model for occupancy and resulting internal loads"
  parameter Modelica.SIunits.Power senPower "Sensible heat gain per person";
  parameter Modelica.SIunits.DimensionlessRatio radFraction "Fraction of sensible gain that is radiant";
  parameter Modelica.SIunits.Power latPower "Latent heat gain per person";
  parameter Modelica.SIunits.MassFlowRate co2Gen "CO2 generation per person";
  parameter Modelica.SIunits.DimensionlessRatio occ_density "Number of occupants per m^2";
  Modelica.Blocks.Sources.CombiTimeTable sch(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0; 8*3600,0; 8*3600,1.0; 18*3600,1.0; 18*3600,0; 24*3600,0],
    columns={2})
    "Occupancy schedule"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
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
equation
  connect(sch.y[1], gaiRad.u) annotation (Line(points={{-79,0},{-40,0},{-40,40},
          {38,40}}, color={0,0,127}));
  connect(sch.y[1], gaiCon.u)
    annotation (Line(points={{-79,0},{38,0}}, color={0,0,127}));
  connect(sch.y[1], gaiLat.u) annotation (Line(points={{-79,0},{-40,0},{-40,-40},
          {38,-40}}, color={0,0,127}));
  connect(gaiRad.y, rad)
    annotation (Line(points={{61,40},{110,40}}, color={0,0,127}));
  connect(gaiCon.y, con)
    annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(gaiLat.y, lat)
    annotation (Line(points={{61,-40},{110,-40}}, color={0,0,127}));
  connect(gaiCO2.y, co2)
    annotation (Line(points={{61,-80},{110,-80}}, color={0,0,127}));
  connect(sch.y[1], gaiCO2.u) annotation (Line(points={{-79,0},{-40,0},{-40,-80},
          {38,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OccupancyLoad;
