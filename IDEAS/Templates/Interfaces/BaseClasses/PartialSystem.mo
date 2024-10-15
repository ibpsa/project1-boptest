within IDEAS.Templates.Interfaces.BaseClasses;
partial model PartialSystem "General partial for electricity-based systems"

  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-200,80},{-180,100}})));
  parameter Integer nZones(min=1)
    "Number of conditioned thermal zones in the building";
  // --- Electrical
  parameter Integer nLoads(min=0) = 0
    "Number of electric loads. If zero, all electric equations disappear.";

  Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
    plugLoad(m=1) if
       hasElectric
      "Electricity connection to the Inhome feeder"
    annotation (Placement(transformation(extent={{190,-10},{210,10}})));
  IDEAS.Experimental.Electric.BaseClasses.AC.WattsLawPlug wattsLawPlug(
    each numPha=1,
    final nLoads=nLoads) if hasElectric
    annotation (Placement(transformation(extent={{170,-10},{190,10}})));
protected
  final parameter Boolean hasElectric = nLoads>0
    "Removes electric equations when false";
  final parameter Integer nLoads_min=max(1, nLoads);

  Modelica.SIunits.Power[nLoads_min] P = zeros(nLoads_min)
    "Active power for each of the loads";
  Modelica.SIunits.Power[nLoads_min] Q = zeros(nLoads_min)
    "Passive power for each of the loads";
  Modelica.Blocks.Sources.RealExpression[nLoads_min] P_val(y=P)
    "Active power"
    annotation (Placement(transformation(extent={{140,7},{160,27}})));
  Modelica.Blocks.Sources.RealExpression[nLoads_min] Q_val(y=Q)
    "Reactive power"
    annotation (Placement(transformation(extent={{140,-20},{160,0}})));
equation
  connect(wattsLawPlug.vi, plugLoad) annotation (Line(
        points={{190,0},{200,0}},
        color={85,170,255},
        smooth=Smooth.None));
  connect(P_val.y, wattsLawPlug.P) annotation (Line(
      points={{161,17},{168,17},{168,5},{174,5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Q_val.y, wattsLawPlug.Q) annotation (Line(
      points={{161,-10},{170,-10},{170,1},{173,1}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,
            100}}), graphics),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,
            100}}),     graphics),
    Documentation(info="<html>
<p>
This documentation is outdated.
</p>
<p><b>Description</b> </p>
<p>Interface model for a complete multi-zone heating system (with our without domestic hot water and solar system).</p>
<p>This model defines the ports used to link a heating system with a building, and the basic parameters that most heating systems will need to have. The model is modular as a function of the number of zones <i>nZones. </i></p>
<p>Two sets of heatPorts are defined:</p>
<ol>
<li><i>heatPortCon[nZones]</i> and <i>heatPortRad[nZones]</i> for convective respectively radiative heat transfer to the building. </li>
<li><i>heatPortEmb[nZones]</i> for heat transfer to TABS elements in the building. </li>
</ol>
<p>The model also defines <i>TSensor[nZones]</i> and <i>TSet[nZones]</i> for the control, and a nominal power <i>QNom[nZones].</i></p>
<p>There is also an input for the DHW flow rate, <i>mDHW60C</i>, but this can be unconnected if the system only includes heating and no DHW.</p>
<h4>Assumptions and limitations </h4>
<ol>
<li>See the different extensions of this model in <a href=\"modelica://IDEAS.Thermal.HeatingSystems\">IDEAS.Thermal.HeatingSystems</a></li>
</ol>
<h4>Model use</h4>
<ol>
<li>Connect the heating system to the corresponding heatPorts of a <a href=\"modelica://IDEAS.Templates.Interfaces.BaseClasses.Structure\">structure</a>. </li>
<li>Connect <i>TSet</i> and <i>TSensor</i> and <i>plugLoad. </i></li>
<li>Connect <i>plugLoad </i> to an inhome grid.  A<a href=\"modelica://IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder\"> dummy inhome grid like this</a> has to be used if no inhome grid is to be modelled. </li>
<li>Set all parameters that are required, depending on which implementation of this interface is used. </li>
</ol>
<h4>Validation </h4>
<p>No validation performed.</p>
<h4>Example </h4>
<p>See the <a href=\"modelica://IDEAS.Thermal.HeatingSystems.Examples\">heating system examples</a>. </p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"));
end PartialSystem;
