within IDEAS.BoundaryConditions.Occupants.StROBe;
model StrobeInfoManager
  "StROBe information manager for handling occupant data required in each for simulation."

  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  parameter String filDir = Modelica.Utilities.Files.loadResource("modelica://IDEAS") + "/Inputs/"
    "Directory containing the data files, default under IDEAS/Inputs/";
  final parameter Modelica.SIunits.Time timZonSta(displayUnit="h") = sim.timZonSta
    "standard time zone";
  final parameter Modelica.SIunits.Angle lon(displayUnit="deg") = sim.lon;

  parameter Integer nOcc=33 "Number of occupant profiles to be read";

  parameter Boolean StROBe_P = true "Boolean to read plug load profiles" annotation (Dialog(group="StROBe power load"));

  parameter String FilNam_P = "none.txt"
    "File with (active) plug load profiles from StROBe"
  annotation (Dialog(group="StROBe power load", enable=StROBe_P));

  parameter Boolean StROBe = true "Boolean to read the other profiles too" annotation (Dialog(group="StROBe"));

  parameter String FilNam_Q = "none.txt"
    "File with (reactive) plug load profiles"  annotation (Dialog(group="StROBe", enable=StROBe));
  parameter String FilNam_mDHW = "none.txt"
    "File with hot watter tapping profiles"  annotation (Dialog(group="StROBe", enable=StROBe));
  parameter String FilNam_QCon = "none.txt"
    "File with (convective) internal heat gain profiles" annotation (Dialog(group="StROBe", enable=StROBe));
  parameter String FilNam_QRad = "none.txt"
    "File with (radiative) internal heat gain profiles" annotation (Dialog(group="StROBe", enable=StROBe));
  parameter String FilNam_TSet = "none.txt"
    "File with (main) space heating setpoint profiles" annotation (Dialog(group="StROBe", enable=StROBe));
  parameter String FilNam_TSet2 = "none.txt"
    "File with (secondary) space heating setpoint profiles" annotation (Dialog(group="StROBe", enable=StROBe));

  parameter Boolean PHp = false "Boolean to read heat pump load profiles" annotation (Dialog(group="Heat pumps"));
  parameter String FilNam_PHp = "none.txt"
    "File with (active) electric load heat pump profiles" annotation (Dialog(group="Heat pumps", enable=PHp));

  parameter Boolean PPv = false "Boolean to read photovoltaic load profiles" annotation (Dialog(group="Photovoltaics"));
  parameter String FilNam_PPv = "none.txt"
    "File with (active) photovoltaic load profiles"
    annotation (Dialog(group="Photovoltaics", enable=PPv));
  parameter Integer nPv = 33 "Number of photovoltaic profiles"
    annotation (Dialog(group="Photovoltaics", enable=PPv));
  parameter Modelica.SIunits.Power P_nominal=1000
    "Nominal power of the photovoltaic profiles"
    annotation (Dialog(group="Photovoltaics", enable=PPv));

protected
  IDEAS.Climate.Time.SimTimes timMan(
    timZonSta=timZonSta,
    lon=lon,
    DST=false,
    ifSolCor=true)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
public
  Modelica.Blocks.Tables.CombiTable1Ds tabQCon(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=filDir + FilNam_QCon,
    columns=2:nOcc + 1) if StROBe
    annotation (Placement(transformation(extent={{-40,-34},{-26,-20}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabQRad(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=filDir + FilNam_QRad,
    columns=2:nOcc + 1) if StROBe
    annotation (Placement(transformation(extent={{-36,-38},{-22,-24}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabTSet(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=filDir + FilNam_TSet,
    columns=2:nOcc + 1) if StROBe
    annotation (Placement(transformation(extent={{-40,18},{-26,32}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabP(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=filDir + FilNam_P,
    columns=2:nOcc + 1) if StROBe_P
    annotation (Placement(transformation(extent={{-40,-58},{-26,-44}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabQ(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=filDir +FilNam_Q,
    columns=2:nOcc + 1) if StROBe
    annotation (Placement(transformation(extent={{-36,-62},{-22,-48}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabDHW(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=filDir + FilNam_mDHW,
    columns=2:nOcc + 1) if StROBe
    annotation (Placement(transformation(extent={{-40,40},{-26,54}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabPPv(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=filDir + FilNam_PPv,
    columns=2:nPPv + 1) if PPv
    annotation (Placement(transformation(extent={{-40,-8},{-26,6}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabTSet2(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=filDir + FilNam_TSet2,
    columns=2:nOcc + 1) if StROBe
    annotation (Placement(transformation(extent={{-36,14},{-22,28}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabPHp(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=filDir + FilNam_PHp,
    columns=2:nPHp + 1) if PHp
    annotation (Placement(transformation(extent={{-36,-12},{-22,2}})));
equation
  connect(timMan.timCal, tabQCon.u) annotation (Line(
      points={{-60,6},{-52,6},{-52,-27},{-41.4,-27}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(timMan.timCal, tabQRad.u) annotation (Line(
      points={{-60,6},{-50,6},{-50,-31},{-37.4,-31}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(timMan.timCal, tabP.u) annotation (Line(
      points={{-60,6},{-52,6},{-52,-51},{-41.4,-51}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(timMan.timCal, tabQ.u) annotation (Line(
      points={{-60,6},{-50,6},{-50,-55},{-37.4,-55}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(timMan.timCal, tabTSet.u) annotation (Line(
      points={{-60,6},{-52,6},{-52,25},{-41.4,25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(timMan.timCal, tabTSet2.u) annotation (Line(
      points={{-60,6},{-50,6},{-50,21},{-37.4,21}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(timMan.timCal, tabPHp.u) annotation (Line(
      points={{-60,6},{-50,6},{-50,-5},{-37.4,-5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(timMan.timCal, tabDHW.u) annotation (Line(
      points={{-60,6},{-52,6},{-52,47},{-41.4,47}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(timMan.timCal, tabPPv.u) annotation (Line(
      points={{-60,6},{-52,6},{-52,-1},{-41.4,-1}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    defaultComponentName="strobe",
    defaultComponentPrefixes="inner",
    missingInnerMessage=
        "Your model is using an outer \"strobe\" component. An inner \"strobe\" component is not defined. For simulation drag IDEAS.Occupants.StROBe.StrobeInfoManager into your model.",
    Icon(graphics={
        Line(points={{-80,-30},{88,-30}}, color={0,0,0}),
        Line(points={{-76,-68},{-46,-30}}, color={0,0,0}),
        Line(points={{-42,-68},{-12,-30}}, color={0,0,0}),
        Line(points={{-8,-68},{22,-30}},  color={0,0,0}),
        Line(points={{28,-68},{58,-30}}, color={0,0,0}),
        Rectangle(
          extent={{-60,76},{60,-24}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Solid,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-50,66},{50,-4}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Rectangle(
          extent={{-10,-34},{10,-24}},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{-40,-60},{-40,-60}},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,-34},{40,-34},{50,-44},{-52,-44},{-40,-34}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{44,0},{38,40}},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{34,0},{28,12}},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{24,0},{18,56}},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{14,0},{8,36}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{4,0},{-2,12}},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-6,0},{-46,0}},
          color={0,255,0},
          smooth=Smooth.None),
        Text(
          extent={{-50,66},{-20,26}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Italic},
          fontName="Bookman Old Style",
          textString="s")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics),
    Documentation(info="<html>
</html>"));
end StrobeInfoManager;
