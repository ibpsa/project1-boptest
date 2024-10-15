within IDEAS.Templates.Interfaces;
model Building

  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  replaceable package Medium=IDEAS.Media.Water;
  replaceable package MediumAir=IDEAS.Media.Air;

  parameter Boolean standAlone=true;

  final parameter Modelica.SIunits.Temperature T_start = 293.15
    "Operative zonal start temperatures";
  final parameter Modelica.SIunits.Power[building.nZones] Q_design = building.Q_design+ventilationSystem.Q_design
    "Total design heat load for heating system based on heat losses";

  replaceable IDEAS.Templates.Interfaces.BaseClasses.Structure building(
      redeclare package Medium = MediumAir)
    constrainedby IDEAS.Templates.Interfaces.BaseClasses.Structure(
      redeclare package Medium = MediumAir,
      final nEmb=heatingSystem.nEmbPorts,
      final T_start=T_start) "Building structure" annotation (Placement(
        transformation(extent={{-66,-10},{-36,10}})), choicesAllMatching=true);

  replaceable IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem heatingSystem
    constrainedby IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem(
    redeclare package Medium = Medium,
    final nZones=building.nZones,
    final Q_design=Q_design) "Thermal building heating system" annotation (
      Placement(transformation(extent={{-20,-10},{20,10}})), choicesAllMatching=
       true);
  replaceable IDEAS.Templates.Interfaces.BaseClasses.Occupant occupant
    constrainedby IDEAS.Templates.Interfaces.BaseClasses.Occupant(nZones=
        building.nZones) "Building occupant" annotation (Placement(
        transformation(extent={{-20,-50},{20,-30}})), choicesAllMatching=true);
  replaceable IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid
    constrainedby IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder
    "Inhome low-voltage electricity grid system" annotation (Placement(
        transformation(extent={{32,-10},{52,10}})), __Dymola_choicesAllMatching=
       true);

  replaceable IDEAS.Templates.Interfaces.BaseClasses.VentilationSystem ventilationSystem(
      redeclare package Medium = MediumAir)
    constrainedby IDEAS.Templates.Interfaces.BaseClasses.VentilationSystem(
      redeclare package Medium = MediumAir,
      final nZones=building.nZones, final VZones=building.VZones)
    "Ventilation system" annotation (Placement(transformation(extent={{-20,20},
            {20,40}})), choicesAllMatching=true);
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
    plugFeeder(v(re(start=230), im(start=0))) if not standAlone
    "Electricity connection to the district feeder"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(
    pin_n(reference(gamma(fixed=true,start=0))),
    f=50,
    V=230,
    phi=0) if standAlone annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={70,-12})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground if
    standAlone
    annotation (Placement(transformation(extent={{62,-40},{78,-24}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) if                               heatingSystem.isDH
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium) if                                heatingSystem.isDH
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  final parameter Boolean InInterface = true;

equation
  connect(heatingSystem.TSet, occupant.TSet) annotation (Line(
      points={{0,-10.2},{0,-30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(building.heatPortEmb, heatingSystem.heatPortEmb) annotation (Line(
      points={{-36,6},{-20,6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.heatPortCon, heatingSystem.heatPortCon) annotation (Line(
      points={{-36,2},{-20,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.heatPortCon, occupant.heatPortCon) annotation (Line(
      points={{-36,2},{-26,2},{-26,-38},{-20,-38}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.heatPortRad, heatingSystem.heatPortRad) annotation (Line(
      points={{-36,-2},{-20,-2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.heatPortRad, occupant.heatPortRad) annotation (Line(
      points={{-36,-2},{-30,-2},{-30,-42},{-20,-42}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(building.TSensor, heatingSystem.TSensor) annotation (Line(
      points={{-35.4,-6},{-20.4,-6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(building.TSensor, ventilationSystem.TSensor) annotation (Line(
      points={{-35.4,-6},{-32,-6},{-32,24},{-20.4,24}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(ventilationSystem.plugLoad, inHomeGrid.nodeSingle) annotation (Line(
      points={{20,30},{26,30},{26,0},{32,0}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(heatingSystem.plugLoad, inHomeGrid.nodeSingle) annotation (Line(
      points={{20,0},{32,0}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(occupant.plugLoad, inHomeGrid.nodeSingle) annotation (Line(
      points={{20,-40},{26,-40},{26,0},{32,0}},
      color={85,170,255},
      smooth=Smooth.None));

  if standAlone then
    connect(voltageSource.pin_p, ground.pin) annotation (Line(
        points={{70,-20},{70,-24}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(inHomeGrid.pinSingle, voltageSource.pin_n) annotation (Line(
        points={{52,0},{70,0},{70,-4}},
        color={85,170,255},
        smooth=Smooth.None));
  else
    connect(inHomeGrid.pinSingle, plugFeeder) annotation (Line(
        points={{52,0},{100,0}},
        color={85,170,255},
        smooth=Smooth.None));
  end if;

  connect(ventilationSystem.port_b, building.port_a) annotation (Line(
      points={{-20,28},{-49,28},{-49,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building.port_b, ventilationSystem.port_a) annotation (Line(
      points={{-53,10},{-52,10},{-52,32},{-20,32}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(heatingSystem.port_a, port_a) annotation (Line(
      points={{12,-10},{12,-26},{30,-26},{30,-76},{-20,-76},{-20,-100}},
      color={0,127,255},
      thickness=0.5));
  connect(heatingSystem.port_b, port_b) annotation (Line(
      points={{16,-10},{16,-10},{16,-22},{34,-22},{34,-80},{20,-80},{20,-100}},
      color={0,127,255},
      thickness=0.5,
      pattern=LinePattern.Dash));

  annotation (Documentation(info="<html>
<p>
Interface for building model, that allows to select a structure, heating system,
ventilation system, occupant model and optional in-home electrical grid. 
These components must also be defined as extensions of the respective templates in
<a href=\"modelica://IDEAS.Templates.Interfaces.BaseClasses\">
IDEAS.Templates.Interfaces.BaseClasses</a>. This interface connects the componets appropriately and defines the media that are used. <br/>
By setting <code>standAlone=false</code> an electric pin becomes available for connection to an external electricity grid. <br/>
Fluid ports for the connection to a district heating network will be used if parameter <code>isDH=true</code> in the <code>heatingSystem</code> model. 
Furthermore, the number of embeded ports of the structure is taken from the one defined by the heating system: <code>building.nEmb=heatingSystem.nEmbPorts</code>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 31, 2020, by Christina Protopapadaki:<br/>
Parameter <code>isDH</code> defining if the building is connected to a DH grid is now set in the heating system model instead of here.
The number of embeded ports of the structure is now taken from the one defined by the heating system: <code>nEmb=heatingSystem.nEmbPorts</code>.
See <a href=https://github.com/open-ideas/IDEAS/issues/1118>#1118</a>.
</li>
</ul>
</html>"),
  Icon(graphics={
        Line(
          points={{60,22},{0,74},{-60,24},{-60,-46},{60,-46}},
          color={127,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{60,22},{56,18},{0,64},{-54,20},{-54,-40},{60,-40},{60,-46},{
              -60,-46},{-60,24},{0,74},{60,22}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,6},{-46,-6},{-44,-8},{-24,4},{-24,16},{-26,18},{-46,6}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,-18},{-46,-30},{-44,-32},{-24,-20},{-24,-8},{-26,-6},{-46,
              -18}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-44,-4},{-50,-8},{-50,-32},{-46,-36},{28,-36},{42,-26}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{-50,-32},{-44,-28}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{-24,14},{-20,16},{-20,-18},{-16,-22},{-16,-22},{40,-22}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{-24,-10},{-20,-8}},
          color={127,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{40,-12},{40,-32},{50,-38},{58,-32},{58,-16},{54,-10},{48,-6},
              {40,-12}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-60},{100,-100}},
          lineColor={127,0,0},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}})));
end Building;
