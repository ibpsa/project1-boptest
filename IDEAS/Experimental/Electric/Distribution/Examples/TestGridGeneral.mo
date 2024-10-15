within IDEAS.Experimental.Electric.Distribution.Examples;
model TestGridGeneral
  extends Modelica.Icons.Example;
  IDEAS.Experimental.Electric.Distribution.Examples.Components.SinePower risingflankSingle
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  IDEAS.Experimental.Electric.Distribution.AC.Grid_1PEq gridGeneral(
    redeclare IDEAS.Experimental.Electric.Data.Grids.TestGrid2Nodes
                                        grid,
    redeclare IDEAS.Experimental.Electric.Data.TransformerImp.Transfo_100kVA
      transformer)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  IDEAS.Experimental.Electric.Distribution.AC.Grid_3P gridGeneral1(
    redeclare IDEAS.Experimental.Electric.Data.Grids.TestGrid2Nodes
                                        grid,
    redeclare IDEAS.Experimental.Electric.Data.TransformerImp.Transfo_100kVA
      transformer)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  IDEAS.Experimental.Electric.Distribution.Examples.Components.SinePower risingflankSingle1[3]
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));

  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-98,78},{-78,98}})));
equation
  connect(gridGeneral.gridNodes1P[2], risingflankSingle.nodes) annotation (Line(
      points={{-20,10},{40,10}},
      color={0,0,255},
      smooth=Smooth.None));

  connect(gridGeneral1.gridNodes3P[:, 2], risingflankSingle1.nodes) annotation (
     Line(
      points={{-20,-30},{40,-30}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=1.2096e+006, Interval=600),
    __Dymola_experimentSetupOutput,
    uses(IDEAS(version="1.0.0")));
end TestGridGeneral;
