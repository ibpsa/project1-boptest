within IDEAS.LIDEAS.Components.BaseClasses;
model LinWindowResponse
  "Shortwave window response implementation for LIDEAS"
  parameter Integer nLay(min=1) "Number of layers of the wall";
  parameter Real[:, nLay + 1] SwAbs
    "Absorbed solar radiation for each layer for look-up table as function of angle of incidence";
  parameter Real[:, 2] SwTrans
    "Transmitted solar radiation for look-up table as function of angle of incidence";
  parameter Real[nLay] SwAbsDif
    "Absorbed solar radiation for each layer for look-up table as function of angle of incidence";
  parameter Real SwTransDif
    "Transmitted solar radiation for look-up table as function of angle of incidence";
  parameter Boolean linearise = false
    "Set to true for enabling linearization inputs/outputs";
  parameter Boolean createOutputs = false
    "Set to true for enabling linearization inputs/outputs";

  final parameter Integer[nLay] columns=if (nLay == 1) then {2} else integer(
      linspace(
      2,
      nLay + 1,
      nLay));
  Modelica.Blocks.Interfaces.RealInput solDir
    "Direct solar illuminance on surface"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput solDif
    "Diffuse solar illuminance on surface"
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput angInc
    "Angle of incidence"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nLay] iSolAbs
    "Solar absorptance in the panes"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a iSolDir
    "Transmitted direct solar radiation"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a iSolDif
    "Transmitted diffuse solar radiation"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Blocks.Math.Gain radToDeg(final k=180/Modelica.Constants.pi)
    "Conversion from radians to degrees"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Interfaces.RealInput[nLay] AbsQFlowInput if linearise
    annotation (Placement(transformation(extent={{124,70},{84,110}})));
  Modelica.Blocks.Interfaces.RealInput iSolDirInput if linearise
    annotation (Placement(transformation(extent={{124,30},{84,70}})));
  Modelica.Blocks.Interfaces.RealInput iSolDifInput if linearise
    annotation (Placement(transformation(extent={{124,-10},{84,30}})));
  Modelica.Blocks.Interfaces.RealOutput[nLay] AbsQFlowOutput if createOutputs
    annotation (Placement(transformation(extent={{96,-30},{116,-10}})));
  Modelica.Blocks.Interfaces.RealOutput iSolDifOutput if createOutputs
    annotation (Placement(transformation(extent={{96,-90},{116,-70}})));
  Modelica.Blocks.Interfaces.RealOutput iSolDirOutput if createOutputs
    annotation (Placement(transformation(extent={{96,-60},{116,-40}})));

  Modelica.Blocks.Tables.CombiTable1Ds SwAbsDir(
    final table=SwAbs,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final columns=columns)
    "Table for AOI dependent absorptance"
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-29,-11})));
  Modelica.Blocks.Tables.CombiTable1Ds SwTransDir(
    final table=SwTrans,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final columns={2})
    "Table for AOI dependent transmittance"
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-3,-11})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nLay] Abs_flow
    "Solar absorptance in the panes source" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-8.88178e-016,78})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Dir_flow
    "Transmitted direct solar radiation source" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-20,-78})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Dif_flow
    "Transmitted difuse solar radiation source" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={20,-78})));
  Modelica.Blocks.Math.Product[nLay] SwAbsDirProd  annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-33,19})));
  Modelica.Blocks.Math.Product SwTransDirProd annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-7,19})));
  Modelica.Blocks.Math.Gain[   nLay] SwAbsDifProd(k=SwAbsDif)  annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={19,17})));
  Modelica.Blocks.Math.Gain    SwTransDifProd(k=SwTransDif)  annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={45,17})));
  Modelica.Blocks.Math.Add[nLay] add annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=-90,
        origin={-32,48})));

