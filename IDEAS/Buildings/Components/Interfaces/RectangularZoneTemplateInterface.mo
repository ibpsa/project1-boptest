within IDEAS.Buildings.Components.Interfaces;
partial model RectangularZoneTemplateInterface
  "Rectangular zone including walls, floor and ceiling"
  extends IDEAS.Buildings.Components.Interfaces.PartialZone(
    calculateViewFactor=false,
    final nSurf=indWinCei+nSurfExt,
    final V=A*h,
    final A=AZone,
    final hZone=h,
    final fRH=11);

  parameter IDEAS.Buildings.Components.Interfaces.BoundaryType bouTypA
    "Modelled boundary for face A of the zone"
    annotation(Dialog(tab="Face A", group="Construction details"));
  parameter IDEAS.Buildings.Components.Interfaces.BoundaryType bouTypB
    "Modelled boundary for face B of the zone"
    annotation(Dialog(tab="Face B", group="Construction details"));
  parameter IDEAS.Buildings.Components.Interfaces.BoundaryType bouTypC
    "Modelled boundary for face C of the zone"
    annotation(Dialog(tab="Face C", group="Construction details"));
  parameter IDEAS.Buildings.Components.Interfaces.BoundaryType bouTypD
    "Modelled boundary for face D of the zone"
    annotation(Dialog(tab="Face D", group="Construction details"));
  parameter IDEAS.Buildings.Components.Interfaces.BoundaryType bouTypFlo
    "Modelled boundary for the zone floor"
    annotation(Dialog(tab="Floor", group="Construction details"));
  parameter IDEAS.Buildings.Components.Interfaces.BoundaryType bouTypCei
    "Modelled boundary for the zone ceiling"
    annotation(Dialog(tab="Ceiling", group="Construction details"));
  parameter Integer nExtA(min=0) = 1 "Number of external surfaces connected to face A"
    annotation(Dialog(tab="Face A", group="Construction details",
               enable=bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.External));
  parameter Integer nExtB(min=0) = 1 "Number of external surfaces connected to face B"
    annotation(Dialog(tab="Face B", group="Construction details",
               enable=bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.External));
  parameter Integer nExtC(min=0) = 1 "Number of external surfaces connected to face C"
    annotation(Dialog(tab="Face C", group="Construction details",
               enable=bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.External));
  parameter Integer nExtD(min=0) = 1 "Number of external surfaces connected to face D"
    annotation(Dialog(tab="Face D", group="Construction details",
               enable=bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.External));
  parameter Integer nExtFlo(min=0) = 1 "Number of external surfaces connected to floor"
    annotation(Dialog(tab="Floor", group="Construction details",
               enable=bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.External));
  parameter Integer nExtCei(min=0) = 1 "Number of external surfaces connected to ceiling"
    annotation(Dialog(tab="Ceiling", group="Construction details",
               enable=bouTypCei == IDEAS.Buildings.Components.Interfaces.BoundaryType.External));

  parameter Boolean hasWinA = false
    "Modelling window for face A if true"
    annotation(Dialog(tab="Face A", group="Window details", enable=not (bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.None)));
  parameter Boolean hasWinB = false
    "Modelling window for face B if true"
    annotation(Dialog(tab="Face B", group="Window details", enable=not (bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.None)));
  parameter Boolean hasWinC = false
    "Modelling window for face C if true"
    annotation(Dialog(tab="Face C", group="Window details", enable=not (bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.None)));
  parameter Boolean hasWinD = false
    "Modelling window for face D if true"
    annotation(Dialog(tab="Face D", group="Window details", enable=not (bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.None)));
  parameter Boolean hasWinCei = false
    "Modelling window for ceiling if true"
    annotation(Dialog(tab="Ceiling", group="Window details", enable=not (bouTypCei == IDEAS.Buildings.Components.Interfaces.BoundaryType.None)));
  parameter Boolean hasInt = false
    "If true, the zone contains an internal wall with both faces connected to the zone"
    annotation(Dialog(tab="Internal wall"));
  parameter Integer nSurfExt = 0
    "Number of additional connected external surfaces";
  parameter Integer aziOpt = 5
    "Azimuth angle option from simInfoManager, or custom using aziA"
    annotation(choices(__Dymola_radioButtons=true, choice=1 "South", choice=2 "West", choice=3 "North", choice=4 "East", choice=5 "Custom"));
  parameter Modelica.SIunits.Angle aziA=sim.aziOpts[aziOpt]
    "Azimuth angle of face A"
    annotation(Dialog(enable=aziOpt==5));
  parameter Modelica.SIunits.Length l
    "Horizontal length of faces A and C. This parameter can be overwritten per surface";
  parameter Modelica.SIunits.Length w
    "Horizontal length of faces B and D. This parameter can be overwritten per surface";
  parameter Modelica.SIunits.Length lA = l
    "Horizontal length of face A" annotation(Dialog(tab="Face A", group="Overwrite"));
  parameter Modelica.SIunits.Length lB = w
    "Horizontal length of face B" annotation(Dialog(tab="Face B", group="Overwrite"));
  parameter Modelica.SIunits.Length lC = l
    "Horizontal length of face C" annotation(Dialog(tab="Face C", group="Overwrite"));
  parameter Modelica.SIunits.Length lD = w
    "Horizontal length of face D" annotation(Dialog(tab="Face D", group="Overwrite"));
  parameter Modelica.SIunits.Length lInt = lA
    "Horizontal length of internal wall contained within the zone" annotation(Dialog(tab="Internal wall", group="Construction details", enable=hasInt));
  parameter Modelica.SIunits.Area AZone = w*l
    "Parameter to overwrite the zone surface area"
                                  annotation(Dialog(tab="Advanced", group="Overwrite"));
  parameter Modelica.SIunits.Area ACei = w*l "Surface of roof or ceiling (including potential windows)"
    annotation(Dialog(tab="Ceiling", group="Overwrite"));

  parameter Modelica.SIunits.Length h
    "Height between top of floor and bottom of ceiling";
  parameter Modelica.SIunits.Area A_winA=0
    "Surface area of window of face A"
    annotation(Dialog(tab="Face A", group="Window details",
    enable=hasWinA));
  parameter Modelica.SIunits.Area A_winB=0
    "Surface area of window of face B"
    annotation(Dialog(tab="Face B", group="Window details",
    enable=hasWinB));
  parameter Modelica.SIunits.Area A_winC=0
    "Surface area of window of face C"
    annotation(Dialog(tab="Face C", group="Window details",
    enable=hasWinC));
  parameter Modelica.SIunits.Area A_winD=0
    "Surface area of window of face D"
    annotation(Dialog(tab="Face D", group="Window details",
    enable=hasWinD));
  parameter Modelica.SIunits.Area A_winCei=0
    "Surface area of window of ceiling"
    annotation(Dialog(tab="Ceiling", group="Window details",
    enable=hasWinCei));

  parameter Real fracA=0.15
    "Area fraction of the window frame of face A"
    annotation(Dialog(tab="Face A", group="Window details",
    enable=hasWinA));
  parameter Real fracB=0.15
    "Area fraction of the window frame of face B"
    annotation(Dialog(tab="Face B", group="Window details",
    enable=hasWinB));
  parameter Real fracC=0.15
    "Area fraction of the window frame of face C"
    annotation(Dialog(tab="Face C", group="Window details",
    enable=hasWinC));
  parameter Real fracD=0.15
    "Area fraction of the window frame of face D"
    annotation(Dialog(tab="Face D", group="Window details",
    enable=hasWinD));
  parameter Real fracCei=0.15
    "Area fraction of the window frame of the ceiling"
    annotation(Dialog(tab="Ceiling", group="Window details",
    enable=hasWinCei));
  parameter Real nWinA=1
    "Scaling factor to model nWinA identical windows in facade A"
    annotation(Dialog(tab="Face A", group="Window details",
    enable=hasWinA));
  parameter Real nWinB=1
    "Scaling factor to model nWinB identical windows in facade B"
    annotation(Dialog(tab="Face B", group="Window details",
    enable=hasWinB));
  parameter Real nWinC=1
    "Scaling factor to model nWinC identical windows in facade C"
    annotation(Dialog(tab="Face C", group="Window details",
    enable=hasWinC));
  parameter Real nWinD=1
    "Scaling factor to model nWinD identical windows in facade D"
    annotation(Dialog(tab="Face D", group="Window details",
    enable=hasWinD));
  parameter Real nWinCei=1
    "Scaling factor to model nWinCei identical windows in the ceiling"
    annotation(Dialog(tab="Ceiling", group="Window details",
    enable=hasWinCei));

  parameter Boolean linIntCon=sim.linIntCon
    "= true, if convective heat transfer should be linearised"
    annotation(Dialog(tab="Advanced", group="Convective heat exchange"));
  parameter Interfaces.WindowDynamicsType windowDynamicsType=IDEAS.Buildings.Components.Interfaces.WindowDynamicsType.Two
    "Type of dynamics for glazings and frames: using zero, one combined or two states"
    annotation(Dialog(group="Windows", tab="Advanced"));
  parameter SI.TemperatureDifference dT_nominal_win=-3
    "Nominal temperature difference used for linearisation, negative temperatures indicate the solid is colder"
    annotation(Dialog(group="Convective heat transfer", tab="Advanced"));
  parameter Boolean linExtCon=sim.linExtCon
    "= true, if exterior convective heat transfer should be linearised (uses average wind speed)"
    annotation(Dialog(tab="Advanced", group="Convective heat exchange"));
  parameter Boolean linExtRad=sim.linExtRad
    "= true, if exterior radiative heat transfer for walls should be linearised"
    annotation(Dialog(tab="Advanced", group="Radiative heat exchange"));
  parameter Boolean linExtRadWin=sim.linExtRadWin
    "= true, if exterior radiative heat transfer for windows should be linearised"
    annotation(Dialog(tab="Advanced", group="Radiative heat exchange"));

  parameter Real mSenFac(min=0.1)=5
    "Factor for scaling the sensible thermal mass of the zone air"
    annotation(Dialog(tab="Advanced",group="Air model"));
  parameter SI.TemperatureDifference dT_nominal_bou=-1
    "Nominal temperature difference for boundary walls, used for linearisation, negative temperatures indicate the solid is colder"
    annotation(Dialog(tab="Advanced", group="Convective heat transfer"));
  parameter SI.TemperatureDifference dT_nominal_out=-3
    "Nominal temperature difference for outer walls, used for linearisation, negative temperatures indicate the solid is colder"
    annotation(Dialog(tab="Advanced", group="Convective heat transfer"));
  parameter SI.TemperatureDifference dT_nominal_sla=-3
    "Nominal temperature difference of slab on ground, used for linearisation, negative temperatures indicate the solid is colder"
    annotation(Dialog(tab="Advanced", group="Convective heat transfer"));
  parameter SI.Temperature TeAvg=273.15 + 10.8
    "Annual average outdoor temperature"
    annotation(Dialog(tab="Floor", group="Slab on ground", enable=(bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround)));
  parameter SI.Temperature TiAvg=273.15 + 22
    "Annual average indoor temperature"
    annotation(Dialog(tab="Floor", group="Slab on ground", enable=(bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround)));
  parameter SI.TemperatureDifference dTeAvg=4
    "Amplitude of variation of monthly average outdoor temperature"
    annotation(Dialog(tab="Floor", group="Slab on ground", enable=(bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround)));
  parameter SI.TemperatureDifference dTiAvg=2
    "Amplitude of variation of monthly average indoor temperature"
    annotation(Dialog(tab="Floor", group="Slab on ground", enable=(bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround)));
  parameter SI.TemperatureDifference dT_nominal_intA=1
    "Nominal temperature difference between zone air and interior walls, used for linearisation"
    annotation(Dialog(tab="Advanced", group="Convective heat transfer"));
  parameter SI.TemperatureDifference dT_nominal_intB=1
    "Nominal temperature difference between interior walls exterior connection, used for linearisation"
    annotation(Dialog(tab="Advanced", group="Convective heat transfer"));
  replaceable parameter IDEAS.Buildings.Data.Constructions.CavityWall conTypA
    constrainedby IDEAS.Buildings.Data.Interfaces.Construction
    "Material structure of face A" annotation (
    choicesAllMatching=true,
    Placement(transformation(extent={{-228,8},{-224,12}})),
    Dialog(tab="Face A",group="Construction details",
           enable=not (bouTypA==IDEAS.Buildings.Components.Interfaces.BoundaryType.None) and not
                 (bouTypA==IDEAS.Buildings.Components.Interfaces.BoundaryType.External)));
  replaceable parameter IDEAS.Buildings.Data.Constructions.CavityWall conTypB
    constrainedby IDEAS.Buildings.Data.Interfaces.Construction
    "Material structure of face B" annotation (
    choicesAllMatching=true,
    Placement(transformation(extent={{-228,-12},{-224,-8}})),
    Dialog(tab="Face B",group="Construction details",
           enable=not (bouTypB==IDEAS.Buildings.Components.Interfaces.BoundaryType.None) and not
                 (bouTypB==IDEAS.Buildings.Components.Interfaces.BoundaryType.External)));
  replaceable parameter IDEAS.Buildings.Data.Constructions.CavityWall conTypC
    constrainedby IDEAS.Buildings.Data.Interfaces.Construction
    "Material structure of face C" annotation (
    choicesAllMatching=true,
    Placement(transformation(extent={{-228,-32},{-224,-28}})),
    Dialog(tab="Face C",group="Construction details",
           enable=not (bouTypC==IDEAS.Buildings.Components.Interfaces.BoundaryType.None) and not
                 (bouTypC==IDEAS.Buildings.Components.Interfaces.BoundaryType.External)));
  replaceable parameter IDEAS.Buildings.Data.Constructions.CavityWall conTypD
    constrainedby IDEAS.Buildings.Data.Interfaces.Construction
    "Material structure of face D" annotation (
    choicesAllMatching=true,
    Placement(transformation(extent={{-228,-52},{-224,-48}})),
    Dialog(tab="Face D",group="Construction details",
           enable=not (bouTypD==IDEAS.Buildings.Components.Interfaces.BoundaryType.None) and not
                 (bouTypD==IDEAS.Buildings.Components.Interfaces.BoundaryType.External)));
  replaceable parameter IDEAS.Buildings.Data.Constructions.CavityWall conTypCei
    constrainedby IDEAS.Buildings.Data.Interfaces.Construction
    "Material structure of ceiling" annotation (
    choicesAllMatching=true,
    Placement(transformation(extent={{-228,-92},{-224,-88}})),
    Dialog(tab="Ceiling",group="Construction details",
           enable=not (bouTypCei==IDEAS.Buildings.Components.Interfaces.BoundaryType.None) and not
                 (bouTypCei==IDEAS.Buildings.Components.Interfaces.BoundaryType.External)));
  replaceable parameter IDEAS.Buildings.Data.Constructions.CavityWall conTypFlo
    constrainedby IDEAS.Buildings.Data.Interfaces.Construction
    "Material structure of floor" annotation (
    choicesAllMatching=true,
    Placement(transformation(extent={{-228,-72},{-224,-68}})),
    Dialog(tab="Floor",group="Construction details",
           enable=not (bouTypFlo==IDEAS.Buildings.Components.Interfaces.BoundaryType.None) and not
                 (bouTypFlo==IDEAS.Buildings.Components.Interfaces.BoundaryType.External)));
  replaceable parameter IDEAS.Buildings.Data.Constructions.CavityWall conTypInt
    constrainedby IDEAS.Buildings.Data.Interfaces.Construction
    "Material structure of internal wall" annotation (
    choicesAllMatching=true,
    Placement(transformation(extent={{-228,-72},{-224,-68}})),
    Dialog(tab="Internal wall",group="Construction details", enable=hasInt));
  replaceable IDEAS.Buildings.Data.Glazing.Ins2 glazingA
    constrainedby IDEAS.Buildings.Data.Interfaces.Glazing "Glazing type of window of face A"
    annotation (choicesAllMatching=true,
    Dialog(tab="Face A", group="Window details",
           enable = hasWinA));
  replaceable IDEAS.Buildings.Data.Glazing.Ins2 glazingB
    constrainedby IDEAS.Buildings.Data.Interfaces.Glazing "Glazing type of window of face B"
    annotation (choicesAllMatching=true,
    Dialog(tab="Face B", group="Window details",
           enable = hasWinB));
  replaceable IDEAS.Buildings.Data.Glazing.Ins2 glazingC
    constrainedby IDEAS.Buildings.Data.Interfaces.Glazing "Glazing type of window of face C"
    annotation (choicesAllMatching=true,
    Dialog(tab="Face C", group="Window details",
           enable = hasWinC));
  replaceable IDEAS.Buildings.Data.Glazing.Ins2 glazingD
    constrainedby IDEAS.Buildings.Data.Interfaces.Glazing "Glazing type of window of face D"
    annotation (choicesAllMatching=true,
    Dialog(tab="Face D", group="Window details",
           enable = hasWinD));
  replaceable IDEAS.Buildings.Data.Glazing.Ins2 glazingCei
    constrainedby IDEAS.Buildings.Data.Interfaces.Glazing "Glazing type of window of ceiling"
    annotation (
           choicesAllMatching=true,
           Dialog(tab="Ceiling", group="Window details",
           enable = hasWinCei));

  replaceable parameter IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties shaTypA
    constrainedby
    IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties
    "Shading type and properties of window of face A"
    annotation (
           choicesAllMatching=true,
           Dialog(tab="Face A", group="Window details",
           enable = hasWinA));
  replaceable parameter IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties shaTypB
    constrainedby
    IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties
    "Shading type and properties of window of face B"
    annotation (
           choicesAllMatching=true,
           Dialog(tab="Face B", group="Window details",
           enable = hasWinB));
  replaceable parameter IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties shaTypC
    constrainedby
    IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties
    "Shading type and properties of window of face C"
    annotation (
           choicesAllMatching=true,
           Dialog(tab="Face C", group="Window details",
           enable = hasWinC));
  replaceable parameter IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties shaTypD
    constrainedby
    IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties
    "Shading type and properties of window of face D"
    annotation (
           choicesAllMatching=true,
           Dialog(tab="Face D", group="Window details",
           enable = hasWinD));
  replaceable parameter IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties shaTypCei
    constrainedby
    IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties
    "Shading type and properties of window of ceiling"
    annotation (
           choicesAllMatching=true,
           Dialog(tab="Ceiling", group="Window details",
           enable = hasWinCei));
  replaceable parameter IDEAS.Buildings.Data.Frames.None fraTypA
    constrainedby IDEAS.Buildings.Data.Interfaces.Frame
    "Window frame type for surface A"
    annotation (choicesAllMatching=true,
                Dialog(tab="Face A", group="Window details", enable=hasWinA));
  replaceable parameter IDEAS.Buildings.Data.Frames.None fraTypB
    constrainedby IDEAS.Buildings.Data.Interfaces.Frame
    "Window frame type for surface B"
    annotation (choicesAllMatching=true,
                Dialog(tab="Face B", group="Window details", enable=hasWinB));
  replaceable parameter IDEAS.Buildings.Data.Frames.None fraTypC
    constrainedby IDEAS.Buildings.Data.Interfaces.Frame
    "Window frame type for surface C"
    annotation (choicesAllMatching=true,
                Dialog(tab="Face C", group="Window details", enable=hasWinC));
  replaceable parameter IDEAS.Buildings.Data.Frames.None fraTypD
    constrainedby IDEAS.Buildings.Data.Interfaces.Frame
    "Window frame type for surface D"
    annotation (choicesAllMatching=true,
                Dialog(tab="Face D", group="Window details", enable=hasWinD));
  replaceable parameter IDEAS.Buildings.Data.Frames.None fraTypCei
    constrainedby IDEAS.Buildings.Data.Interfaces.Frame
    "Window frame type for surface Cei"
    annotation (choicesAllMatching=true,
                Dialog(tab="Ceiling", group="Window details", enable=hasWinCei));

  // open door modelling
  parameter Boolean hasCavityA = false
    "=true, to model open door or cavity in internal wall"
    annotation(Dialog(tab="Face A", group="Cavity or open door", enable=(bouTypeA==IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall)));
  parameter Modelica.SIunits.Length hA(min=0) = 2
    "Height of (rectangular) cavity in internal wall"
     annotation(Dialog(enable=hasCavityA,tab="Face A", group="Cavity or open door"));
  parameter Modelica.SIunits.Length wA(min=0) = 1
    "Width of (rectangular) cavity in internal wall"
     annotation(Dialog(enable=hasCavityA,tab="Face A", group="Cavity or open door"));
  parameter Boolean hasCavityB = false
    "=true, to model open door or cavity in internal wall"
    annotation(Dialog(tab="Face B", group="Cavity or open door", enable=(bouTypeB==IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall)));
  parameter Modelica.SIunits.Length hB(min=0) = 2
    "Height of (rectangular) cavity in internal wall"
     annotation(Dialog(enable=hasCavityB,tab="Face B", group="Cavity or open door"));
  parameter Modelica.SIunits.Length wB(min=0) = 1
    "Width of (rectangular) cavity in internal wall"
     annotation(Dialog(enable=hasCavityB,tab="Face B", group="Cavity or open door"));
  parameter Boolean hasCavityC = false
    "=true, to model open door or cavity in internal wall"
    annotation(Dialog(tab="Face C", group="Cavity or open door", enable=(bouTypeC==IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall)));
  parameter Modelica.SIunits.Length hC(min=0) = 2
    "Height of (rectangular) cavity in internal wall"
     annotation(Dialog(enable=hasCavityC,tab="Face C", group="Cavity or open door"));
  parameter Modelica.SIunits.Length wC(min=0) = 1
    "Width of (rectangular) cavity in internal wall"
     annotation(Dialog(enable=hasCavityC,tab="Face C", group="Cavity or open door"));
  parameter Boolean hasCavityD = false
    "=true, to model open door or cavity in internal wall"
    annotation(Dialog(tab="Face D", group="Cavity or open door", enable=(bouTypeD==IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall)));
  parameter Modelica.SIunits.Length hD(min=0) = 2
    "Height of (rectangular) cavity in internal wall"
     annotation(Dialog(enable=hasCavityD,tab="Face D", group="Cavity or open door"));
  parameter Modelica.SIunits.Length wD(min=0) = 1
    "Width of (rectangular) cavity in internal wall"
     annotation(Dialog(enable=hasCavityD,tab="Face D", group="Cavity or open door"));
  parameter Modelica.SIunits.Acceleration g = Modelica.Constants.g_n
    "Gravity, for computation of buoyancy"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Modelica.SIunits.Pressure p = 101300
    "Absolute pressure for computation of buoyancy"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Modelica.SIunits.Density rho = p/r/T
    "Nominal density for computation of buoyancy mass flow rate"
    annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Modelica.SIunits.SpecificHeatCapacity c_p = 1013
   "Nominal heat capacity for computation of buoyancy heat flow rate"
   annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Modelica.SIunits.Temperature T = 293.15
   "Nominal temperature for linearising heat flow rate"
   annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));
  parameter Modelica.SIunits.TemperatureDifference dT = 1
   "Nominal temperature difference when linearising heat flow rate"
   annotation(Dialog(enable=hasCavity,group="Cavity or open door",tab="Advanced"));

  parameter Boolean hasBuildingShadeA=false
    "=true, to enable computation of shade cast by opposite building or object on OuterWall"
    annotation(Dialog(tab="Face A", group="Building shade", enable=(bouTypA==IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall)));
  parameter SI.Length LShaA=0
    "Distance between shading object and wall, perpendicular to wall"
    annotation(Dialog(enable=hasBuildingShadeA,tab="Face A", group="Building shade"));
  parameter SI.Length dhShaA=0
    "Height difference between top of shading object and top of wall A"
    annotation(Dialog(enable=hasBuildingShadeA,tab="Face A", group="Building shade"));
  parameter Boolean hasBuildingShadeB=false
    "=true, to enable computation of shade cast by opposite building or object on OuterWall"
    annotation(Dialog(tab="Face B", group="Building shade", enable=(bouTypB==IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall)));
  parameter SI.Length LShaB=0
    "Distance between shading object and wall, perpendicular to wall"
    annotation(Dialog(enable=hasBuildingShadeB,tab="Face B", group="Building shade"));
  parameter SI.Length dhShaB=0
    "Height difference between top of shading object and top of wall B"
    annotation(Dialog(enable=hasBuildingShadeB,tab="Face B", group="Building shade"));
  parameter Boolean hasBuildingShadeC=false
    "=true, to enable computation of shade cast by opposite building or object on OuterWall"
    annotation(Dialog(tab="Face C", group="Building shade", enable=(bouTypC==IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall)));
  parameter SI.Length LShaC=0
    "Distance between shading object and wall, perpendicular to wall"
    annotation(Dialog(enable=hasBuildingShadeC,tab="Face C", group="Building shade"));
  parameter SI.Length dhShaC=0
    "Height difference between top of shading object and top of wall C"
    annotation(Dialog(enable=hasBuildingShadeC,tab="Face C", group="Building shade"));
  parameter Boolean hasBuildingShadeD=false
    "=true, to enable computation of shade cast by opposite building or object on OuterWall"
    annotation(Dialog(tab="Face D", group="Building shade", enable=(bouTypD==IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall)));
  parameter SI.Length LShaD=0
    "Distance between shading object and wall, perpendicular to wall"
    annotation(Dialog(enable=hasBuildingShadeD,tab="Face D", group="Building shade"));
  parameter SI.Length dhShaD=0
    "Height difference between top of shading object and top of wall D"
    annotation(Dialog(enable=hasBuildingShadeD,tab="Face D", group="Building shade"));
  parameter SI.Length PWall = (if hasOutA then lA else 0) + (if hasOutB then lB else 0) + (if hasOutC then lC else 0) + (if hasOutD then lD else 0)
    "Total floor slab perimeter length" annotation(Dialog(tab="Advanced", group="SlabOnGround", enable=(bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround)));

  parameter Boolean hasEmb = false
    "Set to true if floor is equipped with floor heating or concrete core activation"
  annotation(Dialog(tab="Floor", group="Floor heating / CCA",
            enable=(bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall or
                    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall or
                    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround)));
  final parameter Modelica.SIunits.Angle aziB = aziAInt + Modelica.Constants.pi/2
    "Azimuth angle of face B";
  final parameter Modelica.SIunits.Angle aziC = aziAInt + Modelica.Constants.pi
    "Azimuth angle of face C";
  final parameter Modelica.SIunits.Angle aziD = aziAInt + 3*Modelica.Constants.pi/2
    "Azimuth angle of face D";

  IDEAS.Buildings.Components.Interfaces.ZoneBus[nSurfExt] proBusExt(
    redeclare each final package Medium = Medium,
    each final use_port_1=sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    each final use_port_2=sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,
    each final numIncAndAziInBus=sim.numIncAndAziInBus,
    each final outputAngles=sim.outputAngles) if nSurfExt>0
    "Propsbus for connecting additional external surfaces" annotation (
      Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-210,50}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={-120,100})));

