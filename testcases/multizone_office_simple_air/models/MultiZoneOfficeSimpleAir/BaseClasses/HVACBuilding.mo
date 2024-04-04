within MultiZoneOfficeSimpleAir.BaseClasses;
partial model HVACBuilding
  "Partial model that contains the HVAC and building model copied from Buildings.Examples.VAVReheat.BaseClasses.HVACBuilding with modified hot and chilled water plants"

  replaceable package MediumA = Buildings.Media.Air "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";

  final parameter Modelica.SIunits.Volume VRooCor = flo.VRooCor
    "Room volume corridor";
  final parameter Modelica.SIunits.Volume VRooSou = flo.VRooSou
    "Room volume south";
  final parameter Modelica.SIunits.Volume VRooNor = flo.VRooNor
    "Room volume north";
  final parameter Modelica.SIunits.Volume VRooEas = flo.VRooEas
    "Room volume east";
  final parameter Modelica.SIunits.Volume VRooWes = flo.VRooWes
    "Room volume west";

  final parameter Modelica.SIunits.Area AFloCor = flo.AFloCor "Floor area corridor";
  final parameter Modelica.SIunits.Area AFloSou = flo.AFloSou "Floor area south";
  final parameter Modelica.SIunits.Area AFloNor = flo.AFloNor "Floor area north";
  final parameter Modelica.SIunits.Area AFloEas = flo.AFloEas "Floor area east";
  final parameter Modelica.SIunits.Area AFloWes = flo.AFloWes "Floor area west";

  final parameter Modelica.SIunits.Area AFlo[:]={AFloCor,AFloSou,AFloEas,
      AFloNor,AFloWes} "Floor area of each zone";
  final parameter Modelica.SIunits.Area ATot=sum(AFlo) "Total floor area";

  constant Real conv=1.2/3600 "Conversion factor for nominal mass flow rate";

  parameter Modelica.SIunits.MassFlowRate mCor_flow_nominal
    "Design mass flow rate core";
  parameter Modelica.SIunits.MassFlowRate mSou_flow_nominal
    "Design mass flow rate south";
  parameter Modelica.SIunits.MassFlowRate mEas_flow_nominal
    "Design mass flow rate east";
  parameter Modelica.SIunits.MassFlowRate mNor_flow_nominal
    "Design mass flow rate north";
  parameter Modelica.SIunits.MassFlowRate mWes_flow_nominal
    "Design mass flow rate west";

  parameter Modelica.SIunits.Temperature THotWatInl_nominal(
    displayUnit="degC")=45 + 273.15
    "Reheat coil nominal inlet water temperature";

  replaceable
  MultiZoneOfficeSimpleAir.BaseClasses.PartialHVAC hvac
    constrainedby MultiZoneOfficeSimpleAir.BaseClasses.PartialHVAC(
    redeclare final package MediumA = MediumA,
    redeclare final package MediumW = MediumW,
    final VRooCor=VRooCor,
    final VRooSou=VRooSou,
    final VRooNor=VRooNor,
    final VRooEas=VRooEas,
    final VRooWes=VRooWes,
    final AFloCor=AFloCor,
    final AFloSou=AFloSou,
    final AFloNor=AFloNor,
    final AFloEas=AFloEas,
    final AFloWes=AFloWes,
    final mCor_flow_nominal=mCor_flow_nominal,
    final mSou_flow_nominal=mSou_flow_nominal,
    final mEas_flow_nominal=mEas_flow_nominal,
    final mNor_flow_nominal=mNor_flow_nominal,
    final mWes_flow_nominal=mWes_flow_nominal,
    final m_flow_nominal=0.7*(mCor_flow_nominal + mSou_flow_nominal +
        mEas_flow_nominal + mNor_flow_nominal + mWes_flow_nominal),
    final THotWatInl_nominal=THotWatInl_nominal)
    "HVAC system"
    annotation (Placement(transformation(extent={{-46,-28},{42,22}})));
  replaceable
  Buildings.Examples.VAVReheat.BaseClasses.PartialFloor flo
    constrainedby Buildings.Examples.VAVReheat.BaseClasses.PartialFloor(
      redeclare final package Medium = MediumA)
    "Building"
    annotation (Placement(transformation(extent={{20,40},{90,80}})));

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
   filNam=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
      computeWetBulbTemperature=false) "Weather data reader"
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  AirCooledChiller chi "Chiller"
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
  AirToWaterHeatPump heaPum "Heat pump for heating coil and reheat coils"
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  Buildings.Fluid.FixedResistances.Junction jun(redeclare package Medium =
        MediumW, dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{22,-46},{12,-56}})));
  Buildings.Fluid.FixedResistances.Junction jun1(redeclare package Medium =
        MediumW, dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{32,-36},{22,-46}})));
