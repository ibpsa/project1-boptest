within IDEAS.Experimental.Electric.Batteries.Validation;
model BatteryCharging
extends Modelica.Icons.Example;
Modelica.SIunits.Power Pnet=-1000;
output Modelica.SIunits.Efficiency SoC = batterySystemGeneral.battery.SoC_out;

protected
  Distribution.AC.Grid_3P gridGeneral(redeclare
      Data.Grids.TestGrid2Nodes                grid,
    redeclare Data.TransformerImp.Transfo_100kVA                transformer,
    traTCal=false)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  AC.BatterySystemGeneral batterySystemGeneral(
    redeclare Data.Batteries.LiIon                technology,
    SoC_start=0.6,
    Pnet=Pnet,
    EBat=10,
    DOD_max=0.8)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
public
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation

  connect(gridGeneral.gridNodes3P[1, 2], batterySystemGeneral.pin[1])
    annotation (Line(
      points={{-60,-30.6667},{-31.6,-30.6667},{-31.6,-30},{0.4,-30}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics),
   Documentation(info="<html>
<h4>General description</h4>
<p>Mathematical validation of battery charging</p>
<h4>Expected result</h4>
<p>1h simulation: delta_soc = +8.736% (total discharging efficiency = 98% + self-discharge)</p>
</html>"));
end BatteryCharging;
