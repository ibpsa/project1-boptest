within IDEAS.Buildings.Components.Interfaces;
model DummyConnection "Source generator/sink for propsbus"
  parameter Boolean isZone = false "Set to true when connecting to a surface";
  parameter Real A=1 "Surface area"
    annotation(Dialog(enable=not isZone));
  parameter Modelica.SIunits.HeatFlowRate surfCon=0
    "Fixed heat flow rate for surfCon"
    annotation(Dialog(enable=not isZone));
  parameter Modelica.SIunits.HeatFlowRate iSolDir=0
    "Fixed heat flow rate for iSolDir"
    annotation(Dialog(enable=not isZone));
  parameter Modelica.SIunits.HeatFlowRate iSolDif=0
    "Fixed heat flow rate for iSolDif"
    annotation(Dialog(enable=not isZone));
  parameter Modelica.SIunits.Temperature T = 293.15 "Fixed temperature for surfRad, or zone when isZone";

  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  IDEAS.Buildings.Components.Interfaces.ZoneBus zoneBus(
    outputAngles=sim.outputAngles,
    numIncAndAziInBus=sim.numIncAndAziInBus)
    annotation (Placement(transformation(extent={{80,-22},{120,18}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow prescribedHeatFlow[3](
      Q_flow={surfCon,iSolDif,iSolDir}) if
                         not isZone
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Sources.Constant area(k=A) if not isZone
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.Constant eps(k=0.88) if not isZone
    annotation (Placement(transformation(extent={{0,80},{20,100}})));

  Modelica.Blocks.Sources.Constant QTra(k=A) if not isZone
    annotation (Placement(transformation(extent={{0,0},{20,20}})));

  Modelica.Blocks.Sources.Constant azi(k=IDEAS.Types.Azimuth.S) if      not isZone
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Sources.Constant inc(k=IDEAS.Types.Tilt.Floor) if     not isZone
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=T)
    annotation (Placement(transformation(extent={{-70,-16},{-50,4}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow QGai(Q_flow=0) if
                         not isZone
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  IDEAS.Buildings.Components.BaseClasses.ConservationOfEnergy.PrescribedEnergy
    prescribedEnergy if not isZone
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Sources.Constant zero(k=0) if not isZone
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow QRad(Q_flow=0) if
                         isZone
    annotation (Placement(transformation(extent={{-40,-64},{-20,-44}})));
  Modelica.Blocks.Sources.Constant q50_zone(k=0) if  isZone
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.BooleanConstant custom_n50(k=false) if  isZone
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Blocks.Sources.BooleanConstant custom_q50(k=false) if not isZone
    annotation (Placement(transformation(extent={{-80,-130},{-60,-110}})));
equation
  connect(prescribedHeatFlow[1].port, zoneBus.surfCon) annotation (Line(
      points={{-50,20},{62,20},{62,-1.9},{100.1,-1.9}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedHeatFlow[2].port, zoneBus.iSolDir) annotation (Line(
      points={{-50,20},{58,20},{58,-1.9},{100.1,-1.9}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedHeatFlow[3].port, zoneBus.iSolDif) annotation (Line(
      points={{-50,20},{60,20},{60,-1.9},{100.1,-1.9}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(eps.y, zoneBus.epsLw) annotation (Line(
      points={{21,90},{100.1,90},{100.1,-1.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(eps.y, zoneBus.epsSw) annotation (Line(
      points={{21,90},{100,90},{100,34},{100.1,34},{100.1,-1.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(area.y, zoneBus.area) annotation (Line(
      points={{21,50},{100.1,50},{100.1,-1.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QTra.y, zoneBus.QTra_design) annotation (Line(
      points={{21,10},{100.1,10},{100.1,-1.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(azi.y, zoneBus.azi) annotation (Line(
      points={{21,-50},{100,-50},{100,-30},{100.1,-30},{100.1,-1.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(inc.y, zoneBus.inc) annotation (Line(
      points={{21,-90},{100.1,-90},{100.1,-1.9}},
      color={0,0,127},
      smooth=Smooth.None));
  if isZone then
  end if;
  if isZone then
    connect(fixedTemperature.port, zoneBus.surfCon) annotation (Line(points={{-50,
          -6},{100.1,-6},{100.1,-1.9}}, color={191,0,0}));
    connect(fixedTemperature.port, zoneBus.iSolDif) annotation (Line(points={{-50,-6},
          {-48,-6},{-48,-8},{100.1,-8},{100.1,-1.9}},
                                        color={191,0,0}));
    connect(fixedTemperature.port, zoneBus.iSolDir) annotation (Line(points={{-50,-6},
          {-48,-6},{-48,-4},{100,-4},{100,-1.9},{100.1,-1.9}},
                                               color={191,0,0}));
  end if;
  connect(QGai.port, zoneBus.Qgai) annotation (Line(points={{-20,-20},{100.1,-20},
          {100.1,-1.9}}, color={191,0,0}));
  connect(prescribedEnergy.port, zoneBus.E) annotation (Line(points={{-20,-40},{
          100.1,-40},{100.1,-1.9}}, color={0,0,0}));
  connect(zero.y, prescribedEnergy.E) annotation (Line(points={{-59,-40},{-49.5,
          -40},{-40,-40}}, color={0,0,127}));
  if isZone then
    connect(QRad.port, zoneBus.surfRad) annotation (Line(points={{-20,-54},{100.1,
          -54},{100.1,-1.9}}, color={191,0,0}));
    connect(sim.E, zoneBus.E) annotation (Line(points={{-90,20},{-90,20},{-90,-2},
            {100.1,-2},{100.1,-1.9}},          color={0,0,0}));
    connect(sim.Qgai, zoneBus.Qgai) annotation (Line(points={{-90,20},{-90,20},{
            -90,-1.9},{100.1,-1.9}},    color={0,0,0}));
  else
    connect(fixedTemperature.port, zoneBus.surfRad) annotation (Line(points={{-50,
          -6},{-50,-8},{-48,-8},{-48,-10},{100.1,-10},{100.1,-1.9}}, color={191,
          0,0}));
  end if;


  connect(zero.y, zoneBus.v50) annotation (Line(points={{-59,-40},{100.1,-40},{100.1,
          -1.9}}, color={0,0,127}));
  connect(custom_n50.y, zoneBus.use_custom_n50) annotation (Line(points={{-59,-90},
          {100.1,-90},{100.1,-1.9}},color={255,0,255}));
  connect(q50_zone.y, zoneBus.q50_zone) annotation (Line(points={{-59,-70},{100.1,
          -70},{100.1,-1.9}}, color={0,0,127}));
  connect(custom_q50.y, zoneBus.use_custom_q50) annotation (Line(points={{-59,
          -120},{100.1,-120},{100.1,-1.9}},
                                     color={255,0,255}));
   annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Line(
          points={{60,60},{-60,-60}},
          color={0,0,255},
          smooth=Smooth.None), Line(
          points={{-60,60},{60,-60}},
          color={0,0,255},
          smooth=Smooth.None)}),
    Documentation(revisions="<html>
<ul>
<li>
November 21, 2020, by Filip Jorissen:<br/>
Added connections for interzonal airflow.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1066\">
#1066</a>
</li>
<li>
April 26, 2020, by Filip Jorissen:<br/>
Refactored <code>SolBus</code> to avoid many instances in <code>PropsBus</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1131\">
#1131</a>
</li>
</ul>
</html>"));
end DummyConnection;
