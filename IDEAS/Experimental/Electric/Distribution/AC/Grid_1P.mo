within IDEAS.Experimental.Electric.Distribution.AC;
model Grid_1P

  // note: no transformer included, as single-phase grids are mainly used in-building, thus mostly no transformer needed.
replaceable parameter IDEAS.Experimental.Electric.Data.Interfaces.GridType grid(Pha=1)
    "Choose a grid layout" annotation (choicesAllMatching=true);

  Components.Grid_1P grid_1P(grid=grid)
    annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
  IDEAS.Experimental.Electric.BaseClasses.AC.Con1PlusNTo1 con1PlusNTo1_1[grid_1P.grid.nNodes]
    annotation (Placement(transformation(extent={{32,-2},{52,18}})));
public
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin[grid_1P.grid.nNodes] gridNodes1P
    annotation (Placement(transformation(extent={{90,-2},{110,18}})));
Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
                GridConnection(i(
                          im(  each start=0)))
    annotation (Placement(transformation(extent={{-110,20},{-90,40}})));
Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin
                Ground(i( im(  each start=0)))
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
equation

  for n in 1:grid_1P.grid.nNodes loop
    connect(grid_1P.node[:,n], con1PlusNTo1_1[n].twoWire) annotation (Line(
      points={{10,8},{32,8}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(con1PlusNTo1_1[n].oneWire[1], gridNodes1P[n]) annotation (Line(
      points={{52,8},{100,8}},
      color={85,170,255},
      smooth=Smooth.None));
end for;

  connect(GridConnection, grid_1P.GridConnection) annotation (Line(
      points={{-100,30},{-20,30},{-20,8},{-10,8}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Ground, grid_1P.Ground) annotation (Line(
      points={{-100,-20},{-20,-20},{-20,4},{-10,4}},
      color={85,170,255},
      smooth=Smooth.None));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                      graphics), Icon(graphics={
        Line(
          points={{-22,36},{30,2},{100,0}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-32,40},{-32,34},{-4,34},{-4,-80},{4,-80},{4,34},{34,34},{34,
              40},{4,40},{4,46},{-4,46},{-4,40},{-32,40}},
          lineColor={95,95,95},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={95,95,95}),
        Line(
          points={{-102,4},{-46,12},{-28,36}},
          color={0,0,0},
          smooth=Smooth.Bezier)}));
end Grid_1P;
