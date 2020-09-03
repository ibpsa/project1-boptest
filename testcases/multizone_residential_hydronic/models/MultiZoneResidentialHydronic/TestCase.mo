within MultiZoneResidentialHydronic;
model TestCase "Multi zone residential hydronic example model"

  extends Modelica.Icons.Example;
  package MediumA = Buildings.Media.Air "Medium model";
  package MediumW = Buildings.Media.Water "Medium model";

  ///////////////
  //  ENTREES  //
  ///////////////
  parameter Modelica.SIunits.Area S = 100 "Building surface";
  parameter Real OpenDoors = 1 "Doors opening - 0=closed, 1 = open";

  // Boiler
  parameter Modelica.SIunits.Power Q_flow_nominal = 7000
    "Nominal power of heating plant" annotation(Dialog(group = "Boiler"));
  parameter Real scaFacRad = 1.5
    "Scaling factor to scale the power (and mass flow rate) of the radiator loop" annotation(Dialog(group = "Boiler"));
 parameter Modelica.SIunits.Temperature TSup_nominal=273.15 + 60
    "Nominal supply temperature for radiators";
 parameter Modelica.SIunits.Temperature TRet_nominal=273.15 + 50
    "Nominal return temperature for radiators";
  parameter Modelica.SIunits.Temperature dTBoi_nominal = TSup_nominal-TRet_nominal
    "Nominal temperature difference for boiler loop" annotation(Dialog(group = "Boiler"));
  parameter Modelica.SIunits.MassFlowRate mBoi_flow_nominal = scaFacRad*Q_flow_nominal/dTBoi_nominal/4200
    "Nominal mass flow rate of boiler loop" annotation(Dialog(group = "Boiler"));
  parameter Modelica.SIunits.Power P_Pompe_nominal = 45 "Pump electrical power" annotation(Dialog(group = "Boiler"));
 parameter Modelica.SIunits.Power Pmin_Ch = 800 "Boiler minimum power" annotation(Dialog(group = "Chauffage"));
 parameter Modelica.SIunits.Power Pmax_Ch = Q_flow_nominal "Boiler maximum power" annotation(Dialog(group = "Chauffage"));
 parameter Modelica.SIunits.Time t_anticourtcycle=600 "Anti short cycle duration for the boiler" annotation(Dialog(group="Cractristiques de la chaudire"));

  // Radiators
  parameter Real delta_ST_rad = 0 "Coefficient for spatial variation of the control system" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power P_rad_Salon = 1800 "Living room radiator power" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power P_rad_Chambre1 = 1000 "Room 1 radiator power" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power P_rad_Chambre2 = 900 "Room 2 radiator power2" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power P_rad_Chambre3 = 1100 "Room 3 radiator power" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power P_rad_SDB = 800 "Bathroom radiator power" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power P_rad_Couloir = 1000 "Hall radiator power" annotation(Dialog(group = "Radiators"));

  ///////////////
  //  OUTPUTS  //
  ///////////////

  // Heating production
//   Modelica.SIunits.Power Production_Radiateur_Salon "Heating production for the Living room radiator";
//   Modelica.SIunits.Power Production_Radiateur_Chambre1 "Heating production for the Room 1 room radiator";
//   Modelica.SIunits.Power Production_Radiateur_Chambre2 "Heating production for the Room 2 room radiator";
//   Modelica.SIunits.Power Production_Radiateur_Chambre3 "Heating production for the Room 3 room radiator";
//   Modelica.SIunits.Power Production_Radiateur_SDB "Heating production for the Bathroom radiator";
//   Modelica.SIunits.Power Production_Radiateur_Couloir "Heating production for the Hall radiator";

  // Consumption
//  Modelica.SIunits.Power Consommation_Gaz_Chaudiere "Boiler gas consumption";
  Modelica.SIunits.Power Consommation_Elec_Pompe "Boiler pump electricity consumption";

