within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer;
model ZoneLwDistribution "internal longwave radiative heat exchange"

  parameter Integer nSurf(min=1) "Number of surfaces connected to the zone";
  parameter Boolean simVieFac = false "Simplify view factor computation";
  parameter Boolean linearise=true "Linearise radiative heat exchange";
  parameter Modelica.SIunits.Temperature Tzone_nom = 295.15
    "Nominal temperature of environment, used for linearisation"
    annotation(Dialog(group="Linearisation", enable=linearise));
  parameter Modelica.SIunits.TemperatureDifference dT_nom = -2
    "Nominal temperature difference between solid and air, used for linearisation"
    annotation(Dialog(group="Linearisation", enable=linearise));


  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nSurf] port_a
    "Port for radiative heat exchange"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput[nSurf] A(
     each final quantity="Area", each final unit="m2")
    "Surface areas of connected surfaces" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,100})));
  Modelica.Blocks.Interfaces.RealInput[nSurf] epsLw(
     each final quantity="Emissivity", each final unit="1")
    "Longwave surface emissivities of connected surfaces" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));

protected
  parameter Boolean computeCarroll(fixed=false) "if false, then a simplified model is used";
  parameter Real FMax=5 "Upper bound for F";
  parameter Real[nSurf] F1(
     each final fixed=false,
     each final min=0,
     each final max=FMax,
     each start=0.1)
    "View factor estimate by Carroll";
  parameter Real[nSurf] F2(
     each final fixed=false,
     each final min=1e-6,
     each final max=1,
     each start=1)
    "Simplified view factor estimate";
  parameter Real[nSurf] R(
     each final fixed=false,
     each final unit="K4/W")
    "Thermal resistance for longwave radiative heat exchange";

  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.HeatRadiation[nSurf] radRes(
    R=R,
    each linearise=linearise,
    each dT_nom=dT_nom,
    each Tzone_nom=Tzone_nom)
    "Component that computes radiative heat exchange";

initial equation
  // see Eqns 29-30 in Liesen, R. J., & Pedersen, C. O. (1997). An Evaluation of Inside Surface Heat Balance Models for Cooling Load Calculations. ASHRAE Transactions, 3(103), 485–502.
  // or Eqns 4 and 10 in Carroll, J.A. 1980. An "MRT method" of computing radiant energy exchange in rooms. Proceedings of the 2nd Sys- tems Simulation and Economics Analysis Conference, January 23-25
  // The additional min(,) and max(,) function cause the Newton solver to find a (wrong) solution instead of crashing.

  // If max(A)<sum(A)/2 is not satisfied, then the non-linear
  // algebraic loop will not converge and therefore we do not compute
  // view factors according to Carroll.
  computeCarroll = not simVieFac and max(A)<sum(A)/2;
  F1= if computeCarroll then {max(0,min(FMax,1/(1 - A[i] .* F1[i]/(A*F1)))) for i in 1:nSurf} else zeros(nSurf);
  F2= A ./ (ones(nSurf)*sum(A) - A);

  // If Carroll's model converged to a solution for F1
  // that does not equal the variable bounds
  // (i.e. the solution converged using the real model equations),
  // then use this model otherwise use a more simplified model
  // since a solution was found, but not for the real model equations.
  // This should only occur for non-physical geometries where
  // it is difficult to argue whether or not this simplification is correct.
  R= if computeCarroll and max(F1)<FMax*0.9 then
        ((ones(nSurf) - epsLw) ./ epsLw + ones(nSurf)./F1) ./ A/ Modelica.Constants.sigma
      else
        ((ones(nSurf) - epsLw) ./ (A .* epsLw) + (ones(nSurf) - F2) ./ A)/Modelica.Constants.sigma;

  // Throw a warning when the simplified approach is used.
  assert(max(F1)<FMax*0.9 and computeCarroll or simVieFac,
          "WARNING: In " +getInstanceName() + ": The computed view factor returned unexpected results. 
          A simplified method is used. 
          This may be caused by trying to model a non-physical geometry. 
          Avoid this warning by setting simVieFac=true in the respective zone model.\n",
          AssertionLevel.warning);