protected
  constant Real r = 287 "Gas constant";
  final parameter Modelica.SIunits.Angle aziAInt=
     if aziOpt==5
     then aziA
     else sim.aziOpts[aziOpt]
     "Internal azimuth angle";
  final parameter Integer nGainEmb = conTypFlo.nGain "Number of planes in which CCA or FH pipes are located"
    annotation(Dialog(tab="Floor", group="Floor heating / CCA"));
  IDEAS.Buildings.Components.BoundaryWall bouA(azi=aziAInt, inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypA.locGain,
      incLastLay=conTypA.incLastLay,
      mats=conTypA.mats),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_bou,
    A=AWallANet,
    redeclare package Medium = Medium) if
       hasBouA
    "Boundary wall for face A of this zone"
    annotation (Placement(transformation(extent={{-120,0},{-110,20}})));
  IDEAS.Buildings.Components.BoundaryWall bouB(
           inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypB.locGain,
      incLastLay=conTypB.incLastLay,
      mats=conTypB.mats),
    azi=aziB,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_bou,
    A=AWallBNet,
    redeclare package Medium = Medium) if
       hasBouB
    "Boundary wall for face A of this zone"
    annotation (Placement(transformation(extent={{-120,-20},{-110,0}})));
  IDEAS.Buildings.Components.BoundaryWall bouC(inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypC.locGain,
      incLastLay=conTypC.incLastLay,
      mats=conTypC.mats),
    azi=aziC,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_bou,
    A=AWallCNet,
    redeclare package Medium = Medium) if
       hasBouC
    "Boundary wall for face C of this zone"
    annotation (Placement(transformation(extent={{-120,-40},{-110,-20}})));
  IDEAS.Buildings.Components.BoundaryWall bouD(inc=IDEAS.Types.Tilt.Wall, azi=aziD,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypD.locGain,
      incLastLay=conTypD.incLastLay,
      mats=conTypD.mats),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_bou,
    A=AWallDNet,
    redeclare package Medium = Medium) if
       hasBouD
    "Boundary wall for face D of this zone"
    annotation (Placement(transformation(extent={{-120,-60},{-110,-40}})));
  IDEAS.Buildings.Components.BoundaryWall bouFlo(inc=IDEAS.Types.Tilt.Floor, azi=aziAInt,
    A=A,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypFlo.locGain,
      incLastLay=conTypFlo.incLastLay,
      mats=conTypFlo.mats),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_bou,
    redeclare package Medium = Medium) if
       hasBouFlo
    "Boundary wall for zone floor"
    annotation (Placement(transformation(extent={{-120,-80},{-110,-60}})));
  IDEAS.Buildings.Components.BoundaryWall bouCei(inc=IDEAS.Types.Tilt.Ceiling, azi=aziAInt,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypCei.locGain,
      incLastLay=conTypCei.incLastLay,
      mats=conTypCei.mats),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_bou,
    A=ACeiNet,
    redeclare package Medium = Medium) if
       hasBouCei
    "Boundary wall for zone ceiling"
    annotation (Placement(transformation(extent={{-120,-100},{-110,-80}})));
  IDEAS.Buildings.Components.OuterWall outA(azi=aziAInt, inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypA.locGain,
      incLastLay=conTypA.incLastLay,
      mats=conTypA.mats),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_out,
    redeclare package Medium = Medium,
    linExtCon=linExtCon,
    linExtRad=linExtRad,
    A=max(0,AWallANet),
    final hWal=h,
    final hasBuildingShade=hasBuildingShadeA,
    final L=LShaA,
    final dh=dhShaA) if
       hasOutA
    "Outer wall for face A of this zone"
    annotation (Placement(transformation(extent={{-140,0},{-130,20}})));
  IDEAS.Buildings.Components.OuterWall outB(
      inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypB.locGain,
      incLastLay=conTypB.incLastLay,
      mats=conTypB.mats),
    azi=aziB,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_out,
    redeclare package Medium = Medium,
    linExtCon=linExtCon,
    linExtRad=linExtRad,
    A=max(0,AWallBNet),
    final hasBuildingShade=hasBuildingShadeB,
    final L=LShaB,
    final dh=dhShaB,
    final hWal=h) if
       hasOutB
    "Outer wall for face B of this zone"
    annotation (Placement(transformation(extent={{-140,-20},{-130,0}})));
  IDEAS.Buildings.Components.OuterWall outC(inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypC.locGain,
      incLastLay=conTypC.incLastLay,
      mats=conTypC.mats),
    azi=aziC,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_out,
    redeclare package Medium = Medium,
    linExtCon=linExtCon,
    linExtRad=linExtRad,
    A=max(0,AWallCNet),
    final hasBuildingShade=hasBuildingShadeC,
    final L=LShaC,
    final dh=dhShaC,
    final hWal=h) if
       hasOutC
    "Outer wall for face C of this zone"
    annotation (Placement(transformation(extent={{-140,-40},{-130,-20}})));
  IDEAS.Buildings.Components.OuterWall outD(inc=IDEAS.Types.Tilt.Wall, azi=aziD,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypD.locGain,
      incLastLay=conTypD.incLastLay,
      mats=conTypD.mats),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_out,
    redeclare package Medium = Medium,
    linExtCon=linExtCon,
    linExtRad=linExtRad,
    A=max(0,AWallDNet),
    final hasBuildingShade=hasBuildingShadeD,
    final L=LShaD,
    final dh=dhShaD,
    final hWal=h) if
       hasOutD
    "Outer wall for face D of this zone"
    annotation (Placement(transformation(extent={{-140,-60},{-130,-40}})));
  IDEAS.Buildings.Components.OuterWall outCei(
    inc=IDEAS.Types.Tilt.Ceiling,
    azi=aziAInt,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypCei.locGain,
      incLastLay=conTypCei.incLastLay,
      mats=conTypCei.mats),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_out,
    redeclare package Medium = Medium,
    linExtCon=linExtCon,
    linExtRad=linExtRad,
    A=max(0,ACeiNet)) if
       hasOutCei
    "Outer wall for zone ceiling"
    annotation (Placement(transformation(extent={{-140,-100},{-130,-80}})));
  IDEAS.Buildings.Components.SlabOnGround slaOnGro(
    inc=IDEAS.Types.Tilt.Floor,
    azi=aziAInt,
    A=A,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypFlo.locGain,
      incLastLay=conTypFlo.incLastLay,
      mats=conTypFlo.mats),
    T_start=T_start,
    linIntCon_a=linIntCon,
    redeclare package Medium = Medium,
    TeAvg=TeAvg,
    TiAvg=TiAvg,
    dTeAvg=dTeAvg,
    dTiAvg=dTiAvg,
    dT_nominal_a=dT_nominal_sla,
    PWall=PWall) if
     bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround
    "Slab on ground model for zone floor."
    annotation (Placement(transformation(extent={{-160,-80},{-150,-60}})));
  IDEAS.Buildings.Components.InternalWall intA(azi=aziAInt, inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypA.locGain,
      mats=conTypA.mats,
      incLastLay=conTypA.incLastLay),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_intA,
    redeclare package Medium = Medium,
    linIntCon_b=linIntCon,
    dT_nominal_b=dT_nominal_intB,
    hasCavity=hasCavityA,
    h=hA,
    w=wA,
    g=g,
    p=p,
    rho=rho,
    c_p=c_p,
    T=T,
    dT=dT,
    A=lA*h - (if hasCavityA then hA*wA else 0)) if
    hasIntA
    "Internal wall for face A of this zone"
    annotation (Placement(transformation(extent={{-176,0},{-164,20}})));
  IDEAS.Buildings.Components.InternalWall intB(
           inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypB.locGain,
      incLastLay=conTypB.incLastLay,
      mats=conTypB.mats),
    azi=aziB,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_intA,
    redeclare package Medium = Medium,
    linIntCon_b=linIntCon,
    dT_nominal_b=dT_nominal_intB,
    g=g,
    p=p,
    rho=rho,
    c_p=c_p,
    T=T,
    dT=dT,
    hasCavity=hasCavityB,
    h=hB,
    w=wB,
    A=lB*h - (if hasCavityB then hB*wB else 0)) if
    hasIntB
    "Internal wall for face B of this zone"
    annotation (Placement(transformation(extent={{-176,-20},{-164,0}})));
  IDEAS.Buildings.Components.InternalWall intC(inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypC.locGain,
      incLastLay=conTypC.incLastLay,
      mats=conTypC.mats),
    azi=aziC,
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_intA,
    redeclare package Medium = Medium,
    linIntCon_b=linIntCon,
    dT_nominal_b=dT_nominal_intB,
    g=g,
    p=p,
    rho=rho,
    c_p=c_p,
    T=T,
    dT=dT,
    hasCavity=hasCavityC,
    h=hC,
    w=wC,
    A=lC*h - (if hasCavityC then hC*wC else 0)) if
    hasIntC
    "Internal wall for face C of this zone"
    annotation (Placement(transformation(extent={{-176,-40},{-164,-20}})));
  IDEAS.Buildings.Components.InternalWall intD(inc=IDEAS.Types.Tilt.Wall, azi=aziD,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypD.locGain,
      incLastLay=conTypD.incLastLay,
      mats=conTypD.mats),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_intA,
    redeclare package Medium = Medium,
    linIntCon_b=linIntCon,
    dT_nominal_b=dT_nominal_intB,
    g=g,
    p=p,
    rho=rho,
    c_p=c_p,
    T=T,
    dT=dT,
    hasCavity=hasCavityD,
    h=hD,
    w=wD,
    A=lD*h - (if hasCavityD then hD*wD else 0)) if
    hasIntD
    "Internal wall for face D of this zone"
    annotation (Placement(transformation(extent={{-176,-60},{-164,-40}})));
  IDEAS.Buildings.Components.InternalWall intFlo(
    inc=IDEAS.Types.Tilt.Floor,
    azi=aziAInt,
    A=A,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypFlo.locGain,
      incLastLay=conTypFlo.incLastLay,
      mats=conTypFlo.mats),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_intA,
    redeclare package Medium = Medium,
    linIntCon_b=linIntCon,
    dT_nominal_b=dT_nominal_intB) if
    hasIntFlo
    "Internal wall for zone floor"
    annotation (Placement(transformation(extent={{-176,-80},{-164,-60}})));

  IDEAS.Buildings.Components.InternalWall int(
    inc=IDEAS.Types.Tilt.Wall,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType(
      locGain=conTypInt.locGain,
      mats=conTypInt.mats,
      incLastLay=conTypInt.incLastLay),
    T_start=T_start,
    linIntCon_a=linIntCon,
    dT_nominal_a=dT_nominal_intA,
    redeclare package Medium = Medium,
    linIntCon_b=linIntCon,
    dT_nominal_b=dT_nominal_intA,
    azi=0,
    A=lInt*h,
    final hasCavity=false) if
    hasInt "Internal wall contained within the zone"
    annotation (Placement(transformation(extent={{-176,20},{-164,40}})));
