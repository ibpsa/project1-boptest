within TwoZoneApartmentHydronic.Components.Rooms;
model DayZone "Milan day zone thermal zone istance"
  parameter Modelica.Units.SI.Angle S_=Buildings.Types.Azimuth.SE
    "Azimuth for south walls";
  parameter Modelica.Units.SI.Angle E_=Buildings.Types.Azimuth.NE
    "Azimuth for east walls";
  parameter Modelica.Units.SI.Angle W_=Buildings.Types.Azimuth.SW
    "Azimuth for west walls";
  parameter Modelica.Units.SI.Angle N_=Buildings.Types.Azimuth.NW
    "Azimuth for north walls";
  parameter Modelica.Units.SI.Angle C_=Buildings.Types.Tilt.Ceiling
    "Tilt for ceiling";
  parameter Modelica.Units.SI.Angle F_=Buildings.Types.Tilt.Floor
    "Tilt for floor";
  parameter Modelica.Units.SI.Angle Z_=Buildings.Types.Tilt.Wall
    "Tilt for wall";
 //   "Number of surface that are connected to constructions that are modeled inside the room";
  parameter Modelica.Units.SI.VolumeFlowRate AirChange=-48*2.7*0.5/3600
    "Infiltration rate";
  parameter Modelica.Units.SI.Area Afloor=22 "Floor area";
  extends thermalZone(
    nConBou=4,
    nSurBou=1,
    roo(
      datConExtWin(
        layers={matExtWal},
        A={5.3*2.7},
        glaSys={Wind600},
        wWin={1.6},
        hWin={2.35},
        fFra={0.001},
        til={Z_},
        azi={S_}),
      datConBou(
        layers={matRoof,matIntWall,matAptSep,matElevatorSep},
        A={Afloor,11.94,11.94,14.28},
        til={C_,Z_,Z_,Z_},
        azi={S_,W_,E_,N_},
        each stateAtSurface_a=false),
      surBou(
        A={Afloor},
        each absIR=0.9,
        each absSol=0.9,
        til={F_})));
  parameter BaseClasses.Data.Window24 Wind600
    annotation (Placement(transformation(extent={{40,84},{54,98}})));
  annotation (Documentation(revisions="<html>
<ul>
<li>
August 6, 2021, by Ettore Zanetti:<br/>
First implementation.
</li>
</ul>
</html>"),
       experiment(
      StartTime=-864000,
      StopTime=31536000,
      Interval=3600.00288,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-100},{120,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
end DayZone;