equation
  connect(Abs_flow.port, iSolAbs) annotation (Line(
      points={{4.89859e-016,86},{0,86},{0,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Dir_flow.port, iSolDir) annotation (Line(
      points={{-20,-86},{-20,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Dif_flow.port, iSolDif) annotation (Line(
      points={{20,-86},{20,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solDir, SwTransDirProd.u1) annotation (Line(
      points={{-100,60},{-60,60},{-60,4},{-11.2,4},{-11.2,10.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SwAbsDir.y, SwAbsDirProd.u2) annotation (Line(
      points={{-29,-1.1},{-29,13.45},{-28.8,13.45},{-28.8,10.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SwTransDir.y[1], SwTransDirProd.u2) annotation (Line(
      points={{-3,-1.1},{-3,13.45},{-2.8,13.45},{-2.8,10.6}},
      color={0,0,127},
      smooth=Smooth.None));
  for i in 1:nLay loop
    connect(solDir, SwAbsDirProd[i].u1) annotation (Line(
        points={{-100,60},{-60,60},{-60,4},{-37.2,4},{-37.2,10.6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(solDif, SwAbsDifProd[i].u) annotation (Line(
        points={{-100,20},{-62,20},{-62,2},{19,2},{19,8.6}},
        color={0,0,127},
        smooth=Smooth.None));
  end for;
  if not linearise then
    connect(add.y, Abs_flow.Q_flow) annotation (Line(
      points={{-32,56.8},{-32,62},{-4.89859e-016,62},{-4.89859e-016,70}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(SwTransDifProd.y, Dif_flow.Q_flow) annotation (Line(
      points={{45,24.7},{45,32},{66,32},{66,-44},{20,-44},{20,-70}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(SwTransDirProd.y, Dir_flow.Q_flow) annotation (Line(
      points={{-7,26.7},{-7,50},{80,50},{80,-54},{-20,-54},{-20,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  end if;
  connect(SwAbsDirProd.y, add.u2) annotation (Line(
      points={{-33,26.7},{-33,31.35},{-36.8,31.35},{-36.8,38.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SwAbsDifProd.y, add.u1) annotation (Line(
      points={{19,24.7},{19,32},{-27.2,32},{-27.2,38.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Abs_flow.Q_flow, AbsQFlowInput) annotation (Line(
      points={{0,70},{2,70},{2,62},{74,62},{74,90},{104,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iSolDirInput, Dir_flow.Q_flow) annotation (Line(
      points={{104,50},{70,50},{70,-48},{-20,-48},{-20,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iSolDifInput, Dif_flow.Q_flow) annotation (Line(
      points={{104,10},{88,10},{88,-70},{20,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AbsQFlowOutput, add.y) annotation (Line(
      points={{106,-20},{56,-20},{56,56.8},{-32,56.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SwTransDirProd.y, iSolDirOutput) annotation (Line(
      points={{-7,26.7},{-7,40},{52,40},{52,-50},{106,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SwTransDifProd.y, iSolDifOutput) annotation (Line(
      points={{45,24.7},{45,32},{52,32},{52,-80},{106,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solDif, SwTransDifProd.u) annotation (Line(
      points={{-100,20},{-66,20},{-66,0},{45,0},{45,8.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radToDeg.u, angInc) annotation (Line(points={{-62,-40},{-78,-40},{-78,
          -60},{-100,-60}},     color={0,0,127}));
  connect(radToDeg.y, SwAbsDir.u) annotation (Line(points={{-39,-40},{-29,-40},{
          -29,-21.8}},  color={0,0,127}));
  connect(radToDeg.y, SwTransDir.u) annotation (Line(points={{-39,-40},{-3,-40},
          {-3,-21.8}},      color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics),
    Icon(graphics={
        Rectangle(
          extent={{-80,90},{80,70}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{-80,70},{80,70}},
          pattern=LinePattern.None,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{44,40},{44,-50}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{44,40},{38,30}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{44,40},{50,30}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{14,40},{14,-50}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{14,40},{8,30}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{14,40},{20,30}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{-16,40},{-16,-50}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{-16,40},{-22,30}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{-16,40},{-10,30}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{-46,40},{-46,-50}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{-46,40},{-52,30}},
          smooth=Smooth.None,
          color={127,0,0}),
        Line(
          points={{-46,40},{-40,30}},
          smooth=Smooth.None,
          color={127,0,0})}),
    Documentation(info="<html>
<p>he properties for absorption by and transmission through the glazingare taken into account depending on the angle of incidence of solar irradiation and are based on the output of the <a href=\"Solarwind.Buildings.UsersGuide.References\">[WINDOW 6.3]</a> software, i.e. the shortwave properties itselves based on the layers in the window are not calculated in the model but are input parameters. </p>
</html>", revisions="<html>
<ul>
<li>
August 24, 2018 by Filip Jorissen: <br/> 
Revised implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/812\">#812</a>.
</li>
</ul>
</html>"));
end LinWindowResponse;
