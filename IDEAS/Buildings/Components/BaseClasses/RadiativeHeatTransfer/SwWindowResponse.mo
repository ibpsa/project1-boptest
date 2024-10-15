within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer;
model SwWindowResponse "Shortwave window respone"
  parameter Integer nLay(min=1)
    "Number of layers of the window";
  parameter Real[:, nLay + 1] SwAbs
    "Absorbed solar radiation for each layer for look-up table as function of angle of incidence";
  parameter Real[:, 2] SwTrans
    "Transmitted solar radiation for look-up table as function of angle of incidence";
  parameter Real[nLay] SwAbsDif
    "Absorbed solar radiation for each layer for look-up table as function of angle of incidence";
  parameter Real SwTransDif
    "Transmitted solar radiation for look-up table as function of angle of incidence";

  final parameter Integer[nLay] columns=
    if (nLay == 1)
    then {2}
    else integer(
      linspace(
      2,
      nLay + 1,
      nLay));

  Modelica.Blocks.Interfaces.RealInput solDir
    "Direct solar irradiation"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput solDif
    "Diffuse solar irradiation"
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput angInc
    "Angle of incidence"
    annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nLay] iSolAbs
    "Port for absorbed solar irradiation"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a iSolDir
    "Transmitted direct solar radiation through the glazing"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a iSolDif
    "Transmitted diffuse solar radiation through the glazing"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Blocks.Math.Gain radToDeg(final k=180/Modelica.Constants.pi)
    "Conversion of radians to degrees"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Tables.CombiTable1Ds SwAbsDir(
    final table=SwAbs,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final columns=columns) "lookup table for AOI dependent absorptance"
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-29,-11})));
  Modelica.Blocks.Tables.CombiTable1Ds SwTransDir(
    final table=SwTrans,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final columns={2}) "lookup table for AOI dependent transmittance"
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
    "Transmitted diffuse solar radiation source" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={20,-78})));
  Modelica.Blocks.Math.Product[nLay] SwAbsDirProd annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-33,19})));
  Modelica.Blocks.Math.Product SwTransDirProd annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-7,19})));
  Modelica.Blocks.Math.Add[nLay] add annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=-90,
        origin={-32,48})));

  Modelica.Blocks.Math.Gain[nLay] SwAbsDifProd(k=SwAbsDif)  annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={25,21})));
  Modelica.Blocks.Math.Gain SwTransDifProd(k=SwTransDif)  annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={51,21})));
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
    connect(SwAbsDifProd[i].u, solDif) annotation (Line(points={{25,12.6},{25,2},{
          -64,2},{-64,20},{-100,20}}, color={0,0,127}));
  end for;

  connect(SwTransDirProd.y, Dir_flow.Q_flow) annotation (Line(
      points={{-7,26.7},{-7,50},{80,50},{80,-54},{-20,-54},{-20,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SwAbsDirProd.y, add.u2) annotation (Line(
      points={{-33,26.7},{-33,31.35},{-36.8,31.35},{-36.8,38.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, Abs_flow.Q_flow) annotation (Line(
      points={{-32,56.8},{-32,62},{-4.89859e-016,62},{-4.89859e-016,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radToDeg.u, angInc) annotation (Line(points={{-62,-40},{-76,-40},{
          -100,-40}},           color={0,0,127}));
  connect(radToDeg.y, SwAbsDir.u) annotation (Line(points={{-39,-40},{-29,-40},
          {-29,-21.8}}, color={0,0,127}));
  connect(radToDeg.y, SwTransDir.u) annotation (Line(points={{-39,-40},{-3,-40},
          {-3,-21.8}},      color={0,0,127}));
  connect(SwAbsDifProd.y, add.u1) annotation (Line(points={{25,28.7},{25,34},{-27.2,
          34},{-27.2,38.4}}, color={0,0,127}));
  connect(SwTransDifProd.y, Dif_flow.Q_flow) annotation (Line(points={{51,28.7},
          {51,34},{38,34},{38,-60},{20,-60},{20,-70}}, color={0,0,127}));

   connect(SwTransDifProd.u, solDif) annotation (Line(points={{51,12.6},{51,2},{-64,
          2},{-64,20},{-100,20}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
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
<p>The properties for absorption by and transmission through the glazingare taken into account depending on the angle of incidence of solar irradiation and are based on the output of the <a href=\"IDEAS.Buildings.UsersGuide.References\">[WINDOW 6.3]</a> software, i.e. the shortwave properties itselves based on the layers in the window are not calculated in the model but are input parameters. </p>
</html>"));
end SwWindowResponse;