protected
  parameter Modelica.SIunits.Length HSP = 2.57 "Ceiling height";
  parameter Modelica.SIunits.Length H_Combles = 1.84 "Attic height";
  parameter Modelica.SIunits.ThermalConductivity k_PT = 9.7/42.8 "Thermal bridges coefficient";
  parameter Modelica.SIunits.Density d_air = 1.184 "Air density";
  parameter Modelica.SIunits.MassFlowRate Q_batiment = 113.4/3600*d_air "Global mechanical ventilation airflow";

  // ===================================================================== //
  // =================== DO NOT MODIFY  =================== //
  // ===================================================================== //

  // Spe - Surface parois extrieures (m^2)
  // Spi - Surface parois intrieures (m^2)
  // Spl - Surface plancher/plafond (m^2)
  // Sf - Surface des fentres (m^2)

  // Building reference floor surface
  parameter Modelica.SIunits.Area S_ref = 100
    "Buildign rerefence surface"; // used to scale up the actual building and take into account a bigger building surface

  // Garage
  parameter Modelica.SIunits.Area S_Garage = 20.52 * S/S_ref;
  parameter Modelica.SIunits.Area Spe_Garage_Nord = 3.8 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spe_Garage_Est = 5.4 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spe_Garage_Ouest = 0.7 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_Garage_Salon = 8.5 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spl_Garage_Combles = S_Garage;
  parameter Modelica.SIunits.Area Spl_Garage_exterieur = S_Garage;
  parameter Modelica.SIunits.MassFlowRate Q_Garage = 0.5*S_Garage*HSP/3600*d_air;

  // Living room
  parameter Modelica.SIunits.Area S_Salon = 30.32 * S/S_ref;
  parameter Modelica.SIunits.Length L_ext_Salon = (Spe_Salon_Nord+Spi_Salon_Garage+Spe_Salon_Est+Spe_Salon_Sud)/HSP;
  parameter Modelica.SIunits.Area Spe_Salon_Nord = 2.8 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spe_Salon_Est = 2.6 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spe_Salon_Sud = 6.6 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_Salon_Garage = Spi_Garage_Salon;
  parameter Modelica.SIunits.Area Spi_Salon_Chambre1 = 3.6 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_Salon_SDB = 2.7 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_Salon_Couloir = 1 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spl_Salon_Combles = S_Salon;
  parameter Modelica.SIunits.Area Spl_Salon_exterieur = S_Salon;
  parameter Modelica.SIunits.Area Sf_Salon_Nord = 3.65 * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Sf_Salon_Sud = 5.52 * sqrt(S/S_ref);
  parameter Modelica.SIunits.MassFlowRate Q_Salon = Q_batiment * S_Salon/(S_Salon+S_Chambre1+S_Chambre2+S_Chambre3);

  // Room 1
  parameter Modelica.SIunits.Area S_Chambre1 = 11.16 * S/S_ref;
  parameter Modelica.SIunits.Length L_ext_Chambre1 = Spe_Chambre1_Sud/HSP;
  parameter Modelica.SIunits.Area Spe_Chambre1_Sud = 3.1 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_Chambre1_Salon = Spi_Salon_Chambre1;
  parameter Modelica.SIunits.Area Spi_Chambre1_Couloir = 3.6 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_Chambre1_Chambre2 = 3.1 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spl_Chambre1_Combles = S_Chambre1;
  parameter Modelica.SIunits.Area Spl_Chambre1_exterieur = S_Chambre1;
  parameter Modelica.SIunits.Area Sf_Chambre1_Sud = 1.56 * sqrt(S/S_ref);
  parameter Modelica.SIunits.MassFlowRate Q_Chambre1 = Q_batiment * S_Chambre1/(S_Salon+S_Chambre1+S_Chambre2+S_Chambre3);

  // Room 2
  parameter Modelica.SIunits.Area S_Chambre2 = 9.85 * S/S_ref;
  parameter Modelica.SIunits.Length L_ext_Chambre2 = (Spe_Chambre2_Sud+Spe_Chambre2_Ouest)/HSP;
  parameter Modelica.SIunits.Area Spe_Chambre2_Sud = 3 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spe_Chambre2_Ouest = 3.1 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_Chambre2_Chambre1 = Spi_Chambre1_Chambre2;
  parameter Modelica.SIunits.Area Spi_Chambre2_Couloir = 3.5 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spl_Chambre2_Combles = S_Chambre2;
  parameter Modelica.SIunits.Area Spl_Chambre2_exterieur = S_Chambre2;
  parameter Modelica.SIunits.Area Sf_Chambre2_Sud = 1.56 * sqrt(S/S_ref);
  parameter Modelica.SIunits.MassFlowRate Q_Chambre2 = Q_batiment * S_Chambre2/(S_Salon+S_Chambre1+S_Chambre2+S_Chambre3);

  // Room 3
  parameter Modelica.SIunits.Area S_Chambre3 = 14.28 * S/S_ref;
  parameter Modelica.SIunits.Length L_ext_Chambre3 = (Spe_Chambre3_Ouest+Spe_Chambre3_Nord)/HSP;
  parameter Modelica.SIunits.Area Spe_Chambre3_Ouest = 3.4 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spe_Chambre3_Nord = 4.2 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_Chambre3_SDB = 3.4 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_Chambre3_Couloir = 4.2 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spl_Chambre3_Combles = S_Chambre3;
  parameter Modelica.SIunits.Area Spl_Chambre3_exterieur = S_Chambre3;
  parameter Modelica.SIunits.Area Sf_Chambre3_Nord = 1.56 * sqrt(S/S_ref);
  parameter Modelica.SIunits.MassFlowRate Q_Chambre3 = Q_batiment * S_Chambre3/(S_Salon+S_Chambre1+S_Chambre2+S_Chambre3);

  // Bathroom
  parameter Modelica.SIunits.Area S_SDB = 6.46 * S/S_ref;
  parameter Modelica.SIunits.Length L_ext_SDB = (Spe_SDB_Nord+Spe_SDB_Est)/HSP;
  parameter Modelica.SIunits.Area Spe_SDB_Nord = 1.9 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spe_SDB_Est = 0.7 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_SDB_Salon = Spi_Salon_SDB;
  parameter Modelica.SIunits.Area Spi_SDB_Couloir = 1.9 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_SDB_Chambre3 = Spi_Chambre3_SDB;
  parameter Modelica.SIunits.Area Spl_SDB_Combles = S_SDB;
  parameter Modelica.SIunits.Area Spl_SDB_exterieur = S_SDB;
  parameter Modelica.SIunits.Area Sf_SDB_Nord = 0.15 * sqrt(S/S_ref);

  // Hall
  parameter Modelica.SIunits.Area S_Couloir = 7.05 * S/S_ref;
  parameter Modelica.SIunits.Length L_ext_Couloir = Spe_Couloir_Ouest/HSP;
  parameter Modelica.SIunits.Area Spe_Couloir_Ouest = 1.5 * HSP * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spi_Couloir_Chambre1 = Spi_Chambre1_Couloir;
  parameter Modelica.SIunits.Area Spi_Couloir_Chambre2 = Spi_Chambre2_Couloir;
  parameter Modelica.SIunits.Area Spi_Couloir_Chambre3 = Spi_Chambre3_Couloir;
  parameter Modelica.SIunits.Area Spi_Couloir_SDB = Spi_SDB_Couloir;
  parameter Modelica.SIunits.Area Spi_Couloir_Salon = Spi_Salon_Couloir;
  parameter Modelica.SIunits.Area Spl_Couloir_Combles = S_Couloir;
  parameter Modelica.SIunits.Area Spl_Couloir_exterieur = S_Couloir;

  // Attic
  parameter Modelica.SIunits.Area S_Combles = 100 * S/S_ref;
  parameter Modelica.SIunits.Area Spe_Combles_exterieur_Nord = sqrt(H_Combles^2 + (8*sqrt(S/S_ref))^2)*(12.7*sqrt(S/S_ref));
  parameter Modelica.SIunits.Area Spl_Combles_Est = 8 * H_Combles/2 * sqrt(S/S_ref);
  parameter Modelica.SIunits.Area Spl_Combles_Ouest = Spl_Combles_Est;
  parameter Modelica.SIunits.Area Spe_Combles_exterieur_Sud = Spe_Combles_exterieur_Nord;
  parameter Modelica.SIunits.Area Spl_Combles_Garage = Spl_Garage_Combles;
  parameter Modelica.SIunits.Area Spl_Combles_Salon = Spl_Salon_Combles;
  parameter Modelica.SIunits.Area Spl_Combles_Chambre1 = Spl_Chambre1_Combles;
  parameter Modelica.SIunits.Area Spl_Combles_Chambre2 = Spl_Chambre2_Combles;
  parameter Modelica.SIunits.Area Spl_Combles_Chambre3 = Spl_Chambre3_Combles;
  parameter Modelica.SIunits.Area Spl_Combles_SDB = Spl_SDB_Combles;
  parameter Modelica.SIunits.Area Spl_Combles_Couloir = Spl_Couloir_Combles;
  parameter Modelica.SIunits.MassFlowRate Q_Combles = 0.5*S_Combles*H_Combles/2/3600*d_air;

  Modelica.Blocks.Sources.BooleanExpression boolean_ModeDHW(y=false)
    annotation (Placement(transformation(extent={{-190,-170},{-178,-154}})));
  Buildings.Controls.Continuous.OffTimer
           offHys
    annotation (Placement(transformation(extent={{-284,-124},{-274,-114}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       t_anticourtcycle)
    annotation (Placement(transformation(extent={{-268,-124},{-258,-114}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-250,-124},{-240,-114}})));
  Modelica.Blocks.Sources.RealExpression Cst1(y=0)
    annotation (Placement(transformation(extent={{-284,-144},{-270,-128}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.01)
    annotation (Placement(transformation(extent={{-300,-124},{-290,-114}})));
  Building.Control.ConHea regul_Chaudiere_Securite(Khea=1)
    annotation (Placement(transformation(extent={{-307,-186},{-294,-179}})));
  Modelica.Blocks.Sources.RealExpression SetSecurityBoiler(y=273.15 + 90)
    "Security temperature setpoint for the boiler"
    annotation (Placement(transformation(extent={{-328,-186},{-314,-170}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-238,-186},{-218,-166}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1
    annotation (Placement(transformation(extent={{-268,-188},{-256,-176}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1
    annotation (Placement(transformation(extent={{-286,-188},{-274,-176}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-234,-232},{-222,-220}})));
  Modelica.Blocks.Continuous.LimPID con_HeaModeBoiler(
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    yMax=1,
    yMin=Pmin_Ch/Pmax_Ch,
    Td=10,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=300)
    annotation (Placement(transformation(extent={{-272,-222},{-260,-210}})));
  Modelica.Blocks.Sources.RealExpression Consigne_regul_Chaudiere_Securite1(y=0)
    annotation (Placement(transformation(extent={{-260,-252},{-246,-236}})));
  Modelica.Blocks.Logical.OnOffController
                                       onOffController(bandwidth=0.5)
    annotation (Placement(transformation(extent={{-296,-242},{-276,-222}})));
public
  Buildings.ThermalZones.Detailed.MixedAir Garage(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=273.15 + 22,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    nPorts=2,
    intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Fixed,
    hIntFixed=7.7,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.Fixed,
    hExtFixed=25,
    nSurBou=1,
    AFlo=S_Garage,
    surBou(A={Spi_Garage_Salon}, til={Buildings.Types.Tilt.Wall}),
    nConExtWin=0,
    nConExt=3,
    datConExt(
      layers={ExtWall,ExtWall,ExtWall},
      A={Spe_Garage_Nord,Spe_Garage_Est,Spe_Garage_Ouest},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
    nConBou=2,
    datConBou(
      layers={IntWall,FloorWall},
      A={Spl_Garage_Combles,Spl_Garage_exterieur},
      til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Floor},
      stateAtSurface_a={true,false})) "Modle de la zone Garage"
    annotation (Placement(transformation(extent={{-138,-56},{-122,-40}})));

  Buildings.ThermalZones.Detailed.MixedAir Salon(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Fixed,
    hIntFixed=7.7,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.Fixed,
    hExtFixed=25,
    nConExtWin=2,
    datConExtWin(
      layers={ExtWall,ExtWall},
      A={Spe_Salon_Nord,Spe_Salon_Sud},
      glaSys={Window,Window},
      hWin={sqrt(Sf_Salon_Nord),sqrt(Sf_Salon_Sud)},
      wWin={sqrt(Sf_Salon_Nord),sqrt(Sf_Salon_Sud)},
      each fFra=0.1,
      each til=Buildings.Types.Tilt.Wall,
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.S}),
    AFlo=S_Salon,
    nSurBou=3,
    surBou(A={Spi_Salon_Chambre1,Spi_Salon_SDB,Spi_Salon_Couloir}, til={
          Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
    nPorts=4,
    nConExt=1,
    datConExt(
      layers={ExtWall},
      A={Spe_Salon_Est},
      til={Buildings.Types.Tilt.Wall}),
    nConBou=3,
    datConBou(
      layers={IntWall,ExtWall,FloorWall},
      A={Spl_Salon_Combles,Spi_Salon_Garage,Spl_Salon_exterieur},
      til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Floor},
      stateAtSurface_a={true,true,false}),
    T_start=273.15 + 19) "Modle de la zone Salon"
    annotation (Placement(transformation(extent={{-96,14},{-80,30}})));

  Buildings.ThermalZones.Detailed.MixedAir Chambre1(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    nPorts=3,
    intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Fixed,
    hIntFixed=7.7,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.Fixed,
    hExtFixed=25,
    nConExtWin=1,
    AFlo=S_Chambre1,
    datConExtWin(
      layers={ExtWall},
      A={Spe_Chambre1_Sud},
      glaSys={Window},
      hWin={sqrt(Sf_Chambre1_Sud)},
      wWin={sqrt(Sf_Chambre1_Sud)},
      each fFra=0.1,
      each til=Buildings.Types.Tilt.Wall,
      azi={Buildings.Types.Azimuth.S}),
    nSurBou=2,
    surBou(A={Spi_Chambre1_Couloir,Spi_Chambre1_Chambre2}, til={Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall}),
    nConExt=0,
    nConBou=3,
    datConBou(
      layers={IntWall,IntWall,FloorWall},
      A={Spl_Chambre1_Combles,Spi_Chambre1_Salon,Spl_Chambre1_exterieur},
      til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Floor},
      stateAtSurface_a={true,true,false}),
    T_start=273.15 + 19) "Modle de la zone Chambre1"
    annotation (Placement(transformation(extent={{-16,10},{0,26}})));

  Buildings.ThermalZones.Detailed.MixedAir Chambre2(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    nPorts=3,
    intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Fixed,
    hIntFixed=7.7,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.Fixed,
    hExtFixed=25,
    nConExtWin=1,
    nSurBou=1,
    datConExtWin(
      layers={ExtWall},
      A={Spe_Chambre2_Sud},
      glaSys={Window},
      hWin={sqrt(Sf_Chambre2_Sud)},
      wWin={sqrt(Sf_Chambre2_Sud)},
      each fFra=0.1,
      each til=Buildings.Types.Tilt.Wall,
      azi={Buildings.Types.Azimuth.S}),
    AFlo=S_Chambre2,
    surBou(A={Spi_Chambre2_Couloir}, til={Buildings.Types.Tilt.Wall}),
    nConExt=1,
    datConExt(
      layers={ExtWall},
      A={Spe_Chambre2_Ouest},
      til={Buildings.Types.Tilt.Wall}),
    nConBou=3,
    datConBou(
      layers={IntWall,IntWall,FloorWall},
      A={Spl_Chambre2_Combles,Spi_Chambre2_Chambre1,Spl_Chambre2_exterieur},
      til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Floor},
      stateAtSurface_a={true,true,false}),
    T_start=273.15 + 19) "Modle de la zone Chambre2"
    annotation (Placement(transformation(extent={{42,10},{58,26}})));

  Buildings.ThermalZones.Detailed.MixedAir Chambre3(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    nPorts=3,
    intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Fixed,
    hIntFixed=7.7,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.Fixed,
    hExtFixed=25,
    nConExtWin=1,
    AFlo=S_Chambre3,
    datConExtWin(
      layers={ExtWall},
      A={Spe_Chambre3_Nord},
      glaSys={Window},
      hWin={sqrt(Sf_Chambre3_Nord)},
      wWin={sqrt(Sf_Chambre3_Nord)},
      each fFra=0.1,
      each til=Buildings.Types.Tilt.Wall,
      azi={Buildings.Types.Azimuth.N}),
    nSurBou=2,
    surBou(A={Spi_Chambre3_SDB,Spi_Chambre3_Couloir}, til={Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall}),
    nConExt=1,
    datConExt(
      layers={ExtWall},
      A={Spe_Chambre3_Ouest},
      til={Buildings.Types.Tilt.Wall}),
    nConBou=2,
    datConBou(
      layers={IntWall,FloorWall},
      A={Spl_Chambre3_Combles,Spl_Chambre3_exterieur},
      til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Floor},
      stateAtSurface_a={true,false}),
    T_start=273.15 + 19) "Modle de la zone Chambre3"
    annotation (Placement(transformation(extent={{42,-62},{58,-46}})));

  Buildings.ThermalZones.Detailed.MixedAir SDB(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    nPorts=3,
    intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Fixed,
    hIntFixed=7.7,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.Fixed,
    hExtFixed=25,
    nConExtWin=1,
    datConExtWin(
      layers={ExtWall},
      A={Spe_SDB_Nord},
      glaSys={Window},
      hWin={sqrt(Sf_SDB_Nord)},
      wWin={sqrt(Sf_SDB_Nord)},
      each fFra=0.1,
      each til=Buildings.Types.Tilt.Wall,
      azi={Buildings.Types.Azimuth.N}),
    AFlo=S_SDB,
    nSurBou=1,
    surBou(A={Spi_SDB_Couloir}, til={Buildings.Types.Tilt.Wall}),
    nConExt=1,
    datConExt(
      layers={ExtWall},
      A={Spe_SDB_Est},
      til={Buildings.Types.Tilt.Wall}),
    nConBou=4,
    datConBou(
      layers={IntWall,IntWall,IntWall,FloorWall},
      A={Spl_SDB_Combles,Spi_SDB_Salon,Spi_SDB_Chambre3,Spl_SDB_exterieur},
      til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Floor},
      stateAtSurface_a={true,true,true,false}),
    T_start=273.15 + 19) "Modle de la zone SDB"
    annotation (Placement(transformation(extent={{-18,-62},{-2,-46}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_Salon
    "Temprature de la zone"
    annotation (Placement(transformation(extent={{-78,20},{-74,24}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_Garage
    "Temprature de la zone"
    annotation (Placement(transformation(extent={{-120,-50},{-116,-46}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_Chambre1
    "Temprature de la zone"
    annotation (Placement(transformation(extent={{2,16},{6,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_Chambre2
    "Temprature de la zone"
    annotation (Placement(transformation(extent={{60,16},{64,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_SDB
    "Temprature de la zone"
    annotation (Placement(transformation(extent={{0,-56},{4,-52}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_Chambre3
    "Temprature de la zone"
    annotation (Placement(transformation(extent={{60,-56},{64,-52}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(                           winSpe=
        5.25,
    winSpeSou=Buildings.BoundaryConditions.Types.DataSource.Parameter,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "Resources/FRA_Bordeaux.075100_IWEC.mos"))
    annotation (Placement(transformation(extent={{-296,46},{-276,66}})));
  Building.Schedules.Schedules_MI_ZoneJour schedules_MI_ZoneJour(delta_ST=
        delta_ST_rad)
    annotation (Placement(transformation(extent={{-372,-16},{-350,6}})));
  Building.Schedules.Schedules_MI_ZoneNuit schedules_MI_ZoneNuit(delta_ST=
        delta_ST_rad)
    annotation (Placement(transformation(extent={{-372,-54},{-350,-32}})));
  Building.Gains.Q_conv_3 q_conv_Jour
    annotation (Placement(transformation(extent={{-332,-4},{-320,6}})));
  Building.Gains.Q_rad_5 q_rad_Jour
    annotation (Placement(transformation(extent={{-332,-18},{-320,-8}})));
  Building.Gains.Q_conv_3 q_conv_Nuit
    annotation (Placement(transformation(extent={{-332,-42},{-320,-32}})));
  Building.Gains.Q_rad_5 q_rad_Nuit
    annotation (Placement(transformation(extent={{-332,-56},{-320,-46}})));
  Modelica.Blocks.Sources.Constant qCon_Garage(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-158,-48},{-154,-44}})));
  Modelica.Blocks.Sources.Constant qRad_Garage(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-158,-42},{-154,-38}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_Garage
    annotation (Placement(transformation(extent={{-148,-48},{-144,-44}})));
  Modelica.Blocks.Sources.Constant qLat_Garage(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-158,-54},{-154,-50}})));
  Modelica.Blocks.Sources.Constant qCon_SDB(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-38,-54},{-34,-50}})));
  Modelica.Blocks.Sources.Constant qRad_SDB(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-38,-48},{-34,-44}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_SDB
    annotation (Placement(transformation(extent={{-28,-54},{-24,-50}})));
  Modelica.Blocks.Sources.Constant qLat_SDB(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-38,-60},{-34,-56}})));
  Modelica.Blocks.Sources.Constant qLat_Chambre1(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-34,12},{-30,16}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_Chambre1
    annotation (Placement(transformation(extent={{-24,18},{-20,22}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=q_rad_Nuit.Q_rad)
    annotation (Placement(transformation(extent={{-36,20},{-30,26}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=q_conv_Nuit.Q_conv)
    annotation (Placement(transformation(extent={{-36,16},{-30,22}})));
  Modelica.Blocks.Sources.Constant qLat_Chambre2(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{24,12},{28,16}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_Chambre2
    annotation (Placement(transformation(extent={{34,18},{38,22}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=q_rad_Nuit.Q_rad)
    annotation (Placement(transformation(extent={{22,20},{28,26}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=q_conv_Nuit.Q_conv)
    annotation (Placement(transformation(extent={{22,16},{28,22}})));
  Modelica.Blocks.Sources.Constant qLat_Chambre3(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{24,-60},{28,-56}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_Chambre3
    annotation (Placement(transformation(extent={{34,-54},{38,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=q_rad_Nuit.Q_rad)
    annotation (Placement(transformation(extent={{22,-52},{28,-46}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=q_conv_Nuit.Q_conv)
    annotation (Placement(transformation(extent={{22,-56},{28,-50}})));
  Modelica.Blocks.Sources.Constant qLat_Chambre4(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-116,16},{-112,20}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_Chambre4
    annotation (Placement(transformation(extent={{-106,22},{-102,26}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=q_rad_Jour.Q_rad)
    annotation (Placement(transformation(extent={{-118,24},{-112,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=q_conv_Jour.Q_conv)
    annotation (Placement(transformation(extent={{-118,20},{-112,26}})));
  Modelica.Blocks.Sources.Constant uSha_Salon(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-114,34},{-110,38}})));
  Modelica.Blocks.Routing.Replicator replicator_Salon(nout=max(1, 2))
    annotation (Placement(transformation(extent={{-106,34},{-102,38}})));
  Modelica.Blocks.Sources.Constant uSha_Chambre1(
                                                k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-34,30},{-30,34}})));
  Modelica.Blocks.Routing.Replicator replicator_Chambre1(nout=max(1, 1))
    annotation (Placement(transformation(extent={{-26,30},{-22,34}})));
  Modelica.Blocks.Sources.Constant uSha_Chambre2(
                                                k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{26,28},{30,32}})));
  Modelica.Blocks.Routing.Replicator replicator_Chambre2(nout=max(1, 1))
    annotation (Placement(transformation(extent={{32,28},{36,32}})));
  Modelica.Blocks.Sources.Constant uSha_SDB(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-34,-40},{-30,-36}})));
  Modelica.Blocks.Routing.Replicator replicator_SDB(nout=max(1, 1))
    annotation (Placement(transformation(extent={{-28,-40},{-24,-36}})));
  Modelica.Blocks.Sources.Constant uSha_Chambre3(
                                                k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{26,-44},{30,-40}})));
  Modelica.Blocks.Routing.Replicator replicator_Chambre3(nout=max(1, 1))
    annotation (Placement(transformation(extent={{32,-44},{36,-40}})));
public
  Buildings.ThermalZones.Detailed.MixedAir Couloir(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    nPorts=10,
    intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Fixed,
    hIntFixed=7.7,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.Fixed,
    hExtFixed=25,
    nConExtWin=0,
    nSurBou=0,
    AFlo=S_Couloir,
    nConExt=1,
    datConExt(
      layers={ExtWall},
      A={Spe_Couloir_Ouest},
      til={Buildings.Types.Tilt.Wall}),
    nConBou=7,
    datConBou(
      layers={IntWall,IntWall,IntWall,IntWall,IntWall,IntWall,FloorWall},
      A={Spl_Couloir_Combles,Spi_Couloir_Chambre1,Spi_Couloir_Chambre2,
          Spi_Couloir_Chambre3,Spi_Couloir_SDB,Spi_Couloir_Salon,
          Spl_Couloir_exterieur},
      til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Floor},
      stateAtSurface_a={true,true,true,true,true,true,false}),
    T_start=273.15 + 19) "Modle de la zone Couloir"
    annotation (Placement(transformation(extent={{44,-18},{60,-2}})));
  Modelica.Blocks.Sources.Constant qCon_Couloir(
                                               k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{0,-12},{2,-10}})));
  Modelica.Blocks.Sources.Constant qRad_Couloir(
                                               k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{4,-10},{6,-8}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_Couloir
    annotation (Placement(transformation(extent={{10,-14},{14,-10}})));
  Modelica.Blocks.Sources.Constant qLat_Couloir(
                                               k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{4,-14},{6,-12}})));
  Buildings.ThermalZones.Detailed.MixedAir Combles(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    lat=weaDat.lat,
    nPorts=2,
    intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Fixed,
    hIntFixed=7.7,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.Fixed,
    hExtFixed=25,
    nConExt=4,
    nConExtWin=0,
    nConBou=0,
    nSurBou=7,
    AFlo=S_Combles,
    hRoo=H_Combles/2,
    surBou(A={Spl_Combles_Garage,Spl_Combles_Salon,Spl_Combles_Chambre1,
          Spl_Combles_Chambre2,Spl_Combles_Chambre3,Spl_Combles_SDB,
          Spl_Combles_Couloir}, til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Ceiling,
          Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Ceiling,
          Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Ceiling}),
    datConExt(
      layers={CeilingWall,ExtWall,CeilingWall,ExtWall},
      A={Spe_Combles_exterieur_Nord,Spl_Combles_Est,Spl_Combles_Ouest,
          Spe_Combles_exterieur_Sud},
      til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Floor,
          Buildings.Types.Tilt.Ceiling},
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W,
          Buildings.Types.Azimuth.S}),
    T_start=273.15 + 19) "Modle de la zone Combles"
    annotation (Placement(transformation(extent={{-228,-18},{-212,-2}})));
  Modelica.Blocks.Sources.Constant qCon_Combles(
                                               k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-254,-10},{-250,-6}})));
  Modelica.Blocks.Sources.Constant qRad_Combles(
                                               k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-254,-4},{-250,0}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_Combles
    annotation (Placement(transformation(extent={{-244,-10},{-240,-6}})));
  Modelica.Blocks.Sources.Constant qLat_Combles(
                                               k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-254,-16},{-250,-12}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor con_Salon(G=
        L_ext_Salon*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{-92,34},{-86,40}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature prescribedText
    annotation (Placement(transformation(extent={{-148,60},{-142,66}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-166,64},{-154,76}}), iconTransformation(extent=
           {{-236,54},{-216,74}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor con_Chambre1(G=
        L_ext_Chambre1*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{-12,30},{-6,36}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor con_Chambre2(G=
        L_ext_Chambre2*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{46,30},{52,36}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor con_Chambre3(G=
        L_ext_Chambre3*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{44,-42},{50,-36}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor con_SDB(G=L_ext_SDB*
        k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{-14,-42},{-8,-36}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor con_Couloir(G=
        L_ext_Couloir*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{70,-8},{64,-2}})));
  Building.Ventilation.Ventil_4bis ventil_Garage(Q=Q_Garage)
    annotation (Placement(transformation(extent={{-144,-54},{-140,-50}})));
  Building.Ventilation.Ventil_4 ventil_Chambre1(Q=Q_Chambre1)
    annotation (Placement(transformation(extent={{-22,12},{-16,16}})));
  Building.Ventilation.Ventil_5bis ventil_Salon(Q=Q_Salon + 0.2*(Q_Chambre1 +
        Q_Chambre2 + Q_Chambre3)*OpenDoors)
    annotation (Placement(transformation(extent={{-104,16},{-98,20}})));
  Building.Ventilation.Ventil_4 ventil_Chambre2(Q=Q_Chambre2)
    annotation (Placement(transformation(extent={{36,12},{42,16}})));
  Building.Ventilation.Ventil_4 ventil_Chambre3(Q=Q_Chambre3)
    annotation (Placement(transformation(extent={{36,-60},{42,-56}})));
  Building.Ventilation.Ventil_4bis ventil_Combles(Q=Q_Combles)
    annotation (Placement(transformation(extent={{-236,-16},{-232,-12}})));
  Buildings.Airflow.Multizone.DoorDiscretizedOperable dooOpeClo_Salon(
    LClo=20*1E-4,
    hA=3/2,
    hB=3/2,
    CDOpe=0.78,
    nCom=10,
    redeclare package Medium = MediumA,
    CDClo=0.78,
    show_T=true,
    wOpe=0.8,
    hOpe=2,
    dp_turbulent=0.1) "Discretized door"
    annotation (Placement(transformation(extent={{-45,-15},{-36,-6}})));
  Buildings.Airflow.Multizone.DoorDiscretizedOperable dooOpeClo_Chambre1(
    LClo=20*1E-4,
    hA=3/2,
    hB=3/2,
    CDOpe=0.78,
    CDClo=0.78,
    nCom=10,
    redeclare package Medium = MediumA,
    show_T=true,
    wOpe=0.8,
    hOpe=2,
    dp_turbulent=0.1) "Discretized door" annotation (Placement(transformation(
        extent={{-4.5,-4.5},{4.5,4.5}},
        rotation=270,
        origin={-10.5,-2.5})));
  Buildings.Airflow.Multizone.DoorDiscretizedOperable dooOpeClo_Chambre2(
    LClo=20*1E-4,
    hA=3/2,
    hB=3/2,
    CDOpe=0.78,
    CDClo=0.78,
    nCom=10,
    redeclare package Medium = MediumA,
    show_T=true,
    wOpe=0.8,
    hOpe=2,
    dp_turbulent=0.1) "Discretized door" annotation (Placement(transformation(
        extent={{-4.5,-4.5},{4.5,4.5}},
        rotation=270,
        origin={27.5,-2.5})));
  Buildings.Airflow.Multizone.DoorDiscretizedOperable dooOpeClo_SDB(
    LClo=20*1E-4,
    hA=3/2,
    hB=3/2,
    CDOpe=0.78,
    CDClo=0.78,
    nCom=10,
    redeclare package Medium = MediumA,
    show_T=true,
    wOpe=0.8,
    hOpe=2,
    dp_turbulent=0.1) "Discretized door" annotation (Placement(transformation(
        extent={{-4.5,-4.5},{4.5,4.5}},
        rotation=90,
        origin={-10.5,-18.5})));
  Buildings.Airflow.Multizone.DoorDiscretizedOperable dooOpeClo_Chambre3(
    LClo=20*1E-4,
    hA=3/2,
    hB=3/2,
    CDOpe=0.78,
    CDClo=0.78,
    nCom=10,
    redeclare package Medium = MediumA,
    show_T=true,
    wOpe=0.8,
    hOpe=2,
    dp_turbulent=0.1) "Discretized door" annotation (Placement(transformation(
        extent={{-4.5,-4.5},{4.5,4.5}},
        rotation=90,
        origin={29.5,-18.5})));
  Modelica.Blocks.Sources.RealExpression realExpression11(y=OpenDoors)
    annotation (Placement(transformation(extent={{-58,-14},{-54,-8}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_Couloir
    "Temprature de la zone"
    annotation (Placement(transformation(extent={{62,-14},{66,-10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_Combles
    "Temprature de la zone"
    annotation (Placement(transformation(extent={{-210,-12},{-206,-8}})));
  Building.Control.Regul_Clim_1 regul_Chambre1
    annotation (Placement(transformation(extent={{10,14},{18,18}})));
  Building.Control.Regul_Clim_1 regul_Chambre2
    annotation (Placement(transformation(extent={{66,10},{76,16}})));
  Building.Control.Regul_Clim_1 regul_Chambre3
    annotation (Placement(transformation(extent={{66,-46},{76,-40}})));
  Building.Control.Regul_Clim_1 regul_SDB
    annotation (Placement(transformation(extent={{6,-48},{16,-42}})));
  Modelica.Blocks.Sources.Sine temSoil(
    amplitude=2,
    offset=15 + 273.15,
    freqHz=1/(8760*3600),
    phase=0) annotation (Placement(transformation(extent={{24,82},{34,92}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature T_sol
    annotation (Placement(transformation(extent={{40,84},{46,90}})));
  Building.Ventilation.Ventil_5 ventil_SDB(Q=0.8*(Q_Chambre1 + Q_Chambre2 +
        Q_Chambre3)*OpenDoors + 0.001)
    annotation (Placement(transformation(extent={{-30,-64},{-20,-56}})));
  Building.Control.Regul_Clim_1 regul_Salon
    annotation (Placement(transformation(extent={{-66,18},{-56,24}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic CeilingWall(final
      nLay=1, material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.20,
        k=0.04,
        c=1032,
        d=32)})
    annotation (Placement(transformation(extent={{-300,82},{-288,94}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic IntWall(nLay=3,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.013,
        k=0.4,
        c=1000,
        d=800),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.10,
        k=0.667,
        c=1002.737,
        d=1.2),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.013,
        k=0.4,
        c=1000,
        d=800)}) "Murs intrieurs"
    annotation (Placement(transformation(extent={{-348,82},{-336,94}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic FloorWall(final
      nLay=2, material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.15,
        k=0.92,
        c=880,
        d=2200),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.06,
        k=0.022,
        c=1000,
        d=30)})
    annotation (Placement(transformation(extent={{-316,82},{-304,94}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic ExtWall(final
      nLay=2, material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.2,
        k=0.2,
        c=1000,
        d=782),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.08,
        k=0.032,
        c=1450,
        d=17)}) "Murs extrieurs"
    annotation (Placement(transformation(extent={{-332,82},{-320,94}})));
  parameter Buildings.HeatTransfer.Data.GlazingSystems.Generic Window(
    UFra=1.4,
    glass={Buildings.HeatTransfer.Data.Glasses.ID102(),
        Buildings.HeatTransfer.Data.Glasses.ID102()},
    gas={Buildings.HeatTransfer.Data.Gases.Air(x=0.0127)})
    annotation (Placement(transformation(extent={{-282,82},{-270,94}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=
        schedules_MI_ZoneNuit.CooSetRT12)
    annotation (Placement(transformation(extent={{2,10},{6,14}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=
        schedules_MI_ZoneNuit.CooSetRT12)
    annotation (Placement(transformation(extent={{60,8},{64,12}})));
  Modelica.Blocks.Sources.RealExpression realExpression12(y=
        schedules_MI_ZoneNuit.CooSetRT12)
    annotation (Placement(transformation(extent={{58,-50},{62,-46}})));
  Modelica.Blocks.Sources.RealExpression realExpression14(y=
        schedules_MI_ZoneNuit.CooSetRT12)
    annotation (Placement(transformation(extent={{-2,-48},{2,-44}})));
  Modelica.Blocks.Sources.RealExpression realExpression17(y=
        schedules_MI_ZoneJour.CooSetRT12)
    annotation (Placement(transformation(extent={{-78,14},{-74,18}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_Chambre1(
    redeclare package Medium = MediumW,
    Q_flow_nominal=P_rad_Chambre1,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{-22,-130},{-8,-116}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val_Chambre1(
    redeclare package Medium = MediumW,
    dpValve_nominal=1e-3,
    m_flow_nominal=mBoi_flow_nominal,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-6,-118},{4,-128}})));
  Building.Control.ConHeaZon conHeaRo1(Khea=1, Ti=300,
    zone="Ro1")
    annotation (Placement(transformation(extent={{-12,-144},{-2,-138}})));
  Modelica.Blocks.Sources.RealExpression realExpression19(
                                                         y=T_Chambre1.T)
    annotation (Placement(transformation(extent={{-24,-146},{-18,-140}})));
  Modelica.Blocks.Sources.RealExpression realExpression20(
                                                         y=
        schedules_RT2012_MI.HeaSetRT12 + delta_ST_rad)
    annotation (Placement(transformation(extent={{-24,-142},{-18,-136}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_Chambre2(
    redeclare package Medium = MediumW,
    Q_flow_nominal=P_rad_Chambre2,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{36,-130},{50,-116}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val_Chambre2(
    redeclare package Medium = MediumW,
    dpValve_nominal=1e-3,
    m_flow_nominal=mBoi_flow_nominal,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{52,-118},{62,-128}})));
  Building.Control.ConHeaZon conHeaRo2(Khea=1, Ti=300,
    zone="Ro2")
    annotation (Placement(transformation(extent={{44,-144},{54,-138}})));
  Modelica.Blocks.Sources.RealExpression realExpression21(y=T_Chambre2.T)
    annotation (Placement(transformation(extent={{32,-146},{38,-140}})));
  Modelica.Blocks.Sources.RealExpression realExpression22(y=
        schedules_RT2012_MI.HeaSetRT12 + delta_ST_rad)
    annotation (Placement(transformation(extent={{32,-142},{38,-136}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_Chambre3(
    redeclare package Medium = MediumW,
    Q_flow_nominal=P_rad_Chambre3,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{38,-210},{52,-196}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val_Chambre3(
    redeclare package Medium = MediumW,
    dpValve_nominal=1e-3,
    m_flow_nominal=mBoi_flow_nominal,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{54,-198},{64,-208}})));
  Building.Control.ConHeaZon conHeaRo3(Khea=1, Ti=300,
    zone="Ro3")
    annotation (Placement(transformation(extent={{46,-226},{56,-220}})));
  Modelica.Blocks.Sources.RealExpression realExpression23(y=T_Chambre3.T)
    annotation (Placement(transformation(extent={{34,-228},{40,-222}})));
  Modelica.Blocks.Sources.RealExpression realExpression24(y=
        schedules_RT2012_MI.HeaSetRT12 + delta_ST_rad)
    annotation (Placement(transformation(extent={{34,-224},{40,-218}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_SDB(
    redeclare package Medium = MediumW,
    Q_flow_nominal=P_rad_SDB,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{-16,-210},{-2,-196}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val_SDB(
    redeclare package Medium = MediumW,
    dpValve_nominal=1e-3,
    m_flow_nominal=mBoi_flow_nominal,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{4,-198},{14,-208}})));
  Building.Control.ConHeaZon conHeaBth(Khea=1, Ti=300,
    zone="Bth")
    annotation (Placement(transformation(extent={{-12,-222},{-2,-216}})));
  Modelica.Blocks.Sources.RealExpression realExpression25(y=T_SDB.T)
    annotation (Placement(transformation(extent={{-26,-224},{-20,-218}})));
  Modelica.Blocks.Sources.RealExpression realExpression26(y=
        schedules_RT2012_MI.HeaSetRT12 + delta_ST_rad)
    annotation (Placement(transformation(extent={{-26,-220},{-20,-214}})));
  Buildings.Fluid.FixedResistances.Junction inSplVal2(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,-1,-1},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving)
                        "Flow splitter" annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-31,-123})));
  Buildings.Fluid.FixedResistances.Junction inSplVal3(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,-1,-1},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving)
                        "Flow splitter" annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={29,-123})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_Couloir(
    redeclare package Medium = MediumW,
    Q_flow_nominal=300,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{10,-176},{24,-162}})));
  Buildings.Fluid.FixedResistances.Junction inSplVal4(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,-1,-1},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving)
                        "Flow splitter" annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-11,-169})));
  Buildings.Fluid.FixedResistances.Junction inSplVal5(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,-1,-1},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving)
                        "Flow splitter" annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={29,-203})));
  Buildings.Fluid.FixedResistances.Junction outSplVal2(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,1,-1},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering)
                        "Flow splitter" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={11,-123})));
  Buildings.Fluid.FixedResistances.Junction outSplVal3(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,1,-1},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering)
                        "Flow splitter" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={69,-123})));
  Buildings.Fluid.FixedResistances.Junction outSplVal4(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,1,-1},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering)
                        "Flow splitter" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={33,-169})));
  Buildings.Fluid.FixedResistances.Junction outSplVal5(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,1,-1},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering)
                        "Flow splitter" annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={71,-203})));
  Buildings.Fluid.FixedResistances.PressureDrop       res(
    redeclare package Medium = MediumW,
    dp_nominal=1e-3,
    m_flow_nominal=mBoi_flow_nominal)
    annotation (Placement(transformation(extent={{-2,-174},{6,-164}})));
  Modelica.Blocks.Sources.RealExpression realExpression30(
                                                         y=
        schedules_RT2012_MI.HeaSetRT12 + delta_ST_rad)
    annotation (Placement(transformation(extent={{-84,-136},{-78,-130}})));
  Modelica.Blocks.Sources.RealExpression realExpression31(y=T_Salon.T)
    annotation (Placement(transformation(extent={{-84,-140},{-78,-134}})));
  Building.Control.ConHeaZon conHeaSal(Khea=1, Ti=300,
    zone="Sal")
    annotation (Placement(transformation(extent={{-74,-138},{-64,-132}})));
  Buildings.Fluid.FixedResistances.Junction inSplVal1(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,-1,-1},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving)
                        "Flow splitter" annotation (Placement(
        transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-85,-119})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_Salon(
    redeclare package Medium = MediumW,
    Q_flow_nominal=P_rad_Salon,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{-80,-126},{-66,-112}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear          val_Salon(
    redeclare package Medium = MediumW,
    dpValve_nominal=1e-3,
    m_flow_nominal=mBoi_flow_nominal,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-64,-114},{-54,-124}})));
  Buildings.Fluid.FixedResistances.Junction outSplVal1(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,1,-1},
    from_dp=false,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering)
                        "Flow splitter" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-47,-119})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor
    heatFlowSensor_Salon_Conv annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-76,-100})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor_Salon_Rad
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-70,-100})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor
    heatFlowSensor_Chambre1_Rad annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-10,-100})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor
    heatFlowSensor_Chambre1_Conv annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-16,-100})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor
    heatFlowSensor_Chambre2_Conv annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={40,-100})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor
    heatFlowSensor_Chambre2_Rad annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={46,-100})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor
    heatFlowSensor_Couloir_Conv annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={14,-100})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor
    heatFlowSensor_Couloir_Rad annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={20,-100})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor_SDB_Rad
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-6,-190})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor_SDB_Conv
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-12,-190})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor
    heatFlowSensor_Chambre3_Rad annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={48,-190})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor
    heatFlowSensor_Chambre3_Conv annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={42,-190})));
  Building.Schedules.Schedules_RT2012_MI schedules_RT2012_MI
    annotation (Placement(transformation(extent={{-372,20},{-352,42}})));
  Building.Control.Regul_Clim_1 regul_Couloir
    annotation (Placement(transformation(extent={{68,-16},{78,-10}})));
  Modelica.Blocks.Sources.RealExpression realExpression8( y=
        schedules_MI_ZoneNuit.CooSetRT12)
    annotation (Placement(transformation(extent={{62,-18},{66,-14}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-258,82},{-244,96}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temSup(
    redeclare package Medium = MediumW,
    m_flow_nominal=mBoi_flow_nominal,
    T_start=TSup_nominal) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-99,-139})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear                val_chaudiere(
    redeclare package Medium = MediumW,
    dpValve_nominal=1e-3,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=mBoi_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=false,
    use_inputFilter=false)
                          annotation (Placement(transformation(extent={{-118,
            -144},{-108,-134}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temRet(
    redeclare package Medium = MediumW,
    m_flow_nominal=mBoi_flow_nominal,
    T_start=TRet_nominal) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={-98,-174})));
  Buildings.Fluid.FixedResistances.Junction spl(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dp_nominal={0,0,0},
    m_flow_nominal=mBoi_flow_nominal*{1,1,-1},
    from_dp=false)             "Flow splitter" annotation (Placement(
        transformation(
        extent={{5,5},{-5,-5}},
        rotation=0,
        origin={-113,-175})));
  Buildings.Controls.SetPoints.HotWaterTemperatureReset heaCha(
    dTOutHeaBal=0,
    use_TRoo_in=true,
    TSup_nominal=TSup_nominal,
    TRet_nominal=TRet_nominal,
    TOut_nominal(displayUnit="degC") = 268.15)
    annotation (Placement(transformation(extent={{-130,-126},{-126,-122}})));
  Building.Control.ConHea conHeaBoiler(Khea=1)
    annotation (Placement(transformation(extent={{-122,-126},{-116,-122}})));
  Modelica.Blocks.Sources.RealExpression realExpression29(y=schedules_RT2012_MI.HeaSetRT12
         + delta_ST_rad)
    annotation (Placement(transformation(extent={{-150,-128},{-144,-122}})));
  Building.Equipement.Heating.Boiler boi(
    effCur=Buildings.Fluid.Types.EfficiencyCurves.Polynomial,
    a={1.191,-0.214,0,0,0,0},
    redeclare package MediumW = MediumW,
    fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
    Q_flow_nominal=Q_flow_nominal,
    m_flow_nominal=mBoi_flow_nominal,
    T_nominal=353.15,
    dp_nominal=100)
    annotation (Placement(transformation(extent={{-150,-150},{-130,-130}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        MediumW) annotation (Placement(transformation(
        extent={{-4,3},{4,-3}},
        rotation=90,
        origin={-91,-136})));
  Building.Control.ConHea conPumHea(
    Khea=mBoi_flow_nominal,
    k=1,
    Ti=600) annotation (Placement(transformation(
        extent={{8.00015,-5},{-8.00025,5.00001}},
        rotation=180,
        origin={-202,-209})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                           pompe_chaudiere(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare package Medium = MediumW,
    addPowerToMedium=false,
    constantMassFlowRate=0.15,
    m_flow_nominal=mBoi_flow_nominal,
    redeclare Buildings.Fluid.Movers.Data.Generic per,
    use_inputFilter=false,
    nominalValuesDefineDefaultPressureCurve=true)
    annotation (Placement(transformation(extent={{5,5},{-5,-5}}, origin={-83,-175})));
  Modelica.Blocks.Sources.RealExpression HeaSet_LivingRoom(y=
        schedules_RT2012_MI.HeaSetRT12 + delta_ST_rad)
    annotation (Placement(transformation(extent={{-368,-224},{-330,-196}})));
  Modelica.Blocks.Sources.RealExpression Meas_T_LivingRoom(y=T_Salon.T)
    annotation (Placement(transformation(extent={{-366,-260},{-328,-234}})));
  Buildings.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{-110,-194},{-102,-186}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTSetHea(
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    description="Zone air setpoint temperature")
    annotation (Placement(transformation(extent={{-332,40},{-326,46}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaTSetCoo(
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    description="Zone air setpoint temperature")
    annotation (Placement(transformation(extent={{-332,30},{-326,36}})));

  Modelica.Blocks.Sources.RealExpression realExpression13(y=
        heatFlowSensor_Salon_Conv.Q_flow + heatFlowSensor_Salon_Rad.Q_flow)
    annotation (Placement(transformation(extent={{-84,-148},{-78,-142}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaHeaSal(description=
        "Read heating delivered to Salon", y(unit="W"))
    annotation (Placement(transformation(extent={{-70,-148},{-64,-142}})));
  Modelica.Blocks.Sources.RealExpression realExpression15(y=
        heatFlowSensor_Chambre1_Conv.Q_flow + heatFlowSensor_Chambre1_Rad.Q_flow)
    annotation (Placement(transformation(extent={{-24,-152},{-18,-146}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaHeaRo1(description=
        "Read heating delivered to room 1", y(unit="W"))
    annotation (Placement(transformation(extent={{-10,-152},{-4,-146}})));
  Modelica.Blocks.Sources.RealExpression realExpression16(y=
        heatFlowSensor_Chambre2_Conv.Q_flow + heatFlowSensor_Chambre2_Rad.Q_flow)
    annotation (Placement(transformation(extent={{32,-152},{38,-146}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaHeaRo2(description=
        "Read heating delivered to room 2", y(unit="W"))
    annotation (Placement(transformation(extent={{46,-152},{52,-146}})));
  Modelica.Blocks.Sources.RealExpression realExpression18(y=
        heatFlowSensor_Chambre3_Conv.Q_flow + heatFlowSensor_Chambre3_Rad.Q_flow)
    annotation (Placement(transformation(extent={{34,-234},{40,-228}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaHeaRo3(description=
        "Read heating delivered to room 3", y(unit="W"))
    annotation (Placement(transformation(extent={{46,-234},{52,-228}})));
  Modelica.Blocks.Sources.RealExpression realExpression27(y=
        heatFlowSensor_SDB_Conv.Q_flow + heatFlowSensor_SDB_Rad.Q_flow)
    annotation (Placement(transformation(extent={{-24,-230},{-18,-224}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaHeaBth(description=
        "Read heating delivered to bathroom", y(unit="W"))
    annotation (Placement(transformation(extent={{-12,-230},{-6,-224}})));
  Modelica.Blocks.Sources.RealExpression realExpression32(y=
        heatFlowSensor_Couloir_Conv.Q_flow + heatFlowSensor_Couloir_Rad.Q_flow)
    annotation (Placement(transformation(extent={{42,-172},{48,-166}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaHeaHal(description=
        "Read heating delivered to Hall", y(unit="W"))
    annotation (Placement(transformation(extent={{52,-172},{58,-166}})));
  Modelica.Blocks.Sources.RealExpression realExpression28(y=T_Couloir.T)
    annotation (Placement(transformation(extent={{60,-172},{66,-166}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTHal(description=
        "Read hall temperature", y(unit="K"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    zone="Hal")
    annotation (Placement(transformation(extent={{70,-172},{76,-166}})));

  IBPSA.Utilities.IO.SignalExchange.Read reaTAti(
    description="Read attic air temperature",
    y(unit="K"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    zone="Hal")
    annotation (Placement(transformation(extent={{-196,-12},{-190,-6}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTGar(
    description="Read garage temperature",
    y(unit="K"),
    KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    zone="Hal")
    annotation (Placement(transformation(extent={{-110,-50},{-104,-44}})));
equation
  // Heating production
//  Production_Radiateur_Salon = max(heatFlowSensor_Salon_Conv.Q_flow,0)+max(heatFlowSensor_Salon_Rad.Q_flow,0);
//  Production_Radiateur_Chambre1 = max(heatFlowSensor_Chambre1_Conv.Q_flow,0)+max(heatFlowSensor_Chambre1_Rad.Q_flow,0);
//   Production_Radiateur_Chambre2 = max(heatFlowSensor_Chambre2_Conv.Q_flow,0)+max(heatFlowSensor_Chambre2_Rad.Q_flow,0);
//   Production_Radiateur_Chambre3 = max(heatFlowSensor_Chambre3_Conv.Q_flow,0)+max(heatFlowSensor_Chambre3_Rad.Q_flow,0);
//   Production_Radiateur_SDB = max(heatFlowSensor_SDB_Conv.Q_flow,0)+max(heatFlowSensor_SDB_Rad.Q_flow,0);
//   Production_Radiateur_Couloir = max(heatFlowSensor_Couloir_Conv.Q_flow,0)+max(heatFlowSensor_Couloir_Rad.Q_flow,0);

  // Consumptions
//  Consommation_Gaz_Chaudiere =Boiler.QWat_flow;
  Consommation_Elec_Pompe = pompe_chaudiere.m_flow/pompe_chaudiere.m_flow_nominal*P_Pompe_nominal;

  connect(Salon.heaPorAir, T_Salon.port) annotation (Line(points={{-88.4,22},{-83.2,
          22},{-78,22}},        color={191,0,0}));
  connect(Chambre1.heaPorAir, T_Chambre1.port)
    annotation (Line(points={{-8.4,18},{-4,18},{2,18}},  color={191,0,0}));
  connect(Chambre2.heaPorAir, T_Chambre2.port) annotation (Line(points={{49.6,18},
          {54.8,18},{60,18}},           color={191,0,0}));
  connect(Chambre3.heaPorAir, T_Chambre3.port) annotation (Line(points={{49.6,-54},
          {54.8,-54},{60,-54}},            color={191,0,0}));
  connect(SDB.heaPorAir, T_SDB.port) annotation (Line(points={{-10.4,-54},{-5.2,
          -54},{0,-54}},       color={191,0,0}));
  connect(Garage.heaPorAir, T_Garage.port) annotation (Line(points={{-130.4,-48},
          {-125.2,-48},{-120,-48}},    color={191,0,0}));
  connect(weaDat.weaBus, Salon.weaBus) annotation (Line(
      points={{-276,56},{-80.84,56},{-80.84,29.16}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, Chambre1.weaBus) annotation (Line(
      points={{-276,56},{-0.84,56},{-0.84,25.16}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, Garage.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{-122.84,-94},{-122.84,-40.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, SDB.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{-2.84,-94},{-2.84,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, Chambre3.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{57.16,-94},{57.16,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, Chambre2.weaBus) annotation (Line(
      points={{-276,56},{57.16,56},{57.16,25.16}},
      color={255,204,51},
      thickness=0.5));
  connect(q_conv_Jour.Occupation, schedules_MI_ZoneJour.OccupRateRT12)
    annotation (Line(points={{-333.2,1.4},{-342,1.4},{-342,-6.2},{-350,-6.2}},
        color={0,0,127}));
  connect(q_rad_Jour.Occupation, schedules_MI_ZoneJour.OccupRateRT12)
    annotation (Line(points={{-333.2,-12.125},{-338,-12.125},{-338,-6.2},{-350,
          -6.2}}, color={0,0,127}));
  connect(q_rad_Jour.Eclairage, schedules_MI_ZoneJour.LightRT12)
    annotation (Line(points={{-333.2,-14.625},{-342,-14.625},{-342,-9.2},{-350,
          -9.2}}, color={0,0,127}));
  connect(q_rad_Jour.Autres, schedules_MI_ZoneJour.OtherLoadsRateRT12)
    annotation (Line(points={{-333.2,-16.875},{-346,-16.875},{-346,-12.4},{-350,
          -12.4}},color={0,0,127}));
  connect(schedules_MI_ZoneNuit.OccupRateRT12, q_conv_Nuit.Occupation)
    annotation (Line(points={{-350,-44.2},{-342,-44.2},{-342,-36.6},{-333.2,
          -36.6}},
        color={0,0,127}));
  connect(q_rad_Nuit.Occupation, schedules_MI_ZoneNuit.OccupRateRT12)
    annotation (Line(points={{-333.2,-50.125},{-342,-50.125},{-342,-44.2},{-350,
          -44.2}},
        color={0,0,127}));
  connect(q_rad_Nuit.Eclairage, schedules_MI_ZoneNuit.LightRT12)
    annotation (Line(points={{-333.2,-52.625},{-344,-52.625},{-344,-47.2},{-350,
          -47.2}},
        color={0,0,127}));
  connect(q_rad_Nuit.Autres, schedules_MI_ZoneNuit.OtherLoadsRateRT12)
    annotation (Line(points={{-333.2,-54.875},{-346,-54.875},{-346,-50.4},{-350,
          -50.4}},
        color={0,0,127}));
  connect(qRad_Garage.y, multiplex3_Garage.u1[1]) annotation (Line(
      points={{-153.8,-40},{-152,-40},{-152,-44.6},{-148.4,-44.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qCon_Garage.y,multiplex3_Garage. u2[1]) annotation (Line(
      points={{-153.8,-46},{-148.4,-46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLat_Garage.y,multiplex3_Garage. u3[1]) annotation (Line(
      points={{-153.8,-52},{-152,-52},{-152,-47.4},{-148.4,-47.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_Garage.y, Garage.qGai_flow) annotation (Line(points={{-143.8,
          -46},{-138.64,-46},{-138.64,-44.8}},      color={0,0,127}));
  connect(multiplex3_SDB.y, SDB.qGai_flow) annotation (Line(points={{-23.8,-52},
          {-18.64,-52},{-18.64,-50.8}},    color={0,0,127}));
  connect(qRad_SDB.y, multiplex3_SDB.u1[1]) annotation (Line(points={{-33.8,-46},
          {-32,-46},{-32,-50.6},{-28.4,-50.6}}, color={0,0,127}));
  connect(qCon_SDB.y, multiplex3_SDB.u2[1])
    annotation (Line(points={{-33.8,-52},{-28.4,-52}},
                                                    color={0,0,127}));
  connect(qLat_SDB.y, multiplex3_SDB.u3[1]) annotation (Line(points={{-33.8,-58},
          {-32,-58},{-32,-53.4},{-28.4,-53.4}}, color={0,0,127}));
  connect(multiplex3_Chambre1.y, Chambre1.qGai_flow) annotation (Line(
        points={{-19.8,20},{-16.64,20},{-16.64,21.2}},
                                                    color={0,0,127}));
  connect(qLat_Chambre1.y, multiplex3_Chambre1.u3[1]) annotation (Line(
        points={{-29.8,14},{-28,14},{-28,18.6},{-24.4,18.6}},
                                                          color={0,0,127}));
  connect(realExpression1.y, multiplex3_Chambre1.u2[1]) annotation (Line(
        points={{-29.7,19},{-28,19},{-28,20},{-24.4,20}},
                                                      color={0,0,127}));
  connect(multiplex3_Chambre1.u1[1], realExpression.y) annotation (Line(
        points={{-24.4,21.4},{-28,21.4},{-28,23},{-29.7,23}},
                                                          color={0,0,127}));
  connect(qLat_Chambre2.y, multiplex3_Chambre2.u3[1]) annotation (Line(
        points={{28.2,14},{30,14},{30,18.6},{33.6,18.6}}, color={0,0,127}));
  connect(realExpression3.y, multiplex3_Chambre2.u2[1]) annotation (Line(
        points={{28.3,19},{30,19},{30,20},{33.6,20}}, color={0,0,127}));
  connect(multiplex3_Chambre2.u1[1], realExpression2.y) annotation (Line(
        points={{33.6,21.4},{32,21.4},{32,23},{28.3,23}}, color={0,0,127}));
  connect(multiplex3_Chambre2.y, Chambre2.qGai_flow) annotation (Line(
        points={{38.2,20},{41.36,20},{41.36,21.2}}, color={0,0,127}));
  connect(qLat_Chambre3.y, multiplex3_Chambre3.u3[1]) annotation (Line(
        points={{28.2,-58},{30,-58},{30,-53.4},{33.6,-53.4}}, color={0,0,
          127}));
  connect(realExpression5.y, multiplex3_Chambre3.u2[1]) annotation (Line(
        points={{28.3,-53},{30,-53},{30,-52},{33.6,-52}}, color={0,0,127}));
  connect(multiplex3_Chambre3.u1[1], realExpression4.y) annotation (Line(
        points={{33.6,-50.6},{30,-50.6},{30,-49},{28.3,-49}}, color={0,0,
          127}));
  connect(multiplex3_Chambre3.y, Chambre3.qGai_flow) annotation (Line(
        points={{38.2,-52},{41.36,-52},{41.36,-50.8}}, color={0,0,127}));
  connect(qLat_Chambre4.y, multiplex3_Chambre4.u3[1]) annotation (Line(
        points={{-111.8,18},{-110,18},{-110,22.6},{-106.4,22.6}},
                                                              color={0,0,
          127}));
  connect(realExpression7.y, multiplex3_Chambre4.u2[1]) annotation (Line(
        points={{-111.7,23},{-110,23},{-110,24},{-106.4,24}},
                                                          color={0,0,127}));
  connect(multiplex3_Chambre4.u1[1], realExpression6.y) annotation (Line(
        points={{-106.4,25.4},{-110,25.4},{-110,27},{-111.7,27}},
                                                              color={0,0,
          127}));
  connect(multiplex3_Chambre4.y, Salon.qGai_flow) annotation (Line(points={{-101.8,
          24},{-96.64,24},{-96.64,25.2}},        color={0,0,127}));
  connect(uSha_Salon.y, replicator_Salon.u)
    annotation (Line(points={{-109.8,36},{-106.4,36}},
                                                     color={0,0,127}));
  connect(replicator_Salon.y[1], Salon.uSha[1]) annotation (Line(points={{-101.8,
          36},{-100,36},{-100,28.88},{-96.64,28.88}},     color={0,0,127}));
  connect(replicator_Salon.y[2], Salon.uSha[2]) annotation (Line(points={{-101.8,
          36},{-100,36},{-100,29.52},{-96.64,29.52}},     color={0,0,127}));
  connect(uSha_Chambre1.y, replicator_Chambre1.u)
    annotation (Line(points={{-29.8,32},{-26.4,32}},
                                                   color={0,0,127}));
  connect(replicator_Chambre1.y[1], Chambre1.uSha[1]) annotation (Line(
        points={{-21.8,32},{-20,32},{-20,25.2},{-16.64,25.2}},
                                                           color={0,0,127}));
  connect(uSha_Chambre2.y, replicator_Chambre2.u)
    annotation (Line(points={{30.2,30},{31.6,30}}, color={0,0,127}));
  connect(replicator_Chambre2.y[1], Chambre2.uSha[1]) annotation (Line(
        points={{36.2,30},{38,30},{38,25.2},{41.36,25.2}}, color={0,0,127}));
  connect(uSha_Chambre3.y, replicator_Chambre3.u)
    annotation (Line(points={{30.2,-42},{31.6,-42}}, color={0,0,127}));
  connect(replicator_Chambre3.y[1], Chambre3.uSha[1]) annotation (Line(
        points={{36.2,-42},{38,-42},{38,-46.8},{41.36,-46.8}}, color={0,0,
          127}));
  connect(uSha_SDB.y, replicator_SDB.u)
    annotation (Line(points={{-29.8,-38},{-28.4,-38}},
                                                     color={0,0,127}));
  connect(replicator_SDB.y[1], SDB.uSha[1]) annotation (Line(points={{-23.8,-38},
          {-22,-38},{-22,-46.8},{-18.64,-46.8}},   color={0,0,127}));
  connect(multiplex3_Couloir.y, Couloir.qGai_flow) annotation (Line(points={{14.2,
          -12},{43.36,-12},{43.36,-6.8}},
                                       color={0,0,127}));
  connect(qRad_Couloir.y, multiplex3_Couloir.u1[1]) annotation (Line(points={{6.1,-9},
          {9.6,-9},{9.6,-10.6}},    color={0,0,127}));
  connect(qCon_Couloir.y, multiplex3_Couloir.u2[1])
    annotation (Line(points={{2.1,-11},{2.1,-12},{9.6,-12}},
                                                   color={0,0,127}));
  connect(qLat_Couloir.y, multiplex3_Couloir.u3[1]) annotation (Line(points={{6.1,-13},
          {9.6,-13},{9.6,-13.4}},   color={0,0,127}));
  connect(qRad_Combles.y, multiplex3_Combles.u1[1]) annotation (Line(
      points={{-249.8,-2},{-248,-2},{-248,-6.6},{-244.4,-6.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qCon_Combles.y, multiplex3_Combles.u2[1]) annotation (Line(
      points={{-249.8,-8},{-244.4,-8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLat_Combles.y, multiplex3_Combles.u3[1]) annotation (Line(
      points={{-249.8,-14},{-248,-14},{-248,-9.4},{-244.4,-9.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_Combles.y, Combles.qGai_flow) annotation (Line(points={{-239.8,
          -8},{-234,-8},{-234,-6.8},{-228.64,-6.8}},
                                                color={0,0,127}));
  connect(Combles.surf_surBou[1], Garage.surf_conBou[1]) annotation (Line(
        points={{-221.52,-15.9429},{-222,-15.9429},{-222,-76},{-127.6,-76},{
          -127.6,-54.6}},
                   color={191,0,0}));
  connect(Combles.surf_surBou[2], Salon.surf_conBou[1]) annotation (Line(points={{-221.52,
          -15.8286},{-222,-15.8286},{-222,-76},{-85.6,-76},{-85.6,15.3333}},
        color={191,0,0}));
  connect(Combles.surf_surBou[3], Chambre1.surf_conBou[1]) annotation (Line(
        points={{-221.52,-15.7143},{-221.52,-44},{-176,-44},{-176,6},{-5.6,6},{
          -5.6,11.3333}},         color={191,0,0}));
  connect(Combles.surf_surBou[4], Chambre2.surf_conBou[1]) annotation (Line(
        points={{-221.52,-15.6},{-221.52,-44},{-176,-44},{-176,6},{52.4,6},{
          52.4,11.3333}},
        color={191,0,0}));
  connect(Combles.surf_surBou[5], Chambre3.surf_conBou[1]) annotation (Line(
        points={{-221.52,-15.4857},{-221.52,-76},{52.4,-76},{52.4,-60.6}},
                   color={191,0,0}));
  connect(Combles.surf_surBou[6], SDB.surf_conBou[1]) annotation (Line(points={{-221.52,
          -15.3714},{-221.52,-76},{-7.6,-76},{-7.6,-60.7}},
        color={191,0,0}));
  connect(Combles.surf_surBou[7], Couloir.surf_conBou[1]) annotation (Line(
        points={{-221.52,-15.2571},{-192,-15.2571},{-192,-32},{-68,-32},{-68,
          -16.7429},{54.4,-16.7429}},         color={191,0,0}));
  connect(Garage.surf_surBou[1], Salon.surf_conBou[2]) annotation (Line(points={{-131.52,
          -53.6},{-131.52,-54},{-132,-54},{-132,-74},{-85.6,-74},{-85.6,
          15.6}}, color={191,0,0}));
  connect(Salon.surf_surBou[1], Chambre1.surf_conBou[2]) annotation (Line(
        points={{-89.52,16.1333},{-89.52,8},{-6,8},{-6,12},{-5.6,12},{-5.6,11.6}},
        color={191,0,0}));
  connect(Salon.surf_surBou[2], SDB.surf_conBou[2]) annotation (Line(points={{-89.52,
          16.4},{-89.52,8},{-86,8},{-86,-74},{-7.6,-74},{-7.6,-60.5}},   color={
          191,0,0}));
  connect(Salon.surf_surBou[3], Couloir.surf_conBou[6]) annotation (Line(points={{-89.52,
          16.6667},{-89.52,8},{86,8},{86,-16},{70,-16},{62,-16},{62,-16.1714},{
          54.4,-16.1714}},               color={191,0,0}));
  connect(Chambre1.surf_surBou[1], Couloir.surf_conBou[2]) annotation (Line(
        points={{-9.52,12.2},{-9.52,8},{86,8},{86,-16},{70,-16},{70,-16.6286},{
          54.4,-16.6286}},
                  color={191,0,0}));
  connect(Chambre1.surf_surBou[2], Chambre2.surf_conBou[2]) annotation (Line(
        points={{-9.52,12.6},{-9.52,8},{52.4,8},{52.4,11.6}},   color={191,0,0}));
  connect(Chambre2.surf_surBou[1], Couloir.surf_conBou[3]) annotation (Line(
        points={{48.48,12.4},{48.48,8},{86,8},{86,-16},{70,-16},{70,-16.5143},{
          54.4,-16.5143}},
                      color={191,0,0}));
  connect(Chambre3.surf_surBou[1], SDB.surf_conBou[3]) annotation (Line(points={{48.48,
          -59.8},{48.48,-74},{-7.6,-74},{-7.6,-60.3}},           color={191,0,0}));
  connect(Chambre3.surf_surBou[2], Couloir.surf_conBou[4]) annotation (Line(
        points={{48.48,-59.4},{48.48,-74},{86,-74},{86,-16},{70,-16},{70,
          -16.4},{54.4,-16.4}},
                            color={191,0,0}));
  connect(SDB.surf_surBou[1], Couloir.surf_conBou[5]) annotation (Line(points={{-11.52,
          -59.6},{-11.52,-74},{86,-74},{86,-16},{70,-16},{70,-16.2857},{54.4,
          -16.2857}},
        color={191,0,0}));
  connect(weaDat.weaBus, Couloir.weaBus) annotation (Line(
      points={{-276,56},{59.16,56},{59.16,-2.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, Combles.weaBus) annotation (Line(
      points={{-276,56},{-212.84,56},{-212.84,-2.84}},
      color={255,204,51},
      thickness=0.5));
  connect(prescribedText.port, con_Salon.port_a) annotation (Line(points={{-142,63},
          {-122,63},{-122,62},{-122,44},{-94,44},{-94,37},{-92,37}},     color={
          191,0,0}));
  connect(con_Salon.port_b, Salon.heaPorAir) annotation (Line(points={{-86,37},{
          -86,37},{-86,36},{-84,36},{-84,32},{-88.4,32},{-88.4,22}}, color={191,
          0,0}));
  connect(con_Chambre1.port_b, Chambre1.heaPorAir) annotation (Line(points={{-6,
          33},{-6,33},{-6,32},{-2,32},{-2,28},{-8.4,28},{-8.4,18}}, color={191,0,
          0}));
  connect(con_Chambre2.port_b, Chambre2.heaPorAir) annotation (Line(points={{52,
          33},{54,33},{54,32},{54,28},{49.6,28},{49.6,18}}, color={191,0,0}));
  connect(con_Chambre3.port_b, Chambre3.heaPorAir) annotation (Line(points={{50,-39},
          {56,-39},{56,-44},{49.6,-44},{49.6,-54}},               color={191,0,0}));
  connect(con_SDB.port_b, SDB.heaPorAir) annotation (Line(points={{-8,-39},{-6,-39},
          {-6,-40},{-6,-44},{-10.4,-44},{-10.4,-54}}, color={191,0,0}));
  connect(prescribedText.port, con_Chambre1.port_a) annotation (Line(points={{-142,
          63},{-114,63},{-16,63},{-16,33},{-12,33}}, color={191,0,0}));
  connect(prescribedText.port, con_Chambre2.port_a) annotation (Line(points={{-142,63},
          {42,63},{42,64},{42,33},{46,33}},             color={191,0,0}));
  connect(prescribedText.port, con_Couloir.port_a) annotation (Line(points={{-142,63},
          {86,63},{86,62},{86,-8},{72,-8},{72,-5},{70,-5}},
        color={191,0,0}));
  connect(prescribedText.port, con_Chambre3.port_a) annotation (Line(points={{-142,63},
          {86,63},{86,-32},{38,-32},{38,-39},{44,-39}},
        color={191,0,0}));
  connect(prescribedText.port, con_SDB.port_a) annotation (Line(points={{-142,63},
          {86,63},{86,-32},{-18,-32},{-18,-39},{-14,-39}}, color={191,0,0}));
  connect(weaBus, weaDat.weaBus) annotation (Line(
      points={{-160,70},{-162,70},{-162,56},{-276,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, prescribedText.T) annotation (Line(
      points={{-160,70},{-160,70},{-160,64},{-148.6,64},{-148.6,63}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(ventil_Garage.ports1, Garage.ports[2:2]) annotation (Line(points={{-139.92,
          -53.35},{-137.96,-53.35},{-137.96,-51.2},{-136,-51.2}}, color={0,127,255}));
  connect(ventil_Garage.weaBus, weaDat.weaBus) annotation (Line(
      points={{-144.4,-53.3},{-146,-53.3},{-146,-94},{-164,-94},{-164,56},{-276,
          56}},
      color={255,204,51},
      thickness=0.5));
  connect(ventil_Chambre2.ports2, Chambre2.ports[1:1]) annotation (Line(points={{42.12,
          13.85},{43.06,13.85},{43.06,12.9333},{44,12.9333}},
                                                           color={0,127,255}));
  connect(ventil_Chambre3.ports2, Chambre3.ports[1:1]) annotation (Line(points={{42.12,
          -58.15},{43.06,-58.15},{43.06,-59.0667},{44,-59.0667}},
                                                               color={0,127,255}));
  connect(weaDat.weaBus, ventil_Salon.weaBus) annotation (Line(
      points={{-276,56},{-126,56},{-126,6},{-104.6,6},{-104.6,16.7}},
      color={255,204,51},
      thickness=0.5));

  connect(weaDat.weaBus, ventil_Chambre1.weaBus) annotation (Line(
      points={{-276,56},{-22.6,56},{-22.6,12.7}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, ventil_Chambre2.weaBus) annotation (Line(
      points={{-276,56},{35.4,56},{35.4,12.7}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, ventil_Chambre3.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{35.4,-94},{35.4,-59.3}},
      color={255,204,51},
      thickness=0.5));
  connect(ventil_Combles.ports1, Combles.ports[1:1]) annotation (Line(points={{-231.92,
          -15.35},{-228.96,-15.35},{-228.96,-14.8},{-226,-14.8}},
                                                               color={0,127,255}));
  connect(weaDat.weaBus, ventil_Combles.weaBus) annotation (Line(
      points={{-276,56},{-236.4,56},{-236.4,-15.3}},
      color={255,204,51},
      thickness=0.5));
  connect(realExpression11.y, dooOpeClo_Salon.y) annotation (Line(points={{-53.8,
          -11},{-45.45,-11},{-45.45,-10.5}}, color={0,0,127}));
  connect(dooOpeClo_Chambre1.y, realExpression11.y) annotation (Line(points={{-10.5,
          2.45},{-10.5,4},{-48,4},{-48,-11},{-53.8,-11}}, color={0,0,127}));
  connect(dooOpeClo_Chambre2.y, realExpression11.y) annotation (Line(points={{27.5,
          2.45},{27.5,4},{-48,4},{-48,-11},{-53.8,-11}}, color={0,0,127}));
  connect(dooOpeClo_Chambre3.y, realExpression11.y) annotation (Line(points={{29.5,
          -23.45},{29.5,-30},{-48,-30},{-48,-11},{-53.8,-11}}, color={0,0,127}));
  connect(dooOpeClo_Chambre2.port_b2, Chambre2.ports[2]) annotation (Line(
        points={{24.8,2},{26,2},{26,6},{38,6},{38,10},{44,10},{44,14}}, color={0,
          127,255}));
  connect(dooOpeClo_Chambre2.port_a1, Chambre2.ports[3]) annotation (Line(
        points={{30.2,2},{32,2},{32,6},{38,6},{38,10},{44,10},{44,15.0667}},
        color={0,127,255}));
  connect(dooOpeClo_Chambre2.port_b1, Couloir.ports[1]) annotation (Line(points={{30.2,-7},
          {30.2,-15.44},{46,-15.44}},           color={0,127,255}));
  connect(dooOpeClo_Chambre2.port_a2, Couloir.ports[2]) annotation (Line(points={{24.8,-7},
          {24.8,-15.12},{46,-15.12}},           color={0,127,255}));
  connect(dooOpeClo_Chambre3.port_a2, Couloir.ports[3]) annotation (Line(points={{32.2,
          -14},{46,-14},{46,-14.8}},       color={0,127,255}));
  connect(dooOpeClo_Chambre3.port_b1, Couloir.ports[4]) annotation (Line(points={{26.8,
          -14},{46,-14},{46,-14.48}},       color={0,127,255}));
  connect(dooOpeClo_SDB.port_a2, Couloir.ports[5]) annotation (Line(points={{-7.8,
          -14},{46,-14},{46,-14.16}}, color={0,127,255}));
  connect(dooOpeClo_SDB.port_b1, Couloir.ports[6]) annotation (Line(points={{-13.2,
          -14},{16,-14},{16,-13.84},{46,-13.84}}, color={0,127,255}));
  connect(dooOpeClo_Chambre1.port_b1, Couloir.ports[7]) annotation (Line(points={{-7.8,-7},
          {19.1,-7},{19.1,-13.52},{46,-13.52}},           color={0,127,255}));
  connect(dooOpeClo_Chambre1.port_a2, Couloir.ports[8]) annotation (Line(points={{-13.2,
          -7},{16.4,-7},{16.4,-13.2},{46,-13.2}},        color={0,127,255}));
  connect(dooOpeClo_Salon.port_b1, Couloir.ports[9]) annotation (Line(points={{-36,
          -7.8},{6,-7.8},{6,-12.88},{46,-12.88}}, color={0,127,255}));
  connect(dooOpeClo_Chambre3.port_b2, Chambre3.ports[2]) annotation (Line(
        points={{32.2,-23},{32.2,-58},{44,-58}}, color={0,127,255}));
  connect(dooOpeClo_Chambre3.port_a1, Chambre3.ports[3]) annotation (Line(
        points={{26.8,-23},{26.8,-56.9333},{44,-56.9333}}, color={0,127,255}));
  connect(dooOpeClo_SDB.port_a1, SDB.ports[1]) annotation (Line(points={{-13.2,
          -23},{-13.2,-32},{-16,-32},{-16,-59.0667}},
                                            color={0,127,255}));
  connect(dooOpeClo_SDB.port_b2, SDB.ports[2]) annotation (Line(points={{-7.8,-23},
          {-7.8,-32},{-16,-32},{-16,-58}},      color={0,127,255}));
  connect(ventil_Chambre1.ports2, Chambre1.ports[1:1]) annotation (Line(points={{-15.88,
          13.85},{-14.94,13.85},{-14.94,12.9333},{-14,12.9333}},         color={
          0,127,255}));
  connect(dooOpeClo_Chambre1.port_b2, Chambre1.ports[2])
    annotation (Line(points={{-13.2,2},{-14,2},{-14,14}}, color={0,127,255}));
  connect(dooOpeClo_Chambre1.port_a1, Chambre1.ports[3]) annotation (Line(
        points={{-7.8,2},{-14,2},{-14,15.0667}}, color={0,127,255}));
  connect(dooOpeClo_Salon.port_a2, Couloir.ports[10]) annotation (Line(points={{-36,
          -13.2},{6,-13.2},{6,-12.56},{46,-12.56}},     color={0,127,255}));
  connect(ventil_Salon.ports3, Salon.ports[1:1]) annotation (Line(points={{-97.88,
          18.05},{-95.94,18.05},{-95.94,16.8},{-94,16.8}}, color={0,127,255}));
  connect(ventil_Salon.ports1, Salon.ports[2:2]) annotation (Line(points={{-97.88,
          16.55},{-95.94,16.55},{-95.94,17.6},{-94,17.6}}, color={0,127,255}));
  connect(dooOpeClo_Salon.port_a1, Salon.ports[3]) annotation (Line(points={{-45,
          -7.8},{-94,-7.8},{-94,18.4}}, color={0,127,255}));
  connect(dooOpeClo_Salon.port_b2, Salon.ports[4]) annotation (Line(points={{-45,
          -13.2},{-94,-13.2},{-94,19.2}}, color={0,127,255}));

  connect(T_Couloir.port, Couloir.heaPorAir) annotation (Line(points={{62,-12},{
          60,-12},{60,-10},{51.6,-10}},       color={191,0,0}));
  connect(T_Combles.port, Combles.heaPorAir)
    annotation (Line(points={{-210,-10},{-220.4,-10}},
                                                   color={191,0,0}));
  connect(regul_Chambre2.T, T_Chambre2.T)
    annotation (Line(points={{65.2,13},{64,13},{64,18}}, color={0,0,127}));
  connect(regul_Chambre3.T, T_Chambre3.T) annotation (Line(points={{65.2,-43},{64,
          -43},{64,-54}},          color={0,0,127}));
  connect(regul_SDB.T, T_SDB.T)
    annotation (Line(points={{5.2,-45},{4,-45},{4,-54}}, color={0,0,127}));
  connect(temSoil.y, T_sol.T) annotation (Line(points={{34.5,87},{37.25,87},{39.4,
          87}}, color={0,0,127}));
  connect(T_sol.port, Salon.surf_conBou[3]) annotation (Line(points={{46,87},{
          58,87},{58,86},{58,66},{58,64},{86,64},{86,8},{-85.6,8},{-85.6,
          15.8667}}, color={191,0,0}));
  connect(T_sol.port, Chambre1.surf_conBou[3]) annotation (Line(points={{46,87},
          {58,87},{58,86},{58,64},{86,64},{86,8},{-5.6,8},{-5.6,11.8667}},
        color={191,0,0}));
  connect(T_sol.port, Chambre2.surf_conBou[3]) annotation (Line(points={{46,87},
          {58,87},{58,86},{58,64},{86,64},{86,8},{54,8},{52.4,8},{52.4,11.8667}},
                                    color={191,0,0}));
  connect(T_sol.port, Chambre3.surf_conBou[2]) annotation (Line(points={{46,
          87},{58,87},{58,64},{86,64},{86,-74},{52.4,-74},{52.4,-60.2}},
        color={191,0,0}));
  connect(T_sol.port, SDB.surf_conBou[4]) annotation (Line(points={{46,87},
          {58,87},{58,86},{58,64},{86,64},{86,-74},{-7.6,-74},{-7.6,-60.1}},
        color={191,0,0}));
  connect(T_sol.port, Couloir.surf_conBou[7]) annotation (Line(points={{46,87},
          {58,87},{58,86},{58,64},{86,64},{86,-16.0571},{54.4,-16.0571}},
                      color={191,0,0}));
  connect(T_sol.port, Garage.surf_conBou[2]) annotation (Line(points={{46,
          87},{58,87},{58,88},{58,66},{86,66},{86,-74},{-127.6,-74},{-127.6,
          -54.2}}, color={191,0,0}));
  connect(dooOpeClo_SDB.y, realExpression11.y) annotation (Line(points={{
          -10.5,-23.45},{-10.5,-30},{-48,-30},{-48,-11},{-53.8,-11}}, color=
         {0,0,127}));
  connect(con_Couloir.port_b, Couloir.heaPorAir) annotation (Line(points={{
          64,-5},{64,-5},{64,-6},{51.6,-6},{51.6,-10}}, color={191,0,0}));
  connect(ventil_Combles.ports2, Combles.ports[2:2]) annotation (Line(points={{-231.92,
          -14.15},{-228.96,-14.15},{-228.96,-13.2},{-226,-13.2}},    color={0,127,
          255}));
  connect(ventil_Garage.ports2, Garage.ports[1:1]) annotation (Line(points={{-139.92,
          -52.15},{-137.96,-52.15},{-137.96,-52.8},{-136,-52.8}},       color={0,
          127,255}));
  connect(ventil_SDB.ports1, SDB.ports[3:3]) annotation (Line(points={{-19.8,
          -62.9},{-19.8,-60.45},{-16,-60.45},{-16,-56.9333}},
                                                       color={0,127,255}));
  connect(ventil_SDB.weaBus, SDB.weaBus) annotation (Line(
      points={{-31,-62.6},{-31,-76},{-31,-94},{-2.84,-94},{-2.84,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(regul_Chambre1.P, Chambre1.heaPorAir) annotation (Line(points={{18,16},
          {20,16},{20,22},{0,22},{0,18},{-8.4,18}},                  color={191,
          0,0}));
  connect(regul_Chambre2.P, Chambre2.heaPorAir) annotation (Line(points={{76,13},
          {80,13},{80,22},{58,22},{58,18},{49.6,18}},           color={191,0,0}));
  connect(regul_Chambre3.P, Chambre3.heaPorAir) annotation (Line(points={{76,-43},
          {78,-43},{78,-42},{78,-60},{60,-60},{60,-56},{49.6,-56},{49.6,
          -54}},
        color={191,0,0}));
  connect(regul_SDB.P, SDB.heaPorAir) annotation (Line(points={{16,-45},{
          18,-45},{18,-44},{18,-60},{2,-60},{2,-54},{-10.4,-54}},
                                                          color={191,0,0}));
  connect(regul_Salon.P, Salon.heaPorAir) annotation (Line(points={{-56,21},{
          -54,21},{-54,22},{-52,22},{-52,28},{-78,28},{-78,22},{-88.4,22}},
                color={191,0,0}));
  connect(regul_Salon.T, T_Salon.T) annotation (Line(points={{-66.8,21},{-70.4,21},
          {-70.4,22},{-74,22}},     color={0,0,127}));
  connect(realExpression9.y, regul_Chambre1.ConsigneClim) annotation (
      Line(points={{6.2,12},{9.36,12},{9.36,14.6667}},
                                                     color={0,0,127}));
  connect(realExpression10.y, regul_Chambre2.ConsigneClim) annotation (
      Line(points={{64.2,10},{65.2,10},{65.2,11}},       color={0,0,127}));
  connect(realExpression12.y, regul_Chambre3.ConsigneClim) annotation (
      Line(points={{62.2,-48},{64,-48},{64,-45},{65.2,-45}},    color={0,
          0,127}));
  connect(realExpression14.y, regul_SDB.ConsigneClim) annotation (Line(
        points={{2.2,-46},{4,-46},{4,-47},{5.2,-47}},     color={0,0,127}));
  connect(weaDat.weaBus, Garage.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{-122.84,-94},{-122.84,-40.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, SDB.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{-2.84,-94},{-2.84,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, Chambre3.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{57.16,-94},{57.16,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(ventil_Garage.weaBus, weaDat.weaBus) annotation (Line(
      points={{-144.4,-53.3},{-146,-53.3},{-146,-94},{-164,-94},{-164,56},{-276,
          56}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, ventil_Chambre3.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{35.4,-94},{35.4,-59.3}},
      color={255,204,51},
      thickness=0.5));
  connect(ventil_SDB.weaBus, SDB.weaBus) annotation (Line(
      points={{-31,-62.6},{-31,-76},{-31,-94},{-2.84,-94},{-2.84,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(rad_Chambre1.port_b,val_Chambre1. port_a) annotation (Line(points={{-8,-123},
          {-8,-123},{-6,-123}},        color={0,127,255}));
  connect(realExpression19.y, conHeaRo1.T) annotation (Line(points={{-17.7,-143},
          {-16,-143},{-16,-141},{-12.8,-141}}, color={0,0,127}));
  connect(realExpression20.y, conHeaRo1.ConsigneCh)
    annotation (Line(points={{-17.7,-139},{-12.8,-139}}, color={0,0,127}));
  connect(rad_Chambre2.port_b,val_Chambre2. port_a) annotation (Line(points={{50,-123},
          {50,-123},{52,-123}},       color={0,127,255}));
  connect(realExpression21.y, conHeaRo2.T) annotation (Line(points={{38.3,-143},
          {42,-143},{42,-141},{43.2,-141}}, color={0,0,127}));
  connect(realExpression22.y, conHeaRo2.ConsigneCh)
    annotation (Line(points={{38.3,-139},{43.2,-139}}, color={0,0,127}));
  connect(rad_Chambre3.port_b,val_Chambre3. port_a) annotation (Line(points={{52,-203},
          {52,-203},{54,-203}},       color={0,127,255}));
  connect(conHeaRo3.yHea, val_Chambre3.y)
    annotation (Line(points={{57,-223},{59,-223},{59,-209}}, color={0,0,127}));
  connect(realExpression24.y, conHeaRo3.ConsigneCh)
    annotation (Line(points={{40.3,-221},{45.2,-221}}, color={0,0,127}));
  connect(rad_SDB.port_b,val_SDB. port_a) annotation (Line(points={{-2,-203},{4,
          -203}},          color={0,127,255}));
  connect(conHeaBth.yHea, val_SDB.y)
    annotation (Line(points={{-1,-219},{9,-219},{9,-209}}, color={0,0,127}));
  connect(realExpression25.y, conHeaBth.T) annotation (Line(points={{-19.7,-221},
          {-16,-221},{-16,-219},{-12.8,-219}}, color={0,0,127}));
  connect(realExpression26.y, conHeaBth.ConsigneCh)
    annotation (Line(points={{-19.7,-217},{-12.8,-217}}, color={0,0,127}));
  connect(inSplVal2.port_2,rad_Chambre1. port_a) annotation (Line(points={{
          -26,-123},{-26,-123},{-22,-123}}, color={0,127,255}));
  connect(inSplVal3.port_2,rad_Chambre2. port_a)
    annotation (Line(points={{34,-123},{36,-123}}, color={0,127,255}));
  connect(inSplVal2.port_3,inSplVal3. port_1) annotation (Line(points={{-31,
          -128},{-32,-128},{-32,-156},{22,-156},{22,-123},{24,-123}}, color=
         {0,127,255}));
  connect(inSplVal4.port_1,inSplVal3. port_3) annotation (Line(points={{-16,
          -169},{-20,-169},{-20,-158},{29,-158},{29,-128}},
                            color={0,127,255}));
  connect(inSplVal5.port_1,inSplVal4. port_3) annotation (Line(points={{24,
          -203},{24,-203},{22,-203},{22,-174},{-11,-174}}, color={0,127,255}));
  connect(inSplVal5.port_2,rad_Chambre3. port_a)
    annotation (Line(points={{34,-203},{38,-203}}, color={0,127,255}));
  connect(inSplVal5.port_3,rad_SDB. port_a) annotation (Line(points={{29,-208},
          {30,-208},{30,-244},{-38,-244},{-38,-203},{-16,-203}},
                  color={0,127,255}));
  connect(val_Chambre1.port_b,outSplVal2. port_1)
    annotation (Line(points={{4,-123},{6,-123}}, color={0,127,255}));
  connect(val_Chambre3.port_b,outSplVal5. port_1)
    annotation (Line(points={{64,-203},{66,-203}}, color={0,127,255}));
  connect(val_SDB.port_b,outSplVal5. port_3) annotation (Line(points={{14,-203},
          {18,-203},{18,-244},{71,-244},{71,-208}},           color={0,127,
          255}));
  connect(outSplVal5.port_2,outSplVal4. port_3) annotation (Line(points={{
          76,-203},{78,-203},{78,-204},{78,-192},{78,-190},{33,-190},{33,
          -174}}, color={0,127,255}));
  connect(rad_Couloir.port_b,outSplVal4. port_1) annotation (Line(points={{24,-169},
          {28,-169}},                     color={0,127,255}));
  connect(conHeaRo2.yHea, val_Chambre2.y)
    annotation (Line(points={{55,-141},{57,-141},{57,-129}}, color={0,0,127}));
  connect(val_Chambre2.port_b,outSplVal3. port_1) annotation (Line(points={{62,-123},
          {64,-123}},           color={0,127,255}));
  connect(outSplVal3.port_2,outSplVal2. port_3) annotation (Line(points={{74,-123},
          {76,-123},{76,-162},{11,-162},{11,-128}},           color={0,127,255}));
  connect(outSplVal4.port_2,outSplVal3. port_3) annotation (Line(points={{38,-169},
          {38,-174},{78,-174},{78,-134},{69,-134},{69,-128}},
                                                    color={0,127,255}));
  connect(inSplVal4.port_2,res. port_a)
    annotation (Line(points={{-6,-169},{-2,-169}}, color={0,127,255}));
  connect(res.port_b,rad_Couloir. port_a)
    annotation (Line(points={{6,-169},{10,-169}}, color={0,127,255}));
  connect(conHeaRo1.yHea, val_Chambre1.y)
    annotation (Line(points={{-1,-141},{-1,-129}}, color={0,0,127}));
  connect(realExpression30.y, conHeaSal.ConsigneCh)
    annotation (Line(points={{-77.7,-133},{-74.8,-133}}, color={0,0,127}));
  connect(realExpression31.y, conHeaSal.T) annotation (Line(points={{-77.7,-137},
          {-75.85,-137},{-75.85,-135},{-74.8,-135}}, color={0,0,127}));
  connect(conHeaSal.yHea, val_Salon.y) annotation (Line(points={{-63,-135},{-64,
          -135},{-64,-136},{-58,-136},{-58,-125},{-59,-125}}, color={0,0,127}));
  connect(inSplVal1.port_2,rad_Salon. port_a) annotation (Line(points={{-82,
          -119},{-80,-119}},      color={0,127,255}));
  connect(val_Salon.port_b,outSplVal1. port_1) annotation (Line(points={{-54,-119},
          {-54,-119},{-52,-119}}, color={0,127,255}));
  connect(inSplVal1.port_3,inSplVal2. port_1) annotation (Line(points={{-85,
          -122},{-86,-122},{-86,-128},{-38,-128},{-38,-123},{-36,-123}},
        color={0,127,255}));
  connect(outSplVal2.port_2,outSplVal1. port_2) annotation (Line(points={{16,-123},
          {18,-123},{18,-122},{18,-154},{-42,-154},{-42,-119}}, color={0,127,255}));
  connect(rad_Salon.port_b,val_Salon. port_a) annotation (Line(points={{-66,
          -119},{-64,-119}},      color={0,127,255}));
  connect(rad_Salon.heatPortCon,heatFlowSensor_Salon_Conv. port_a) annotation (
      Line(points={{-74.4,-113.96},{-74.4,-112.98},{-76,-112.98},{-76,-104}},
        color={191,0,0}));
  connect(heatFlowSensor_Salon_Conv.port_b, Salon.heaPorAir) annotation (Line(
        points={{-76,-96},{-76,-96},{-74,-96},{-74,-74},{-86,-74},{-86,8},{-80,8},
          {-80,22},{-88.4,22}}, color={191,0,0}));
  connect(rad_Salon.heatPortRad,heatFlowSensor_Salon_Rad. port_a) annotation (
      Line(points={{-71.6,-113.96},{-71.6,-112.98},{-70,-112.98},{-70,-104}},
        color={191,0,0}));
  connect(heatFlowSensor_Salon_Rad.port_b, Salon.heaPorRad) annotation (Line(
        points={{-70,-96},{-70,-96},{-74,-96},{-74,-74},{-86,-74},{-86,8},{-80,8},
          {-80,20.48},{-88.4,20.48}}, color={191,0,0}));
  connect(rad_Chambre1.heatPortRad,heatFlowSensor_Chambre1_Rad. port_a)
    annotation (Line(points={{-13.6,-117.96},{-13.6,-114.98},{-10,-114.98},{-10,
          -104}}, color={191,0,0}));
  connect(heatFlowSensor_Chambre1_Rad.port_b, Chambre1.heaPorRad) annotation (
      Line(points={{-10,-96},{-10,-96},{86,-96},{86,8},{0,8},{0,16},{-4,16},{-4,
          16.48},{-8.4,16.48}}, color={191,0,0}));
  connect(rad_Chambre1.heatPortCon,heatFlowSensor_Chambre1_Conv. port_a)
    annotation (Line(points={{-16.4,-117.96},{-16.4,-115.98},{-16,-115.98},{-16,
          -104}}, color={191,0,0}));
  connect(heatFlowSensor_Chambre1_Conv.port_b, Chambre1.heaPorAir) annotation (
      Line(points={{-16,-96},{-16,-96},{86,-96},{86,8},{0,8},{0,18},{-8.4,18}},
        color={191,0,0}));
  connect(rad_Chambre2.heatPortCon,heatFlowSensor_Chambre2_Conv. port_a)
    annotation (Line(points={{41.6,-117.96},{41.6,-116.98},{40,-116.98},{40,-104}},
        color={191,0,0}));
  connect(heatFlowSensor_Chambre2_Conv.port_b, Chambre2.heaPorAir) annotation (
      Line(points={{40,-96},{40,-96},{86,-96},{86,8},{58,8},{58,18},{49.6,18}},
        color={191,0,0}));
  connect(rad_Chambre2.heatPortRad,heatFlowSensor_Chambre2_Rad. port_a)
    annotation (Line(points={{44.4,-117.96},{44.4,-115.98},{46,-115.98},{46,-104}},
        color={191,0,0}));
  connect(heatFlowSensor_Chambre2_Rad.port_b, Chambre2.heaPorRad) annotation (
      Line(points={{46,-96},{46,-96},{86,-96},{86,8},{58,8},{58,16},{54,16},{54,
          16.48},{49.6,16.48}}, color={191,0,0}));
  connect(rad_Couloir.heatPortCon,heatFlowSensor_Couloir_Conv. port_a)
    annotation (Line(points={{15.6,-163.96},{15.6,-153.98},{14,-153.98},{14,-104}},
        color={191,0,0}));
  connect(heatFlowSensor_Couloir_Conv.port_b, Couloir.heaPorAir) annotation (
      Line(points={{14,-96},{14,-96},{86,-96},{86,-12},{60,-12},{60,-10},{51.6,-10}},
        color={191,0,0}));
  connect(rad_Couloir.heatPortRad,heatFlowSensor_Couloir_Rad. port_a)
    annotation (Line(points={{18.4,-163.96},{18.4,-104},{20,-104}},
        color={191,0,0}));
  connect(heatFlowSensor_Couloir_Rad.port_b, Couloir.heaPorRad) annotation (
      Line(points={{20,-96},{20,-96},{86,-96},{86,-14},{60,-14},{60,-12},{51.6,-12},
          {51.6,-11.52}}, color={191,0,0}));
  connect(rad_SDB.heatPortCon,heatFlowSensor_SDB_Conv. port_a) annotation (Line(
        points={{-10.4,-197.96},{-10.4,-195.98},{-12,-195.98},{-12,-194}},
        color={191,0,0}));
  connect(heatFlowSensor_SDB_Conv.port_b, SDB.heaPorAir) annotation (Line(
        points={{-12,-186},{-12,-180},{86,-180},{86,-76},{-2,-76},{-2,-54},{
          -10.4,-54}},
                 color={191,0,0}));
  connect(rad_SDB.heatPortRad,heatFlowSensor_SDB_Rad. port_a) annotation (Line(
        points={{-7.6,-197.96},{-7.6,-195.98},{-6,-195.98},{-6,-194}}, color={191,
          0,0}));
  connect(heatFlowSensor_SDB_Rad.port_b, SDB.heaPorRad) annotation (Line(points={{-6,-186},
          {-6,-180},{86,-180},{86,-76},{-2,-76},{-2,-55.52},{-10.4,-55.52}},
        color={191,0,0}));
  connect(rad_Chambre3.heatPortCon,heatFlowSensor_Chambre3_Conv. port_a)
    annotation (Line(points={{43.6,-197.96},{43.6,-196.98},{42,-196.98},{42,-194}},
        color={191,0,0}));
  connect(heatFlowSensor_Chambre3_Conv.port_b, Chambre3.heaPorAir) annotation (
      Line(points={{42,-186},{42,-178},{86,-178},{86,-74},{60,-74},{60,-54},{49.6,
          -54}}, color={191,0,0}));
  connect(rad_Chambre3.heatPortRad,heatFlowSensor_Chambre3_Rad. port_a)
    annotation (Line(points={{46.4,-197.96},{46.4,-196.98},{48,-196.98},{48,-194}},
        color={191,0,0}));
  connect(heatFlowSensor_Chambre3_Rad.port_b, Chambre3.heaPorRad) annotation (
      Line(points={{48,-186},{48,-178},{86,-178},{86,-74},{60,-74},{60,-55.52},{
          49.6,-55.52}}, color={191,0,0}));
  connect(T_Couloir.T, regul_Couloir.T) annotation (Line(points={{66,-12},{66.6,
          -12},{66.6,-13},{67.2,-13}}, color={0,0,127}));
  connect(regul_Couloir.ConsigneClim, realExpression8.y) annotation (Line(
        points={{67.2,-15},{66.7,-15},{66.7,-16},{66.2,-16}}, color={0,0,127}));
  connect(regul_Couloir.P, Couloir.heaPorAir) annotation (Line(points={{78,-13},
          {80,-13},{80,-12},{60,-12},{60,-10},{51.6,-10}}, color={191,0,0}));
  connect(spl.port_1, temRet.port_b) annotation (Line(points={{-108,-175},{-108,
          -174},{-102,-174}}, color={0,127,255}));
  connect(spl.port_3,val_chaudiere. port_3) annotation (Line(points={{-113,-170},
          {-113,-144}},                   color={0,127,255}));
  connect(weaBus.TDryBul,heaCha. TOut) annotation (Line(
      points={{-160,70},{-164,70},{-164,56},{-164,-94},{-140,-94},{-140,-122.8},
          {-130.4,-122.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(realExpression29.y,heaCha. TRoo_in) annotation (Line(points={{-143.7,-125},
          {-131.85,-125},{-131.85,-125.2},{-130.38,-125.2}}, color={0,0,127}));
  connect(heaCha.TSup, conHeaBoiler.ConsigneCh) annotation (Line(points={{-125.8,
          -122.8},{-123.9,-122.8},{-123.9,-122.667},{-122.48,-122.667}}, color={
          0,0,127}));
  connect(val_chaudiere.port_2, temSup.port_a) annotation (Line(points={{-108,
          -139},{-104,-139}},       color={0,127,255}));
  connect(boi.port_b, val_chaudiere.port_1) annotation (Line(points={{-129.8,
          -139.091},{-124,-139.091},{-124,-139},{-118,-139}},
                                                    color={0,127,255}));
  connect(spl.port_2, boi.port_a) annotation (Line(points={{-118,-175},{-118,
          -176},{-156,-176},{-156,-139.091},{-150.4,-139.091}},
                                                          color={0,127,255}));
  connect(temSup.port_b, massFlowRate.port_a) annotation (Line(points={{-94,
          -139},{-92,-139},{-92,-140},{-91,-140}},
                                             color={0,127,255}));
  connect(temRet.port_a, pompe_chaudiere.port_b) annotation (Line(points={{-94,
          -174},{-92,-174},{-92,-175},{-88,-175}},
                                             color={0,127,255}));
  connect(pompe_chaudiere.port_a, outSplVal1.port_3) annotation (Line(points={{-78,
          -175},{-78,-174},{-47,-174},{-47,-124}},            color={0,127,255}));
  connect(boolean_ModeDHW.y, boi.Mode_ECS) annotation (Line(points={{-177.4,
          -162},{-158,-162},{-158,-146.909},{-152,-146.909}},
                                                        color={255,0,255}));
  connect(offHys.y,greaterEqualThreshold. u) annotation (Line(points={{-273.5,-119},
          {-269,-119}},                       color={0,0,127}));
  connect(greaterEqualThreshold.y,switch1. u2)
    annotation (Line(points={{-257.5,-119},{-251,-119}},
                                                     color={255,0,255}));
  connect(Cst1.y,switch1. u3) annotation (Line(points={{-269.3,-136},{-254,-136},
          {-254,-123},{-251,-123}},  color={0,0,127}));
  connect(greaterThreshold.y,offHys. u) annotation (Line(points={{-289.5,-119},{
          -285,-119}},             color={255,0,255}));
  connect(product1.u2,product1. u2)
    annotation (Line(points={{-240,-182},{-240,-182}},
                                                     color={0,0,127}));
  connect(SetSecurityBoiler.y, regul_Chaudiere_Securite.ConsigneCh) annotation (
     Line(points={{-313.3,-178},{-308.04,-178},{-308.04,-180.167}}, color={0,0,127}));
  connect(booleanToReal1.u,realToBoolean1. y) annotation (Line(points={{-269.2,-182},
          {-273.4,-182}},            color={255,0,255}));
  connect(regul_Chaudiere_Securite.yHea,realToBoolean1. u) annotation (Line(
        points={{-292.7,-182.5},{-286.35,-182.5},{-286.35,-182},{-287.2,-182}},
        color={0,0,127}));
  connect(booleanToReal1.y,product1. u2) annotation (Line(points={{-255.4,-182},
          {-240,-182}},                color={0,0,127}));
  connect(con_HeaModeBoiler.y, switch4.u1) annotation (Line(points={{-259.4,-216},
          {-244.7,-216},{-244.7,-221.2},{-235.2,-221.2}}, color={0,0,127}));
  connect(switch4.u3,Consigne_regul_Chaudiere_Securite1. y) annotation (Line(
        points={{-235.2,-230.8},{-242,-230.8},{-242,-244},{-245.3,-244}},
                                                                      color={0,0,
          127}));
  connect(onOffController.y, switch4.u2) annotation (Line(points={{-275,-232},{-246,
          -232},{-246,-226},{-235.2,-226}}, color={255,0,255}));
  connect(HeaSet_LivingRoom.y, con_HeaModeBoiler.u_s) annotation (Line(points={{
          -328.1,-210},{-306,-210},{-306,-216},{-273.2,-216}}, color={0,0,127}));
  connect(Meas_T_LivingRoom.y, con_HeaModeBoiler.u_m) annotation (Line(points={{
          -326.1,-247},{-266,-247},{-266,-223.2}}, color={0,0,127}));
  connect(boi.T, regul_Chaudiere_Securite.T) annotation (Line(points={{-128.2,
          -134},{-122,-134},{-122,-130},{-216,-130},{-216,-144},{-336,-144},{-336,
          -182.5},{-308.04,-182.5}}, color={0,0,127}));
  connect(conPumHea.yHea, pompe_chaudiere.m_flow_in) annotation (Line(points={{-192.4,
          -209},{-83,-209},{-83,-181}},        color={0,0,127}));
  connect(Meas_T_LivingRoom.y, onOffController.u) annotation (Line(points={{-326.1,
          -247},{-314,-247},{-314,-238},{-298,-238}}, color={0,0,127}));
  connect(product1.y, switch1.u1) annotation (Line(points={{-217,-176},{-208,-176},
          {-208,-152},{-256,-152},{-256,-115},{-251,-115}}, color={0,0,127}));
  connect(product1.y, greaterThreshold.u) annotation (Line(points={{-217,-176},{
          -208,-176},{-208,-152},{-308,-152},{-308,-119},{-301,-119}}, color={0,
          0,127}));
  connect(switch4.y, product1.u1) annotation (Line(points={{-221.4,-226},{-218,
          -226},{-218,-196},{-248,-196},{-248,-170},{-240,-170}},
                                                            color={0,0,127}));
  connect(Meas_T_LivingRoom.y, conPumHea.T) annotation (Line(points={{-326.1,
          -247},{-314,-247},{-314,-209},{-211.28,-209}}, color={0,0,127}));
  connect(bou.ports[1], temRet.port_a) annotation (Line(points={{-102,-190},{
          -94,-190},{-94,-174}},
                             color={0,127,255}));
  connect(realExpression17.y, regul_Salon.ConsigneClim) annotation (Line(points=
         {{-73.8,16},{-70,16},{-70,19},{-66.8,19}}, color={0,0,127}));
  connect(switch1.y, boi.y) annotation (Line(points={{-239.5,-119},{-184,-119},
          {-184,-134},{-152,-134}}, color={0,0,127}));
  connect(T_Chambre1.T, regul_Chambre1.T) annotation (Line(points={{6,18},{8,18},
          {8,16},{9.36,16}}, color={0,0,127}));
  connect(HeaSet_LivingRoom.y, onOffController.reference) annotation (Line(
        points={{-328.1,-210},{-306,-210},{-306,-226},{-298,-226}}, color={0,0,127}));
  connect(HeaSet_LivingRoom.y, conPumHea.ConsigneCh) annotation (Line(points={{-328.1,
          -210},{-314,-210},{-314,-202},{-226,-202},{-226,-212.333},{-211.28,
          -212.333}},         color={0,0,127}));
  connect(conHeaBoiler.yHea, val_chaudiere.y) annotation (Line(points={{-115.4,
          -124},{-113,-124},{-113,-133}},
                                    color={0,0,127}));
  connect(temSup.T, conHeaBoiler.T) annotation (Line(points={{-99,-133.5},{-99,
          -128},{-124,-128},{-124,-124},{-122.48,-124}},
                                                   color={0,0,127}));
  connect(massFlowRate.port_b, inSplVal1.port_1) annotation (Line(points={{-91,
          -132},{-92,-132},{-92,-119},{-88,-119}}, color={0,127,255}));
  connect(schedules_RT2012_MI.HeaSetRT12, reaTSetHea.u) annotation (Line(points=
         {{-352,38},{-336,38},{-336,43},{-332.6,43}}, color={0,0,127}));
  connect(schedules_RT2012_MI.CooSetRT12, reaTSetCoo.u) annotation (Line(points=
         {{-352,34.6},{-346,34.6},{-346,33},{-332.6,33}}, color={0,0,127}));
  connect(conPumHea.yHea, boi.m_PompeCirc) annotation (Line(points={{-192.4,
          -209},{-162,-209},{-162,-144},{-152,-144},{-152,-143.636}},
                                                                color={0,0,127}));
  connect(realExpression13.y, reaHeaSal.u)
    annotation (Line(points={{-77.7,-145},{-70.6,-145}}, color={0,0,127}));
  connect(realExpression15.y, reaHeaRo1.u)
    annotation (Line(points={{-17.7,-149},{-10.6,-149}}, color={0,0,127}));
  connect(realExpression16.y, reaHeaRo2.u)
    annotation (Line(points={{38.3,-149},{45.4,-149}}, color={0,0,127}));
  connect(realExpression18.y, reaHeaRo3.u)
    annotation (Line(points={{40.3,-231},{45.4,-231}}, color={0,0,127}));
  connect(realExpression23.y, conHeaRo3.T) annotation (Line(points={{40.3,-225},
          {42.15,-225},{42.15,-223},{45.2,-223}}, color={0,0,127}));
  connect(realExpression27.y, reaHeaBth.u)
    annotation (Line(points={{-17.7,-227},{-12.6,-227}}, color={0,0,127}));
  connect(realExpression32.y, reaHeaHal.u)
    annotation (Line(points={{48.3,-169},{51.4,-169}}, color={0,0,127}));
  connect(realExpression28.y, reaTHal.u)
    annotation (Line(points={{66.3,-169},{69.4,-169}}, color={0,0,127}));
  connect(T_Combles.T, reaTAti.u) annotation (Line(points={{-206,-10},{-202,-10},
          {-202,-9},{-196.6,-9}}, color={0,0,127}));
  connect(T_Garage.T, reaTGar.u) annotation (Line(points={{-116,-48},{-114,-48},
          {-114,-47},{-110.6,-47}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(                           extent={{-100,
            -100},{100,100}})),                                  Diagram(
        coordinateSystem(                           extent={{-380,-260},{100,
            100}}),     graphics={
        Rectangle(extent={{-160,-8},{-100,-88}},
                                               lineColor={28,108,200},
          lineThickness=1),
        Polygon(points={{-160,-8},{-160,52},{-40,52},{-40,-88},{-100,-88},{-100,
              -8},{-160,-8}},
                         lineColor={28,108,200},
          lineThickness=1),
        Rectangle(extent={{-40,-18},{20,-88}},
                                             lineColor={28,108,200},
          lineThickness=1),
        Rectangle(extent={{20,-18},{80,-88}},  lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-156,8},{-130,-36}},
          lineColor={28,108,200},
          textString="Garage"),
        Text(
          extent={{-36,70},{-10,26}},
          lineColor={28,108,200},
          textString="Room1"),
        Text(
          extent={{50,-2},{76,-46}},
          lineColor={28,108,200},
          textString="Room3"),
        Text(
          extent={{22,70},{48,26}},
          lineColor={28,108,200},
          textString="Room2"),
        Text(
          extent={{-24,-68},{10,-96}},
          lineColor={28,108,200},
          textString="Bathroom (SDB)"),
        Rectangle(
          extent={{-40,52},{20,-2}},
          lineColor={28,108,200},
          lineThickness=1),
        Polygon(
          points={{20,52},{80,52},{80,6},{44,6},{44,-2},{20,-2},{20,52}},
          lineColor={28,108,200},
          lineThickness=1),
        Polygon(
          points={{-40,-2},{44,-2},{44,6},{80,6},{80,-18},{-40,-18},{-40,-2}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{-260,16},{-182,-38}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-256,22},{-240,-6}},
          lineColor={28,108,200},
          textString="Attic"),
        Polygon(points={{-160,-166},{-160,-106},{-40,-106},{-40,-246},{-100,-246},
              {-160,-246},{-160,-166}},
                         lineColor={28,108,200},
          lineThickness=1),
        Rectangle(extent={{-40,-176},{20,-246}},
                                             lineColor={28,108,200},
          lineThickness=1),
        Rectangle(extent={{20,-176},{80,-246}},lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-36,-90},{-10,-134}},
          lineColor={28,108,200},
          textString="Room1"),
        Text(
          extent={{22,-90},{48,-134}},
          lineColor={28,108,200},
          textString="Room2"),
        Rectangle(
          extent={{-40,-106},{20,-160}},
          lineColor={28,108,200},
          lineThickness=1),
        Polygon(
          points={{20,-106},{80,-106},{80,-152},{80,-152},{80,-160},{20,-160},{
              20,-106}},
          lineColor={28,108,200},
          lineThickness=1),
        Polygon(
          points={{-40,-160},{44,-160},{44,-160},{80,-160},{80,-176},{-40,-176},
              {-40,-160}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{38,-218},{64,-262}},
          lineColor={28,108,200},
          textString="Room3"),
        Text(
          extent={{-36,-156},{-24,-178}},
          lineColor={28,108,200},
          textString="Hall"),
        Text(
          extent={{-154,22},{-110,-22}},
          lineColor={28,108,200},
          textString="Living room"),
        Text(
          extent={{-36,-218},{16,-262}},
          lineColor={28,108,200},
          textString="Bathroom (SDB)"),
        Text(
          extent={{64,12},{76,-10}},
          lineColor={28,108,200},
          textString="Hall"),
        Text(
          extent={{-316,-158},{-252,-174}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Security of the output 
temperature of the boiler
"),     Text(
          extent={{-288,-98},{-244,-114}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString="Anti-cycling
of the boiler
"),     Text(
          extent={{-154,-210},{-106,-262}},
          lineColor={28,108,200},
          textString="Living room")}),
    Documentation(info="<html>
<p>
This is a single zone residential hydronic system model 
for WP 1.2 of IBPSA project 1. 
</p>
<h3>Building Design and Use</h3>
<h4>Architecture</h4>
<p>
The emulator building model represents a residential French
dwelling compliant with the French Thermal regulation of 2012,
i.e. the French national building energy regulation. Therefore,
the typology is defined to be representative of French new
dwellings. Its area is approximately 120 m&sup2; (<i>S_ref</i>).
The following figure shows the building layout and
a sketch of the hydraulic system. The coloured elements in the scheme 
represent the controllable components
through the BOPTEST interface. The dimensions are provided in metres.
</p>

<p>
<br><img src=\"Resources/layout.png\">
</p>
<p>Figure 1. Simulated residential dwelling.
</p>

<p>
The orientation of each building was chosen to maximize the natural light during winter. 
Thus, the main surface of windows of the building is south oriented. 
The building consists of six thermal zones that are actively controlled and two unheated
zones:
</p>
<ul>
<li>1 living room/kitchen </li>
<li>3 bedrooms (2 South facing, 1 North facing) </li>
<li>1 bathroom </li>
<li>1 hallway/corridor serving the sleeping area (bedrooms and bathroom) </li>
<li>1 unheated garage </li>
<li>1 unheated attic </li>
</ul>

<p>
The building envelope was defined in order to cover the new construction 
modes existing on the market. Thus, each of these modes was characterized 
by a different level of insulation (Table 1). 
</p>

<p><span style=\"font-family: Arial,sans-serif;\">Table 1.Building envelope characteristic</span> </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\"><tr>
<td><p><br><b><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">Wall type </span></b></p></td>
<td><p><b><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">Characteristics</span></b></p></td>
</tr>
<tr>
<td><p><b><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">External wall</span></b></p></td>
<td><p><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">Brick (200 mm, &lambda;=0.2 W/mK) + polystyrene (80 mm, &lambda;=0.032 W/mK)</span></p></td>
</tr>
<tr>
<td></td>
<td><p><br><br><br><b><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">U = 0.272 W.m<sup>-2</sup>.K<sup>-1</span></b></sup></p></td>
</tr>
<tr>
<td><p><b><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">Floor</span></b></p></td>
<td><p><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">Hollow block (150 mm, &lambda;=0.92 W/mK) + polyurethane (60 mm, &lambda;=0.022 W/mK)</span></p></td>
</tr>
<tr>
<td></td>
<td><p><br><br><b><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">U<sub>e</sub> = 0.327 W.m<sup>-2</sup>.K<sup>-1</span></b></sup></p></td>
</tr>
<tr>
<td><p><b><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">Ceiling</span></b></p></td>
<td><p><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">Glass wool (200 mm, &lambda;=0.04 W/mK)</span></p></td>
</tr>
<tr>
<td></td>
<td><p><br><br><b><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">U = 0.193 W.m<sup>-2</sup>.K<sup>-1</span></b></sup></p></td>
</tr>
<tr>
<td><p><b><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">Fenestration</span></b></p></td>
<td><p><span style=\"font-size: 10pt;\">Double glazing with Argon and PVC frame 4/16/4, <span style=\"font-family: Arial,sans-serif;\">Planitherm glass g=0.6, TL=76&percnt; with external solar protection</span></p></td>
</tr>
<tr>
<td></td>
<td><p><br><br><b><span style=\"font-family: Arial,sans-serif; font-size: 10pt;\">U<sub>w</sub> = 1.40 W.m<sup>-2</sup>.K<sup>-1</span></b></sup></p></td>
</tr>
</table>


<p>
These values are in accordance with the French Thermal regulation 2012.
The building was subject to a detailed modeling according to the architecture plans. 
The volume was divided into 8 thermal zones according to space function 
(an additional thermal zone was created to simulate the behaviour of the attic). 
Each space (room) has its own thermal behaviour as a result of the boundary conditions 
(climate, adjacent spaces, etc.) and the internal conditions (internal loads, scenarios, etc.)
</p>
<p>
The thermal bridges effect was taken into account by the intermediate of thermal resistance 
parameterized with the length building element assimilated to the thermal bridge and a thermal 
bridges coefficient (<i>k_PT</i>).
</p>

<h4>Occupancy schedules</h4>
<p>
The thermal zones of the building, except the unheated zones, are subject to conventional 
scenarios (occupation, heating, cooling, ventilation, lighting, internal loads) defined in the 
French Thermal Regulation 2012 (CSTB - Centre Scientifique et Technique du B&acirc;timent), 2012. 
M&eacute;thode de calcul Th-BCE - R&eacute;glementation thermique 2012; CSTB, 2012). 
</p>
<p>
For example, the building is considered occupied continuously by four adults from 19PM to 10AM 
for 4 weekdays, from 15PM to 10AM during all Wednesdays and all day long during weekends. 
On a yearly basis, the building is considered unoccupied one week at the end of December and 
two weeks in August. A reduction of 30&percnt; of the internal loads due to occupants is observed 
during the nighttime. 
</p>
<p>
The building heating temperature setpoint is fixed conventionally at 19&deg;C during 
occupied periods, 16&deg;C during unoccupied periods shorter than 48 hours and 7&deg;C otherwise. 
The scenario for cooling is similar, cooling temperature setpoints are 28&deg;C / 30&deg;C / 30&deg;C. 
</p>
<h4>Internal loads and schedules</h4>
<p>
The internal loads considered are mainly due to lighting and appliances. For lighting, 
approximately 1.1 W/m&sup2; are considered according to CSTB - Centre Scientifique et 
Technique du B&acirc;timent, 2012 M&eacute;thode de calcul Th-BCE - R&eacute;glementation 
thermique 2012; CSTB, 2012, 80&percnt; of the 1.1 W/m&sup2; installed power is transformed in heat. 
Appliances contribution to internal loads are considered at a level of 5.7 W/m&sup2; from 7AM to 10AM 
and from 19PM to 22PM for 4 weekdays, 7AM to 10AM and from 15PM to 22PM during all Wednesdays and all 
day long during weekends. Otherwise, this level is reduced by 80&percnt;. All this elements can be 
</p>
<h4>Climate data</h4>
<p>
The model uses a climate file containing one year
of weather data for Bordeaux, France  (FRA_Bordeaux.075100_IWEC.mos).
</p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>
Each building zone has its own radiator equipped with a thermostatic valve that is modeled 
using a PI controller. The radiators are sized accordingly to the building envelope characteristics 
and to the specific climate of Bordeaux, France.
</p>
<p>
The water through the heating emission system is heated by a gas boiler. 
The boiler is designed to provide power (sum of the radiators nominal 
power) for spacial heating only, domestic hot water production is not taken 
into account in this model.
</p>
<h4>Equipment specifications and performance maps</h4>
<p>
The boiler uses an efficiency curve constant with coefficient 0.9.
The heating system circulation pump uses an efficiency curve that is function of the
mass flow rate of water through the emission system. 
</p>
<h4>Rule-based or local-loop controllers (if included)</h4>
<p>
The following set of controllers drive the baseline controller implemented in this model: 
</p>
<ul>
<li>
A security system of the boiler follows a nominal supply water temperature of 90&deg;C. 
</li>
<li>
A hysteresis controller reads the indoor air temperature setpoint (from the occupancy schedule) and the actual 
indoor air temperature to decide on the boiler mode: either on or off. 
The living room temperature is chosen to represent the indoor temperature of the whole building. 
Therefore, the thermostat is considered to be placed in the living room. 
</li>
<li>
An anti short cycle system of the boiler compares the operating 
time of the boiler between two start/stops. This operating time should be greater than 600 seconds to allow 
the boiler to switch mode. This system should improve the overall boiler performance. &nbsp;
</li>
<li>
When the boiler mode is on, an additional PI controller  
controls the load ratio of the boiler. A minimum partial load ratio of Pmin_Ch/Pmax_Ch 
equal to 11&percnt; is imposed in this controller.
</li>
<li>
A heating curve is implemented to modulate the supply water temperature from the boiler to the emission
circuit based on outdoor temperature readings. A 3 way valve is used for this modulation. 
</li>
<li>
The emission circuit pump is switched on based on a signal of a PI controller 
that observes the indoor air temperature setpoint (from the occupancy schedule) and the measured indoor 
air temperature from the thermostat in the living room.
</li>
<li>
There is one radiator per zone with a motorized valve controlled by a PI controller
that follows the air zone temperature set point. Only the hallway zone has no valve and its hydronic 
circuit remains always open to ensure that there iswater flow. This is a typical layout that avoids
vacuum failures when all valves are closed while the distribution pump is working.
</li>
</ul>

<h3>Model IO's</h3>
<h4>Inputs</h4>
<p>The model inputs are: </p>
<ul>
<li>
<code>regul_Salon_oveTsetCoo_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for cooling
</li>
<li>
<code>regul_SDB_oveTsetCoo_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for cooling
</li>
<li>
<code>conHeaRo2_oveTsetHea_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for heating
</li>
<li>
<code>conHeaRo1_oveTsetHea_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for heating
</li>
<li>
<code>regul_Couloir_ovePCoo_u</code> [W] [min=-10000.0, max=0.0]: Precribed cooling power
</li>
<li>
<code>conHeaRo1_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating
</li>
<li>
<code>conHeaRo3_oveTsetHea_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for heating
</li>
<li>
<code>boi_oveBoi_u</code> [1] [min=0.0, max=1.0]: Boiler control signal
</li>
<li>
<code>conHeaRo3_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating
</li>
<li>
<code>regul_Couloir_oveTsetCoo_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for cooling
</li>
<li>
<code>regul_SDB_ovePCoo_u</code> [W] [min=-10000.0, max=0.0]: Precribed cooling power
</li>
<li>
<code>regul_Chambre1_ovePCoo_u</code> [W] [min=-10000.0, max=0.0]: Precribed cooling power
</li>
<li>
<code>conHeaSal_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating
</li>
<li>
<code>regul_Chambre3_ovePCoo_u</code> [W] [min=-10000.0, max=0.0]: Precribed cooling power
</li>
<li>
<code>conHeaBoiler_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating
</li>
<li>
<code>regul_Salon_ovePCoo_u</code> [W] [min=-10000.0, max=0.0]: Precribed cooling power
</li>
<li>
<code>conHeaBth_oveTsetHea_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for heating
</li>
<li>
<code>conHeaRo2_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating
</li>
<li>
<code>regul_Chambre1_oveTsetCoo_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for cooling
</li>
<li>
<code>regul_Chambre2_oveTsetCoo_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for cooling
</li>
<li>
<code>conHeaSal_oveTsetHea_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for heating
</li>
<li>
<code>regul_Chambre3_oveTsetCoo_u</code> [K] [min=283.15, max=303.15]: Zone air temperature setpoint for cooling
</li>
<li>
<code>conPumHea_oveTsetHea_u</code> [K] [min=283.15, max=368.15]: Zone air temperature setpoint for heating
</li>
<li>
<code>conHeaBoiler_oveTsetHea_u</code> [K] [min=283.15, max=368.15]: Zone air temperature setpoint for heating
</li>
<li>
<code>regul_Chaudiere_Securite_oveTsetHea_u</code> [K] [min=283.15, max=368.15]: Zone air temperature setpoint for heating
</li>
<li>
<code>conPumHea_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating
</li>
<li>
<code>conHeaBth_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating
</li>
<li>
<code>regul_Chaudiere_Securite_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating
</li>
<li>
<code>regul_Chambre2_ovePCoo_u</code> [W] [min=-10000.0, max=0.0]: Precribed cooling power
</li>
</ul>

<h4>Outputs</h4>
<p>The model outputs are: </p>

<ul>
<li>
<code>ventil_Salon_rearelHum_y</code> [1] [min=None, max=None]: Zone relative humidity
</li>
<li>
<code>q_conv_Jour_reaConOcc_y</code> [W/m2] [min=None, max=None]: Convective heat gains
</li>
<li>
<code>reaTHal_y</code> [K] [min=None, max=None]: Read hall temperature
</li>
<li>
<code>reaHeaHal_y</code> [W] [min=None, max=None]: Read heating delivered to Hall
</li>
<li>
<code>reaTSetCoo_y</code> [K] [min=None, max=None]: Zone air setpoint temperature
</li>
<li>
<code>regul_SDB_reaPcoo_y</code> [W] [min=None, max=None]: Cooling electrical power consumption
</li>
<li>
<code>reaHeaBth_y</code> [W] [min=None, max=None]: Read heating delivered to bathroom
</li>
<li>
<code>conHeaBth_reaTzon_y</code> [K] [min=None, max=None]: Zone air temperature
</li>
<li>
<code>regul_Chambre1_reaPcoo_y</code> [W] [min=None, max=None]: Cooling electrical power consumption
</li>
<li>
<code>q_conv_Nuit_reaConOcc_y</code> [W/m2] [min=None, max=None]: Convective heat gains
</li>
<li>
<code>conHeaRo1_reaTzon_y</code> [K] [min=None, max=None]: Zone air temperature
</li>
<li>
<code>conHeaRo2_reaTzon_y</code> [K] [min=None, max=None]: Zone air temperature
</li>
<li>
<code>boi_reaPpum_y</code> [W] [min=None, max=None]: Boiler pump electrical power consumption
</li>
<li>
<code>regul_Salon_reaPcoo_y</code> [W] [min=None, max=None]: Cooling electrical power consumption
</li>
<li>
<code>reaTGar_y</code> [K] [min=None, max=None]: Read garage temperature
</li>
<li>
<code>reaTAti_y</code> [K] [min=None, max=None]: Read attic air temperature
</li>
<li>
<code>reaTSetHea_y</code> [K] [min=None, max=None]: Zone air setpoint temperature
</li>
<li>
<code>regul_Chambre3_reaPcoo_y</code> [W] [min=None, max=None]: Cooling electrical power consumption
</li>
<li>
<code>reaHeaSal_y</code> [W] [min=None, max=None]: Read heating delivered to Salon
</li>
<li>
<code>regul_Couloir_reaPcoo_y</code> [W] [min=None, max=None]: Cooling electrical power consumption
</li>
<li>
<code>reaHeaRo1_y</code> [W] [min=None, max=None]: Read heating delivered to room 1
</li>
<li>
<code>conHeaRo3_reaTzon_y</code> [K] [min=None, max=None]: Zone air temperature
</li>
<li>
<code>reaHeaRo3_y</code> [W] [min=None, max=None]: Read heating delivered to room 3
</li>
<li>
<code>conHeaSal_reaTzon_y</code> [K] [min=None, max=None]: Zone air temperature
</li>
<li>
<code>regul_Chambre2_reaPcoo_y</code> [W] [min=None, max=None]: Cooling electrical power consumption
</li>
<li>
<code>reaHeaRo2_y</code> [W] [min=None, max=None]: Read heating delivered to room 2
</li>
<li>
<code>boi_reaHeaBoi_y</code> [W] [min=None, max=None]: Boiler thermal energy usage
</li>

</ul>

<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>
For lighting, approximately 1.1 W/m&sup2; are considered according to CSTB - Centre Scientifique et 
Technique du B&acirc;timent, 2012 M&eacute;thode de calcul Th-BCE - R&eacute;glementation 
thermique 2012; CSTB, 2012, 80&percnt; of the 1.1 W/m&sup2; installed power is transformed in heat. 
</p>
<h4>Shading</h4>
<p>
No shading model is included.
</p>
<h3>Model Implementation Details</h3>
<h4>Moist vs. dry air</h4>
<p>
The model uses moist air despite that no condensation is modelled in any of the used components. 
</p>
<h4>Pressure-flow models</h4>
<p>
A circulation loop with one parallel branch per zone is used to model the heating emission system. 
</p>
<h4>Infiltration models</h4>
<p>
Mechanical ventilation from outside air and air exchange between zones are considered in the model. 
</p>

<h3>Scenario Information</h3>
<h4>Energy Pricing</h4>
<h5>Constant electricity price profile</h5>
<p>
The constant electricity price scenario uses a constant price of 0.108 EUR/kWh,
as obtained from the Engie's \"Elec Ajust\" deal before taxes (HTT) in 
<a href=\"https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-elec-ajust.pdf\">
https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-elec-ajust.pdf</a> 
(accessed on July 2020). 
The tariff used is the one for households with contracted power installations higher than 6 kVA.
</p>
<h5>Dynamic electricity price profile</h5>
<p>
The dynamic electricity price scenario uses a dual rate of 0.126 EUR/kWh during 
day time and 0.086 EUR/kWh during night time,
as obtained from the the Engie's \"Elec Ajust\" deal before taxes (HTT) in 
<a href=\"https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-elec-ajust.pdf\">
https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-elec-ajust.pdf</a> 
(accessed on July 2020). 
The tariff used is the one for households with contracted power installations higher than 6 kVA.
The on-peak daily period takes place between 7:00 a.m. and 10:00 p.m.
The off-peak daily period takes place between 10:00 p.m. and 7:00 a.m. 
</p>
<h5>Highly dynamic electricity price profile</h5>
<p>
For the highly dynamic scenario, the French day-ahead prices of 2019 are used. 
Obtained from:
<a href=\"https://www.epexspot.com/en\">
https://www.epexspot.com/en</a> 
The prices are parsed and exported using this repository:
<a href=\"https://github.com/JavierArroyoBastida/epex-spot-data\">
https://github.com/JavierArroyoBastida/epex-spot-data</a> 
</p>
<h5>Gas price profile</h5>
<p>
The gas price is assumed constant and of 0.0491 EUR/kWh 
as obtained from the \"Gaz Energie Garantie 1 an\" deal for gas in
<a href=\"https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-sommaire-gaz-energie-garantie.pdf\">
https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-sommaire-gaz-energie-garantie.pdf</a> 
(accessed on July 2020). 
Price before taxes (HTT) for a contracted anual tariff between 0 - 6000 kWh.
</p>
<h4>Emission Factors</h4>
<h5>Electricity emissions factor profile</h5>
<p>
It is used a constant emission factor for electricity of 0.047 kgCO2/kWh 
which is the grid electricity emission factor reported by the Association of Issuing Bodies (AIB)
for year 2019 in France. For reference, see:
 <a href=\"https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf\">
https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf</a> 
</p>
<h5>Gas emissions factor profile</h5>
<p>
Based on the kgCO2 emitted per amount of natural gas burned in terms of 
energy content.  It is 0.18108 kgCO2/kWh (53.07 kgCO2/milBTU).
For reference,
see:
<a href=\"https://www.eia.gov/environment/emissions/co2_vol_mass.php\">
https://www.eia.gov/environment/emissions/co2_vol_mass.php</a> 
</p>
</html>", revisions="<html>
<ul>
<li>
September 03, 2020 by Javier Arroyo:<br/>
Address issues from IBPSA peer-review. 
</li>
<li>
July 17, 2020 by Javier Arroyo:<br/>
First implementation. 
</li>
</ul>
</html>"),
    experiment(
      StopTime=604800,
      Interval=600,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file="Scripts/plot_temp.mos" "plot_temp"));
end TestCase;
