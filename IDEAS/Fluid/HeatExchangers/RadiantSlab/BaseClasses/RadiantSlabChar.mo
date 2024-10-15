within IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses;
record RadiantSlabChar
  "Record containing all parameters for a given a floor heating of concrete core activation"

  // The terminology from prEN 15377 is followed, even if I find the development of the theory
  // by Koschenz and Lehmann better (see Thermoaktive Bauteilsysteme tabs, from Empa)

  // First Version 20110622

  // Changed 20110629:
  // Important: this record ALSO contains the parameters that are specific to the building.

  extends Modelica.Icons.Record;

  parameter Boolean tabs = true
    "true if the model is used for tabs, false if the model is used for floor heating. This is used for the correction factor of the thermal resistances in EmbeddedPipe";

  parameter Modelica.SIunits.Length T(
    min=0.15,
    max=0.3) = 0.2 "Pipe spacing, limits imposed by prEN 15377-3 p22";
  parameter Modelica.SIunits.Length d_a=0.02 "External diameter of the pipe";
  parameter Modelica.SIunits.Length s_r=0.0025 "Thickness of the pipe wall";
  parameter Modelica.SIunits.ThermalConductivity lambda_r=0.35
    "Thermal conductivity of the material of the pipe";
  parameter Modelica.SIunits.Length S_1=0.1
    "Thickness of the concrete/screed ABOVE the pipe layer";
  parameter Modelica.SIunits.Length S_2=0.1
    "Thickness of the concrete/screed UNDER the pipe layer";
  parameter Modelica.SIunits.ThermalConductivity lambda_b=1.8
    "Thermal conductivity of the concrete or screed layer";
  parameter Modelica.SIunits.SpecificHeatCapacity c_b=840
    "Thermal capacity of the concrete/screed material";
  parameter Modelica.SIunits.Density rho_b=2100
    "Density of the concrete/screed layer";
  constant Integer n1=3 "Number of discrete capacities in upper layer";
  constant Integer n2=3 "Number of discrete capacities in lower layer";

  parameter Integer nParCir=1 "number of circuit in parallel";

  // Extra parameters for floor heating
  parameter Modelica.SIunits.ThermalConductivity lambda_i = 0.036
    "heat conductivity of the isolation";
  parameter Modelica.SIunits.Length d_i = 0.05 "Thickness of the insulation";
  final parameter Real alp2 = lambda_i / d_i
    "help variable for resistance calculation";

  annotation (Documentation(info="<html>
<p><b>Description</b> </p>
<p>Record containing the properties of a floor heating or TABS.  The&nbsp;terminology&nbsp;from&nbsp;prEN&nbsp;15377&nbsp;is&nbsp;followed,&nbsp;even&nbsp;if&nbsp;I&nbsp;find&nbsp;the&nbsp;development&nbsp;of&nbsp;the&nbsp;theory by&nbsp;Koschenz&nbsp;and&nbsp;Lehmann&nbsp;better&nbsp;(see&nbsp;Thermoaktive&nbsp;Bauteilsysteme&nbsp;tabs,&nbsp;from&nbsp;Empa)</p>
<h4>Model use</h4>
<ol>
<li>It&apos;s important to set at least the floor surface to something different from 1</li>
<li>The embeddedPipe model has a few assertions to check the validity of some parameters and their combinations.</li>
</ol>
</html>", revisions="<html>
<ul>
<li>2013 May, Roel De Coninck, documentation</li>
<li>2011 June, Roel De Coninck, first version</li>
</ul>
</html>"));
end RadiantSlabChar;
