within IDEAS.Examples.PPD12;
model Structure "Ppd 12 example model"
  extends Modelica.Icons.Example;
  inner replaceable IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{400,38},{380,58}})));
  parameter Real n50=1.1
    "n50 value cfr airtightness, i.e. the ACH at a pressure diffence of 50 Pa";
  replaceable package MediumAir = IDEAS.Media.Air;
  replaceable package MediumWater = IDEAS.Media.Water;

  // GEOMETRY
  parameter Modelica.SIunits.Length hFloor0=2.9 "Height of ground floor";
  parameter Modelica.SIunits.Length hFloor1=2.7 "Height of first floor";
  parameter Modelica.SIunits.Length hFloor2=2.5 "Height of second floor";
  parameter Modelica.SIunits.Length lHallway=8 "Length of hallway";
  parameter Modelica.SIunits.Length wHallwayAvg=(wHallway1+wHallway2)/2 "Hallway width";
  parameter Modelica.SIunits.Length wHallway1=1.1 "Hallway width";
  parameter Modelica.SIunits.Length wHallway2=1.4 "Hallway width";
  parameter Modelica.SIunits.Length wZon=(wZonStr+wBathroom)/2 "Avg living width";
  parameter Modelica.SIunits.Length wZonStr=3.2 "Living width at street";
  parameter Modelica.SIunits.Length wBuilding = 4.6;
  parameter Modelica.SIunits.Length wBathroom = 2.85;
  parameter Modelica.SIunits.Length lDiner = 3;
  parameter Modelica.SIunits.Length wBedroom = 4.4;
  parameter Modelica.SIunits.Length wDiner = 4.5;
  parameter Modelica.SIunits.Length lPorch = 2;
  parameter Modelica.SIunits.Length wPorch = wBuilding-wKitchen;
  parameter Modelica.SIunits.Length wKitchen = 1.4;
  parameter Modelica.SIunits.Length lHalfBuilding = 3.75;
  parameter Modelica.SIunits.Length lBuilding = 8;

  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg angDelta=23.6;
  parameter Modelica.SIunits.Angle north = IDEAS.Types.Azimuth.N + Modelica.SIunits.Conversions.from_deg(angDelta)
    "Azimuth of the wall, i.e. 0deg denotes South";
  parameter Modelica.SIunits.Angle south = IDEAS.Types.Azimuth.S + Modelica.SIunits.Conversions.from_deg(angDelta)
    "Azimuth of the wall, i.e. 0deg denotes South";
  parameter Modelica.SIunits.Angle west = IDEAS.Types.Azimuth.W + Modelica.SIunits.Conversions.from_deg(angDelta)
    "Azimuth of the wall, i.e. 0deg denotes South";
  parameter Modelica.SIunits.Angle east = IDEAS.Types.Azimuth.E + Modelica.SIunits.Conversions.from_deg(angDelta)
    "Azimuth of the wall, i.e. 0deg denotes South";


  IDEAS.Buildings.Components.BoundaryWall com1(
    inc=IDEAS.Types.Tilt.Wall,
    azi=south,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall constructionType,
    A=2.3*lPorch) "Common wall on south side"
    annotation (Placement(transformation(extent={{-104,-72},{-94,-52}})));
  IDEAS.Buildings.Components.OuterWall out1(
    inc=IDEAS.Types.Tilt.Wall,
    A=hFloor0*wKitchen,
    azi=east,
    redeclare IDEAS.Examples.PPD12.Data.OuterWall constructionType)
    "Outerwall on east side - kitchen" annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-89,-94})));
  IDEAS.Buildings.Components.InternalWall cei2(
    A=wZon*lHallway/2,
    azi=0,
    redeclare IDEAS.Examples.PPD12.Data.Floor constructionType,
    inc=IDEAS.Types.Tilt.Floor) "Floor between living and bedroom 1"
    annotation (Placement(transformation(extent={{94,72},{104,52}})));
  IDEAS.Buildings.Components.InternalWall cei1(
    azi=0,
    A=lHallway*wHallway1,
    redeclare IDEAS.Examples.PPD12.Data.Floor constructionType,
    inc=IDEAS.Types.Tilt.Floor) "Floor between hallway and bedroom 1"
    annotation (Placement(transformation(extent={{70,68},{80,88}})));
  IDEAS.Buildings.Components.Window winBed3(
    frac=0.1,
    azi=east,
    redeclare IDEAS.Examples.PPD12.Data.PvcInsulated fraType,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar glazing,
    inc=(IDEAS.Types.Tilt.Wall + IDEAS.Types.Tilt.Ceiling)/2,
    A=1.2*1) "Window roof, bedroom 3"
    annotation (Placement(transformation(
        extent={{-5,10},{5,-10}},
        rotation=90,
        origin={305,-2})));
  IDEAS.Buildings.Components.OuterWall Roof2(
    azi=east,
    inc=(IDEAS.Types.Tilt.Wall + IDEAS.Types.Tilt.Ceiling)/2,
    A=wBedroom*lHalfBuilding*sqrt(2)/2,
    redeclare IDEAS.Examples.PPD12.Data.Roof constructionType)
    "Roof, east side"
    annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={263,-2})));
  IDEAS.Buildings.Components.OuterWall out2(
    inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Examples.PPD12.Data.OuterWall constructionType,
    azi=east,
    A=0.5*wBedroom)
    "Outer wall of top floor on east facade" annotation (
      Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={235,-2})));

  IDEAS.Buildings.Components.RectangularZoneTemplate living(
    h=hFloor0,
    aziA=east,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    hasWinC=true,
    l=wZon,
    w=lBuilding,
    redeclare package Medium = MediumAir,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    redeclare IDEAS.Examples.PPD12.Data.TripleGlazing glazingC,
    A_winC=2.55*1.74,
    fracC=0.1,
    redeclare IDEAS.Examples.PPD12.Data.OuterWall conTypC,
    redeclare IDEAS.Examples.PPD12.Data.InteriorWall10 conTypB,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypD,
    redeclare IDEAS.Examples.PPD12.Data.FloorOnGround conTypFlo,
    nSurfExt=1,
    redeclare Data.Ppd12WestShadingGnd shaTypC,
    n50=n50,
    hasCavityA=true,
    hA=2.7,
    wA=2,
    redeclare Data.InteriorWall18 conTypA,
    mSenFac=1)
    annotation (Placement(transformation(extent={{-26,56},{-46,36}})));

  IDEAS.Buildings.Components.RectangularZoneTemplate hallway(
    h=hFloor0,
    aziA=east,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    w=lBuilding,
    redeclare package Medium = MediumAir,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    redeclare IDEAS.Examples.PPD12.Data.TripleGlazing
                                 glazingC,
    A_winC=2.55*1.74,
    fracC=0.1,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    l=wHallwayAvg,
    redeclare IDEAS.Examples.PPD12.Data.OuterWall conTypC,
    redeclare IDEAS.Examples.PPD12.Data.InteriorWall30 conTypA,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypB,
    nSurfExt=1,
    n50=n50,
    mSenFac=1,
    redeclare Data.FloorOnGround conTypFlo)
    annotation (Placement(transformation(extent={{-72,60},{-92,40}})));
  IDEAS.Buildings.Components.RectangularZoneTemplate Diner(
    h=hFloor0,
    aziA=east,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    redeclare package Medium = MediumAir,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    redeclare IDEAS.Examples.PPD12.Data.TripleGlazing glazingC,
    A_winC=2.55*1.74,
    fracC=0.1,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypB,
    l=wDiner,
    w=lDiner,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypD,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    nSurfExt=4,
    redeclare IDEAS.Examples.PPD12.Data.FloorOnGround conTypFlo,
    n50=n50,
    redeclare Data.RoofHor conTypCei,
    redeclare Data.GlassWall conTypA,
    mSenFac=1)
    annotation (Placement(transformation(extent={{-46,-18},{-26,-38}})));
  IDEAS.Buildings.Components.RectangularZoneTemplate Porch(
    aziA=east,
    redeclare package Medium = MediumAir,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    redeclare IDEAS.Examples.PPD12.Data.TripleGlazing glazingC,
    A_winC=2.55*1.74,
    fracC=0.1,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypB,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    redeclare IDEAS.Examples.PPD12.Data.Roof conTypCei,
    l=wPorch,
    w=lPorch,
    h=2.3,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    redeclare IDEAS.Examples.PPD12.Data.InteriorWall10 conTypD,
    nSurfExt=0,
    redeclare IDEAS.Examples.PPD12.Data.FloorOnGround conTypFlo,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    redeclare IDEAS.Buildings.Data.Glazing.EpcDouble glazingCei,
    redeclare IDEAS.Buildings.Data.Glazing.EpcDouble glazingA,
    hasWinCei=true,
    hasWinA=true,
    A_winA=wPorch*2.3*0.9,
    A_winCei=wPorch*lPorch*0.9,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.LightWall
      conTypA,
    n50=n50,
    mSenFac=1)
    annotation (Placement(transformation(extent={{-44,-66},{-24,-86}})));

  IDEAS.Buildings.Components.RectangularZoneTemplate bedRoom1(
    aziA=east,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    hasWinC=true,
    redeclare package Medium = MediumAir,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    redeclare IDEAS.Examples.PPD12.Data.TripleGlazing glazingC,
    redeclare IDEAS.Examples.PPD12.Data.OuterWall conTypC,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypD,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypB,
    fracC=0.15,
    A_winC=1.9*(1 + 1.5),
    l=wBedroom,
    w=lHalfBuilding,
    h=hFloor1,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    nSurfExt=2,
    redeclare Data.Ppd12WestShadingFirst shaTypC,
    n50=n50,
    mSenFac=1)
             "Master bedroom"
    annotation (Placement(transformation(extent={{140,80},{120,60}})));

  IDEAS.Buildings.Components.RectangularZoneTemplate bathRoom(
    aziA=east,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare package Medium = MediumAir,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypD,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    hasWinA=true,
    A_winA=1.21*1.99,
    redeclare IDEAS.Examples.PPD12.Data.OuterWall conTypA,
    redeclare IDEAS.Examples.PPD12.Data.TripleGlazing glazingA,
    w=lHalfBuilding,
    h=hFloor1,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    l=wBathroom,
    redeclare IDEAS.Examples.PPD12.Data.InteriorWall10 conTypB,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    redeclare IDEAS.Examples.PPD12.Data.Floor conTypFlo,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    redeclare IDEAS.Examples.PPD12.Data.InteriorWall18 conTypC,
    nSurfExt=0,
    n50=n50,
    mSenFac=1)
    "Bathroom"
    annotation (Placement(transformation(extent={{140,26},{120,6}})));

  IDEAS.Buildings.Components.RectangularZoneTemplate stairWay(
    aziA=east,
    redeclare package Medium = MediumAir,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    hasWinA=true,
    redeclare IDEAS.Examples.PPD12.Data.OuterWall conTypA,
    redeclare IDEAS.Examples.PPD12.Data.TripleGlazing glazingA,
    w=lHalfBuilding,
    h=hFloor1,
    nSurfExt=0,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    l=wHallway2,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypB,
    A_winA=1.09*1.69,
    fracA=0.1,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.LightWall
      conTypFlo,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    redeclare IDEAS.Examples.PPD12.Data.InteriorWall10 conTypC,
    n50=n50,
    mSenFac=1)
    "Stairway"
    annotation (Placement(transformation(extent={{86,26},{66,6}})));
  IDEAS.Buildings.Components.RectangularZoneTemplate bedRoom2(
    aziA=east,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    hasWinC=true,
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Examples.PPD12.Data.TripleGlazing glazingC,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypD,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypB,
    fracC=0.15,
    l=wBedroom,
    w=lHalfBuilding,
    h=hFloor1,
    A_winC=1.1*0.66 + 1.1*1.54,
    redeclare IDEAS.Examples.PPD12.Data.InteriorWall18 conTypC,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    redeclare IDEAS.Examples.PPD12.Data.InteriorWall10 conTypA,
    nSurfExt=0,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    redeclare IDEAS.Examples.PPD12.Data.Floor conTypFlo,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare IDEAS.Examples.PPD12.Data.FloorAttic conTypCei,
    redeclare Data.Ppd12WestShadingSecond shaTypC,
    n50=n50,
    mSenFac=1)
    "Master bedroom"
    annotation (Placement(transformation(extent={{276,82},{256,62}})));
  IDEAS.Buildings.Components.RectangularZoneTemplate bedRoom3(
    aziA=east,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare package Medium = MediumAir,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypD,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare IDEAS.Examples.PPD12.Data.CommonWall conTypB,
    l=wBedroom,
    w=lHalfBuilding,
    h=hFloor1,
    redeclare IDEAS.Examples.PPD12.Data.InteriorWall10 conTypA,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    redeclare IDEAS.Examples.PPD12.Data.Roof conTypCei,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    redeclare IDEAS.Examples.PPD12.Data.Floor conTypFlo,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    hasWinA=true,
    A_winA=1.1*0.73,
    fracA=0.15,
    redeclare IDEAS.Examples.PPD12.Data.TripleGlazing glazingA,
    nSurfExt=3,
    calculateViewFactor=false,
    n50=n50,
    mSenFac=1)
    "Master bedroom"
    annotation (Placement(transformation(extent={{280,40},{260,20}})));

  IDEAS.Buildings.Components.OuterWall Roof1(
    inc=(IDEAS.Types.Tilt.Wall + IDEAS.Types.Tilt.Ceiling)/2,
    azi=west,
    A=wBedroom*lHalfBuilding*sqrt(2),
    redeclare IDEAS.Examples.PPD12.Data.Roof constructionType)
    "Roof, west side"                     annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={283,-2})));
  IDEAS.Buildings.Components.InternalWall cei3(
    azi=0,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.LightWall
      constructionType,
    A=lHallway*wHallway2,
    inc=IDEAS.Types.Tilt.Floor)
    "Dummy for representing stairway connection between floors"
    annotation (Placement(transformation(extent={{182,-22},{192,-2}})));
