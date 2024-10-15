within IDEAS.Airflow.AHU.BaseClasses;
model AdsolairControllerInterface "Interface for adsolair controller models"
  extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealOutput yBypTop
    "Control signal of top bypass damper"
    annotation (Placement(transformation(extent={{100,88},{120,108}})));
  Modelica.Blocks.Interfaces.RealOutput yRecTop
    "Control signal of top IEH damper"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput yRecBot
    "Control signal of bottom IEH damper"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput yBypBot
    "Control signal of bottom bypass damper"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.BooleanOutput onAdia
    "Indirect evaporative cooling status" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-30})));
  Modelica.Blocks.Interfaces.BooleanOutput onChi "Chiller status" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-70})));
  Modelica.Blocks.Interfaces.RealOutput mod
    "Modulation signal of chiller compressor"
    annotation (Placement(transformation(extent={{100,-10},{140,30}})));
  Modelica.Blocks.Interfaces.RealInput TSet
    "Set point temperature at AHU outlet"
    annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-104,30})));
  Modelica.Blocks.Interfaces.RealInput TFanOutSup
    "Outlet temperature of supply fan" annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-104,0})));
  Modelica.Blocks.Interfaces.RealInput TIehOutSup
    "Temperature of IEH supply outlet" annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-104,-30})));
  Modelica.Blocks.Interfaces.RealInput TIehInSup
    "Temperature of IEH supply inlet" annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-104,-60})));
  Modelica.Blocks.Interfaces.RealInput TEvaOut "Evaporator outlet temperature"
    annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-104,-90})));
  Modelica.Blocks.Interfaces.BooleanInput on "AHU status"       annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-104,90})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
April 24, 2017, by Filip Jorissen:<br/>
Added first implementation.
</li>
</ul>
</html>"));
end AdsolairControllerInterface;
