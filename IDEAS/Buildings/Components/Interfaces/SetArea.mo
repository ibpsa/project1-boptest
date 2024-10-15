within IDEAS.Buildings.Components.Interfaces;
model SetArea "Block for communicating the surface area of the surface to the SimInfoManager"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Area A
    "Surface area";
  parameter Boolean use_custom_q50
    "Custom q50 value";
  IDEAS.Buildings.Components.Interfaces.AreaPort areaPort
    "Port for communicating surface area"
     annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealInput v50
    "v50 value"
     annotation (Placement(transformation(extent={{-126,48},{-86,88}})));
  Modelica.Blocks.Interfaces.BooleanInput use_custom_n50
    "Is the zones n50 custom?"
     annotation (Placement(transformation(extent={{-126,-30},{-86,10}})));

protected
  parameter Real v50_custom(unit="m3/h",fixed=false)
    "v50 if flow is custom, else 0";
  parameter Modelica.SIunits.Area A_def_q50 = if use_custom_q50 then 0 else A;

initial equation
  if not use_custom_q50 and not use_custom_n50 then
    v50_custom=0;
  else
    v50_custom=v50;
  end if;


equation
  areaPort.A = A;
  areaPort.A_def = (if use_custom_n50 then 0 else A_def_q50); // if surface is not custom, then the area is communicated, else 0
  areaPort.v50 = v50_custom;

end SetArea;