equation
  connect(hallway.proBusD[1], living.proBusB[1]) annotation (Line(
      points={{-72.4,57},{-45,57},{-45,40}},
      color={255,204,51},
      thickness=0.5));
  connect(Diner.proBusC[1], living.proBusA[1]) annotation (Line(
      points={{-29.2,-18.2},{-30,-18.2},{-30,37}},
      color={255,204,51},
      thickness=0.5));
  connect(Diner.proBusExt[1], hallway.proBusA[1]) annotation (Line(
      points={{-48,-36.5},{-76,-36.5},{-76,41}},
      color={255,204,51},
      thickness=0.5));
  connect(Diner.proBusExt[2], com1.propsBus_a) annotation (Line(
      points={{-48,-37.5},{-48,-36},{-94.8333,-36},{-94.8333,-60}},
      color={255,204,51},
      thickness=0.5));
  connect(out1.propsBus_a, Diner.proBusExt[3]) annotation (Line(
      points={{-91,-89.8333},{-91,-38.5},{-48,-38.5}},
      color={255,204,51},
      thickness=0.5));
  connect(Porch.proBusC[1], Diner.proBusA[1]) annotation (Line(
      points={{-27.2,-66.2},{-27.2,-48},{-42,-48},{-42,-37}},
      color={255,204,51},
      thickness=0.5));
  connect(Porch.proBusD[1], Diner.proBusExt[4]) annotation (Line(
      points={{-43.6,-69},{-88,-69},{-88,-38},{-48,-38},{-48,-39.5}},
      color={255,204,51},
      thickness=0.5));
  connect(bedRoom1.proBusFlo[1], cei2.propsBus_a) annotation (Line(
      points={{130,76},{120,76},{120,60},{103.167,60}},
      color={255,204,51},
      thickness=0.5));
  connect(cei2.propsBus_b, living.proBusCei[1]) annotation (Line(
      points={{94.8333,60},{-35.8,60},{-35.8,40}},
      color={255,204,51},
      thickness=0.5));
  connect(bedRoom1.proBusExt[1], cei1.propsBus_a) annotation (Line(
      points={{142,61},{144,61},{144,80},{79.1667,80}},
      color={255,204,51},
      thickness=0.5));
  connect(cei1.propsBus_b, hallway.proBusCei[1]) annotation (Line(
      points={{70.8333,80},{-81.8,80},{-81.8,44}},
      color={255,204,51},
      thickness=0.5));
  connect(bedRoom1.proBusA[1], bathRoom.proBusC[1]) annotation (Line(
      points={{136,61},{136,52},{136,25.8},{123.2,25.8}},
      color={255,204,51},
      thickness=0.5));
  connect(bathRoom.proBusFlo[1], living.proBusExt[1]) annotation (Line(
      points={{130,22},{96,22},{96,32},{96,38},{-24,38},{-24,36}},
      color={255,204,51},
      thickness=0.5));
  connect(stairWay.proBusC[1], bedRoom1.proBusExt[2]) annotation (Line(
      points={{69.2,25.8},{69.2,25.8},{69.2,50},{76,50},{142,50},{142,59}},
      color={255,204,51},
      thickness=0.5));
  connect(stairWay.proBusFlo[1], hallway.proBusExt[1]) annotation (Line(
      points={{76,22},{46,22},{-70,22},{-70,40}},
      color={255,204,51},
      thickness=0.5));
  connect(stairWay.proBusD[1], bathRoom.proBusB[1]) annotation (Line(
      points={{85.6,23},{121,23},{121,10}},
      color={255,204,51},
      thickness=0.5));
  connect(bedRoom2.proBusFlo[1], bedRoom1.proBusCei[1]) annotation (Line(
      points={{266,78},{266,90},{192,90},{192,64},{130.2,64}},
      color={255,204,51},
      thickness=0.5));
  connect(bedRoom3.proBusC[1], bedRoom2.proBusA[1]) annotation (Line(
      points={{263.2,39.8},{264,39.8},{264,63},{272,63}},
      color={255,204,51},
      thickness=0.5));
  connect(bedRoom3.proBusFlo[1], bathRoom.proBusCei[1]) annotation (Line(
      points={{270,36},{202,36},{202,10},{130.2,10}},
      color={255,204,51},
      thickness=0.5));
  connect(out2.propsBus_a, bedRoom3.proBusA[1]) annotation (Line(
      points={{233,2.16667},{233,14},{276,14},{276,21}},
      color={255,204,51},
      thickness=0.5));
  connect(winBed3.propsBus_a, bedRoom3.proBusExt[1]) annotation (Line(
      points={{307,2.16667},{307,21.3333},{282,21.3333}},
      color={255,204,51},
      thickness=0.5));
  connect(Roof1.propsBus_a, bedRoom3.proBusExt[2]) annotation (Line(
      points={{281,2.16667},{281,11.5},{282,11.5},{282,20}},
      color={255,204,51},
      thickness=0.5));
  connect(Roof2.propsBus_a, bedRoom3.proBusCei[1]) annotation (Line(
      points={{261,2.16667},{261,24},{270.2,24}},
      color={255,204,51},
      thickness=0.5));
  connect(cei3.propsBus_a, bedRoom3.proBusExt[3]) annotation (Line(
      points={{191.167,-10},{282,-10},{282,18.6667}},
      color={255,204,51},
      thickness=0.5));
  connect(cei3.propsBus_b, stairWay.proBusCei[1]) annotation (Line(
      points={{182.833,-10},{76.2,-10},{76.2,10}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -200},{400,240}},
        initialScale=0.1), graphics={
        Line(points={{-72,-100},{-100,-100},{-100,100},{-68,100},{-68,-10},{0,-10},
              {0,100},{-68,100}}, color={28,108,200}),
        Line(points={{-72,-98}}, color={28,108,200}),
        Line(points={{-72,-100},{-72,-50},{0,-50},{0,-8}}, color={28,108,200}),
        Line(points={{-60,-10},{-100,-10}}, color={28,108,200}),
        Line(points={{-72,-100},{0,-100},{0,-50}}, color={28,108,200}),
        Line(points={{60,100},{160,100},{160,46},{60,46},{60,100}}, color={28,108,
              200}),
        Line(
          points={{92,100},{92,46}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(points={{60,46},{160,46},{160,-8},{60,-8},{60,46}}, color={28,108,200}),
        Line(points={{92,46},{92,-8}}, color={28,108,200}),
        Line(points={{220,100},{320,100},{320,46},{220,46},{220,100}},
                                                                    color={28,108,
              200}),
        Line(points={{220,46},{320,46},{320,-8},{220,-8},{220,46}}, color={28,108,
              200}),
        Line(
          points={{-68,46},{0,46}},
          color={28,108,200},
          pattern=LinePattern.Dash)}),
                                Icon(coordinateSystem(
        preserveAspectRatio=false,
        initialScale=0.1)),
    experiment(
      StopTime=500000,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Euler"),
    __Dymola_Commands,
    Documentation(info="<html>
<p>
Example model of a partially renovated terraced house in Belgium.
This model only contains the building structure.
</p>
</html>", revisions="<html>
<ul>
<li>
October 13, 2019, by Filip Jorissen:<br/>
Fixed floor type in hallway.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1017\">#1017</a>.
</li>
<li>
May 21, 2018, by Filip Jorissen:<br/>
Using model for air flow through vertical cavity.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/822\">#822</a>.
</li>
<li>
December 20, 2016 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end Structure;
