within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.FlowMover.Pump;
package BaseClasses

  model ValCon
      parameter Integer n= 2
      "the number of pumps";

    Modelica.Blocks.Interfaces.RealInput On[n] "On signal"    annotation (Placement(transformation(extent={{-118,-9},
              {-100,9}})));
    Modelica.Blocks.Interfaces.RealOutput y[n] "On signal"
      annotation (Placement(transformation(extent={{100,-9},{118,9}})));

  equation

      for i in 1:n loop
        y[i] =noEvent(if On[i]>0.01 then 1 else 0);
      end for;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,102},{150,142}},
            textString="%name",
            textColor={0,0,255})}),           Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end ValCon;
end BaseClasses;
