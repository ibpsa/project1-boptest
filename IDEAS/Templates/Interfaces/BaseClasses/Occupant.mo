within IDEAS.Templates.Interfaces.BaseClasses;
partial model Occupant

  extends IDEAS.Templates.Interfaces.BaseClasses.PartialSystem;

  parameter Integer nZones(min=1) "number of conditioned thermal zones";
  parameter Integer id=1 "id-number on extern data references";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
    "Nodes for convective heat gains" annotation (Placement(transformation(
          extent={{-210,10},{-190,30}}),iconTransformation(extent={{-210,10},{
            -190,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortRad
    "Nodes for radiative heat gains" annotation (Placement(transformation(
          extent={{-210,-30},{-190,-10}}),iconTransformation(extent={{-210,-30},
            {-190,-10}})));
  Modelica.Blocks.Interfaces.RealOutput[nZones] TSet(
    final quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC",
    min=0) "Setpoint temperature for the zones" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100})));

  Modelica.Blocks.Interfaces.RealOutput mDHW60C
    "mFlow for domestic hot water, at 60 degC" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,100})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}),
                         graphics={
        Rectangle(
          extent={{-200,100},{200,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={191,0,0}),
        Line(
          points={{200,100},{200,-100}},
          color={85,170,255},
          smooth=Smooth.None),
        Polygon(
          points={{-10,-38},{-10,42},{50,2},{-10,-38}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{70,42},{50,-38}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-28,32},{34,-28}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Italic},
          fontName="Bookman Old Style",
          textString="?"),
        Line(
          points={{-200,20},{-20,20}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{-200,-20},{-20,-20}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,100},{0,52}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{60,100},{60,52}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{210,0},{80,0}},
          color={85,170,255},
          smooth=Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-100},{200,100}}), graphics));
end Occupant;