public
  IDEAS.Buildings.Components.Interfaces.ZoneBus proBusA[nExtA](
    redeclare each final package Medium = Medium,
    each final numIncAndAziInBus=sim.numIncAndAziInBus,
    each final outputAngles=sim.outputAngles,
    each final use_port_1=sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    each final use_port_2=sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts) if
    bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall or
    bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
    "Propsbus connector for connecting to external surface or internalWall of face A"
    annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-188,10}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={-60,90})));

  IDEAS.Buildings.Components.Interfaces.ZoneBus proBusB[nExtB](
    redeclare each final package Medium = Medium,
    each final numIncAndAziInBus=sim.numIncAndAziInBus,
    each final outputAngles=sim.outputAngles,
    each final use_port_1=sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    each final use_port_2=sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts) if
    bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall or
    bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
    "Propsbus connector for connecting to external surface or internalWall of face B"
    annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-188,-10}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=90,
        origin={90,60})));

  IDEAS.Buildings.Components.Interfaces.ZoneBus proBusC[nExtC](
    redeclare each final package Medium = Medium,
    each final numIncAndAziInBus=sim.numIncAndAziInBus,
    each final outputAngles=sim.outputAngles,
    each final use_port_1=sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    each final use_port_2=sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts) if
    bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall or
    bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
    "Propsbus connector for connecting to external surface or internalWall of face C"
    annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-188,-30}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={68,-98})));

  IDEAS.Buildings.Components.Interfaces.ZoneBus proBusD[nExtD](
    redeclare each final package Medium = Medium,
    each final numIncAndAziInBus=sim.numIncAndAziInBus,
    each final outputAngles=sim.outputAngles,
    each final use_port_1=sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    each final use_port_2=sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts) if
    bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall or
    bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
    "Propsbus connector for connecting to external surface or internalWall of face D"
    annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-188,-50}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-96,-70})));

  IDEAS.Buildings.Components.Interfaces.ZoneBus proBusFlo[nExtFlo](
    redeclare each final package Medium = Medium,
    each final numIncAndAziInBus=sim.numIncAndAziInBus,
    each final outputAngles=sim.outputAngles,
    each final use_port_1=sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    each final use_port_2=sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts) if
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall or
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
    "Propsbus connector for connecting to external surface or internalWall of floor"
    annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-188,-70}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={0,-60})));

  IDEAS.Buildings.Components.Interfaces.ZoneBus proBusCei[nExtCei](
    redeclare each final package Medium = Medium,
    each final numIncAndAziInBus=sim.numIncAndAziInBus,
    each final outputAngles=sim.outputAngles,
    each final use_port_1=sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    each final use_port_2=sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts) if
    bouTypCei == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
    "Propsbus connector for connecting to external surface of ceiling: internal walls should be modelled as the floor of the zone above"
    annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-188,-90}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={-2,60})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b gainEmb[nGainEmb] if
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall or
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall or
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround
    "Floor node for embedded heat gain if case of floor heating or CCA."
    annotation (Placement(transformation(extent={{90,-100},{110,-80}})));
