within IDEAS.Experimental.Electric.Distribution.DC.Components;
model GridOnlyDC
//extends Modelica.Icons.UnderConstruction;
replaceable parameter Data.Interfaces.DirectCurrent.GridType grid
    "Choose a grid Layout" annotation (choicesAllMatching=true);

Modelica.Electrical.Analog.Interfaces.PositivePin[2,Nodes] node
     annotation (Placement(transformation(extent={{90,-10},{110,10}})));
Modelica.Electrical.Analog.Interfaces.PositivePin GridConnection[2]
     annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  BaseClasses.Branch branch[Nodes](R=R);
  BaseClasses.Branch neutral[Nodes](R=R);

  output Modelica.SIunits.ActivePower PGriTot;
  output Modelica.SIunits.ActivePower PLosBra[Nodes]=branch.Plos;
  output Modelica.SIunits.ActivePower PLosNeu[Nodes]=neutral.Plos;
  output Modelica.SIunits.ActivePower PGriLosPha;
  output Modelica.SIunits.ActivePower PGriLosNeu;
  output Modelica.SIunits.ActivePower PGriLosTot;

  parameter Integer Nodes=grid.nNodes;
  parameter Integer nodeMatrix[Nodes,Nodes] = grid.nodeMatrix;
  parameter Modelica.SIunits.Resistance[Nodes] R = grid.R;

  output Modelica.SIunits.Voltage Vabs[Nodes];

equation
/***Connecting all neutral connectors (=4th row of nodes)***/
  connect(GridConnection[2],neutral[1].p);
  for x in 1:Nodes loop
    for y in 1:Nodes loop
      if nodeMatrix[x,y]==1 then
        connect(neutral[x].p,node[2,y]);
      elseif nodeMatrix[x,y]==-1 then
        connect(neutral[x].n,node[2,y]);
      end if;
    end for;
  end for;

/***Connecting all phases***/
  connect(GridConnection[1],branch[1].p);
  for x in 1:Nodes loop
    for y in 1:Nodes loop
      if nodeMatrix[x,y]==1 then
        connect(branch[x].p,node[1,y]);
      elseif nodeMatrix[x,y]==-1 then
        connect(branch[x].n,node[1,y]);
      end if;
    end for;
  end for;

/*** Calculating the absolute node voltages ***/
  for x in 1:Nodes loop
    Vabs[x] = node[1,x].v - node[2,x].v;
  end for;

/***Calculating all power phase powers***/
  PGriTot = Vabs[1]*GridConnection[1].i;

  PGriLosPha = ones(Nodes)*PLosBra[:];
  PGriLosNeu = ones(Nodes)*PLosNeu[:];
  PGriLosTot = PGriLosPha + PGriLosNeu;

  annotation(Icon(graphics={
        Rectangle(
          extent={{28,60},{70,20}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-26,54},{-26,20},{-6,20},{-6,28},{4,28},{4,32},{-6,32},{-6,44},
              {8,44},{8,50},{-6,50},{-6,54},{-26,54}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-14,20},{-14,0},{-94,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Rectangle(
          extent={{46,50},{50,42}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{56,34},{60,26}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{38,34},{42,26}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{48,20},{48,0},{96,0}},
          color={0,0,255},
          smooth=Smooth.None)}),                                    Diagram(
        graphics));
end GridOnlyDC;
