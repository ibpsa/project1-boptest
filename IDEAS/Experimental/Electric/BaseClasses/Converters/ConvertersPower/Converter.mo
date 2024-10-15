within IDEAS.Experimental.Electric.BaseClasses.Converters.ConvertersPower;
model Converter "Generalized converter model"
extends Modelica.Blocks.Interfaces.BlockIcon;

parameter Boolean AC "AC or DC output";
parameter Real pf(min=0,max=1) = 1 "Converter power factor (output) [%/100]";
parameter Boolean lagging = true "Lagging pf or not"; // At converter: lagging = Q-consumption by inverter and vice versa.

parameter Modelica.SIunits.Efficiency eff
    "Converter efficiency as a function of the input power [%/100]";

Modelica.SIunits.ActivePower Plos;

protected
 Modelica.SIunits.ApparentPower S;
 Modelica.SIunits.ReactivePower Q;
 parameter Real Qsign = if lagging then 1 else -1 "Sign of reactive power";

public
 Modelica.Blocks.Interfaces.RealInput PIn
   annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
 Modelica.Blocks.Interfaces.RealOutput POut
   annotation (Placement(transformation(extent={{96,30},{116,50}})));
 Modelica.Blocks.Interfaces.RealOutput QOut = Qsign * Q if AC
   annotation (Placement(transformation(extent={{96,-50},{116,-30}})));

equation
POut = PIn * eff;
Plos = (1-eff)*PIn;

S^2=POut^2+Q^2;
pf = abs(POut) / sqrt(POut^2+Q^2);

  annotation (Icon(graphics={Text(
          extent={{-100,20},{-40,-20}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          textString="In"), Text(
          extent={{40,20},{100,-20}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          textString="Out"),
        Line(
          points={{-36,0},{36,0},{0,12},{0,-12},{36,0}},
          color={0,0,0},
          smooth=Smooth.None)}), Diagram(graphics),Documentation(info="<html>
<p>
This is a generalized converter model to convert power with a certain efficiency. The output can be AC or DC, wit a possibility included to deliver reactive power support. A constant efficiency is assumed.
</p>
</html>", revisions="<html>
<ul>
<li>
April 8, 2015 by Juan Van Roy:<br/>
First implementation.
</li>
</ul>
</html>"));
end Converter;
