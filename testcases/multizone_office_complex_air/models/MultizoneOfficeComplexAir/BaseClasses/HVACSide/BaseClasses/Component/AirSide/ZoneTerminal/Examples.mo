within MultizoneOfficeComplexAir.BaseClasses.HVACSide.BaseClasses.Component.AirSide.ZoneTerminal;
package Examples
  extends Modelica.Icons.ExamplesPackage;
  model FivZonVAVCO2
    extends Modelica.Icons.Example;
      //package MediumAir = Buildings.Media.Air "Medium model for air";
      package MediumAir = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Buildings library air media package with CO2";

      package MediumWat = Buildings.Media.Water "Medium model for water";

    parameter Modelica.Units.SI.Pressure PreAirDroMai1=140
      "Pressure drop 1 across the duct";

    parameter Modelica.Units.SI.Pressure PreAirDroMai2=140
      "Pressure drop 2 across the main duct";

    parameter Modelica.Units.SI.Pressure PreAirDroMai3=120
      "Pressure drop 3 across the main duct";

    parameter Modelica.Units.SI.Pressure PreAirDroMai4=152
      "Pressure drop 4 across the main duct";

    parameter Modelica.Units.SI.Pressure PreAirDroBra1=0
      "Pressure drop 1 across the duct branch 1";

    parameter Modelica.Units.SI.Pressure PreAirDroBra2=0
      "Pressure drop 1 across the duct branch 2";

    parameter Modelica.Units.SI.Pressure PreAirDroBra3=0
      "Pressure drop 1 across the duct branch 3";

    parameter Modelica.Units.SI.Pressure PreAirDroBra4=0
      "Pressure drop 1 across the duct branch 4";

    parameter Modelica.Units.SI.Pressure PreAirDroBra5=0
      "Pressure drop 1 across the duct branch 5";

    parameter Modelica.Units.SI.Pressure PreWatDroMai1=79712*0.2
      "Pressure drop 1 across the pipe";

    parameter Modelica.Units.SI.Pressure PreWatDroMai2=79712*0.2
      "Pressure drop 2 across the main pipe";

    parameter Modelica.Units.SI.Pressure PreWatDroMai3=79712*0.2
      "Pressure drop 3 across the main pipe";

    parameter Modelica.Units.SI.Pressure PreWatDroMai4=79712*0.2
      "Pressure drop 4 across the main pipe";

    parameter Modelica.Units.SI.Pressure PreWatDroBra1=0
      "Pressure drop 1 across the pipe branch 1";

    parameter Modelica.Units.SI.Pressure PreWatDroBra2=0
      "Pressure drop 1 across the pipe branch 2";

    parameter Modelica.Units.SI.Pressure PreWatDroBra3=0
      "Pressure drop 1 across the pipe branch 3";

    parameter Modelica.Units.SI.Pressure PreWatDroBra4=0
      "Pressure drop 1 across the pipe branch 4";

    parameter Modelica.Units.SI.Pressure PreWatDroBra5=0
      "Pressure drop 1 across the pipe branch 5";

    parameter Modelica.Units.SI.MassFlowRate mAirFloRat1=10.92*1.2
      "mass flow rate for vav 1";

    parameter Modelica.Units.SI.MassFlowRate mAirFloRat2=2.25*1.2
      "mass flow rate for vav 2";

    parameter Modelica.Units.SI.MassFlowRate mAirFloRat3=1.49*1.2
      "mass flow rate for vav 3";

    parameter Modelica.Units.SI.MassFlowRate mAirFloRat4=1.9*1.2
      "mass flow rate for vav 4";

    parameter Modelica.Units.SI.MassFlowRate mAirFloRat5=1.73*1.2
      "mass flow rate for vav 5";

    parameter Modelica.Units.SI.MassFlowRate mWatFloRat1=mAirFloRat1*0.3*(35 -
        12.88)/4.2/20 "mass flow rate for vav 1";

    parameter Modelica.Units.SI.MassFlowRate mWatFloRat2=mAirFloRat2*0.3*(35 -
        12.88)/4.2/20 "mass flow rate for vav 2";

    parameter Modelica.Units.SI.MassFlowRate mWatFloRat3=mAirFloRat3*0.3*(35 -
        12.88)/4.2/20 "mass flow rate for vav 3";

    parameter Modelica.Units.SI.MassFlowRate mWatFloRat4=mAirFloRat4*0.3*(35 -
        12.88)/4.2/20 "mass flow rate for vav 4";

    parameter Modelica.Units.SI.MassFlowRate mWatFloRat5=mAirFloRat5*0.3*(35 -
        12.88)/4.2/20 "mass flow rate for vav 5";

    parameter Modelica.Units.SI.Pressure PreDroAir1=200
      "Pressure drop in the air side of vav 1";
    parameter Modelica.Units.SI.Pressure PreDroWat1=79712
      "Pressure drop in the water side of vav 1";
    parameter Modelica.Units.SI.Efficiency eps1(max=1) = 0.8
      "Heat exchanger effectiveness of vav 1";

    parameter Modelica.Units.SI.Pressure PreDroAir2=124
      "Pressure drop in the air side of vav 2";
    parameter Modelica.Units.SI.Pressure PreDroWat2=79712
      "Pressure drop in the water side of vav 2";
    parameter Modelica.Units.SI.Efficiency eps2(max=1) = 0.8
      "Heat exchanger effectiveness of vav 2";

    parameter Modelica.Units.SI.Pressure PreDroAir3=124
      "Pressure drop in the air side of vav 3";
    parameter Modelica.Units.SI.Pressure PreDroWat3=79712
      "Pressure drop in the water side of vav 3";
    parameter Modelica.Units.SI.Efficiency eps3(max=1) = 0.8
      "Heat exchanger effectiveness of vav 1";

    parameter Modelica.Units.SI.Pressure PreDroAir4=124
      "Pressure drop in the air side of vav 4";
    parameter Modelica.Units.SI.Pressure PreDroWat4=79712
      "Pressure drop in the water side of vav 4";
    parameter Modelica.Units.SI.Efficiency eps4(max=1) = 0.8
      "Heat exchanger effectiveness of vav 1";

    parameter Modelica.Units.SI.Pressure PreDroAir5=124
      "Pressure drop in the air side of vav 1";
    parameter Modelica.Units.SI.Pressure PreDroWat5=79712
      "Pressure drop in the water side of vav 1";
    parameter Modelica.Units.SI.Efficiency eps5(max=1) = 0.8
      "Heat exchanger effectiveness of vav 1";

    // Initialization
    parameter MediumAir.AbsolutePressure p_start = MediumAir.p_default
      "Start value of zone air pressure"
      annotation(Dialog(tab = "Initialization"));
    parameter MediumAir.Temperature T_start=MediumAir.T_default
      "Start value of zone air temperature"
      annotation(Dialog(tab = "Initialization"));
    parameter MediumAir.MassFraction X_start[MediumAir.nX](
         quantity=MediumAir.substanceNames) = MediumAir.X_default
      "Start value of zone air mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
    parameter MediumAir.ExtraProperty C_start[MediumAir.nC](
         quantity=MediumAir.extraPropertiesNames)=fill(0, MediumAir.nC)
      "Start value of zone air trace substances"
      annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
    parameter MediumAir.ExtraProperty C_nominal[MediumAir.nC](
         quantity=MediumAir.extraPropertiesNames) = fill(1E-2, MediumAir.nC)
      "Nominal value of zone air trace substances. (Set to typical order of magnitude.)"
     annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
    parameter Modelica.Units.SI.MassFlowRate m_flow_lea[4]={0.206*1.2,0.137*1.2,0.206*1.2,0.137*1.2} "Air infiltration mass flow rates to four exterior zones";

    Buildings.Fluid.Sources.Boundary_pT souAir(
      p(displayUnit="Pa") = 100000 + PreAirDroMai1 + PreAirDroMai2 + PreAirDroMai3 + PreAirDroMai4 + PreAirDroBra5 + PreDroAir5,
      redeclare package Medium = MediumAir,
      nPorts=1,
      T=286.02) annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

    Buildings.Fluid.Sources.Boundary_pT sinAir(
      redeclare package Medium = MediumAir,
      p(displayUnit="Pa") = 100000,
      nPorts=1,
      T=299.15) annotation (Placement(transformation(extent={{-100,-26},{
              -80,-6}})));

    Modelica.Blocks.Sources.Ramp Q_flow[5](duration=86400, height=1*1000*10)
      annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
    FiveZoneVAV fivZonVAV(
      redeclare package MediumAir = MediumAir,
      redeclare package MediumWat = MediumWat,
      p_start=p_start,
      T_start=T_start,
      X_start=X_start,
      C_start=C_start,
      C_nominal=C_nominal,
      m_flow_lea=m_flow_lea,
      PreAirDroMai1=PreAirDroMai1,
      PreAirDroMai2=PreAirDroMai2,
      PreAirDroMai3=PreAirDroMai3,
      PreAirDroMai4=PreAirDroMai4,
      PreAirDroBra1=PreAirDroBra1,
      PreAirDroBra2=PreAirDroBra2,
      PreAirDroBra3=PreAirDroBra3,
      PreAirDroBra4=PreAirDroBra4,
      PreAirDroBra5=PreAirDroBra5,
      PreWatDroMai1=PreWatDroMai1,
      PreWatDroMai2=PreWatDroMai2,
      PreWatDroMai3=PreWatDroMai3,
      PreWatDroMai4=PreWatDroMai4,
      PreWatDroBra1=PreWatDroBra1,
      PreWatDroBra2=PreWatDroBra2,
      PreWatDroBra3=PreWatDroBra3,
      PreWatDroBra4=PreWatDroBra4,
      PreWatDroBra5=PreWatDroBra5,
      mAirFloRat1=mAirFloRat1,
      mAirFloRat2=mAirFloRat2,
      mAirFloRat3=mAirFloRat3,
      mAirFloRat4=mAirFloRat4,
      mAirFloRat5=mAirFloRat5,
      mWatFloRat1=mWatFloRat1,
      mWatFloRat2=mWatFloRat2,
      mWatFloRat3=mWatFloRat3,
      mWatFloRat4=mWatFloRat4,
      mWatFloRat5=mWatFloRat5,
      PreDroAir1=PreDroAir1,
      PreDroWat1=PreDroWat1,
      eps1=eps1,
      PreDroAir2=PreDroAir2,
      PreDroWat2=PreDroWat2,
      eps2=eps2,
      PreDroAir3=PreDroAir3,
      PreDroWat3=PreDroWat3,
      eps3=eps3,
      PreDroAir4=PreDroAir4,
      PreDroWat4=PreDroWat4,
      eps4=eps4,
      PreDroAir5=PreDroAir5,
      PreDroWat5=PreDroWat5,
      eps5=eps5)
      annotation (Placement(transformation(extent={{-28,-28},{48,16}})));
    Buildings.Fluid.Sources.Boundary_pT souWat(
      p(displayUnit="Pa") = 100000 + PreWatDroMai1 + PreWatDroMai2 + PreWatDroMai3 + PreWatDroMai4 + PreWatDroBra5 + PreDroWat5,
      nPorts=1,
      redeclare package Medium = MediumWat,
      T=353.15) annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
    Buildings.Fluid.Sources.Boundary_pT sinWat(
      p(displayUnit="Pa") = 100000,
      nPorts=1,
      redeclare package Medium = MediumWat,
      T=299.15) annotation (Placement(transformation(extent={{20,70},{0,90}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression[5](y=true) annotation (Placement(transformation(extent={{-70,-14},
              {-50,6}})));
    Modelica.Blocks.Sources.Ramp airFloRat[5](duration=86400, height=1)
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Modelica.Blocks.Sources.Ramp yVal[5](
      duration=86400,
      height=-1,
      offset=1)
      annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
    Modelica.Blocks.Sources.Constant nPeo[5](k=20)
      annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          Modelica.Utilities.Files.loadResource(
          "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
        computeWetBulbTemperature=true)  "Weather data reader"
      annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  equation

    connect(fivZonVAV.port_a_Air, souAir.ports[1]) annotation (Line(points={{-28,4},
            {-38,4},{-38,50},{-80,50}},                                                                           color={0,127,255}));
    connect(fivZonVAV.port_b_Air, sinAir.ports[1]) annotation (Line(points={{-28,-16},
            {-80,-16}},                                                                                                         color={0,127,255}));
    connect(souWat.ports[1], fivZonVAV.port_a_Wat) annotation (Line(points={{-40,80},
            {-12.8,80},{-12.8,16}},                                                                                                  color={0,127,255}));
    connect(sinWat.ports[1], fivZonVAV.port_b_Wat) annotation (Line(points={{0,80},{
            -4,80},{-4,28},{7.46667,28},{7.46667,16}},                                                                                     color={0,127,255}));
    connect(Q_flow.y, fivZonVAV.Q_flow) annotation (Line(points={{-79,-50},{-48,
            -50},{-48,-18.8},{-30.5333,-18.8}},
                                        color={0,0,127}));
    connect(booleanExpression.y, fivZonVAV.On) annotation (Line(points={{-49,-4},
            {-38,-4},{-38,-6.4},{-30.5333,-6.4}},                                                                 color={255,0,255}));
    connect(yVal.y, fivZonVAV.yVal) annotation (Line(points={{-79,22},{-40,22},
            {-40,8},{-30.5333,8}},
                             color={0,0,127}));
    connect(airFloRat.y, fivZonVAV.airFloRatSet) annotation (Line(points={{-79,80},
            {-66,80},{-66,52},{-30.5333,52},{-30.5333,13.2}},
                                               color={0,0,127}));
    connect(nPeo.y, fivZonVAV.nPeo) annotation (Line(points={{-79,-80},{-42,-80},
            {-42,-23.2},{-30.5333,-23.2}},
                                   color={0,0,127}));
    connect(weaDat.weaBus, fivZonVAV.weaBus) annotation (Line(
        points={{-10,-50},{-2.66667,-50},{-2.66667,-28}},
        color={255,204,51},
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=259200, __Dymola_Algorithm="Dassl"));
  end FivZonVAVCO2;
end Examples;
