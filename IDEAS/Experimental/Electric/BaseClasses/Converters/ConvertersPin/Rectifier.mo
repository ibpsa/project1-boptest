within IDEAS.Experimental.Electric.BaseClasses.Converters.ConvertersPin;
model Rectifier "Rectifier (AC to DC)"
extends Modelica.Blocks.Interfaces.BlockIcon;
extends Partials.Converter;

  parameter Boolean inverter = false "Inverter: true / Rectifier: false";

  Modelica.SIunits.ActivePower Plos;

equation
  if pDC == 0 then
    pAC = 0;
  else
    eff*pAC + pDC = 0;
  end if;

  Plos = (1-eff)*pAC;

  annotation (Icon(graphics={Text(
          extent={{-100,20},{-40,-20}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          textString="AC"), Text(
          extent={{40,20},{100,-20}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          textString="DC"),
        Line(
          points={{-36,0},{36,0},{0,12},{0,-12},{36,0}},
          color={0,0,0},
          smooth=Smooth.None)}), Diagram(graphics),
    Documentation(info="<html>
<p>
This is an ideal AC DC converter, based on a power balance between QS circuit and DC side, including a constant efficiency
</p>
</html>"));
end Rectifier;
