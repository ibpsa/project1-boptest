within IDEAS.Buildings.Components.Comfort.BaseClasses;
partial model PartialComfort "Partial for comfort models"
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean use_phi_in=true
    "Get the relative humidity from the input connector"
    annotation(Evaluate=true);
  parameter Real phi(min=0,max=1)=0.4
    "Default value of relative humidity"
    annotation(Dialog(enable=not use_phi_in));
  parameter IDEAS.Buildings.Components.OccupancyType.OfficeWork
    occupancyType
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Interfaces.RealInput phi_in(min=0, max=1) if use_phi_in "Relative humidity"
    annotation (
      Placement(transformation(extent={{-120,10},{-100,30}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealInput TRad(final quantity="ThermodynamicTemperature",
                                          final unit = "K", displayUnit = "degC")
    "Radiation temperature"
    annotation (
      Placement(transformation(extent={{-120,50},{-100,70}}),
        iconTransformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput TAir(final quantity="ThermodynamicTemperature",
                                          final unit = "K", displayUnit = "degC")
    "Air temperature"
    annotation (Placement(
        transformation(extent={{-120,90},{-100,110}})));

protected
  Modelica.Blocks.Interfaces.RealInput phi_in_internal
    "Needed to connect to conditional connector";
equation
  connect(phi_in, phi_in_internal);
  if not use_phi_in then
    phi_in_internal = phi;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
April 11, 2019 by Filip Jorissen:<br/>
Revised implementation such that default value of relative humidity is
used when using a dry air medium.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1011\">#1011</a>.
</li>
<li>
January 26, 2018 by Filip Jorissen:<br/>
Changed replaceable record into parameter such that 
<code>IDEAS.Buildings.Components.OccupancyType.BaseClasses.PartialOccupancyType</code> 
can be a partial record.
This is for <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end PartialComfort;
