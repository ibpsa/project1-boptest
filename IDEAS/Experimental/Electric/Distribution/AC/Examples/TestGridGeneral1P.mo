within IDEAS.Experimental.Electric.Distribution.AC.Examples;
model TestGridGeneral1P
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,74},{-60,94}})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim1
    annotation (Placement(transformation(extent={{-80,74},{-60,94}})));
  IDEAS.Experimental.Electric.Distribution.AC.Examples.Components.SinePower sinePower
    annotation (Placement(transformation(extent={{58,-10},{78,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(
    f=50,
    V=230,
    phi=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-66,-10})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{-76,-54},{-56,-34}})));
  IDEAS.Experimental.Electric.Distribution.AC.Grid_1P grid_1P(redeclare
      Data.Grids.TestGrid2Nodes grid)
    annotation (Placement(transformation(extent={{-6,-6},{14,14}})));
equation
  connect(voltageSource.pin_n, ground.pin) annotation (Line(
      points={{-66,-20},{-66,-34}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource.pin_p, grid_1P.GridConnection) annotation (Line(
      points={{-66,0},{-66,7},{-6,7}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource.pin_n, grid_1P.Ground) annotation (Line(
      points={{-66,-20},{-20,-20},{-20,2},{-6,2}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(grid_1P.gridNodes1P[2], sinePower.nodes) annotation (Line(
      points={{14,4.8},{36,4.8},{36,0},{58,0}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end TestGridGeneral1P;
