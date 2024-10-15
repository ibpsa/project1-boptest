within IDEAS.BoundaryConditions.Interfaces;
partial model PartialSimInfoManager
  "Partial providing structure for SimInfoManager"

  parameter String filNam=
    Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/Brussels.mos")
    "File name of TMY3 weather file" annotation(Dialog(loadSelector(filter="TMY-files (*.TMY);;Text files (*.txt);;All files (*.*)", caption="Select the weather file")));
  parameter Modelica.SIunits.Angle lat(displayUnit="deg") = weaDat.lat
    "Latitude of the location"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Angle lon(displayUnit="deg") = weaDat.lon
    "Longitude of the location"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Time timZon(displayUnit="h") = weaDat.timZon
    "Time zone for which the simulation time t=0 corresponds to midnight, january 1st";


  parameter Modelica.SIunits.Angle incS = IDEAS.Types.Azimuth.S
    "South inclination"
    annotation(Dialog(tab="Incidence angles"));
  parameter Modelica.SIunits.Angle incW = incS +Modelica.Constants.pi/2
    "West inclination"
      annotation(Dialog(tab="Incidence angles"));
  parameter Modelica.SIunits.Angle incN = incS +Modelica.Constants.pi
    "North inclination"
      annotation(Dialog(tab="Incidence angles"));
  parameter Modelica.SIunits.Angle incE = incS +3*Modelica.Constants.pi/2
    "East inclination"
      annotation(Dialog(tab="Incidence angles"));

  parameter Modelica.SIunits.Angle incAndAziInBus[:,:] = {{IDEAS.Types.Tilt.Ceiling,0},{IDEAS.Types.Tilt.Wall,incS},
                         {IDEAS.Types.Tilt.Wall,incW},{IDEAS.Types.Tilt.Wall,incN},{IDEAS.Types.Tilt.Wall,incE}, {IDEAS.Types.Tilt.Floor,0}}
                        "Combination of inclination and azimuth which are pre-computed and added to solBus." annotation(Dialog(tab="Incidence angles"));
  final parameter Modelica.SIunits.Angle aziOpts[5]={incS, incW, incN, incE, incS}
    "Inclination options, default south";
  final parameter Modelica.SIunits.Angle incOpts[4]={IDEAS.Types.Tilt.Wall, IDEAS.Types.Tilt.Floor, IDEAS.Types.Tilt.Ceiling, IDEAS.Types.Tilt.Wall}
    "Azimuth options, default wall";

  parameter Boolean computeConservationOfEnergy=false
    "Add equations for verifying conservation of energy"
    annotation (Evaluate=true, Dialog(tab="Conservation of energy"));
  parameter Boolean strictConservationOfEnergy=false
    "This adds an assert statement to make sure that energy is conserved"
    annotation (Evaluate=true, Dialog(tab="Conservation of energy", enable=
          computeConservationOfEnergy));
  parameter Boolean openSystemConservationOfEnergy=false
    "Compute conservation of energy for open system" annotation (Evaluate=true,
      Dialog(tab="Conservation of energy", enable=computeConservationOfEnergy));

  parameter Boolean lineariseDymola=false "Linearises building model equations for Dymola linearisation approach"
    annotation (Dialog(tab="Linearisation"));
  parameter Boolean lineariseJModelica=false "Linearises building model equations for optimisations in JModelica"
    annotation (Dialog(tab="Linearisation"));
  parameter Boolean createOutputs = false
    "Creates output connections when linearising windows"
    annotation(Dialog(tab="Linearisation"));
  parameter Boolean outputAngles=not lineariseDymola
    "Output angles in weaBus. Set to false when linearising" annotation(Dialog(tab="Linearisation"));
  parameter Boolean linIntCon=false
    "= true, if interior convective heat transfer should be linearised"
    annotation (Dialog(tab="Linearisation", group="Convection"));
  parameter Boolean linExtCon=false
    "= true, if exterior convective heat transfer should be linearised (uses average wind speed)"
    annotation (Dialog(tab="Linearisation", group="Convection"));
  parameter Boolean linIntRad=true
    "= true, if interior radiative heat transfer should be linearised"
    annotation (Dialog(tab="Linearisation", group="Radiation"));
  parameter Boolean linExtRad=false
    "= true, if exterior radiative heat transfer for walls should be linearised"
    annotation (Dialog(tab="Linearisation", group="Radiation"));
  // separate parameter linExtRadWin since window dynamics are steady state by default
  parameter Boolean linExtRadWin=true
    "= true, if exterior radiative heat transfer for windows should be linearised"
    annotation (Dialog(tab="Linearisation", group="Radiation"));
  parameter Modelica.SIunits.Energy Emax=1
    "Error bound for violation of conservation of energy" annotation (Evaluate=true,
      Dialog(tab="Conservation of energy", enable=strictConservationOfEnergy));
  parameter Modelica.SIunits.Temperature Tenv_nom=280
    "Nominal ambient temperature, only used when linearising equations";

  parameter Integer nWindow = 1
    "Number of windows in the to be linearised model"
    annotation(Dialog(tab="Linearisation"));
  parameter Integer nLayWin= 3
    "Number of window layers in the to be linearised model; should be maximum of all windows"
    annotation(Dialog(tab="Linearisation"));
  parameter Real ppmCO2 = 400
    "Default CO2 concentration in [ppm] when using air medium containing CO2"
    annotation(Dialog(tab="Advanced", group="CO2"));

  parameter IDEAS.BoundaryConditions.Types.InterZonalAirFlow interZonalAirFlowType=
    IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None
    "Type of interzonal air flow model"
    annotation(Dialog(group="Interzonal airflow"),Evaluate=true);

  parameter Boolean unify_n50 = false
    "if true, zone n50 values are merged and then redistributed across al zones even if interZonalAirFlowType==None"
    annotation(choices(checkBox=true),Dialog(enable=interZonalAirFlowType==
    IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,group="Interzonal airflow"));

  parameter Real n50 = 3
    "n50 value of zones"
    annotation(Dialog(enable=interZonalAirFlowType<>
    IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None or unify_n50,group="Interzonal airflow"));

  parameter Modelica.SIunits.Length H=10 "Building or roof height"
                                                                  annotation(Dialog(group="Wind"));
  parameter Real A0=0.6 "Local terrain constant. 0.6 for Suburban,0.35 for Urban and 1 for Unshielded (Ashrae 1993) " annotation(Dialog(group="Wind"));
  parameter Real a=0.28 "Velocity profile exponent. 0.28 for Suburban, 0.4 for Urban and 0.15 for Unshielded (Ashrae 1993) "
                                                                                                                            annotation(Dialog(group="Wind"));
  parameter Modelica.SIunits.Length Hwin=10 "Height above ground of meteorological wind speed measurement"
                                                                                                          annotation(Dialog(group="Wind"));

  parameter Real Cs= (A0*A0)*((H/Hwin)^(2*a)) "Wind speed modifier"
                                                                   annotation(Dialog(group="Wind"));


  final parameter Integer numIncAndAziInBus = size(incAndAziInBus,1)
    "Number of pre-computed azimuth";
  final parameter Modelica.SIunits.Temperature Tdes=-8 + 273.15
    "design outdoor temperature";
  final parameter Modelica.SIunits.Temperature TdesGround=10 + 273.15
    "design ground temperature";
  final parameter Boolean linearise=lineariseDymola or lineariseJModelica
    "Linearises building model equations"
    annotation (Dialog(tab="Linearisation"));

  input Modelica.SIunits.Temperature Te
    "ambient outdoor temperature for determination of sky radiation exchange";
  input Modelica.SIunits.Temperature Tsky "effective overall sky temperature";
  input Modelica.SIunits.Temperature TeAv
    "running average of ambient outdoor temperature of the last 5 days, not yet implemented";
  input Modelica.SIunits.Temperature Tground "ground temperature";
  input Modelica.SIunits.Velocity Va "wind speed";
  input Modelica.SIunits.Angle Vdir "wind direction";

  input Real relHum(final unit="1") "Relative humidity";
  input Modelica.SIunits.Temperature TDewPoi "Dewpoint";


  Modelica.SIunits.Energy Etot "Total internal energy";
  Modelica.SIunits.Energy Qint "Total energy from boundary";

  IDEAS.Utilities.Psychrometrics.X_pTphi XiEnv(use_p_in=false)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));

  // Icon of weaBus is made very small as it is not intended that a user would use it.
  // weaBus is still directly connected in the zone model and the connector should
  // therefore not be protected.
  // Connector weaDatBus is made available for the user and it should be used instead
  // of weaBus.
  IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(numSolBus=numIncAndAziInBus,
      final outputAngles=outputAngles)
    annotation (Placement(transformation(extent={{90,30},{110,50}}),
        iconTransformation(extent={{90,30},{90,30}})));
  IDEAS.BoundaryConditions.SolarIrradiation.ShadedRadSol[numIncAndAziInBus] radSol(
    inc=incAndAziInBus[:, 1],
    azi=incAndAziInBus[:, 2],
    each lat=lat,
    each outputAngles=outputAngles)
    "Model for computing solar irradiation and properties of predefined set of tilted surfaces"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));

  Modelica.Blocks.Sources.RealExpression TskyPow4Expr(y=Tsky^4)
    "Power 4 of sky temperature"
    annotation (Placement(transformation(extent={{-20,94},{0,114}})));
  Modelica.Blocks.Sources.RealExpression TePow4Expr(y=Te^4)
    "Power 4 of ambient temperature"
    annotation (Placement(transformation(extent={{-20,106},{0,126}})));
  Modelica.Blocks.Sources.RealExpression TdesExpr(y=Tdes)
    "Expression for design temperature"
    annotation (Placement(transformation(extent={{60,0},{80,20}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=10e6)
    "Fixed temperature";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Qgai
    "Thermal gains in model"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  IDEAS.Buildings.Components.BaseClasses.ConservationOfEnergy.EnergyPort E
    "Model internal energy"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  Modelica.Blocks.Sources.RealExpression CEnv(y=ppmCO2*MMFraction/1e6)
    "Concentration of trace substance in surroundings"
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));

  final parameter Real V50_def(unit="m3/h")= V50-V50_custom "Corrected V50 value, default for surfaces without custom assignment.";
  final parameter Real V50(unit="m3/h")=V_tot*n50 "V50 value assuming no custom v50 values.";
  final parameter Real q50_def( unit="m3/(h.m2)") = if A_def< Modelica.Constants.small then q50_av else V50_def/A_def;
  final parameter Real q50_av(  unit="m3/(h.m2)") = if A_tot < Modelica.Constants.small then 0 else V50/A_tot "average, not corrected q50";

  final parameter Modelica.SIunits.Volume V_tot(fixed=false) "Total conditioned building volume";
  final parameter Modelica.SIunits.Area A_tot(fixed=false) "Total surface area of OuterWalls and Windows";
  final parameter Real V50_custom( unit="m3/h",fixed=false) "Sum of v50 values for components that have a custom assignment";
  final parameter Modelica.SIunits.Area A_def( fixed=false) "Total area with default q50, i.e. without custom q50 assignment, or connected to zone with custom n50 assigned";

  input IDEAS.Buildings.Components.Interfaces.WindowBus[nWindow] winBusOut(
      each nLay=nLayWin) if createOutputs
    "Bus for windows in case of linearisation";
  Modelica.Blocks.Routing.RealPassThrough solTim
    "Solar time"
    annotation (Placement(transformation(extent={{-86,-2},{-78,6}})));
  IDEAS.BoundaryConditions.WeatherData.Bus weaDatBus
    "Weather data bus connectable to weaBus connector from Buildings Library"
    annotation (Placement(transformation(extent={{-110,-20},{-90,0}}),
        iconTransformation(
        extent={{-20,-19},{20,19}},
        rotation=270,
        origin={99,3.55271e-015})));

  Buildings.Components.Interfaces.VolumePort volumePort
    "Port for summing volumes of all zones"
    annotation (Placement(transformation(extent={{32,-110},{52,-90}})));
  Buildings.Components.Interfaces.AreaPort areaPort
    "Port for summing surface areas of all surfaces"
    annotation (Placement(transformation(extent={{70,-110},{90,-90}})));

protected
  final parameter Integer yr=2014 "depcited year for DST only";

  final constant Real MMFraction=1.528635
    "Molar mass of CO2 divided by the molar mass of moist air";
  IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam=filNam)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.RelativeAirMass
    relativeAirMass "Computation of relative air mass"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.SkyBrightness
    skyBrightness "Computation of sky brightness"
    annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
  IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.SkyClearness skyClearness
    "Computation of sky clearness"
    annotation (Placement(transformation(extent={{-60,100},{-40,120}})));

  IDEAS.BoundaryConditions.SolarIrradiation.BaseClasses.BrighteningCoefficient
    skyBrightnessCoefficients
    "Computation of sky brightness coefficients F1 and F2"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Modelica.Blocks.Sources.RealExpression TGround(y=TdesGround)
    annotation (Placement(transformation(extent={{60,-44},{80,-24}})));
  Modelica.Blocks.Sources.RealExpression u_dummy(y=1)
    annotation (Placement(transformation(extent={{60,-58},{80,-38}})));
  Modelica.Blocks.Routing.RealPassThrough solHouAng "Solar hour angle"
    annotation (Placement(transformation(extent={{-86,66},{-78,74}})));
  Modelica.Blocks.Routing.RealPassThrough solDec "Solar declination angle"
    annotation (Placement(transformation(extent={{-86,52},{-78,60}})));
  Modelica.Blocks.Routing.RealPassThrough HDirNor "Beam solar irradiation"
    annotation (Placement(transformation(extent={{-86,40},{-78,48}})));
  Modelica.Blocks.Routing.RealPassThrough phiEnv "Relative humidity"
    annotation (Placement(transformation(extent={{-86,12},{-78,20}})));
  Modelica.Blocks.Routing.RealPassThrough TDryBul "Dry bulb air temperature"
    annotation (Placement(transformation(extent={{-86,26},{-78,34}})));
  Modelica.Blocks.Routing.RealPassThrough angZen "Solar zenith angle"
    annotation (Placement(transformation(extent={{-86,80},{-78,88}})));
  Modelica.Blocks.Routing.RealPassThrough HGloHor
    "Global/total solar irradiation on a horizontal plane"
    annotation (Placement(transformation(extent={{-86,108},{-78,116}})));
  Modelica.Blocks.Routing.RealPassThrough HDifHor
    "Diffuse solar irradiation on a horizontal plane"
    annotation (Placement(transformation(extent={{-86,94},{-78,102}})));

  Modelica.Blocks.Routing.RealPassThrough winSpe "Wind speed"
    annotation (Placement(transformation(extent={{-86,122},{-78,130}})));
  Modelica.Blocks.Routing.RealPassThrough winDir "Wind direction"
    annotation (Placement(transformation(extent={{-86,136},{-78,144}})));
