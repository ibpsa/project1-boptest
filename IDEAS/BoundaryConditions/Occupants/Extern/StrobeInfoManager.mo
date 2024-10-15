within IDEAS.BoundaryConditions.Occupants.Extern;
model StrobeInfoManager
  "StROBe information manager for handling occupant data required in each for simulation."

  parameter String filDir = Modelica.Utilities.Files.loadResource("modelica://IDEAS") + "/Inputs/"
    "Directory containing the data files, default under IDEAS/Inputs/";

  parameter Integer nOcc=33 "Number of occupant profiles to be read";

  parameter Boolean StROBe_P = true "Boolean to read plug load profiles" annotation (Dialog(group="StROBe power load"));

  parameter String FilNam_P = "none.txt"
    "File with (active) plug load profiles from StROBe (in W)"
  annotation (Dialog(group="StROBe power load", enable=StROBe_P));

  parameter Boolean StROBe = true "Boolean to read the other profiles too" annotation (Dialog(group="StROBe"));

  parameter String FilNam_Q = "none.txt"
    "File with (reactive) plug load profiles (in W)"  annotation (Dialog(group="StROBe", enable=StROBe));
  parameter String FilNam_mDHW = "none.txt"
    "File with hot watter tapping profiles (in l/min)"  annotation (Dialog(group="StROBe", enable=StROBe));
  parameter String FilNam_QCon = "none.txt"
    "File with (convective) internal heat gain profiles (in W)" annotation (Dialog(group="StROBe", enable=StROBe));
  parameter String FilNam_QRad = "none.txt"
    "File with (radiative) internal heat gain profiles (in W)" annotation (Dialog(group="StROBe", enable=StROBe));
  parameter String FilNam_TSet = "none.txt"
    "File with (main) space heating setpoint profiles (in K)" annotation (Dialog(group="StROBe", enable=StROBe));
  parameter String FilNam_TSet2 = "none.txt"
    "File with (secondary) space heating setpoint profiles (in K)" annotation (Dialog(group="StROBe", enable=StROBe));
  parameter Modelica.SIunits.Time startTime=0
    "Output = offset for time < startTime";

  parameter Boolean PHp = false "Boolean to read heat pump load profiles" annotation (Dialog(group="Heat pumps"));
  parameter String FilNam_PHp = "none.txt"
    "File with (active) electric load heat pump profiles (in W)" annotation (Dialog(group="Heat pumps", enable=PHp));

  parameter Boolean PPv = false "Boolean to read photovoltaic load profiles" annotation (Dialog(group="Photovoltaics"));
  parameter String FilNam_PPv = "none.txt"
    "File with (active) photovoltaic load profiles (in W)"
    annotation (Dialog(group="Photovoltaics", enable=PPv));
  parameter Integer nPv = 33 "Number of photovoltaic profiles"
    annotation (Dialog(group="Photovoltaics", enable=PPv));
  parameter Modelica.SIunits.Power P_nominal=1000
    "Nominal power of the photovoltaic profiles"
    annotation (Dialog(group="Photovoltaics", enable=PPv));