protected
  final parameter Boolean hasBouA=
    bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall;
  final parameter Boolean hasBouB=
    bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall;
  final parameter Boolean hasBouC=
    bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall;
  final parameter Boolean hasBouD=
    bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall;
  final parameter Boolean hasBouFlo=
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall;
  final parameter Boolean hasBouCei=
    bouTypCei == IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall;
  final parameter Boolean hasOutA=
    bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall;
  final parameter Boolean hasOutB=
    bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall;
  final parameter Boolean hasOutC=
    bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall;
  final parameter Boolean hasOutD=
    bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall;
  final parameter Boolean hasOutCei=
    bouTypCei == IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall;
  final parameter Boolean hasIntA=
    bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall;
  final parameter Boolean hasIntB=
    bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall;
  final parameter Boolean hasIntC=
    bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall;
  final parameter Boolean hasIntD=
    bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall;
  final parameter Boolean hasIntFlo=
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall;
  final parameter Boolean hasExtA=
    bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.External;
  final parameter Boolean hasExtB=
    bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.External;
  final parameter Boolean hasExtC=
    bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.External;
  final parameter Boolean hasExtD=
    bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.External;
  final parameter Boolean hasExtFlo=
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.External;
  final parameter Boolean hasExtCei=
    bouTypCei == IDEAS.Buildings.Components.Interfaces.BoundaryType.External;
  final parameter Boolean hasNoA=
    bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.None;
  final parameter Boolean hasNoB=
    bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.None;
  final parameter Boolean hasNoC=
    bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.None;
  final parameter Boolean hasNoD=
    bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.None;
  final parameter Boolean hasNoFlo=
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.None;
  final parameter Boolean hasNoCei=
    bouTypCei == IDEAS.Buildings.Components.Interfaces.BoundaryType.None;

  parameter Modelica.SIunits.Area AWallANet(fixed=false);
  parameter Modelica.SIunits.Area AWallBNet(fixed=false);
  parameter Modelica.SIunits.Area AWallCNet(fixed=false);
  parameter Modelica.SIunits.Area AWallDNet(fixed=false);
  parameter Modelica.SIunits.Area ACeiNet(fixed=false);

  final parameter Integer indWalA = if hasNoA then 0 else 1;
  final parameter Integer indWalA_end = indWalA + (if bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
                                    then nExtA - 1  else 0);
  final parameter Integer indWalB = indWalA_end + (if hasNoB then 0 else 1);
  final parameter Integer indWalB_end = indWalB+ (if bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
                                    then nExtB - 1  else 0);
  final parameter Integer indWalC = indWalB_end  + (if hasNoC then 0 else 1);
  final parameter Integer indWalC_end = indWalC + (if bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
                                    then nExtC - 1  else 0);
  final parameter Integer indWalD = indWalC_end  + (if hasNoD then 0 else 1);
  final parameter Integer indWalD_end = indWalD + (if bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
                                    then nExtD - 1  else 0);
  final parameter Integer indFlo = indWalD_end + (if hasNoFlo then 0 else 1);
  final parameter Integer indFlo_end = indFlo + (if bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
                                    then nExtFlo - 1  else 0);
  final parameter Integer indCei = indFlo_end  + (if hasNoCei then 0 else 1);
  final parameter Integer indCei_end = indCei + (if bouTypCei == IDEAS.Buildings.Components.Interfaces.BoundaryType.External
                                    then nExtCei - 1  else 0);
  final parameter Integer indIntZone_a = indCei_end + (if hasInt then 1 else 0);
  final parameter Integer indIntZone_b = indIntZone_a + (if hasInt then 1 else 0);
  final parameter Integer indWinA = indIntZone_b + (if hasWinA then 1 else 0);
  final parameter Integer indWinB = indWinA + (if hasWinB then 1 else 0);
  final parameter Integer indWinC = indWinB + (if hasWinC then 1 else 0);
  final parameter Integer indWinD = indWinC + (if hasWinD then 1 else 0);
  final parameter Integer indWinCei = indWinD + (if hasWinCei then 1 else 0);