initial equation
  V_tot=volumePort.V_tot;
  A_tot=max(Modelica.Constants.small,areaPort.A_tot); //max(.,.) to avoid division by 0 error when no surfaces with possible air leakage
  V50_custom=areaPort.V50_cust;
  A_def=max(0.001,areaPort.A_def_tot);  //max(.,.) to avoid division by 0 error when all surfaces are custom

  //assert(A_def<0.0011, "All surfaces have lower level custome flows, q50_def will not be used in simulation",level = AssertionLevel.warning);
  //assert(A_def>0.001 and V50_def<0,  "The total customly assigned volume flow rate at 50pa exceeds the flow at the given building n50 value, q50_cor will be negative",level = AssertionLevel.error);


  if not linearise and computeConservationOfEnergy then
    Etot = 0;
  end if;
  assert(not computeConservationOfEnergy or interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    "Conservation of energy check only not supported interzonalAirFlowType==None.");
equation
  volumePort.V_tot + volumePort.V = 0;
  areaPort.A_tot + areaPort.A = 0;
  areaPort.V50_cust+areaPort.v50=0;
  areaPort.A_def_tot+areaPort.A_def=0;


  if strictConservationOfEnergy and computeConservationOfEnergy then
    assert(abs(Etot) < Emax, "Conservation of energy violation > Emax J!");
  end if;

  if not linearise and computeConservationOfEnergy then
    der(Qint) = Qgai.Q_flow;
  else
    Qint = 0;
  end if;
  Etot = Qint - E.E;
  E.Etot = Etot;

  connect(skyClearness.skyCle, skyBrightnessCoefficients.skyCle) annotation (
      Line(
      points={{-39,110},{-36,110},{-36,96},{-2,96}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(skyBrightness.skyBri, skyBrightnessCoefficients.skyBri) annotation (
      Line(
      points={{-9,70},{-8,70},{-8,90},{-2,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(relativeAirMass.relAirMas, skyBrightness.relAirMas) annotation (Line(
      points={{-39,70},{-38,70},{-38,74},{-32,74}},
      color={0,0,127},
      smooth=Smooth.None));

  for i in 1:numIncAndAziInBus loop
    connect(solTim.y, radSol[i].solTim) annotation (Line(points={{-77.6,2},{18,2},
            {18,74},{38,74},{38,73},{39.6,73}},   color={0,0,127}));
    connect(solHouAng.y, radSol[i].angHou) annotation (Line(points={{-77.6,70},{
            -74,70},{-74,48},{30,48},{30,68},{39.6,68}}, color={0,0,127}));
    connect(angZen.y, radSol[i].angZen) annotation (Line(points={{-77.6,84},{-68,
            84},{-68,54},{32,54},{32,66},{39.6,66}}, color={0,0,127}));
    connect(solDec.y, radSol[i].angDec) annotation (Line(points={{-77.6,56},{-76,
            56},{-76,46},{28,46},{28,70},{39.6,70}}, color={0,0,127}));
    connect(radSol[i].solDirPer,HDirNor. y) annotation (Line(points={{39.6,80},{
            22,80},{22,44},{-77.6,44}}, color={0,0,127}));
    connect(radSol[i].solDifHor,HDifHor. y) annotation (Line(points={{39.6,76},{
            26,76},{26,52},{-70,52},{-70,98},{-77.6,98}}, color={0,0,127}));
    connect(HGloHor.y, radSol[i].solGloHor) annotation (Line(points={{-77.6,112},
            {-72,112},{-72,50},{24,50},{24,78},{39.6,78}}, color={0,0,127}));
    connect(radSol[i].F2, skyBrightnessCoefficients.F2) annotation (Line(points={{39.6,60},
            {28,60},{28,86},{21,86}},         color={0,0,127}));
    connect(radSol[i].F1, skyBrightnessCoefficients.F1) annotation (Line(points={{39.6,62},
            {26,62},{26,94},{21,94}},         color={0,0,127}));
    connect(TskyPow4Expr.y, radSol[i].TskyPow4) annotation (Line(points={{1,104},
            {52,104},{52,82}},   color={0,0,127}));
    connect(TePow4Expr.y, radSol[i].TePow4) annotation (Line(points={{1,116},{
            56,116},{56,81.8}},            color={0,0,127}));
    connect(winSpe.y, radSol[i].winSpe) annotation (Line(points={{-77.6,126},{
            44,126},{44,82}}, color={0,0,127}));
    connect(winDir.y, radSol[i].winDir) annotation (Line(points={{-77.6,140},{
            48,140},{48,82}}, color={0,0,127}));
  end for;
  if not lineariseDymola then
    connect(solTim.y, weaBus.solTim) annotation (Line(points={{-77.6,2},{18,2},{
          18,36},{100.05,36},{100.05,40.05}}, color={0,0,127}));
    connect(angZen.y, weaBus.angZen) annotation (Line(
      points={{-77.6,84},{-68,84},{-68,54},{100.05,54},{100.05,40.05}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(solHouAng.y, weaBus.angHou) annotation (Line(
        points={{-77.6,70},{-74,70},{-74,48},{100.05,48},{100.05,40.05}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(solDec.y, weaBus.angDec) annotation (Line(
        points={{-77.6,56},{-76,56},{-76,46},{100.05,46},{100.05,40.05}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(HGloHor.y, weaBus.solGloHor) annotation (Line(
        points={{-77.6,112},{-72,112},{-72,50},{100.05,50},{100.05,40.05}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(HDifHor.y, weaBus.solDifHor) annotation (Line(
        points={{-77.6,98},{-70,98},{-70,40.05},{100.05,40.05}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(HDirNor.y, weaBus.solDirPer) annotation (Line(
        points={{-77.6,44},{100.05,44},{100.05,40.05}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(phiEnv.y, weaBus.phi) annotation (Line(points={{-77.6,16},{-70,16},{
          -70,42},{100.05,42},{100.05,40.05}},
                                             color={0,0,127}));
    connect(TDryBul.y, weaBus.Te) annotation (Line(points={{-77.6,30},{100.05,30},
          {100.05,40.05}}, color={0,0,127}));
    connect(CEnv.y, weaBus.CEnv) annotation (Line(points={{81,-20},{100.05,-20},
            {100.05,40.05}},
                         color={0,0,127}));
    connect(XiEnv.X[1], weaBus.X_wEnv) annotation (Line(points={{1,30},{100.05,30},
            {100.05,40.05}},                             color={0,0,127}));
    connect(TdesExpr.y, weaBus.Tdes) annotation (Line(
      points={{81,10},{100.05,10},{100.05,40.05}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(u_dummy.y, weaBus.dummy) annotation (Line(points={{81,-48},{100.05,-48},
            {100.05,40.05}},          color={0,0,127}));
    connect(TGround.y, weaBus.TGroundDes) annotation (Line(points={{81,-34},{100.05,
            -34},{100.05,40.05}},    color={0,0,127}));
    connect(skyBrightnessCoefficients.F1, weaBus.F1) annotation (Line(
      points={{21,94},{26,94},{26,38},{100.05,38},{100.05,40.05}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(skyBrightnessCoefficients.F2, weaBus.F2) annotation (Line(
      points={{21,86},{28,86},{28,34},{100.05,34},{100.05,40.05}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(TskyPow4Expr.y, weaBus.TskyPow4) annotation (Line(
      points={{1,104},{100.05,104},{100.05,40.05}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(TePow4Expr.y, weaBus.TePow4) annotation (Line(
      points={{1,116},{100.05,116},{100.05,40.05}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(winSpe.y, weaBus.Va) annotation (Line(points={{-77.6,126},{10,126},{
          10,40.05},{100.05,40.05}}, color={0,0,127}));
    connect(winDir.y, weaBus.Vdir) annotation (Line(points={{-77.6,140},{10,140},
          {10,40.05},{100.05,40.05}}, color={0,0,127}));
    for i in 1:numIncAndAziInBus loop
      connect(radSol[i].solBus, weaBus.solBus[i]) annotation (Line(
      points={{60,70},{100.05,70},{100.05,40.05}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
    end for;
   end if;
  connect(fixedTemperature.port, Qgai)
    annotation (Line(points={{0,-92},{0,-100}},          color={191,0,0}));
  connect(XiEnv.X[1], weaDatBus.X_wEnv) annotation (Line(points={{1,30},{-100,
            30},{-100,-10}},                             color={0,0,127}));
  connect(TDryBul.y, XiEnv.T) annotation (Line(
      points={{-77.6,30},{-22,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phiEnv.y, XiEnv.phi) annotation (Line(
      points={{-77.6,16},{-22,16},{-22,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(skyBrightnessCoefficients.zen, angZen.y)
    annotation (Line(points={{-2,84},{-77.6,84}}, color={0,0,127}));
  connect(skyBrightness.HDifHor,HDifHor. y) annotation (Line(points={{-32,66},{-70,
          66},{-70,98},{-77.6,98}}, color={0,0,127}));
  connect(relativeAirMass.zen, angZen.y) annotation (Line(points={{-62,70},{-68,
          70},{-68,84},{-77.6,84}}, color={0,0,127}));
  connect(skyClearness.zen, angZen.y) annotation (Line(points={{-62,104},{-68,104},
          {-68,84},{-77.6,84}}, color={0,0,127}));
  connect(skyClearness.HDifHor,HDifHor. y) annotation (Line(points={{-62,110},{-70,
          110},{-70,98},{-77.6,98}},color={0,0,127}));
  connect(skyClearness.HGloHor,HGloHor. y) annotation (Line(points={{-62,116},{-72,
          116},{-72,112},{-77.6,112}},color={0,0,127}));
  connect(solTim.u, weaDatBus.solTim)
    annotation (Line(points={{-86.8,2},{-100,2},{-100,-10}},color={0,0,127}));
  connect(angZen.u, weaDatBus.solZen) annotation (Line(points={{-86.8,84},{-100,
          84},{-100,-10}},color={0,0,127}));
  connect(HDifHor.u, weaDatBus.HDifHor) annotation (Line(points={{-86.8,98},{
          -100,98},{-100,-10}},
                          color={0,0,127}));
  connect(HGloHor.u, weaDatBus.HGloHor) annotation (Line(points={{-86.8,112},{
          -100,112},{-100,-10}},
                           color={0,0,127}));
  connect(HDirNor.u, weaDatBus.HDirNor) annotation (Line(points={{-86.8,44},{
          -100,44},{-100,-10}},
                          color={0,0,127}));
  connect(solDec.u, weaDatBus.solDec) annotation (Line(points={{-86.8,56},{-100,
          56},{-100,-10}},color={0,0,127}));
  connect(solHouAng.u, weaDatBus.solHouAng) annotation (Line(points={{-86.8,70},
          {-100,70},{-100,-10}},color={0,0,127}));
  connect(TDryBul.u, weaDatBus.TDryBul) annotation (Line(points={{-86.8,30},{
          -100,30},{-100,-10}},
                          color={0,0,127}));
  connect(phiEnv.u, weaDatBus.relHum) annotation (Line(points={{-86.8,16},{-100,
          16},{-100,-10}},color={0,0,127}));
  connect(weaDat.weaBus, weaDatBus) annotation (Line(
      points={{-80,-50},{-80,-40},{-80,-10},{-100,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(CEnv.y, weaDatBus.CEnv) annotation (Line(points={{81,-20},{82,-20},{
          82,-10},{40,-10},{40,-10},{-100,-10}}, color={0,0,127}));

  connect(winDir.u, weaDatBus.winDir) annotation (Line(points={{-86.8,140},{
          -100,140},{-100,-10}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(winSpe.u, weaDatBus.winSpe) annotation (Line(points={{-86.8,126},{
          -100,126},{-100,-10}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
    annotation (
    defaultComponentName="sim",
    defaultComponentPrefixes="inner",
    missingInnerMessage=
        "Your model is using an outer \"sim\" component. An inner \"sim\" component is not defined. For simulation drag IDEAS.BoundaryConditions.SimInfoManager into your model.",
    Icon(coordinateSystem(extent={{-100,-100},{100,160}}),
         graphics={
        Line(points={{-80,-30},{88,-30}}, color={0,0,0}),
        Line(points={{-76,-68},{-46,-30}}, color={0,0,0}),
        Line(points={{-42,-68},{-12,-30}}, color={0,0,0}),
        Line(points={{-8,-68},{22,-30}}, color={0,0,0}),
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
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{34,0},{28,12}},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{24,0},{18,56}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{14,0},{8,36}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{4,0},{-2,12}},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-6,0},{-46,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Text(
          extent={{-50,66},{-20,26}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Italic},
          fontName="Bookman Old Style",
          textString="i")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,120}})),
    Documentation(info="<html>
</html>", revisions="<html>
<ul>
<li>
August 10, 2020, by Filip Jorissen:<br/>
Modifications for supporting interzonal airflow.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1066\">
#1066</a>
</li>
<li>
April 16, 2021 by Filip Jorissen:<br/>
Changed the default weather file to Brussels.mos.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1209\">
#1209</a> for more details.
</li>
<li>
June 30, 2020 by Filip Jorissen:<br/>
Overridable assignments of variables of PartialSimInfoManager.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1148\">
#1148</a>
</li>
<li>
November 28, 2019 by Ian Beausoleil-Morrison:<br/>
Remove calculation of convection coefficient at exterior surfaces 
as this has been moved to a new model. 
Also, removed this coefficient from WeaBus as it is not surface-dependent.<br/>
Make wind direction available on weather bus as this is required for new convection model.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1089\">
#1089</a>
</li>
<li>
October 9, 2019 by Josué Borrajo Bastero:<br/>
Added button to select the weather file graphically.
</li>
<li>
January 25, 2019 by Filip Jorissen:<br/>
Corrected molar mass fraction for consistency.
See <a href=https://github.com/open-ideas/IDEAS/issues/1004>#1004</a>.
</li>
<li>
April 10, 2019 by Filip Jorissen:<br/>
Avoided redundant consistent initial equation for <code>Etot</code>.
See <a href=https://github.com/open-ideas/IDEAS/issues/971>#971</a>.
</li>
<li>
July 27, 2018 by Filip Jorissen:<br/>
Added outputs <code>CEnv</code> and <code>X_wEnv</code> to <code>weaDatBus</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/868\">#868</a>.
</li>
<li>
June 21, 2018, by Damien Picard:<br/>
Reduce the icon size of weaBus to something very small such that users would
not try to connect to it.
Rename and make public the connector weaDatBus such that it can be connected 
to models from the Buildings library.
</li>
<li>
June 12, 2018, by Filip Jorissen:<br/>
Refactored implementation such that we use more computations from the weather
data reader instead of computing them ourself using equations.
</li>
<li>
June 11, 2018, by Filip Jorissen:<br/>
Revised implementation such that longitude, latitude and time zone are read from
the TMY3 weather file.
Removed split between file path and file name to avoid confusion
and incorrectly formatted paths.
</li>
<li>
June 11, 2018, by Filip Jorissen:<br/>
Changed table name of TMY3 file from 'data' to IBPSA final default 'tab1'
for issue <a href=https://github.com/open-ideas/IDEAS/issues/808>#808</a>.
</li>
<li>
June 8, 2018, by Filip Jorissen:<br/>
Moved input TMY3 file.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/821>#821</a>.
</li>
<li>
June 7, 2018 by Filip Jorissen:<br/>
Created 'input' for TSky, Va and Fc such that
they can be overwriten from the extends clause.
This is for
<a href=\"https://github.com/open-ideas/IDEAS/issues/838\">#838</a>.
</li>
<li>
March 27, 2018, by Filip Jorissen:<br/>
Added relative humidity to weather bus.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/780>#780</a>.
</li>
<li>
January 26, 2018, by Filip Jorissen:<br/>
Added floor orientation to set of precomputed boundary conditions.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/764>#764</a>.
</li>
<li>
January 21, 2018 by Filip Jorissen:<br/>
Added <code>solTim</code> connections for revised azimuth computations.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/753\">
#753</a>.
</li>
<li>
March 21, 2017, by Filip Jorissen:<br/>
Changed linearisation implementation for JModelica compatibility.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/559>#559</a>.
</li>
<li>
January 10, 2017 by Filip Jorissen:<br/>
Set <code>linExtRad = false</code>
and added new parameter <code>linExtRadWin = true</code>
since only for windows is it necessary that
<code>linExtRad</code> is true.
See <a href=https://github.com/open-ideas/IDEAS/issues/615>#615</a>.
</li>
<li>
September 22, 2016 by Filip Jorissen:<br/>
Reworked implementation such that we use Annex 60 
baseclasses for boundary condition computations.
</li>
<li>
March 25, 2016 by Filip Jorissen:<br/>
Reworked radSol implementation to use RealInputs instead of weaBus.
This simplifies translation and interpretation.
Also cleaned up connections.
</li>
<li>
January 29, 2015, Filip Jorissen:<br/>
Made changes for allowing a proper implementation of <code>airLeakage</code>.
</li>
<li>
June 14, 2015, Filip Jorissen:<br/>
Adjusted implementation for computing conservation of energy.
</li>
<li>
February 10, 2015 by Filip Jorissen:<br/>
Adjusted implementation for grouping of solar calculations.
</li>
</ul>
</html>"));
end PartialSimInfoManager;
