within IDEAS.Experimental.Electric.Distribution.AC.Components;
model Grid_1P "Single-phase grid"
replaceable parameter IDEAS.Experimental.Electric.Data.Interfaces.GridType grid(Pha=1)
    "Choose a grid layout" annotation (choicesAllMatching=true);

Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin[
                               2,Nodes] node
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
                GridConnection(i(
                          im(  each start=0)))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin
                Ground(i( im(  each start=0)))
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));

  IDEAS.Experimental.Electric.Distribution.AC.BaseClasses.Branch branch[Nodes](R=
        Modelica.ComplexMath.real(Z), X=Modelica.ComplexMath.imag(Z)) annotation (Placement(transformation(extent={{-4,-4},
            {16,16}})));
  IDEAS.Experimental.Electric.Distribution.AC.BaseClasses.Branch neutral[Nodes](R=
        Modelica.ComplexMath.real(Z), X=Modelica.ComplexMath.imag(Z)) annotation (Placement(transformation(extent={{-4,-58},
            {16,-38}})));
  Modelica.SIunits.ActivePower PGriTot;
  Modelica.SIunits.ComplexPower SGriTot;
  Modelica.SIunits.ReactivePower QGriTot;

  output Modelica.SIunits.ActivePower PLosBra[Nodes];
  output Modelica.SIunits.ActivePower PLosNeu[Nodes];
  output Modelica.SIunits.ActivePower PGriLosPha;
  output Modelica.SIunits.ActivePower PGriLosNeu;
  output Modelica.SIunits.ActivePower PGriLosTot;

  parameter Integer Nodes=grid.nNodes;
  parameter Integer nodeMatrix[Nodes,Nodes] = grid.nodeMatrix;
  parameter Modelica.SIunits.ComplexImpedance[Nodes] Z = grid.Z;

//Absolute voltages at the nodes
 output Modelica.SIunits.Voltage Vabs[Nodes];

equation
  /***Connecting all neutral connectors (=4th row of nodes)***/
  connect(Ground,neutral[1].pin_p)  annotation (Line(points={{-100,-40},{-56,
          -40},{-10,-40},{-10,-48},{-4,-48}},
                                 color={85,170,255}));
  for x in 1:Nodes loop
    for y in 1:Nodes loop
      if nodeMatrix[x,y]==1 then
        connect(neutral[x].pin_p,node[2,y]) annotation (Line(points={{-4,-48},{
                -10,-48},{-10,-40},{64,-40},{64,4},{64,4},{100,4},{100,5}},
                                 color={85,170,255}));
      elseif nodeMatrix[x,y]==-1 then
        connect(neutral[x].pin_n,node[2,y]) annotation (Line(points={{16,-48},{
                20,-48},{20,-40},{64,-40},{64,4},{100,4},{100,5},{100,5}},
                                 color={85,170,255}));
      end if;
    end for;
  end for;
  /***Connecting all phases***/

  connect(GridConnection,branch[1].pin_p)
                                         annotation (Line(points={{-100,0},{
          -100,0},{-8,0},{-8,6},{-4,6}},
                                 color={85,170,255}));
  for x in 1:Nodes loop
    for y in 1:Nodes loop
      if nodeMatrix[x,y]==1 then
        connect(branch[x].pin_p,node[1,y])
                                          annotation (Line(points={{-4,6},{-4,6},
                {-8,6},{-8,0},{100,0},{100,0},{100,0},{100,-5}},
                                 color={85,170,255}));
      elseif nodeMatrix[x,y]==-1 then
        connect(branch[x].pin_n,node[1,y])
                                          annotation (Line(points={{16,6},{16,6},
                {20,6},{20,0},{100,0},{100,-2},{100,-4},{100,-4},{100,-5}},
                                 color={85,170,255}));
      end if;
    end for;
  end for;

/*** Calculating the absolute node voltages ***/
  for x in 1:Nodes loop
    Vabs[x] = Modelica.ComplexMath.'abs'(node[1, x].v - node[2, x].v);
  end for;

/***Calculating all power phase powers***/
  SGriTot = (branch[1].pin_p.v - neutral[1].pin_p.v)*
    Modelica.ComplexMath.conj(branch[1].pin_p.i);
  PGriTot = Modelica.ComplexMath.real(SGriTot);
  QGriTot = Modelica.ComplexMath.imag(SGriTot);

for x in 1:Nodes loop
  PLosBra[x] = branch[x].R*(Modelica.ComplexMath.'abs'(branch[x].i))^2;
  PLosNeu[x] = neutral[x].R*(Modelica.ComplexMath.'abs'(neutral[x].i))^2;
end for;
  PGriLosPha = ones(Nodes)*PLosBra[:];
  PGriLosNeu = ones(Nodes)*PLosNeu[:];
  PGriLosTot = PGriLosPha + PGriLosNeu;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(graphics={
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
