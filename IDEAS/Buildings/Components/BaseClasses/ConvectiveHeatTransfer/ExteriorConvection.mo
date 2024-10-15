within IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer;
model ExteriorConvection "exterior surface convection"

  parameter Modelica.SIunits.Area A "surface area";
  parameter Boolean linearise = false "Use constant convection coefficient"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConExtLin = 18.3
    "Fixed exterior convection coefficient used when linearising equations"
     annotation(Dialog(enable=linearize));
  parameter Modelica.SIunits.Angle inc "Surface inclination";
  parameter Modelica.SIunits.Angle azi "Surface azimuth";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    "Connector for solid part"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  Modelica.Blocks.Interfaces.RealInput Te(unit="K",displayUnit="degC")
    "Ambient temperature"
    annotation (Placement(transformation(extent={{-120,-68},{-80,-28}})));
  Modelica.Blocks.Interfaces.RealInput hForcedConExt(unit="W/(m2.K)")
    "Exterior convective heat transfer coefficient"
    annotation (Placement(transformation(extent={{-120,-110},{-80,-70}})));

protected
  Modelica.SIunits.CoefficientOfHeatTransfer hNatConvExt
    "Heat transfer coefficient for natural convection" annotation ();
  Modelica.SIunits.CoefficientOfHeatTransfer hSmooth
    "Heat transfer coefficient for a smooth (glass) surface" annotation ();
  Modelica.SIunits.CoefficientOfHeatTransfer hConExt
    "Heat transfer coefficient for combined forced and natural convection"
    annotation ();

  final parameter Boolean isCeiling=abs(sin(inc)) < 10E-5 and cos(inc) > 0
    "true if ceiling" annotation (Evaluate=true);
  final parameter Boolean isFloor=abs(sin(inc)) < 10E-5 and cos(inc) < 0
    "true if floor" annotation (Evaluate=true);


  constant Real C_vertical=1.31 "TARP coeff";
  constant Real C_horz_buoyant=1.509 "TARP coeff";
  constant Real C_horz_stable=0.76 "TARP coeff";
  constant Real n=1/3 "TARP coeff";
  constant Real R=1 "Roughness factor (value of 1 recommended)";

  Real C "TARP coeff";
  Modelica.SIunits.TemperatureDifference dT
    "Surface temperature minus outdoor air temperature" annotation ();



equation

  // Assign empirical coefficient according to flow regime.
  if isCeiling then
    if dT > 0 then
      C = C_horz_buoyant;
    else
      C = C_horz_stable;
    end if;
  elseif isFloor then
    if dT < 0 then
      C = C_horz_buoyant;
    else
      C = C_horz_stable;
    end if;
  else
    C = C_vertical;
  end if;

  // Calculate coefficient for natural convection.
  hNatConvExt = C * abs(dT)^n;

  // Evaluate combined coefficient for natural and forced convection, or use fixed values.
  if linearise then
    hSmooth = 0;
    hConExt = hConExtLin;
  else
    hSmooth = (hNatConvExt^2 + hForcedConExt^2)^0.5;
    hConExt = (1-R)*hNatConvExt + R*hSmooth;
  end if;

  // Apply Newton's law at exterior surface.
  dT = port_a.T - Te;
  port_a.Q_flow = A * hConExt * dT;

  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-90,80},{-60,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(points={{-60,20},{76,20}}, color={191,0,0}),
        Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
        Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
        Line(points={{56,30},{76,20}}, color={191,0,0}),
        Line(points={{56,10},{76,20}}, color={191,0,0}),
        Line(points={{56,-10},{76,-20}}, color={191,0,0}),
        Line(points={{56,-30},{76,-20}}, color={191,0,0}),
        Line(points={{6,80},{6,-80}}, color={0,127,255}),
        Line(points={{40,80},{40,-80}}, color={0,127,255}),
        Line(points={{76,80},{76,-80}}, color={0,127,255}),
        Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
        Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
        Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
        Line(points={{6,-80},{16,-60}}, color={0,127,255}),
        Line(points={{40,-80},{30,-60}}, color={0,127,255}),
        Line(points={{40,-80},{50,-60}}, color={0,127,255}),
        Line(points={{76,-80},{66,-60}}, color={0,127,255}),
        Line(points={{76,-80},{86,-60}}, color={0,127,255}),
        Text(
          extent={{-150,-90},{150,-130}},
          textString="%name",
          lineColor={0,0,255}),
        Line(
          points={{-60,80},{-60,-80}},
          color={0,0,0},
          thickness=0.5)}),
    Documentation(info="<html>
<p>
The exterior convective heat transfer is computed using 
Newton's Law of Cooling. The convection coefficient considers the combined 
effects of natural (buoyancy driven) and forced (wind-driven) flow.
</p>
<p>
The coefficient for forced convection is calculated in ExtConvForcedCoeff.mo, 
whereas the current model calculates the coefficient for natural 
convection and combines the two together to determine the 
coefficient used in Newton&apos;s Law of Cooling.
</p>
<p>
The &quot;TARP&quot; correlation is used to calculate the coefficient for natural convection. 
The parameters for the correlation at sourced from the EnergyPlus Engineering 
manual (Equations 3.75 to 3.77, Page 94). 
Horizontal surfaces are treated as either a ceiling or a floor, 
and can be either stably stratified or buoyant, depending 
upon the surface-to-air temperature difference. 
Any non-horizontal surface is treated as vertical.
</p>
<p>
This implementation includes a &quot;roughness factor&quot; that can be used to 
augment the combined convection coefficient calculated by the correlations.  
This is used in the so-called &quot;DOE-2 model&quot; that is EnergyPlus'; 
default approach.  However, the use of roughness factors other 
than 1 are discouraged as there appears to be little physical basis for this factor.
</p>
</html>", revisions="<html>
<ul>
<li>
November 28, 2019, by Ian Beausoleil-Morrison:<br/>
Major rewrite.  Convection coefficients now calculated by surface to consider 
combined natural and forced effects, and wind direction.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1089\">
#1089</a>
</li>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end ExteriorConvection;