initial equation
  assert(not bouTypA==IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    "The value for bouTypA is not supported");
  assert(not bouTypB==IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    "The value for bouTypB is not supported");
  assert(not bouTypC==IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    "The value for bouTypC is not supported");
  assert(not bouTypD==IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    "The value for bouTypD is not supported");
  assert(not bouTypCei==IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    "The value for bouTypCei is not supported");
  assert(not (bouTypCei==IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall),
              "Using internal walls for the ceiling is not allowed because it is considered bad practice. 
              Use instead the 'External'  connection to connect the the floor of the surface above, 
              or use this option to connect and internal wall externally.");
  assert(not (hasWinA and bouTypA == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall),
    "Combining an internal wall with an (exterior) window is not allowed since this is non-physical.");
  assert(not (hasWinB and bouTypB == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall),
    "Combining an internal wall with an (exterior) window is not allowed since this is non-physical.");
  assert(not (hasWinC and bouTypC == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall),
    "Combining an internal wall with an (exterior) window is not allowed since this is non-physical.");
  assert(not (hasWinD and bouTypD == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall),
    "Combining an internal wall with an (exterior) window is not allowed since this is non-physical.");
  assert(not (hasWinCei and bouTypCei == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall),
    "Combining an internal wall with an (exterior) window is not allowed since this is non-physical.");

  //assert that the cavity is not larger than the wall
  assert(not hasCavityA or (hA <= h and wA <=lA),
    "In " + getInstanceName() + ": The cavity dimensions of surface A exceed the zone dimensions. This is non-physical");
  assert(not hasCavityB or (hB <= h and wB <=lB),
    "In " + getInstanceName() + ": The cavity dimensions of surface B exceed the zone dimensions. This is non-physical");
  assert(not hasCavityC or (hC <= h and wC <=lC),
    "In " + getInstanceName() + ": The cavity dimensions of surface C exceed the zone dimensions. This is non-physical");
  assert(not hasCavityD or (hD <= h and wD <=lD),
    "In " + getInstanceName() + ": The cavity dimensions of surface D exceed the zone dimensions. This is non-physical");

  AWallANet = lA*h - (if hasWinA then  propsBusInt[indWinA].area else 0);
  AWallBNet = lB*h - (if hasWinB then  propsBusInt[indWinB].area else 0);
  AWallCNet = lC*h - (if hasWinC then  propsBusInt[indWinC].area else 0);
  AWallDNet = lD*h - (if hasWinD then  propsBusInt[indWinD].area else 0);
  ACeiNet = ACei - (if hasWinCei then  propsBusInt[indWinCei].area else 0);

  // assert that the windows are not bigger than the wall
  assert(AWallANet >= 0, "The net surface area of wall A is negative. This is not allowed.");
  assert(AWallBNet >= 0, "The net surface area of wall B is negative. This is not allowed.");
  assert(AWallDNet >= 0, "The net surface area of wall C is negative. This is not allowed.");
  assert(AWallDNet >= 0, "The net surface area of wall D is negative. This is not allowed.");
  assert(ACeiNet >= 0, "The net surface area of the ceiling is negative. This is not allowed.");

  if hasIntA then
    assert(nExtA == 1, "The parameter nExtA should be = 1 when internalWall type is chosen for surface A");
  end if;
  if hasIntB then
    assert(nExtB == 1, "The parameter nExtB should be = 1 when internalWall type is chosen for surface B");
  end if;
  if hasIntC then
    assert(nExtC == 1, "The parameter nExtC should be = 1 when internalWall type is chosen for surface C");
  end if;
  if hasIntD then
    assert(nExtD == 1, "The parameter nExtD should be = 1 when internalWall type is chosen for surface D");
  end if;
  if hasIntFlo then
    assert(nExtFlo == 1, "The parameter nExtFlo should be = 1 when internalWall type is chosen for Floor");
  end if;

  if hasWinCei then
    // note that w*l is the default value of ACei
    assert(abs(ACei-w*l) < 1e-6, "The overwrite parameter ACei should not be used when the roof has a window
                                  since then the window surface area cannot be factored in correctly.");
  end if;
equation
  connect(intA.propsBus_a, propsBusInt[indWalA]) annotation (Line(
      points={{-165,12},{-152,12},{-152,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(intB.propsBus_a, propsBusInt[indWalB]) annotation (Line(
      points={{-165,-8},{-152,-8},{-152,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(intC.propsBus_a, propsBusInt[indWalC]) annotation (Line(
      points={{-165,-28},{-152,-28},{-152,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(intD.propsBus_a, propsBusInt[indWalD]) annotation (Line(
      points={{-165,-48},{-152,-48},{-152,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(intFlo.propsBus_a, propsBusInt[indFlo]) annotation (Line(
      points={{-165,-68},{-152,-68},{-152,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(int.propsBus_a, propsBusInt[indIntZone_a]) annotation (Line(
      points={{-165,32},{-80,32},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(int.propsBus_b, propsBusInt[indIntZone_b]) annotation (Line(
      points={{-175,32},{-180,32},{-180,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(outA.propsBus_a, propsBusInt[indWalA]) annotation (Line(
      points={{-130.833,12},{-130.833,12},{-124,12},{-124,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(outB.propsBus_a, propsBusInt[indWalB]) annotation (Line(
      points={{-130.833,-8},{-124,-8},{-124,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(outC.propsBus_a, propsBusInt[indWalC]) annotation (Line(
      points={{-130.833,-28},{-124,-28},{-124,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(outD.propsBus_a, propsBusInt[indWalD]) annotation (Line(
      points={{-130.833,-48},{-124,-48},{-124,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(slaOnGro.propsBus_a, propsBusInt[indFlo]) annotation (Line(
      points={{-150.833,-68},{-150.833,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(outCei.propsBus_a, propsBusInt[indCei]) annotation (Line(
      points={{-130.833,-88},{-124,-88},{-124,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(bouA.propsBus_a, propsBusInt[indWalA]) annotation (Line(
      points={{-110.833,12},{-110.833,12},{-106,12},{-106,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(bouB.propsBus_a, propsBusInt[indWalB]) annotation (Line(
      points={{-110.833,-8},{-106,-8},{-106,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(bouC.propsBus_a, propsBusInt[indWalC]) annotation (Line(
      points={{-110.833,-28},{-106,-28},{-106,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(bouD.propsBus_a, propsBusInt[indWalD]) annotation (Line(
      points={{-110.833,-48},{-106,-48},{-106,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(bouFlo.propsBus_a, propsBusInt[indFlo]) annotation (Line(
      points={{-110.833,-68},{-106,-68},{-106,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(bouCei.propsBus_a, propsBusInt[indCei]) annotation (Line(
      points={{-110.833,-88},{-106,-88},{-106,-76},{-106,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
  connect(intA.propsBus_b, proBusA[1]) annotation (Line(
      points={{-175,12},{-188,12},{-188,10}},
      color={255,204,51},
      thickness=0.5));
  connect(intB.propsBus_b, proBusB[1]) annotation (Line(
      points={{-175,-8},{-188,-8},{-188,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(intC.propsBus_b, proBusC[1]) annotation (Line(
      points={{-175,-28},{-188,-28},{-188,-30}},
      color={255,204,51},
      thickness=0.5));
  connect(intD.propsBus_b, proBusD[1]) annotation (Line(
      points={{-175,-48},{-188,-48},{-188,-50}},
      color={255,204,51},
      thickness=0.5));
  connect(intFlo.propsBus_b, proBusFlo[1]) annotation (Line(
      points={{-175,-68},{-188,-68},{-188,-70}},
      color={255,204,51},
      thickness=0.5));
  if hasExtA then
    for i in indWalA:indWalA_end loop
    connect(proBusA[i-indWalA+1], propsBusInt[i]) annotation (Line(
      points={{-188,10},{-188,10},{-188,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
    end for;
  end if;
  if hasExtB then
    for i in indWalB:indWalB_end loop
    connect(proBusB[i-indWalB+1], propsBusInt[i]) annotation (Line(
      points={{-188,-10},{-188,-10},{-188,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
    end for;
  end if;
  if hasExtC then
    for i in indWalC:indWalC_end loop
    connect(proBusC[i-indWalC+1], propsBusInt[i]) annotation (Line(
      points={{-188,-30},{-188,-30},{-188,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
    end for;
  end if;
  if hasExtD then
    for i in indWalD:indWalD_end loop
    connect(proBusD[i-indWalD+1], propsBusInt[i]) annotation (Line(
      points={{-188,-50},{-188,-50},{-188,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
    end for;
  end if;
  if hasExtFlo then
    for i in indFlo:indFlo_end loop
    connect(proBusFlo[i-indFlo+1], propsBusInt[i]) annotation (Line(
      points={{-188,-70},{-188,-70},{-188,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
    end for;
  end if;
  if hasExtCei then
    for i in indCei:indCei_end loop
    connect(proBusCei[i-indCei+1], propsBusInt[i]) annotation (Line(
      points={{-188,-90},{-188,-90},{-188,40},{-80,40}},
      color={255,204,51},
      thickness=0.5));
    end for;
  end if;

  connect(propsBusInt[(indWinCei+1):(indWinCei+nSurfExt)], proBusExt[1:nSurfExt]) annotation (Line(
      points={{-80,40},{-82,40},{-82,54},{-82,50},{-210,50}},
      color={255,204,51},
      thickness=0.5));
  connect(intFlo.port_emb, gainEmb) annotation (Line(points={{-170,-80},{-170,-104},
          {100,-104},{100,-90}}, color={191,0,0}));
  connect(bouFlo.port_emb, gainEmb) annotation (Line(points={{-115,-80},{-88,-80},
          {-88,-104},{100,-104},{100,-90}}, color={191,0,0}));
  connect(slaOnGro.port_emb, gainEmb) annotation (Line(points={{-155,-80},{-156,
          -80},{-156,-104},{100,-104},{100,-90}}, color={191,0,0}));
    annotation(Dialog(tab="Floor", group="Floor heating / CCA", enable=
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall or
    bouTypFlo == IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall),
                  Icon(coordinateSystem(preserveAspectRatio=false, initialScale=0.1),
        graphics={
        Text(
          extent={{-60,-72},{-30,-38}},
          lineColor={28,108,200},
          textString="Flo"),
        Text(
          extent={{120,-14},{140,20}},
          lineColor={28,108,200},
          textString="B"),
        Text(
          extent={{-10,-122},{10,-94}},
          lineColor={28,108,200},
          textString="C"),
        Text(
          extent={{-122,-14},{-102,20}},
          lineColor={28,108,200},
          textString="D"),
        Text(
          extent={{18,44},{46,80}},
          lineColor={28,108,200},
          textString="Cei"),
        Text(
          extent={{-10,114},{10,148}},
          lineColor={28,108,200},
          textString="A")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},{100,100}}),
                    graphics={
        Text(
          extent={{-220,-60},{-200,-80}},
          lineColor={28,108,200},
          textString="Floor"),
        Text(
          extent={{-220,-80},{-200,-100}},
          lineColor={28,108,200},
          textString="Ceiling"),
        Text(
          extent={{-220,-40},{-200,-60}},
          lineColor={28,108,200},
          textString="D"),
        Text(
          extent={{-220,-20},{-200,-40}},
          lineColor={28,108,200},
          textString="C"),
        Text(
          extent={{-220,0},{-200,-20}},
          lineColor={28,108,200},
          textString="B"),
        Text(
          extent={{-220,20},{-200,0}},
          lineColor={28,108,200},
          textString="A")}),
    Documentation(info="<html>
<p>
This model can be used to set up
zones with a rectangular geometry more quickly.
This template consists of a zone, four walls, a horizontal roof and a floor
and five optional windows.
Additional surfaces may also be connected through external bus connector.
For the documentation of the zone parameters, see the documentation of 
<a href=\"modelica://IDEAS.Buildings.Components.Zone\">Zone</a>.
</p>
<h4>Main equations</h4>
<p>
This model incorporates IDEAS components such as
<a href=modelica://IDEAS.Buildings.Components.OuterWall>
IDEAS.Buildings.Components.OuterWall</a> and reproduces
the same results as a model that would be constructed without 
the use of this template.
</p>
<h4>Assumption and limitations</h4>
<p>
This model assumes that the zone has a rectangular
geometry with width <code>w</code>, length <code>l</code>
and height <code>h</code>.
All walls are vertical and perpendicular to each other and both the roof and
the floor are horizontal.
</p>
<p>
The surface area of each wall is calculated by default using
the parameters <code>h, w</code> and <code>l</code>. If you want to split a wall
and add external walls using the external bus connector, use the overwrite
length parameters <code>lA, lB, lC, lD</code> from the <code>Face</code> tabs
such that the surface area of the wall is correct. Also the ceiling or roof
surface area can be overwritten using the parameter <code>ACei</code>
from the <code>Ceiling</code> tab.
This way the user can overwrite the default ceiling surface area, 
e.g. to better approximate an inclinated roof.
Be also aware that the model
<code>slabOnGround</code> has a parameter <code>PWall</code> which specifies the
perimeter of slab on ground. The model cannot detect external walls connected
using the external bus connector. When splitting outer walls by using the external bus connector
you should update this parameter
manually using the parameter <code>PWall</code> from the <code>Advanced</code> tab.
</p>
<h4>Typical use and important parameters</h4>
<p>
Parameters width <code>w</code>, length <code>l</code>
and height <code>h</code> need to be defined
and are used to compute the dimensions of each of the surfaces.
Parameter <code>aziA</code> represents the azimuth angle
of surface A (see icon). Other surfaces are rotated (clockwise) by multiples
of ninety degrees with respect to <code>aziA</code>.
Parameter <code>nSurfExt</code> may be used
to connect additional surfaces to the template. 
When doing this, you may need to change the surface areas of
the surfaces in the template as these are not updated automatically.
</p>
<p>
Seven parameter tabs allow to specify further parameters
that are specific for each of the seven surfaces: six surfaces 
for the walls, floor and ceiling and one for an internal wall 
contained within the zone.
For each surface the surface type may be specified
using parameters <code>bouTyp*</code>.
The construction type should be defined
using <code>conTyp*</code>.
Parameter <code>hasWin*</code> may be used
for all orientations except for the floor to add
a window.
In this case the window surface area, shading and glazing 
types need to be provided.
For non-default shading a record needs to be created that specifies
the shading properties.
The surface area of the window is deducted from the surface area
of the wall such that the total surface areas add up.
</p>
<p>
The zone template also has a heat port for embedded heat gains
in the floor. This can be used when the floor has a floor heating
system or a concrete core activation system. Set then 
<code>hasEmb</code> from the tab Floor to <code>true</code> 
to get the <code>gaiEmb</code> heat port on the zone template.
Notice that the zone template does not have a heat port for embedded
gains in the ceiling. To model concrete core activation in the ceiling,
use an external surface.
</p>
<h4>Options</h4>
<p>
Advanced options are found under the <code>Advanced</code> 
parameter tab. 
The model may also be adapted further by
overriding the default parameter assignments in the template.
</p>
<p>
You can also use this model for non-rectangular zones by, for example,
using the <code>None</code> type for a wall and by adding additional walls
corresponding to a different geometry through
the external bus connector. 
This model however then does not guarantee that all parameters are consistent.
Therefore, some internal parameters of this model will need to be
updated manually.
</p>
<p>
In the parameter group <code>Windows</code>, you can redeclare the window. 
This is useful when using a window model that has a pre-configured surface area,
glazing type, frame fraction and shading. 
The parameters 
<code>azi=aziA</code>,
<code>inc=IDEAS.Types.Tilt.Wall</code>,
<code>T_start=T_start</code>,
<code>linIntCon_a=linIntCon</code>,
<code>dT_nominal_a=dT_nominal_win</code>,
<code>linExtCon=linExtCon</code>,
<code>windowDynamicsType=windowDynamicsType</code>,
<code>linExtRad=linExtRadWin</code>,
<code>nWin=nWinA</code>,
are still computed from the zone model parameters but, the
other windows parameters are those configured in the
used window model, including the window surface area.
</p>
<h4>Dynamics</h4>
<p>
This model contains wall dynamics
and a state for the zone air temperature.
The zone temperature may be set to steady state using
parameter <code>energyDynamicsAir</code>, which should
in general not be done.
The mass dynamics of the air volume
may be set to steady state by overriding the default parameter
assignment in the <code>airModel</code> submodel.
This removes small time constants
when the zone model is connected to an air flow circuit. 
</p>
<h4>Shading</h4>
<p>
In order to choose the shading of the glazing,
instead of selecting one shading type from the
dropdown menu, click on the
button right of the dropdown menu (edit). 
A menu will appear where the type of 
shading and corresponding parameters
have to be defined.
Alternatively, the shading template can be extended.
</p>
<h4>Validation</h4>
<p>
This implementation is compared with a manual implementation
in <a href=modelica://IDEAS.Buildings.Validation.Tests.ZoneTemplateVerification2>
IDEAS.Buildings.Validation.Tests.ZoneTemplateVerification2</a>.
This gives identical results.
</p>
<h4>Example</h4>
<p>
An example of how this template may be used
can be found in 
<a href=modelica://IDEAS.Examples.PPD12>IDEAS.Examples.PPD12</a>.
</p>
<h4>Implementation</h4>
<p>
Shading types need to be declared using a record instead of
by redeclaring the shading components.
This is a workaround because redeclared 
components cannot be propagated.
</p>
</html>", revisions="<html>
<ul>

<li>
August 10, 2020, by Filip Jorissen:<br/>
Modifications for supporting interzonal airflow.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1066\">
#1066</a>
</li>
<li>
October 13, 2019, by Filip Jorissen:<br/>
Refactored the parameter definition of <code>inc</code> 
and <code>azi</code> by adding the option to use radio buttons.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1067\">
#1067</a>
</li>
<li>
April 10, 2019, by Filip Jorissen:<br/>
Removed obsolete redeclaration.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1009\">#1009</a>.
</li>
<li>
August 29, 2018, by Damien Picard:<br/>
Add embedded heat port for floor heating or CCA.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/903\">#903</a>.
</li>
<li>
August 28, 2018, by Damien Picard:<br/>
Changes to allow multiple external surfaces connection per faces.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/901\">#901</a>.
</li>
<li>
August 26, 2018, by Damien Picard:<br/>
Move all equations except windows equations of
RectangularZoneTemplate to this interface model.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/891\">#891</a>.
</li>
<li>
August 16, 2018, by Damien Picard:<br/>
Make windows replaceable.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/891\">#891</a>.
And correct wall surface computation.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/890\">#890</a>. 
</li>
<li>
August 10, 2018, by Damien Picard:<br/>
Added parameters for scaling factors for windows.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/888\">#888</a>.
</li>
<li>
Adapted model to make it possible to remove walls from the template.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/880\">#880</a>.
</li>
<li>
June 13, 2018, by Filip Jorissen:<br/>
Added parameters for shade cast by external building.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/576\">#576</a>.
</li>
<li>
May 21, 2018, by Filip Jorissen:<br/>
Added parameters for air flow through cavity.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/822\">#822</a>.
</li>
<li>
April 30, 2018 by Iago Cupeiro:<br/>
Propagated boolean input connections for controlled shading.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/809\">#809</a>.
Shading documentation added.
</li>
<li>
July 26, 2017 by Filip Jorissen:<br/>
Added replaceable block that allows to define
the number of occupants.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
<li>
April 26, 2017, by Filip Jorissen:<br/>
Added asserts that check for illegal combinations of internal wall with exterior window.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/714>#714</a>.
</li>
<li>
March 21, 2017, by Filip Jorissen:<br/>
Changed bus parameters for JModelica compatibility.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/559>#559</a>.
Also removed obsolete each.
</li>
<li>
January 20, 2017 by Filip Jorissen:<br/>
Removed propagation of <code>nLay</code> and <code>nGain</code>
since this lead to warnings.
</li>
<li>
January 11, 2017 by Filip Jorissen:<br/>
Added documentation
</li>
<li>
January 10, 2017, by Filip Jorissen:<br/>
Added <code>linExtRadWin</code> for windows.
</li>
<li>
November 14, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end RectangularZoneTemplateInterface;
