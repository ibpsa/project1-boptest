within IDEAS.Experimental.Electric.Distribution.DC;
model GridDCGeneral
  import IDEAS;

replaceable parameter Data.Interfaces.DirectCurrent.GridType grid
    "Choose a grid Layout" annotation (choicesAllMatching=true);

parameter Integer Nodes=grid.nNodes;

  Components.GridOnlyDC gridOnlyDC(grid=grid)
    annotation (Placement(transformation(extent={{-40,-20},{0,20}})));

  Modelica.Electrical.Analog.Interfaces.PositivePin[2,grid.nNodes] node2Lines
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  IDEAS.Experimental.Electric.BaseClasses.DC.Con1PlusNTo1 con1PlusNTo1[
    gridOnlyDC.grid.nNodes]
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
//1,gridOnlyDC.grid.nNodes
  Modelica.Electrical.Analog.Interfaces.PositivePin[1,grid.nNodes] nodes1Phase
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin[2] gridConnection
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  output Modelica.SIunits.ActivePower PGriTot=gridOnlyDC.PGriTot;

  output Modelica.SIunits.Voltage Vabs[Nodes]=gridOnlyDC.Vabs;

  output Modelica.SIunits.ActivePower PLosBra[Nodes]=gridOnlyDC.PLosBra;
  output Modelica.SIunits.ActivePower PLosNeu[Nodes]=gridOnlyDC.PLosNeu;
  output Modelica.SIunits.ActivePower PGriLosPha=gridOnlyDC.PGriLosPha;
  output Modelica.SIunits.ActivePower PGriLosNeu=gridOnlyDC.PGriLosNeu;
  output Modelica.SIunits.ActivePower PGriLosTot=gridOnlyDC.PGriLosTot;

  output Modelica.SIunits.Current Ibranch0=gridOnlyDC.branch[1].i;
  output Modelica.SIunits.Current Ineutral0=gridOnlyDC.neutral[1].i;

equation
  connect(gridOnlyDC.node, node2Lines)
                                    annotation (Line(
       points={{0,0},{30,0}},
       color={0,0,255},
       smooth=Smooth.None));
  for n in 1:gridOnlyDC.grid.nNodes loop
    connect(node2Lines[:,n], con1PlusNTo1[n].twoWire) annotation (Line(
       points={{30,0},{60,0}},
       color={85,170,255},
       smooth=Smooth.None));
    connect(con1PlusNTo1[n].oneWire, nodes1Phase[:,n]) annotation (Line(
       points={{80,0},{100,0}},
       color={85,170,255},
       smooth=Smooth.None));
  end for;

  connect(gridConnection, gridOnlyDC.GridConnection) annotation (Line(
       points={{-100,0},{-40,0}},
       color={85,170,255},
       smooth=Smooth.None));
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
end GridDCGeneral;
