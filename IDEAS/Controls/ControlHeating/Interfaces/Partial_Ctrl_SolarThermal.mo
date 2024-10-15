within IDEAS.Controls.ControlHeating.Interfaces;
partial model Partial_Ctrl_SolarThermal
  "Partial for a solar thermal controller"

  /* 
  This partial class contains the temperature control algorithm. It has to be extended
  in order to be complete controller.  
  

  */

  parameter Modelica.SIunits.TemperatureDifference dTStart=10
    "Nominal dT for starting the pump";
  parameter Modelica.SIunits.TemperatureDifference dTStop=3
    "Nominal dT for stopping the pump";
  Modelica.Blocks.Interfaces.RealInput TSafety "Temperature not to be exceeded"
    annotation (Placement(transformation(extent={{-126,40},{-86,80}}),
        iconTransformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Interfaces.RealInput TCollector
    "Collector output temperature"
    annotation (Placement(transformation(extent={{-120,0},{-80,40}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput TTankBot
    "Bottom (or near bottom) tank temperature"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
        iconTransformation(extent={{-110,-50},{-90,-30}})));
  parameter Modelica.SIunits.Temperature TSafetyMax
    "Maximum temperature for TSafety";

  Modelica.Blocks.Interfaces.RealOutput onOff(start=0) "onoff signal as Real"
    annotation (Placement(transformation(extent={{90,30},{110,50}}),
        iconTransformation(extent={{90,30},{110,50}})));
initial equation
  //der(onOff) = 0;

equation

  annotation (
    Evaluate=false,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
         graphics={
          Rectangle(
          extent={{120,60},{-80,-60}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-80,60},{-80,-60},{-20,0},{-80,60}},
          smooth=Smooth.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0})}),
    Diagram(graphics));
end Partial_Ctrl_SolarThermal;
