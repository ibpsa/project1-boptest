within IDEAS.Fluid.Interfaces;
partial model OnOffInterface
  "Interface for either setting a device on using a parameter or using a realInput"
  parameter Boolean use_onOffSignal = false
    "Set to true to switch device on/off using external signal";
  Modelica.Blocks.Interfaces.BooleanInput on if use_onOffSignal annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,108})));
  parameter Boolean onOff=true "Set to true if device is on"
  annotation (Dialog(enable= not use_onOffSignal));
protected
  Modelica.Blocks.Interfaces.BooleanInput on_internal
    "Needed to connect to conditional connector";
equation
  connect(on,on_internal);
  if not use_onOffSignal then
    on_internal=onOff;
  end if;
  annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
end OnOffInterface;
