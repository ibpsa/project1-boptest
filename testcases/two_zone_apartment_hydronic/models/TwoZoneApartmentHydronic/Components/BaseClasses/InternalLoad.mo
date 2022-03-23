within TwoZoneApartmentHydronic.Components.BaseClasses;
model InternalLoad "A model for internal loads"
  parameter Modelica.SIunits.HeatFlux senPower_nominal "Nominal sensible heat gain";
  parameter Modelica.SIunits.DimensionlessRatio radFraction "Fraction of sensible gain that is radiant";
  parameter Modelica.SIunits.HeatFlux latPower_nominal "Nominal latent heat gain";
  Modelica.Blocks.Interfaces.RealOutput rad "Radiant load in W/m^2"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput con "Convective load in W/m^2"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput lat "Latent load in W/m^2"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Math.Gain gaiRad(k=senPower_nominal*radFraction)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Modelica.Blocks.Math.Gain gaiCon(k=senPower_nominal*(1 - radFraction))
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Math.Gain gaiLat(k=latPower_nominal)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Blocks.Interfaces.RealInput occupation
    annotation (Placement(transformation(extent={{-122,-20},{-82,20}})));
equation
  connect(gaiRad.y, rad)
    annotation (Line(points={{61,40},{110,40}}, color={0,0,127}));
  connect(gaiCon.y, con)
    annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(gaiLat.y, lat)
    annotation (Line(points={{61,-40},{110,-40}}, color={0,0,127}));
  connect(occupation, gaiRad.u) annotation (Line(points={{-102,0},{-33,0},{-33,40},
          {38,40}}, color={0,0,127}));
  connect(occupation, gaiCon.u)
    annotation (Line(points={{-102,0},{38,0}}, color={0,0,127}));
  connect(occupation, gaiLat.u) annotation (Line(points={{-102,0},{-32,0},{-32,-40},
          {38,-40}}, color={0,0,127}));
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
end InternalLoad;
