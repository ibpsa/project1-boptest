within IDEAS.Experimental.Electric.Photovoltaics.Components.Elements;
model PvSerie

  extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Real amount=2;

  Modelica.Electrical.Analog.Interfaces.Pin pinCel
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.Pin pinSer
    annotation (Placement(transformation(extent={{90,50},{110,70}})));

equation
  pinSer.v = amount*pinCel.v;
  pinSer.i = pinCel.i;

  annotation (Icon(graphics={Text(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          textString="#")}));
end PvSerie;
