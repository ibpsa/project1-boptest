within IDEAS.BoundaryConditions.Occupants.Components.BaseClasses;
block PredictedMeanVote "predicted mean vote"

  extends Modelica.Blocks.Interfaces.BlockIcon;

  Modelica.Blocks.Interfaces.RealOutput PMV "predicted mean vote"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealInput Trad "radiative zone temperature"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={20,-100})));
  Modelica.Blocks.Interfaces.RealInput Tair "convective zone temperature"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-100})));
  Modelica.Blocks.Interfaces.RealInput Tclo "clothing surface temperature"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,40})));
  Modelica.Blocks.Interfaces.RealInput CloFrac "clothing fraction" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={20,100})));

  parameter Modelica.SIunits.Area Adu=1.77 "DuBois Area";
  parameter Modelica.SIunits.Efficiency Eta=0.1
    "external mechanical efficiency of the body";
  parameter Modelica.SIunits.HeatFlowRate Met=120 "Metabolic rate";
  parameter Real RelHum=0.50 "Relative humidity";
  parameter Boolean Linear=true;

  constant Real Cb=5.67 "black body constant";
  constant Real b=0.82 "linearization fit";
  final parameter Real Meta=Met/Adu "Specific metabolic rate";

protected
  Real Conv "convective surface coefficient";
  Modelica.SIunits.Temperature DTr4
    "Linearized or not linearized radiative delta T^4";
  Modelica.SIunits.Pressure Pvp "partial water vapour pressure";

algorithm
  if Linear then
    DTr4 := b*Cb/Modelica.Constants.sigma*(Tclo - Tair);
  else
    DTr4 := (Tclo - Tair)*(Tclo + Tair)*(Tclo^2 + Tair^2);
  end if;

  Pvp := RelHum*611*exp(17.08*(Tair - 273.15)/(234.18 + (Tair - 273.15)))/1000;
  Conv := 5;
  /*2.05*(Tclo-Tair)^0.25;*/

  PMV := (0.303*exp(-0.036*Meta) + 0.028)*(Meta - 3.96*10^(-8)*CloFrac*DTr4 -
    CloFrac*Conv*(Tclo - Tair) - 3.05*(5.73 - 0.007*Meta - Pvp) - 0.42*(Meta -
    58.15) - 0.0173*Meta*(5.87 - Pvp) - 0.0014*Meta*(307.15 - Tair));

  annotation (Diagram(graphics), Icon(graphics));
end PredictedMeanVote;
