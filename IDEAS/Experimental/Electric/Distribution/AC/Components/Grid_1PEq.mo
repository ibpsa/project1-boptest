within IDEAS.Experimental.Electric.Distribution.AC.Components;
model Grid_1PEq "One-phase equivalent of three fase grid cable-structure"

public
  replaceable parameter IDEAS.Experimental.Electric.Data.Interfaces.GridType grid(Pha=1)
    "Choose a grid Layout (with 3 phaze values)"
    annotation (choicesAllMatching=true);

  IDEAS.Experimental.Electric.Distribution.AC.BaseClasses.Branch branch[Nodes](R=
        Modelica.ComplexMath.real(Z), X=Modelica.ComplexMath.imag(Z))  annotation (Placement(transformation(extent={{0,-4},{20,16}})));

  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin TraPin
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin[Nodes]
    node annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.SIunits.ActivePower PGriTot;
  Modelica.SIunits.ComplexPower SGriTot;
  Modelica.SIunits.ReactivePower QGriTot;

  //parameter Boolean Loss = true
  //    "if true, PLosBra and PGriLosTot gives branch and Grid losses";
  Modelica.SIunits.ActivePower PLosBra[Nodes];
  Modelica.SIunits.ActivePower PGriLosTot;

  Modelica.SIunits.Voltage Vabs[Nodes];
  Modelica.SIunits.Voltage VMax=max(Vabs);
  Modelica.SIunits.Voltage VMin=min(Vabs);

protected
  parameter Integer nodeMatrix[Nodes, Nodes]=grid.nodeMatrix;
  parameter Modelica.SIunits.ComplexImpedance[Nodes] Z=grid.Z;
  parameter Integer Nodes=grid.nNodes;

equation
  connect(branch[1].pin_p, TraPin)
                                  annotation (Line(points={{0,6},{0,6},{-8,6},{
          -8,0},{-100,0}},       color={85,170,255}));
  for x in 1:Nodes loop
    for y in 1:Nodes loop
      if nodeMatrix[x, y] == 1 then
        connect(branch[x].pin_p, node[y])
                                         annotation (Line(points={{0,6},{0,
                  6},{-8,6},{-8,0},{100,0}},
                                 color={85,170,255}));
      elseif nodeMatrix[x, y] == -1 then
        connect(branch[x].pin_n, node[y])
                                         annotation (Line(points={{20,6},{26,6},
                {26,0},{100,0}}, color={85,170,255}));
      end if;
    end for;

  end for;

  for x in 1:Nodes loop
    Vabs[x] = Modelica.ComplexMath.'abs'(node[x].v);
  end for;

  //if Loss then
  for x in 1:Nodes loop
    PLosBra[x] = branch[x].R*(Modelica.ComplexMath.'abs'(branch[x].i))^2;
  end for;
  PGriLosTot = ones(Nodes)*PLosBra;
  //end if;

  SGriTot = branch[1].pin_p.v*Modelica.ComplexMath.conj(branch[1].pin_p.i);
  PGriTot = Modelica.ComplexMath.real(SGriTot);
  QGriTot = Modelica.ComplexMath.imag(SGriTot);
  annotation (Diagram(graphics), Icon(graphics={
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
end Grid_1PEq;