equation
  for i in 1:nSurf loop
    connect(radRes[i].port_b, port_a[i]);
  end for;

  for i in 1:nSurf - 1 loop
    connect(radRes[i].port_a, radRes[i + 1].port_a);
  end for;

  annotation (
    Diagram(graphics),
    Icon(graphics={
        Rectangle(
          extent={{-90,80},{90,-80}},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward,
          lineColor={0,0,0}),
        Rectangle(
          extent={{68,60},{-68,-60}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(points={{6,0},{64,0}},     color={191,0,0}),
        Line(points={{6,0},{16,6}},      color={191,0,0}),
        Line(points={{6,0},{16,-6}},    color={191,0,0}),
        Line(points={{0,56},{0,12}},      color={191,0,0}),
        Line(points={{-62,0},{-8,0}},   color={191,0,0}),
        Line(points={{-5,-3},{5,3}},   color={191,0,0},
          origin={-13,-3},
          rotation=180),
        Line(points={{-5,3},{5,-3}},   color={191,0,0},
          origin={-13,3},
          rotation=180),
        Line(
          points={{-68,60},{68,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{68,60},{68,-60},{-68,-60},{-68,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(points={{-5,-3},{5,3}},   color={191,0,0},
          origin={-3,17},
          rotation=270),
        Line(points={{-5,3},{5,-3}},   color={191,0,0},
          origin={3,17},
          rotation=270),
        Line(points={{0,-10},{0,-54}},    color={191,0,0}),
        Line(points={{-5,-3},{5,3}},   color={191,0,0},
          origin={-3,-49},
          rotation=270),
        Line(points={{-5,3},{5,-3}},   color={191,0,0},
          origin={3,-49},
          rotation=270),
        Line(points={{-5,3},{5,-3}},   color={191,0,0},
          origin={-3,-15},
          rotation=270),
        Line(points={{-5,-3},{5,3}},   color={191,0,0},
          origin={3,-15},
          rotation=270),
        Line(points={{-5,-3},{5,3}},   color={191,0,0},
          origin={3,51},
          rotation=270),
        Line(points={{-5,3},{5,-3}},   color={191,0,0},
          origin={-3,51},
          rotation=270),
        Line(points={{-62,0},{-52,-6}}, color={191,0,0}),
        Line(points={{-62,0},{-52,6}},   color={191,0,0}),
        Line(points={{-5,3},{5,-3}},   color={191,0,0},
          origin={59,3},
          rotation=180),
        Line(points={{-5,-3},{5,3}},   color={191,0,0},
          origin={59,-3},
          rotation=180)}),
    Documentation(info="<html>
<p>
The Mean Radiant Temperature Network (MRTnet) approach from 
Carroll (1980) is used to compute the radiative heat transfer.
This is a computationally efficient approach that does not require exact view factors to be known.
Each surface exchanges heat with a fictive radiant surface,
leading to a star resistance network.
</p>
<h4>Parameters</h4>
<p>
Parameter <code>simVieFac</code> may be set to false to simplify the 
view factor calculation. This leads to a less accurate computation
of view factors, but this approach is more robust.
It may be used when the initial equation that computes the view factors does not converge.
</p>
<h4>References</h4>
<p>
Liesen, R. J., &amp; Pedersen, C. O. (1997). An Evaluation of Inside Surface Heat Balance Models for Cooling Load Calculations. ASHRAE Transactions, 3(103), 485-502.<br/>
Carroll, J.A. 1980. An \"MRT method\" of computing radiant energy exchange in rooms. Proceedings of the 2nd Sys- tems Simulation and Economics Analysis Conference, January 23-25
</p>
</html>", revisions="<html>
<ul>
<li>
February 18, 2020 by Filip Jorissen:<br/>
Improved warning when view factor computation returns odd results.
See issue 
<a href=https://github.com/open-ideas/IDEAS/issues/1109>#1109</a>.
</li>
<li>
February 1, 2017 by Filip Jorissen:<br/>
Added option for disabling new view factor computation.
See issue 
<a href=https://github.com/open-ideas/IDEAS/issues/663>#663</a>.
</li>
<li>
January 20, 2017 by Filip Jorissen:<br/>
Changed view factor implementation.
See issue 
<a href=https://github.com/open-ideas/IDEAS/issues/643>#643</a>.
</li>
<li>
January 19, 2017 by Filip Jorissen:<br/>
Updated icon for issue
<a href=https://github.com/open-ideas/IDEAS/issues/641>#641
</a>.
</li>
<li>
January 19, 2017 by Filip Jorissen:<br/>
Propagated parameters for linearisation.
</li>
<li>
July 12, 2016 by Filip Jorissen:<br/>
Changed implementation to be more intuitive.
Added units to variables.
</li>
</ul>
</html>"));
end ZoneLwDistribution;
