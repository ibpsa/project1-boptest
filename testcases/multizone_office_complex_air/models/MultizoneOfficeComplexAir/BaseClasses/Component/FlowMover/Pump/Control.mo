within MultizoneOfficeComplexAir.BaseClasses.Component.FlowMover.Pump;
package Control

  model SecPumCon "This model is used for secondary chilled water pump control."
    parameter Real tWai = 300 "Waiting time";

      parameter Integer n=3
      "the number of pumps";
    WaterSide.Control.PumpStageN pumSta(
      tWai=tWai,
      thehol_up=0.9,
      n=n,
      thehol_down=0.6)
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    Modelica.Blocks.Interfaces.BooleanInput On "On signal"
      annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Modelica.Blocks.Interfaces.RealInput sta[n] "Speeds of pumps"
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
    Modelica.Blocks.Interfaces.RealInput dpMea "Measured pressure drop"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Math.Product product[n]
      annotation (Placement(transformation(extent={{20,40},{40,60}})));
    Modelica.Blocks.Interfaces.RealOutput y[n] "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    Modelica.Blocks.Routing.Replicator replicator(nout=n)
      annotation (Placement(transformation(extent={{56,-40},{76,-20}})));
    MultizoneOfficeComplexAir.BaseClasses.Component.conPI conPI(k=0.001, Ti=60)
      annotation (Placement(transformation(extent={{18,-20},{38,0}})));
    Modelica.Blocks.Interfaces.RealInput dpSet
      "Static differential pressure setpoint for the secondary pump"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  equation
    connect(pumSta.On, On) annotation (Line(points={{-52,8},{-66,8},{-80,
            8},{-80,80},{-120,80}}, color={255,0,255}));
    connect(pumSta.sta, sta) annotation (Line(points={{-52,-8},{-80,-8},{
            -80,-80},{-120,-80}}, color={0,0,127}));
    connect(product.y, y) annotation (Line(
        points={{41,50},{60,50},{80,50},{80,0},{110,0}},
        color={0,0,127}));
    connect(pumSta.y, product.u1) annotation (Line(points={{-29,0},{0,0},
            {0,56},{18,56}}, color={0,0,127}));
    connect(replicator.y, product.u2) annotation (Line(
        points={{77,-30},{90,-30},{90,-12},{58,-12},{58,24},{8,24},{8,44},{18,44}},
        color={0,0,127}));

    connect(conPI.On, On) annotation (Line(
        points={{16,-4},{-20,-4},{-20,80},{-120,80}},
        color={255,0,255}));
    connect(conPI.y, replicator.u) annotation (Line(
        points={{39,-10},{46,-10},{46,-30},{54,-30}},
        color={0,0,127}));
    connect(conPI.mea, dpMea) annotation (Line(points={{16,-16},{-92,-16},
            {-92,0},{-120,0}}, color={0,0,127}));
    connect(conPI.set, dpSet) annotation (Line(points={{16,-10},{-20,-10},
            {-20,-40},{-120,-40}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-156,104},{144,144}},
            textString="%name",
            textColor={0,0,255})}),           Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end SecPumCon;
end Control;
