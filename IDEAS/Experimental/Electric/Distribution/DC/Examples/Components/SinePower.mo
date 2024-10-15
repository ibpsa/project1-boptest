within IDEAS.Experimental.Electric.Distribution.DC.Examples.Components;
model SinePower

  //parameter Integer nNodes=34;
  parameter Real amplitude=4000 "How many watts is the amplitude?";
  parameter Real offset=0
    "How many watts offset is there? 1 watt offset = 2 watts more consumption than production";
  parameter Real period=1 "How many days is one period for the simulation?";
  Modelica.Electrical.Analog.Interfaces.NegativePin nodes
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Real P=wattsLaw.P;

protected
  IDEAS.Experimental.Electric.BaseClasses.DC.WattsLaw wattsLaw annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-30,50})));

  Modelica.Blocks.Sources.Sine sine(
    amplitude=amplitude,
    offset=offset,
    freqHz=freq,
    phase=1.5707963267949)
    annotation (Placement(transformation(extent={{-72,76},{-52,96}})));
  parameter Real freq=1/(86400*period);

equation
  connect(wattsLaw.vi[1], nodes) annotation (Line(
      points={{-30,40},{-30,0},{-100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sine.y, wattsLaw.P) annotation (Line(
      points={{-51,86},{-28,86},{-28,60}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end SinePower;
