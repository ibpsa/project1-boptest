within IDEAS.LIDEAS.Examples;
model ZoneWithInputsLinearise
  "Example of how to add controlled and prescribed inputs to the linearised model and how to add outputs."
  extends ZoneLinearise;
  parameter Boolean validation = false "Set to true to keep the prescribed heat flows even when sim.linearize is false. This is used for models in LIDEAS.Validation.";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preQFloCon[nZones] if  sim.linearise or validation
    "Convective heat flow from control inputs"
    annotation (Placement(transformation(extent={{78,50},{58,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preQFloRad[nZones] if  sim.linearise or validation
    "Radiative heat flow from control inputs"
    annotation (Placement(transformation(extent={{78,30},{58,50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preQFloTabs[nEmb] if  sim.linearise or validation
    "Embedded heat flow from control inputs"
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  input Components.BaseClasses.Inputs ctrlInputs if  sim.linearise "Control inputs" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,62})));
  output Components.BaseClasses.Outputs outputs "Outputs"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,-10})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow occQFloCon[nZones] if  sim.linearise or validation
    "Convective heat flow for occupancy"
    annotation (Placement(transformation(extent={{84,-70},{64,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow occQFloRad[nZones] if  sim.linearise or validation
    "Radiative heat flow for occupancy"
    annotation (Placement(transformation(extent={{84,-90},{64,-70}})));
  input Components.BaseClasses.Prescribed prescribedIn if  sim.linearise
    "Prescribed inputs which do not depend on the model states value (e.g. heat flow from occupancy)"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,-60})));
equation
  connect(preQFloCon[1].port, firFlo.gainCon) annotation (Line(points={{58,60},
          {48,60},{48,-63},{40,-63}}, color={191,0,0}));
  connect(preQFloCon[2].port, groFlo.gainCon) annotation (Line(points={{58,60},
          {58,60},{48,60},{48,-13},{40,-13}}, color={191,0,0}));
  connect(preQFloRad[2].port, groFlo.gainRad) annotation (Line(points={{58,40},
          {50,40},{50,-16},{42,-16},{40,-16}}, color={191,0,0}));
  connect(preQFloRad[1].port, firFlo.gainRad) annotation (Line(points={{58,40},
          {58,40},{50,40},{50,-18},{50,40},{50,-66},{40,-66}}, color={191,0,0}));
  connect(preQFloCon.Q_flow, ctrlInputs.QCon) annotation (Line(points={{78,60},{
          100.1,60},{100.1,61.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(preQFloRad.Q_flow, ctrlInputs.QRad) annotation (Line(points={{78,40},{
          100.1,40},{100.1,61.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(preQFloTabs.Q_flow, ctrlInputs.QEmb) annotation (Line(points={{80,20},
          {100.1,20},{100.1,61.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(preQFloTabs[1].port, floor.port_emb[1]) annotation (Line(points={{60,
          20},{52,20},{52,-38},{19,-38}}, color={191,0,0}));
  connect(groFlo.TSensor, outputs.TSensor[1]) annotation (Line(points={{40.6,-10},
          {100.1,-10},{100.1,-10.1}}, color={0,0,127}));
  connect(firFlo.TSensor, outputs.TSensor[2]) annotation (Line(points={{40.6,-60},
          {50,-60},{54,-60},{54,-10.1},{100.1,-10.1}}, color={0,0,127}));
  connect(occQFloCon[1].port, groFlo.gainCon) annotation (Line(points={{64,-60},
          {60,-60},{60,-13},{40,-13}}, color={191,0,0}));
  connect(occQFloCon[2].port, firFlo.gainCon) annotation (Line(points={{64,-60},
          {60,-60},{60,-63},{40,-63}}, color={191,0,0}));
  connect(occQFloRad[1].port, groFlo.gainRad) annotation (Line(points={{64,-80},
          {58,-80},{58,-16},{40,-16}}, color={191,0,0}));
  connect(occQFloRad[2].port, firFlo.gainRad) annotation (Line(points={{64,-80},
          {58,-80},{58,-66},{40,-66}}, color={191,0,0}));
  connect(occQFloRad.Q_flow, prescribedIn.QRad) annotation (Line(points={{84,-80},
          {100,-80},{100,-60.1},{100.1,-60.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(occQFloCon.Q_flow, prescribedIn.QCon) annotation (Line(points={{84,-60},
          {100.1,-60},{100.1,-60.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Scripts/linearize_zoneWithInputsLinearise.mos" "Linearise"),
    Documentation(revisions="<html>
<ul>
<li>
April 5, 2018 by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>This model illustrates how to add <i>control inputs</i> to the linearised model. Control inputs are inputs which will be decided by the user / controller. Additionally, <i>prescribed inputs</i> are added. Prescribed inputs are inputs which can be precomputed as they are known in advance (i.e. internal gains due to occupancy). Finally, the <i>outputs</i> bus should include all variables that the user wants to output from the linearised model.</p>
<p>The ctrlInputs, outputs and prescribed buses can be adapted to the user&apos;s need. However, the names <i>ctrlInputs</i>, <i>outputs</i>, and <i>prescribed</i> should remain unchanged such that it is compatible with the model creating the outputs.</p>
<p>In order to linearise the model, use the command <i>Linearise </i>from the Dymola Commands menu.</p>
</html>"));
end ZoneWithInputsLinearise;
