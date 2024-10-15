within IDEAS.Experimental.Electric.Distribution.DC.Examples;
model TestGridDC
  import IDEAS;
extends Modelica.Icons.Example;
  IDEAS.Experimental.Electric.Distribution.DC.GridDCGeneral gridGeneralDC(
      redeclare
      IDEAS.Experimental.Electric.Data.Grids.DirectCurrent.TestGrid2Nodes grid)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=230)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,0})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Components.SinePower sinePower
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(constantVoltage.p, gridGeneralDC.gridConnection[1]) annotation (Line(
      points={{-80,10},{-20,10},{-20,-1}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.n, ground.p) annotation (Line(
      points={{-80,-10},{-80,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground.p, gridGeneralDC.gridConnection[2]) annotation (Line(
      points={{-80,-10},{-20,-10},{-20,1}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(gridGeneralDC.nodes1Phase[1, 2], sinePower.nodes) annotation (Line(
      points={{20,0},{40,0}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end TestGridDC;