equation
  connect(weaDat.weaBus, hvac.weaBus) annotation (Line(
      points={{-70,10},{-56,10},{-56,11.4444},{-40.225,11.4444}},
      color={255,204,51},
      thickness=0.5));
  connect(flo.TRooAir, hvac.TRoo) annotation (Line(points={{91.5217,61.6667},{
          96,61.6667},{96,92},{-60,92},{-60,16.4444},{-48.75,16.4444}},
                                                            color={0,0,127}));
  connect(hvac.port_supAir[1], flo.portsSou[1]) annotation (Line(points={{42.275,
          19.2222},{45.5652,19.2222},{45.5652,49.3333}}, color={0,127,255}));
  connect(hvac.port_supAir[2], flo.portsEas[1]) annotation (Line(points={{42.275,
          19.2222},{80.2609,19.2222},{80.2609,62.6667}}, color={0,127,255}));
  connect(hvac.port_supAir[3], flo.portsNor[1]) annotation (Line(points={{42.275,
          19.2222},{56,19.2222},{56,74},{45.5652,74}},           color={0,127,255}));
  connect(hvac.port_supAir[4], flo.portsWes[1]) annotation (Line(points={{42.275,
          19.2222},{56,19.2222},{56,36},{26.6957,36},{26.6957,62.6667}}, color={
          0,127,255}));
  connect(hvac.port_supAir[5], flo.portsCor[1]) annotation (Line(points={{42.275,
          19.2222},{56,19.2222},{56,62.6667},{45.5652,62.6667}}, color={0,127,255}));
  connect(hvac.port_retAir[1], flo.portsSou[2]) annotation (Line(points={{42.275,
          -4.38889},{48.6087,-4.38889},{48.6087,49.3333}}, color={0,127,255}));
  connect(hvac.port_retAir[2], flo.portsEas[2]) annotation (Line(points={{42.275,
          -4.38889},{83.3043,-4.38889},{83.3043,62.6667}}, color={0,127,255}));
  connect(hvac.port_retAir[3], flo.portsNor[2]) annotation (Line(points={{42.275,
          -4.38889},{58,-4.38889},{58,74},{48.6087,74}},           color={0,127,
          255}));
  connect(hvac.port_retAir[4], flo.portsWes[2]) annotation (Line(points={{42.275,
          -4.38889},{60,-4.38889},{60,34},{29.7391,34},{29.7391,62.6667}},
        color={0,127,255}));
  connect(hvac.port_retAir[5], flo.portsCor[2]) annotation (Line(points={{42.275,
          -4.38889},{60,-4.38889},{60,58},{48.6087,58},{48.6087,62.6667}},
        color={0,127,255}));
  connect(weaDat.weaBus, flo.weaBus) annotation (Line(
      points={{-70,10},{-66,10},{-66,90},{64.1304,90}},
      color={255,204,51},
      thickness=0.5));
  connect(chi.sup, hvac.portCooCoiSup) annotation (Line(points={{-10,-90},{-20,
          -90},{-20,-60},{-2,-60},{-2,-28}}, color={0,127,255}));
  connect(chi.ret, hvac.portCooCoiRet) annotation (Line(points={{10,-90},{20,
          -90},{20,-60},{6.25,-60},{6.25,-28}}, color={0,127,255}));
  connect(weaDat.weaBus, chi.weaBus) annotation (Line(
      points={{-70,10},{-66,10},{-66,-68},{-10,-68},{-10,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(heaPum.weaBus, chi.weaBus) annotation (Line(
      points={{40,-80},{40,-68},{-10,-68},{-10,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(jun.port_1, heaPum.sup) annotation (Line(points={{22,-51},{26,-51},{
          26,-50},{30,-50},{30,-90},{40,-90}}, color={0,127,255}));
  connect(jun.port_3, hvac.portHeaTerSup) annotation (Line(points={{17,-46},{
          17.25,-46},{17.25,-28}}, color={0,127,255}));
  connect(jun.port_2, hvac.portHeaCoiSup) annotation (Line(points={{12,-51},{-2,
          -51},{-2,-50},{-21.25,-50},{-21.25,-28}}, color={0,127,255}));
  connect(hvac.portHeaTerRet, jun1.port_3) annotation (Line(points={{25.5,-28},
          {25.5,-32},{27,-32},{27,-36}}, color={0,127,255}));
  connect(jun1.port_1, heaPum.ret) annotation (Line(points={{32,-41},{42,-41},{
          42,-40},{72,-40},{72,-90},{60,-90}}, color={0,127,255}));
  connect(jun1.port_2, hvac.portHeaCoiRet) annotation (Line(points={{22,-41},{6,
          -41},{6,-40},{-13,-40},{-13,-28}}, color={0,127,255}));
  annotation (
    Documentation(info="<html>
<p>
Partial model that contains an HVAC system connected to a building
with five conditioned thermal zones.
</p>
</html>", revisions="<html>
<ul>
<li>
October 4, 2021, by Michael Wetter:<br/>
Refactored <a href=\"modelica://Buildings.Examples.VAVReheat\">Buildings.Examples.VAVReheat</a>
and its base classes to separate building from HVAC model.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2652\">issue #2652</a>.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end HVACBuilding;
