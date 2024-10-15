within IDEAS.Experimental.Electric.BaseClasses.Converters.Examples;
model converterPower
extends Modelica.Icons.Example;

  ConvertersPower.Converter converter(AC=false, eff=0.95)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=5,
    startTime=5,
    height=-1000)
    annotation (Placement(transformation(extent={{-74,-10},{-54,10}})));

equation
  connect(ramp.y, converter.PIn) annotation (Line(
      points={{-53,0},{-10.8,0}},
      color={0,0,127},
      smooth=Smooth.None));
annotation (Diagram(graphics));
end converterPower;
