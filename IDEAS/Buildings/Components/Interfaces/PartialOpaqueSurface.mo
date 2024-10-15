within IDEAS.Buildings.Components.Interfaces;
partial model PartialOpaqueSurface
  "Partial component for the opaque surfaces of the building envelope"

  replaceable parameter IDEAS.Buildings.Data.Interfaces.Construction constructionType
    constrainedby IDEAS.Buildings.Data.Interfaces.Construction
    "Building component material structure" annotation (
    __Dymola_choicesAllMatching=true,
    Placement(transformation(extent={{-34,78},{-30,82}})),
    Dialog(group="Construction details"));
  extends IDEAS.Buildings.Components.Interfaces.PartialSurface(
    E(y=if sim.computeConservationOfEnergy then layMul.E else 0),
    Qgai(y=layMul.port_b.Q_flow + (if sim.openSystemConservationOfEnergy or not sim.computeConservationOfEnergy
         then 0 else sum(port_emb.Q_flow))),
    layMul(
      final nLay=constructionType.nLay,
      final mats=constructionType.mats,
      T_start=ones(constructionType.nLay)*T_start,
      nGain=constructionType.nGain));


  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_emb[constructionType.nGain]
    "Port for gains by embedded active layers"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow iSolDir(final Q_flow=0);
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow iSolDif(final Q_flow=0);

initial equation
  assert(not energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState,
    "In " + getInstanceName() + ": Using SteadyState energyDynamics for a wall
    is not allowed since this causes large algebraic loops, which significantly affects computation time.");
  assert(IDEAS.Utilities.Math.Functions.isAngle(constructionType.incLastLay, IDEAS.Types.Tilt.Other) or
    constructionType.incLastLay >= incInt - Modelica.Constants.pi/3 - Modelica.Constants.eps and
    constructionType.incLastLay <= incInt + Modelica.Constants.pi/3 + Modelica.Constants.eps,
    "In " + getInstanceName() + ": The inclination of a wall, a floor or a ceiling does not correspond to its record.");

equation
  connect(iSolDif.port, propsBus_a.iSolDif);
  connect(iSolDir.port, propsBus_a.iSolDir);

  for i in 1:constructionType.nGain loop
    connect(layMul.port_gain[constructionType.locGain[i]], port_emb[i])
    annotation (Line(points={{0,-10},{0,-10},{0,-100}}, color={191,0,0}));
  end for;

    annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-100},{60,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-50,-100},{50,100}}),
        graphics),
    Documentation(revisions="<html>
<ul>
<li>
August 12, 2020 by Filip Jorissen:<br/>
No longer using connector and initial equation for <code>epsSw</code>.
<a href=\"https://github.com/open-ideas/IDEAS/issues/1162\">#1162</a>.
</li>
<li>
April 29, 2020, by Filip Jorissen:<br/>
Added <code>getInstanceName()</code> in assert. 
See issue <a href=https://github.com/open-ideas/IDEAS/issues/1133>#1133</a>.
</li>
<li>
June 27, 2018, by Filip Jorissen:<br/>
Added check to avoid <code>energyDynamics=SteadyState</code>. 
See issue <a href=https://github.com/open-ideas/IDEAS/issues/856>#856</a>.
</li>
<li>
March 21, 2017, by Filip Jorissen:<br/>
Changed conservation of energy implementation for JModelica compatibility.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/559>#559</a>.
</li>
<li>
January 10, 2017, by Filip Jorissen:<br/>
Removed
<code>AWall</code>  and declared <code>A</code> in 
<a href=modelica://IDEAS.Buildings.Components.Interfaces.PartialSurface>
IDEAS.Buildings.Components.Interfaces.PartialSurface</a>.
This is for 
<a href=https://github.com/open-ideas/IDEAS/issues/609>#609</a>.
</li>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation: cleaned up connections and partials.
</li>
<li>
February 6, 2016 by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model extends 
<a href=modelica://IDEAS.Buildings.Components.Interfaces.PartialSurface>IDEAS.Buildings.Components.Interfaces.PartialSurface</a>
with parameters that are typical for opaque surfaces, i.e. all surfaces except windows.
</p>
</html>"));
end PartialOpaqueSurface;
