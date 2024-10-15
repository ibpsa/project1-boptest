within IDEAS.Experimental.Electric.Distribution.AC.Examples;
model TestGridGeneral1PEq
  import IDEAS;
    extends Modelica.Icons.Example;
  IDEAS.Experimental.Electric.Distribution.AC.Examples.Components.SinePower
    risingflankSingle1(amplitude=12000)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));

  IDEAS.Experimental.Electric.Distribution.AC.Grid_1PEq grid1PGeneral(
    redeclare IDEAS.Experimental.Electric.Data.Grids.TestGrid2Nodes grid,
    redeclare IDEAS.Experimental.Electric.Data.TransformerImp.Transfo_160kVA
      transformer,
    traTCal=true)
    annotation (Placement(transformation(extent={{-38,0},{-18,20}})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-90,64},{-70,84}})));
equation

  connect(grid1PGeneral.gridNodes1P[2], risingflankSingle1.nodes) annotation (
      Line(
      points={{-18,10},{40,10}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics),
    experiment(StopTime=1.2096e+006, Interval=600),
    __Dymola_experimentSetupOutput);
end TestGridGeneral1PEq;