public
  Modelica.Blocks.Sources.CombiTimeTable tabQCon(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=IDEAS.BoundaryConditions.WeatherData.BaseClasses.getAbsolutePath(
        filDir + FilNam_QCon),
    columns=2:nOcc + 1,
    startTime=startTime,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) if
                           StROBe
    annotation (Placement(transformation(extent={{-40,-34},{-26,-20}})));
  Modelica.Blocks.Sources.CombiTimeTable tabQRad(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=IDEAS.BoundaryConditions.WeatherData.BaseClasses.getAbsolutePath(
        filDir + FilNam_QRad),
    columns=2:nOcc + 1,
    startTime=startTime,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) if
                           StROBe
    annotation (Placement(transformation(extent={{-36,-38},{-22,-24}})));
  Modelica.Blocks.Sources.CombiTimeTable tabTSet(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=IDEAS.BoundaryConditions.WeatherData.BaseClasses.getAbsolutePath(
        filDir + FilNam_TSet),
    columns=2:nOcc + 1,
    startTime=startTime,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) if
                           StROBe
    annotation (Placement(transformation(extent={{-40,18},{-26,32}})));
  Modelica.Blocks.Sources.CombiTimeTable tabP(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=IDEAS.BoundaryConditions.WeatherData.BaseClasses.getAbsolutePath(
        filDir + FilNam_P),
    columns=2:nOcc + 1,
    startTime=startTime,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) if
                           StROBe_P
    annotation (Placement(transformation(extent={{-40,-58},{-26,-44}})));
  Modelica.Blocks.Sources.CombiTimeTable tabQ(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=IDEAS.BoundaryConditions.WeatherData.BaseClasses.getAbsolutePath(
        filDir + FilNam_Q),
    columns=2:nOcc + 1,
    startTime=startTime,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) if
                           StROBe
    annotation (Placement(transformation(extent={{-36,-62},{-22,-48}})));
  Modelica.Blocks.Sources.CombiTimeTable tabDHW(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=IDEAS.BoundaryConditions.WeatherData.BaseClasses.getAbsolutePath(
        filDir + FilNam_mDHW),
    columns=2:nOcc + 1,
    startTime=startTime,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) if
                           StROBe
    annotation (Placement(transformation(extent={{-40,40},{-26,54}})));
  Modelica.Blocks.Sources.CombiTimeTable tabPPv(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=IDEAS.BoundaryConditions.WeatherData.BaseClasses.getAbsolutePath(
        filDir + FilNam_PPv),
    columns=2:nPv + 1,
    startTime=startTime,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) if
                          PPv
    annotation (Placement(transformation(extent={{-40,-8},{-26,6}})));
  Modelica.Blocks.Sources.CombiTimeTable tabTSet2(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=IDEAS.BoundaryConditions.WeatherData.BaseClasses.getAbsolutePath(
        filDir + FilNam_TSet2),
    columns=2:nOcc + 1,
    startTime=startTime,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) if
                           StROBe
    annotation (Placement(transformation(extent={{-36,14},{-22,28}})));
  Modelica.Blocks.Sources.CombiTimeTable tabPHp(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=true,
    tableName="data",
    fileName=IDEAS.BoundaryConditions.WeatherData.BaseClasses.getAbsolutePath(
        filDir + FilNam_PHp),
    columns=2:nOcc + 1,
    startTime=startTime,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) if
                           PHp
    annotation (Placement(transformation(extent={{-36,-12},{-22,2}})));

  // Conditional connectors
  Modelica.Blocks.Interfaces.RealOutput[nOcc] tabQCon_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealOutput[nOcc] tabQRad_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealOutput[nOcc] tabTSet_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealOutput[nOcc] tabP_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealOutput[nOcc] tabQ_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealOutput[nOcc] tabDHW_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealOutput[nPv] tabPPv_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealOutput[nOcc] tabTSet2_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealOutput[nOcc] tabPHp_internal
    "Needed to connect to conditional connector";

equation
  // Conditional connectors
  connect(tabQCon.y, tabQCon_internal);
  if not StROBe then
    tabQCon_internal = zeros(nOcc);
  end if;

  connect(tabQRad.y, tabQRad_internal);
  if not StROBe then
    tabQRad_internal = zeros(nOcc);
  end if;

  connect(tabTSet.y, tabTSet_internal);
  if not StROBe then
    tabTSet_internal = zeros(nOcc);
  end if;

  connect(tabP.y, tabP_internal);
  if not StROBe_P then
    tabP_internal = zeros(nOcc);
  end if;

  connect(tabQ.y, tabQ_internal);
  if not StROBe then
    tabQ_internal = zeros(nOcc);
  end if;

  connect(tabDHW.y, tabDHW_internal);
  if not StROBe then
    tabDHW_internal = zeros(nOcc);
  end if;

  connect(tabPPv.y, tabPPv_internal);
  if not PPv then
    tabPPv_internal = zeros(nPv);
  end if;

  connect(tabTSet2.y, tabTSet2_internal);
  if not StROBe then
    tabTSet2_internal = zeros(nOcc);
  end if;

  connect(tabPHp.y, tabPHp_internal);
  if not PHp then
    tabPHp_internal = zeros(nOcc);
  end if;

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
</html>", revisions="<html>
<ul>
<li>
April 1, 2020 by Jelger Jansen:<br/>
Added conditional connectors to be in line with the Modelica specification. 
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1125\">#1125</a>.
</li>
<li>
December 20, 2017 by Bram van der Heijde: <br/>
Propagate start time of <code>CombiTimeTable</code>s in <code>StrobeInfoManager</code> 
and make data reader repeat input data to avoid errors.
</li>
</ul>
</html>"));
end StrobeInfoManager;
