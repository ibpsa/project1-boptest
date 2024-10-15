within IDEAS.BoundaryConditions.Occupants.Components.BaseClasses;
block CloTemperature "clothing surface temperature"

  extends Modelica.Blocks.Interfaces.BlockIcon;

  Modelica.Blocks.Interfaces.RealOutput Tclo "clothing surface temperature"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealInput Trad "radiative zone temperature"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={20,-100})));
  Modelica.Blocks.Interfaces.RealInput Tair "convective zone temperature"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-40,-100})));
  Modelica.Blocks.Interfaces.RealInput RClo "clothing thermal resistance"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealInput CloFrac "clothign fraction" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={20,100})));

  parameter Modelica.SIunits.Area Adu=1.77 "DuBois Area";
  parameter Modelica.SIunits.Efficiency Eta=0.1
    "external mechanical efficiency of the body";
  parameter Modelica.SIunits.HeatFlowRate Met=120 "Metabolic rate";
  parameter Boolean Linear=true;
  parameter Modelica.SIunits.Velocity VelVen=0.2;

  constant Real Cb=5.67 "black body constant";
  constant Real b=0.82 "linearization fit";
  final parameter Real Meta=Met/Adu "Specific metabolic rate";

protected
  Real Conv "convective surface coefficient";
  Real DTr4 "Linearized or not linearized radiative delta T^4";

algorithm
  if Linear then
    DTr4 := b*Cb/Modelica.Constants.sigma*(Tclo - Tair);
  else
    DTr4 := (Tclo - Tair)*(Tclo + Tair)*(Tclo^2 + Tair^2);
  end if;

  if noEvent(65*(Tclo - Tair) > 21435.89*VelVen) then
    Conv := 2.38*(Tclo - Tair)^0.25;
  else
    Conv := 12.1*VelVen^0.5;
  end if;

  Tclo := (35.7 - 0.028*Meta - RClo*(3.96*10^(-8)*CloFrac*DTr4 + CloFrac*Conv*(
    Tclo - Tair))) + 273.15;

  annotation (Diagram(graphics), Icon(graphics));
end CloTemperature;
