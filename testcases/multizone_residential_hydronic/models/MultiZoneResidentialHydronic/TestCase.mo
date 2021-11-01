within MultiZoneResidentialHydronic;
model TestCase "Multi zone residential hydronic example model"

  extends Modelica.Icons.Example;

  ///////////////
  //  INPUTS   //
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
  parameter Modelica.SIunits.Power P_pum_nominal = 45 "Pump electrical power" annotation(Dialog(group = "Boiler"));
 parameter Modelica.SIunits.Power Pmin_Ch = 800 "Boiler minimum power" annotation(Dialog(group = "Chauffage"));
 parameter Modelica.SIunits.Power Pmax_Ch = Q_flow_nominal "Boiler maximum power" annotation(Dialog(group = "Chauffage"));
 parameter Modelica.SIunits.Time t_anticourtcycle=600 "Anti short cycle duration for the boiler" annotation(Dialog(group="Cractristiques de la chaudire"));

  // Radiators
  parameter Real delta_ST_rad = 0 "Coefficient for spatial variation of the control system" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power Q_rad_liv = 1800 "Living room radiator power" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power Q_rad_ro1 = 1000 "Room 1 radiator power" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power Q_rad_ro2 = 900  "Room 2 radiator power2" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power Q_rad_ro3 = 1100 "Room 3 radiator power" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power Q_rad_bth = 800  "Bathroom radiator power" annotation(Dialog(group = "Radiators"));
  parameter Modelica.SIunits.Power Q_rad_hal = 1000 "Hall radiator power" annotation(Dialog(group = "Radiators"));

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
  parameter Modelica.SIunits.MassFlowRate Q_batiment = 113.4/3600*d_air "Global mechanical ventilation airflow, this is approximately 1 m3/h/m2 ";

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

  Modelica.Blocks.Sources.BooleanExpression booDHW(y=false)
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
  Building.Control.ConHea conBoiSaf(Khea=1) "Boiler safety controller"
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
  Modelica.Blocks.Continuous.LimPID conHeaModeBoiler(
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    yMax=1,
    yMin=Pmin_Ch/Pmax_Ch,
    Td=10,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=300)
    annotation (Placement(transformation(extent={{-272,-222},{-260,-210}})));
  Modelica.Blocks.Sources.RealExpression BoilerSafetyMode(y=0)
    annotation (Placement(transformation(extent={{-260,-252},{-246,-236}})));
  Modelica.Blocks.Logical.OnOffController
                                       onOffController(bandwidth=0.5)
    annotation (Placement(transformation(extent={{-296,-242},{-276,-222}})));
public
  Buildings.ThermalZones.Detailed.MixedAir gar(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=273.15 + 22,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
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
      stateAtSurface_a={true,false}),
    C_start={400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM},
    nPorts=3)                         "Garage zone"
    annotation (Placement(transformation(extent={{-138,-56},{-122,-40}})));

  Buildings.ThermalZones.Detailed.MixedAir liv(
    redeclare package Medium = MediumA,
    use_C_flow=true,
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
    T_start=273.15 + 19,
    C_start={400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM},
    nPorts=5)            "Living room zone"
    annotation (Placement(transformation(extent={{-96,14},{-80,30}})));

  Buildings.ThermalZones.Detailed.MixedAir ro1(
    redeclare package Medium = MediumA,
    use_C_flow=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    C_start={400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM},
    nPorts=4,
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
    T_start=273.15 + 19) "Room1 zone"
    annotation (Placement(transformation(extent={{-16,10},{0,26}})));

  Buildings.ThermalZones.Detailed.MixedAir ro2(
    redeclare package Medium = MediumA,
    use_C_flow=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    C_start={400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM},
    nPorts=4,
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
    T_start=273.15 + 19) "Room2 zone"
    annotation (Placement(transformation(extent={{42,10},{58,26}})));

  Buildings.ThermalZones.Detailed.MixedAir ro3(
    redeclare package Medium = MediumA,
    use_C_flow=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    C_start={400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM},
    nPorts=4,
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
    T_start=273.15 + 19) "Room3 model"
    annotation (Placement(transformation(extent={{42,-62},{58,-46}})));

  Buildings.ThermalZones.Detailed.MixedAir bth(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    C_start={400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM},
    nPorts=4,
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
    T_start=273.15 + 19) "Bathroom zone"
    annotation (Placement(transformation(extent={{-18,-62},{-2,-46}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TLiv
    "Living room temperature"
    annotation (Placement(transformation(extent={{-78,20},{-74,24}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TGar
    "Garage temperature"
    annotation (Placement(transformation(extent={{-120,-50},{-116,-46}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRo1
    "Room 1 temperature"
    annotation (Placement(transformation(extent={{2,16},{6,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRo2
    "Room 2 temperature"
    annotation (Placement(transformation(extent={{60,16},{64,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TBth
    "Bathroom temperature"
    annotation (Placement(transformation(extent={{0,-56},{4,-52}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRo3
    "Room 3 temperature"
    annotation (Placement(transformation(extent={{60,-56},{64,-52}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3     weaDat(                           winSpe=
        5.25,
    winSpeSou=Buildings.BoundaryConditions.Types.DataSource.Parameter,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "Resources/FRA_Bordeaux.075100_IWEC.mos"))
    annotation (Placement(transformation(extent={{-296,46},{-276,66}})));
  Building.Schedules.ScheduleDay schDay(delta_ST=delta_ST_rad) "Day schedule"
    annotation (Placement(transformation(extent={{-372,-16},{-350,6}})));
  Building.Schedules.ScheduleNight schNight(delta_ST=delta_ST_rad)
    "Night schedule"
    annotation (Placement(transformation(extent={{-372,-54},{-350,-32}})));
  Building.Gains.Q_conv_3 qConvDay "Convective heating during day"
    annotation (Placement(transformation(extent={{-332,-4},{-320,6}})));
  Building.Gains.Q_rad_5 qRadDay "Radiative heating during day"
    annotation (Placement(transformation(extent={{-332,-18},{-320,-8}})));
  Building.Gains.Q_conv_3 qConvNight "Convective heating during night"
    annotation (Placement(transformation(extent={{-332,-42},{-320,-32}})));
  Building.Gains.Q_rad_5 qRadNight "Radiative heating during night"
    annotation (Placement(transformation(extent={{-332,-56},{-320,-46}})));
  Modelica.Blocks.Sources.Constant qConGar(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-158,-48},{-154,-44}})));
  Modelica.Blocks.Sources.Constant qRadGar(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-158,-42},{-154,-38}})));
  Modelica.Blocks.Routing.Multiplex3 mulGar
    annotation (Placement(transformation(extent={{-148,-48},{-144,-44}})));
  Modelica.Blocks.Sources.Constant qLatGar(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-158,-54},{-154,-50}})));
  Modelica.Blocks.Sources.Constant qConBth(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-38,-54},{-34,-50}})));
  Modelica.Blocks.Sources.Constant qRadBth(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-38,-48},{-34,-44}})));
  Modelica.Blocks.Routing.Multiplex3 mulBth
    annotation (Placement(transformation(extent={{-28,-54},{-24,-50}})));
  Modelica.Blocks.Sources.Constant qLatBth(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-38,-60},{-34,-56}})));
  Modelica.Blocks.Sources.Constant qLatRo1(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-36,18},{-32,22}})));
  Modelica.Blocks.Routing.Multiplex3 mulRo1
    annotation (Placement(transformation(extent={{-24,18},{-20,22}})));
  Modelica.Blocks.Sources.RealExpression qRadRo1(y=qRadNight.Q_rad)
    annotation (Placement(transformation(extent={{-36,26},{-30,32}})));
  Modelica.Blocks.Sources.RealExpression qConRo1(y=qConvNight.Q_conv)
    annotation (Placement(transformation(extent={{-36,22},{-30,28}})));
  Modelica.Blocks.Sources.Constant qLatRo2(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{22,22},{26,26}})));
  Modelica.Blocks.Routing.Multiplex3 mulRo2
    annotation (Placement(transformation(extent={{32,28},{36,32}})));
  Modelica.Blocks.Sources.RealExpression qRadRo2(y=qRadNight.Q_rad)
    annotation (Placement(transformation(extent={{20,30},{26,36}})));
  Modelica.Blocks.Sources.RealExpression qConRo2(y=qConvNight.Q_conv)
    annotation (Placement(transformation(extent={{20,26},{26,32}})));
  Modelica.Blocks.Sources.Constant qLatRo3(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{24,-56},{28,-52}})));
  Modelica.Blocks.Routing.Multiplex3 mulRo3
    annotation (Placement(transformation(extent={{34,-52},{38,-48}})));
  Modelica.Blocks.Sources.RealExpression qRadRo3(y=qRadNight.Q_rad)
    annotation (Placement(transformation(extent={{22,-48},{28,-42}})));
  Modelica.Blocks.Sources.RealExpression qConRo3(y=qConvNight.Q_conv)
    annotation (Placement(transformation(extent={{22,-52},{28,-46}})));
  Modelica.Blocks.Sources.Constant qLatLiv(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-120,28},{-116,32}})));
  Modelica.Blocks.Routing.Multiplex3 mulLiv
    annotation (Placement(transformation(extent={{-110,32},{-106,36}})));
  Modelica.Blocks.Sources.RealExpression qRadLiv(y=qRadDay.Q_rad)
    annotation (Placement(transformation(extent={{-122,36},{-116,42}})));
  Modelica.Blocks.Sources.RealExpression qConLiv(y=qConvDay.Q_conv)
    annotation (Placement(transformation(extent={{-122,32},{-116,38}})));
  Modelica.Blocks.Sources.Constant uShaLiv(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-118,44},{-114,48}})));
  Modelica.Blocks.Routing.Replicator repLiv(nout=max(1, 2))
    annotation (Placement(transformation(extent={{-110,44},{-106,48}})));
  Modelica.Blocks.Sources.Constant uShaRo1(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-36,34},{-32,38}})));
  Modelica.Blocks.Routing.Replicator repRo1(nout=max(1, 1))
    annotation (Placement(transformation(extent={{-28,34},{-24,38}})));
  Modelica.Blocks.Sources.Constant uShaRo2(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{24,38},{28,42}})));
  Modelica.Blocks.Routing.Replicator repRo2(nout=max(1, 1)) "Replicator room 2"
    annotation (Placement(transformation(extent={{30,38},{34,42}})));
  Modelica.Blocks.Sources.Constant uShaBth(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-34,-40},{-30,-36}})));
  Modelica.Blocks.Routing.Replicator repBth(nout=max(1, 1))
    annotation (Placement(transformation(extent={{-28,-40},{-24,-36}})));
  Modelica.Blocks.Sources.Constant uShaRo3(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{24,-38},{28,-34}})));
  Modelica.Blocks.Routing.Replicator repRo3(nout=max(1, 1))
    annotation (Placement(transformation(extent={{30,-38},{34,-34}})));
public
  Buildings.ThermalZones.Detailed.MixedAir hal(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    hRoo=HSP,
    lat=weaDat.lat,
    C_start={400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM},
    nPorts=12,
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
    T_start=273.15 + 19) "Hall zone"
    annotation (Placement(transformation(extent={{44,-18},{60,-2}})));
  Modelica.Blocks.Sources.Constant qConHal(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{10,-10},{12,-8}})));
  Modelica.Blocks.Sources.Constant qRadHal(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{10,-8},{12,-6}})));
  Modelica.Blocks.Routing.Multiplex3 mulHal
    annotation (Placement(transformation(extent={{16,-12},{20,-8}})));
  Modelica.Blocks.Sources.Constant qLatHal(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{10,-12},{12,-10}})));
  Buildings.ThermalZones.Detailed.MixedAir ati(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nConPar=0,
    lat=weaDat.lat,
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
    T_start=273.15 + 19,
    C_start={400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM},
    nPorts=3)            "Attic zone"
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
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thConLiv(G=
        L_ext_Salon*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{-92,34},{-86,40}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature prescribedText
    annotation (Placement(transformation(extent={{-136,60},{-128,68}})));
  Buildings.BoundaryConditions.WeatherData.Bus     weaBus annotation (Placement(
        transformation(extent={{-170,50},{-158,62}}), iconTransformation(extent=
           {{-236,54},{-216,74}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thConRo1(G=
        L_ext_Chambre1*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{-12,30},{-6,36}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thConRo2(G=
        L_ext_Chambre2*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{46,30},{52,36}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thConRo3(G=
        L_ext_Chambre3*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{44,-42},{50,-36}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thConBth(G=
        L_ext_SDB*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{-14,-42},{-8,-36}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thConHal(G=
        L_ext_Couloir*k_PT)
    "Thermal conductor used to take into acount thermal bridges effect"
    annotation (Placement(transformation(extent={{72,-8},{66,-2}})));
  Buildings.Airflow.Multizone.DoorDiscretizedOperable dooLiv(
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
  Buildings.Airflow.Multizone.DoorDiscretizedOperable dooRo1(
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
  Buildings.Airflow.Multizone.DoorDiscretizedOperable dooRo2(
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
  Buildings.Airflow.Multizone.DoorDiscretizedOperable dooBth(
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
  Buildings.Airflow.Multizone.DoorDiscretizedOperable dooRo3(
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
    annotation (Placement(transformation(extent={{-60,-14},{-54,-8}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor THal
    "Hall temperature"
    annotation (Placement(transformation(extent={{60,-12},{64,-8}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_Combles
    "Temprature de la zone"
    annotation (Placement(transformation(extent={{-210,-12},{-206,-8}})));
  Building.Control.ConCoo conCooRo1(Kcoo=3e3,
                                    zone="Ro1")
    "Cooling controller for zone Ro1"
    annotation (Placement(transformation(extent={{10,14},{14,16}})));
  Building.Control.ConCoo conCooRo2(Kcoo=3e3,
                                    zone="Ro2")
    "Cooling controller for zone Ro2"
    annotation (Placement(transformation(extent={{68,14},{72,16}})));
  Building.Control.ConCoo conCooRo3(Kcoo=3e3,
                                    zone="Ro3")
    "Cooling controller for zone Ro3"
    annotation (Placement(transformation(extent={{68,-40},{72,-38}})));
  Building.Control.ConCoo conCooBth(Kcoo=3e3,
                                    zone="Bth")
    "Cooling controller for zone Bth"
    annotation (Placement(transformation(extent={{6,-48},{10,-46}})));
  Modelica.Blocks.Sources.Sine temSoil(
    amplitude=2,
    offset=15 + 273.15,
    freqHz=1/(8760*3600),
    phase=0) annotation (Placement(transformation(extent={{24,80},{32,88}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature T_sol
    annotation (Placement(transformation(extent={{40,80},{48,88}})));
  Building.Control.ConCoo conCooLiv(Kcoo=5e3,
                                    zone="Liv")
    annotation (Placement(transformation(extent={{-66,18},{-62,20}})));
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
  Modelica.Blocks.Sources.RealExpression expCooRo1(y=schNight.CooSetRT12)
    annotation (Placement(transformation(extent={{2,10},{6,14}})));
  Modelica.Blocks.Sources.RealExpression expCooRo2(y=schNight.CooSetRT12)
    annotation (Placement(transformation(extent={{60,8},{64,12}})));
  Modelica.Blocks.Sources.RealExpression expCooRo3(y=schNight.CooSetRT12)
    annotation (Placement(transformation(extent={{58,-40},{62,-36}})));
  Modelica.Blocks.Sources.RealExpression expCooBth(y=schNight.CooSetRT12)
    annotation (Placement(transformation(extent={{-2,-48},{2,-44}})));
  Modelica.Blocks.Sources.RealExpression expCooLiv(y=schDay.CooSetRT12)
    annotation (Placement(transformation(extent={{-78,14},{-74,18}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radRo1(
    redeclare package Medium = MediumW,
    Q_flow_nominal=Q_rad_ro1,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{-22,-130},{-8,-116}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage
                                                valRo1(
    redeclare package Medium = MediumW,
    dpValve_nominal=6000,
    m_flow_nominal=mBoi_flow_nominal,
    use_inputFilter=false,
    dpFixed_nominal=6000)
    annotation (Placement(transformation(extent={{-6,-118},{4,-128}})));
  Building.Control.ConHeaZon conHeaRo1(Khea=1,
    k=0.1,
    Ti=120,
    zone="Ro1") "Heating controller for zone Ro1"
    annotation (Placement(transformation(extent={{-12,-142},{-4,-138}})));
  Modelica.Blocks.Sources.RealExpression realExpression19(y=TRo1.T)
    annotation (Placement(transformation(extent={{-24,-146},{-18,-140}})));
  Modelica.Blocks.Sources.RealExpression realExpression20(y=schGeneral.HeaSetRT12
         + delta_ST_rad)
    annotation (Placement(transformation(extent={{-24,-142},{-18,-136}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radRo2(
    redeclare package Medium = MediumW,
    Q_flow_nominal=Q_rad_ro2,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{36,-130},{50,-116}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage
                                                valRo2(
    redeclare package Medium = MediumW,
    dpValve_nominal=6000,
    m_flow_nominal=mBoi_flow_nominal,
    use_inputFilter=false,
    dpFixed_nominal=6000)
    annotation (Placement(transformation(extent={{52,-118},{62,-128}})));
  Building.Control.ConHeaZon conHeaRo2(Khea=1,
    k=0.1,
    Ti=120,
    zone="Ro2") "Heating controller for zone Ro2"
    annotation (Placement(transformation(extent={{48,-142},{54,-138}})));
  Modelica.Blocks.Sources.RealExpression realExpression21(y=TRo2.T)
    annotation (Placement(transformation(extent={{32,-146},{38,-140}})));
  Modelica.Blocks.Sources.RealExpression realExpression22(y=schGeneral.HeaSetRT12
         + delta_ST_rad)
    annotation (Placement(transformation(extent={{32,-142},{38,-136}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radRo3(
    redeclare package Medium = MediumW,
    Q_flow_nominal=Q_rad_ro3,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{38,-210},{52,-196}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage
                                                valRo3(
    redeclare package Medium = MediumW,
    dpValve_nominal=6000,
    m_flow_nominal=mBoi_flow_nominal,
    use_inputFilter=false,
    dpFixed_nominal=6000)
    annotation (Placement(transformation(extent={{54,-198},{64,-208}})));
  Building.Control.ConHeaZon conHeaRo3(Khea=1,
    k=0.1,
    Ti=120,
    zone="Ro3") "Heating controller for zone Ro3"
    annotation (Placement(transformation(extent={{50,-224},{56,-220}})));
  Modelica.Blocks.Sources.RealExpression realExpression23(y=TRo3.T)
    annotation (Placement(transformation(extent={{34,-228},{40,-222}})));
  Modelica.Blocks.Sources.RealExpression realExpression24(y=schGeneral.HeaSetRT12
         + delta_ST_rad)
    annotation (Placement(transformation(extent={{34,-222},{40,-216}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radBth(
    redeclare package Medium = MediumW,
    Q_flow_nominal=Q_rad_bth,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{-16,-210},{-2,-196}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage
                                                valBth(
    redeclare package Medium = MediumW,
    dpValve_nominal=6000,
    m_flow_nominal=mBoi_flow_nominal,
    use_inputFilter=false,
    dpFixed_nominal=6000)
    annotation (Placement(transformation(extent={{4,-198},{14,-208}})));
  Building.Control.ConHeaZon conHeaBth(Khea=1,
    k=0.1,
    Ti=120,
    zone="Bth") "Heating controller for zone Bth"
    annotation (Placement(transformation(extent={{-12,-222},{-6,-218}})));
  Modelica.Blocks.Sources.RealExpression realExpression25(y=TBth.T)
    annotation (Placement(transformation(extent={{-26,-224},{-20,-218}})));
  Modelica.Blocks.Sources.RealExpression realExpression26(y=schGeneral.HeaSetRT12
         + delta_ST_rad)
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
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radHal(
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
    dp_nominal=6000,
    m_flow_nominal=mBoi_flow_nominal)
    annotation (Placement(transformation(extent={{-2,-174},{6,-164}})));
  Modelica.Blocks.Sources.RealExpression realExpression30(y=schGeneral.HeaSetRT12
         + delta_ST_rad)
    annotation (Placement(transformation(extent={{-80,-146},{-74,-140}})));
  Modelica.Blocks.Sources.RealExpression realExpression31(y=TLiv.T)
    annotation (Placement(transformation(extent={{-80,-150},{-74,-144}})));
  Building.Control.ConHeaZon conHeaLiv(Khea=1,
    k=0.1,
    Ti=120,
    zone="Liv")
    annotation (Placement(transformation(extent={{-68,-146},{-60,-142}})));
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
    Q_flow_nominal=Q_rad_liv,
    T_a_nominal=TSup_nominal,
    T_b_nominal=TRet_nominal)
    annotation (Placement(transformation(extent={{-80,-126},{-66,-112}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage
                                                valLiv(
    redeclare package Medium = MediumW,
    dpValve_nominal=6000,
    m_flow_nominal=mBoi_flow_nominal,
    use_inputFilter=false,
    dpFixed_nominal=6000)
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
  Building.Schedules.ScheduleGeneral schGeneral "General schedule"
    annotation (Placement(transformation(extent={{-372,20},{-352,42}})));
  Building.Control.ConCoo conCooHal(Kcoo=3e3,
                                    zone="Hal")
    "Cooling controller for zone Hal"
    annotation (Placement(transformation(extent={{74,-10},{78,-8}})));
  Modelica.Blocks.Sources.RealExpression expCooHal(y=schNight.CooSetRT12)
    annotation (Placement(transformation(extent={{66,-14},{70,-10}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-258,82},{-244,96}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temSup(
    redeclare package Medium = MediumW,
    m_flow_nominal=mBoi_flow_nominal,
    T_start=TSup_nominal) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-99,-139})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valBoi(
    redeclare package Medium = MediumW,
    dpValve_nominal=6000,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=mBoi_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=false,
    use_inputFilter=false) "Boiler valve"
    annotation (Placement(transformation(extent={{-118,-144},{-108,-134}})));
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
  Building.Control.HotWaterTemperatureReset             heaCha(
    dTOutHeaBal=0,
    use_TRoo_in=true,
    TSup_nominal=TSup_nominal,
    TRet_nominal=TRet_nominal,
    TOut_nominal(displayUnit="degC") = 268.15)
    annotation (Placement(transformation(extent={{-144,-114},{-140,-110}})));
  Building.Control.ConHea conHeaTSup(
    Khea=1,
    k=0.1,
    Ti=120)
    annotation (Placement(transformation(extent={{-122,-114},{-116,-110}})));
  Modelica.Blocks.Sources.RealExpression realExpression29(y=schGeneral.HeaSetRT12
         + delta_ST_rad)
    annotation (Placement(transformation(extent={{-156,-116},{-150,-110}})));
  Building.Equipement.Heating.Boiler boi(
    effCur=Buildings.Fluid.Types.EfficiencyCurves.Constant,
    a={0.9},
    redeclare package MediumW = MediumW,
    fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
    Q_flow_nominal=Q_flow_nominal,
    m_flow_nominal=mBoi_flow_nominal,
    T_nominal=353.15,
    dp_nominal=100)
    annotation (Placement(transformation(extent={{-150,-150},{-130,-130}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        MediumW) annotation (Placement(transformation(
        extent={{-3,3},{3,-3}},
        rotation=90,
        origin={-91,-127})));
  Building.Control.ConHea conPumHea(
    Khea=mBoi_flow_nominal,
    k=1,
    Ti=600) annotation (Placement(transformation(
        extent={{4.99991,-2.99998},{-4.99997,2.99997}},
        rotation=180,
        origin={-203,-199})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumEmiSystem(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare package Medium = MediumW,
    addPowerToMedium=false,
    dp_nominal=20000,
    constantMassFlowRate=0.15,
    m_flow_nominal=mBoi_flow_nominal,
    redeclare Buildings.Fluid.Movers.Data.Generic per,
    use_inputFilter=false,
    nominalValuesDefineDefaultPressureCurve=true) "Pump for emission system"
    annotation (Placement(transformation(extent={{5,5},{-5,-5}}, origin={-83,-175})));
  Modelica.Blocks.Sources.RealExpression HeaSetLiv(y=schGeneral.HeaSetRT12 +
        delta_ST_rad)
    annotation (Placement(transformation(extent={{-368,-224},{-330,-196}})));
  Modelica.Blocks.Sources.RealExpression expTLiv(y=TLiv.T)
    annotation (Placement(transformation(extent={{-366,-260},{-328,-234}})));
  Buildings.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        MediumW)
    annotation (Placement(transformation(extent={{-110,-194},{-102,-186}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTSetHea(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    description="Building heating air setpoint temperature")
    annotation (Placement(transformation(extent={{-332,40},{-326,46}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTSetCoo(
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K"),
    description="Building cooling air setpoint temperature")
    annotation (Placement(transformation(extent={{-332,30},{-326,36}})));

  Modelica.Blocks.Sources.RealExpression realExpression13(y=
        heatFlowSensor_Salon_Conv.Q_flow + heatFlowSensor_Salon_Rad.Q_flow)
    annotation (Placement(transformation(extent={{-84,-160},{-78,-154}})));
  Buildings.Utilities.IO.SignalExchange.Read reaHeaLiv(description=
        "Heating delivered to Liv",        y(unit="W"))
    annotation (Placement(transformation(extent={{-70,-160},{-64,-154}})));
  Modelica.Blocks.Sources.RealExpression realExpression15(y=
        heatFlowSensor_Chambre1_Conv.Q_flow + heatFlowSensor_Chambre1_Rad.Q_flow)
    annotation (Placement(transformation(extent={{-24,-152},{-18,-146}})));
  Buildings.Utilities.IO.SignalExchange.Read reaHeaRo1(description=
        "Heating delivered to Ro1",         y(unit="W"))
    annotation (Placement(transformation(extent={{-10,-152},{-4,-146}})));
  Modelica.Blocks.Sources.RealExpression realExpression16(y=
        heatFlowSensor_Chambre2_Conv.Q_flow + heatFlowSensor_Chambre2_Rad.Q_flow)
    annotation (Placement(transformation(extent={{32,-152},{38,-146}})));
  Buildings.Utilities.IO.SignalExchange.Read reaHeaRo2(description=
        "Heating delivered to Ro2",         y(unit="W"))
    annotation (Placement(transformation(extent={{46,-152},{52,-146}})));
  Modelica.Blocks.Sources.RealExpression realExpression18(y=
        heatFlowSensor_Chambre3_Conv.Q_flow + heatFlowSensor_Chambre3_Rad.Q_flow)
    annotation (Placement(transformation(extent={{34,-234},{40,-228}})));
  Buildings.Utilities.IO.SignalExchange.Read reaHeaRo3(description=
        "Heating delivered to Ro3",         y(unit="W"))
    annotation (Placement(transformation(extent={{46,-234},{52,-228}})));
  Modelica.Blocks.Sources.RealExpression realExpression27(y=
        heatFlowSensor_SDB_Conv.Q_flow + heatFlowSensor_SDB_Rad.Q_flow)
    annotation (Placement(transformation(extent={{-26,-232},{-20,-226}})));
  Buildings.Utilities.IO.SignalExchange.Read reaHeaBth(description=
        "Heating delivered to Bth",           y(unit="W"))
    annotation (Placement(transformation(extent={{-14,-232},{-8,-226}})));
  Modelica.Blocks.Sources.RealExpression realExpression32(y=
        heatFlowSensor_Couloir_Conv.Q_flow + heatFlowSensor_Couloir_Rad.Q_flow)
    annotation (Placement(transformation(extent={{42,-172},{48,-166}})));
  Buildings.Utilities.IO.SignalExchange.Read reaHeaHal(description=
        "Heating delivered to Hal",       y(unit="W"))
    annotation (Placement(transformation(extent={{52,-172},{58,-166}})));
  Modelica.Blocks.Sources.RealExpression realExpression28(y=THal.T)
    annotation (Placement(transformation(extent={{60,-172},{66,-166}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTHal(
    description="Air temperature of zone Hal",
                                 y(unit="K"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    zone="Hal")
    annotation (Placement(transformation(extent={{70,-172},{76,-166}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTAti(
    description="Air temperature of zone Ati",
    y(unit="K"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    zone="Hal")
    annotation (Placement(transformation(extent={{-196,-4},{-190,2}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTGar(
    description="Air temperature of zone Gar",
    y(unit="K"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    zone="Hal")
    annotation (Placement(transformation(extent={{-110,-50},{-104,-44}})));
  Buildings.Utilities.IO.SignalExchange.WeatherStation weatherStation
    annotation (Placement(transformation(extent={{-200,70},{-180,90}})));
  Building.Ventilation.InfiltrationExtraction infRo1(m_flow_vent=Q_Chambre1,
      zone="Ro1") "Infiltration to room 1"
    annotation (Placement(transformation(extent={{-24,8},{-20,12}})));
  Building.Ventilation.InfiltrationExtraction infRo2(m_flow_vent=Q_Chambre2,
      zone="Ro2") "Infiltration to room 2"
    annotation (Placement(transformation(extent={{32,10},{36,14}})));
  Building.Ventilation.InfiltrationExtraction infRo3(m_flow_vent=Q_Chambre3,
      zone="Ro3") "Infiltration to room 3"
    annotation (Placement(transformation(extent={{32,-72},{36,-68}})));
  Building.Ventilation.GenCO2 genCO2Ro1(nOcc=1)  "CO2 generation in room 1"
    annotation (Placement(transformation(extent={{-24,12},{-20,16}})));
  Modelica.Blocks.Sources.RealExpression nightSch1(y=schNight.OccupRateRT12)
    "Night schedule"
    annotation (Placement(transformation(extent={{-36,12},{-30,16}})));
  Building.Ventilation.GenCO2 genCO2Ro2(nOcc=1) "CO2 generation in room 2"
    annotation (Placement(transformation(extent={{32,14},{36,18}})));
  Modelica.Blocks.Sources.RealExpression nightSch2(y=schNight.OccupRateRT12)
    "Night schedule"
    annotation (Placement(transformation(extent={{22,14},{28,18}})));
  Modelica.Blocks.Sources.RealExpression nightSch3(y=schNight.OccupRateRT12)
    "Night schedule"
    annotation (Placement(transformation(extent={{22,-68},{28,-64}})));
  Building.Ventilation.GenCO2 genCO2Ro3(nOcc=2) "CO2 generation in room 3"
    annotation (Placement(transformation(extent={{32,-68},{36,-64}})));
  Building.Ventilation.InfiltrationExtraction infHal(m_flow_vent=0, zone="Hal")
    "Infiltration to hall"
    annotation (Placement(transformation(extent={{36,-8},{40,-4}})));
  Building.Ventilation.InfiltrationExtraction extBth(m_flow_vent=-0.8*(
        Q_Chambre1 + Q_Chambre2 + Q_Chambre3)*OpenDoors - 0.001, zone="Bth")
    "Extraction from bathroom"
    annotation (Placement(transformation(extent={{-28,-62},{-24,-58}})));
  Modelica.Blocks.Sources.RealExpression daySch(y=schDay.OccupRateRT12)
    "Day schedule"
    annotation (Placement(transformation(extent={{-118,20},{-112,24}})));
  Building.Ventilation.GenCO2 genCO2Liv(nOcc=4) "CO2 generation in living room"
    annotation (Placement(transformation(extent={{-108,20},{-104,24}})));
  Building.Ventilation.InfiltrationExtractionBoundary extLiv(m_flow_vent=-
        Q_Salon - 0.2*(Q_Chambre1 + Q_Chambre2 + Q_Chambre3)*OpenDoors, zone=
        "Liv") "Extraction from living room"
    annotation (Placement(transformation(extent={{-108,16},{-104,20}})));
  Building.Ventilation.InfiltrationExtractionBoundary infAti(
    m_flow_vent=Q_Combles,
    zone="Ati",
    isConditionedZone=false) "Infiltration to attic"
    annotation (Placement(transformation(extent={{-238,-26},{-234,-22}})));
  Building.Ventilation.InfiltrationExtractionBoundary infGar(
    m_flow_vent=Q_Garage,
    zone="Gar",
    isConditionedZone=false) "Infiltration to garage"
    annotation (Placement(transformation(extent={{-148,-58},{-144,-54}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTSup(description=
        "Supply water temperature measurement to radiators", y(unit="K"))
    "Read the supply water temperature"
    annotation (Placement(transformation(extent={{-102,-132},{-110,-124}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetSup(u(
      min=273.15 + 10,
      max=273.15 + 95,
      unit="K"), description="Supply water temperature setpoint to radiators")
    "Overwrite the supply water temperature setpoint to radiators"
    annotation (Placement(transformation(extent={{-134,-114},{-128,-108}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveMixValSup(u(
      min=0,
      max=1,
      unit="1"), description=
        "Actuator signal for 0three-way mixing valve controlling supply water temperature to radiators")
    "Overwrite the three-way mixing valve controlling supply water temperature to radiators"
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=-90,
        origin={-113,-119})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveEmiPum(u(
      min=0,
      max=1,
      unit="1"), description=
        "Control signal to the circulation pump of the emission system")
    "Overwrite the control signal to the circulation pump of the emission system"
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-187,-199})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetPum(u(
      min=273.15 + 10,
      max=273.15 + 95,
      unit="K"), description=
        "Heating zone air temperature setpoint used to control circulation pump of the emission system")
    "Overwrite the heating setpoint used to control circulation pump of the emission system"
    annotation (Placement(transformation(extent={{-238,-210},{-230,-202}})));
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
  Consommation_Elec_Pompe =pumEmiSystem.m_flow/pumEmiSystem.m_flow_nominal*
    P_pum_nominal;

  connect(liv.heaPorAir, TLiv.port) annotation (Line(points={{-88.4,22},{-78,22}},
                         color={191,0,0}));
  connect(ro1.heaPorAir, TRo1.port)
    annotation (Line(points={{-8.4,18},{2,18}},         color={191,0,0}));
  connect(ro2.heaPorAir, TRo2.port)
    annotation (Line(points={{49.6,18},{60,18}},           color={191,0,0}));
  connect(ro3.heaPorAir, TRo3.port) annotation (Line(points={{49.6,-54},{54.8,-54},
          {60,-54}}, color={191,0,0}));
  connect(bth.heaPorAir, TBth.port) annotation (Line(points={{-10.4,-54},{-5.2,
          -54},{0,-54}}, color={191,0,0}));
  connect(gar.heaPorAir, TGar.port) annotation (Line(points={{-130.4,-48},{-120,
          -48}},            color={191,0,0}));
  connect(weaDat.weaBus, liv.weaBus) annotation (Line(
      points={{-276,56},{-80.84,56},{-80.84,29.16}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, ro1.weaBus) annotation (Line(
      points={{-276,56},{-0.84,56},{-0.84,25.16}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, gar.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{-122.84,-94},{-122.84,-40.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,bth. weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{-2.84,-94},{-2.84,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, ro3.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{57.16,-94},{57.16,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, ro2.weaBus) annotation (Line(
      points={{-276,56},{57.16,56},{57.16,25.16}},
      color={255,204,51},
      thickness=0.5));
  connect(qConvDay.Occupation, schDay.OccupRateRT12) annotation (Line(points={{
          -333.2,1.4},{-342,1.4},{-342,-6.2},{-350,-6.2}}, color={0,0,127}));
  connect(qRadDay.Occupation, schDay.OccupRateRT12) annotation (Line(points={{-333.2,
          -12.125},{-338,-12.125},{-338,-6.2},{-350,-6.2}}, color={0,0,127}));
  connect(qRadDay.Eclairage, schDay.LightRT12) annotation (Line(points={{-333.2,
          -14.625},{-342,-14.625},{-342,-9.2},{-350,-9.2}}, color={0,0,127}));
  connect(qRadDay.Autres, schDay.OtherLoadsRateRT12) annotation (Line(points={{
          -333.2,-16.875},{-346,-16.875},{-346,-12.4},{-350,-12.4}}, color={0,0,
          127}));
  connect(schNight.OccupRateRT12, qConvNight.Occupation) annotation (Line(
        points={{-350,-44.2},{-342,-44.2},{-342,-36.6},{-333.2,-36.6}}, color={
          0,0,127}));
  connect(qRadNight.Occupation, schNight.OccupRateRT12) annotation (Line(points=
         {{-333.2,-50.125},{-342,-50.125},{-342,-44.2},{-350,-44.2}}, color={0,
          0,127}));
  connect(qRadNight.Eclairage, schNight.LightRT12) annotation (Line(points={{-333.2,
          -52.625},{-344,-52.625},{-344,-47.2},{-350,-47.2}}, color={0,0,127}));
  connect(qRadNight.Autres, schNight.OtherLoadsRateRT12) annotation (Line(
        points={{-333.2,-54.875},{-346,-54.875},{-346,-50.4},{-350,-50.4}},
        color={0,0,127}));
  connect(qRadGar.y, mulGar.u1[1]) annotation (Line(
      points={{-153.8,-40},{-152,-40},{-152,-44.6},{-148.4,-44.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGar.y, mulGar.u2[1]) annotation (Line(
      points={{-153.8,-46},{-148.4,-46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qLatGar.y, mulGar.u3[1]) annotation (Line(
      points={{-153.8,-52},{-152,-52},{-152,-47.4},{-148.4,-47.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mulGar.y, gar.qGai_flow) annotation (Line(points={{-143.8,-46},{-138.64,
          -46},{-138.64,-44.8}}, color={0,0,127}));
  connect(mulBth.y, bth.qGai_flow) annotation (Line(points={{-23.8,-52},{-18.64,
          -52},{-18.64,-50.8}}, color={0,0,127}));
  connect(qRadBth.y, mulBth.u1[1]) annotation (Line(points={{-33.8,-46},{-32,-46},
          {-32,-50.6},{-28.4,-50.6}}, color={0,0,127}));
  connect(qConBth.y, mulBth.u2[1])
    annotation (Line(points={{-33.8,-52},{-28.4,-52}}, color={0,0,127}));
  connect(qLatBth.y, mulBth.u3[1]) annotation (Line(points={{-33.8,-58},{-32,-58},
          {-32,-53.4},{-28.4,-53.4}}, color={0,0,127}));
  connect(mulRo1.y, ro1.qGai_flow) annotation (Line(points={{-19.8,20},{-16.64,
          20},{-16.64,21.2}}, color={0,0,127}));
  connect(qLatRo1.y, mulRo1.u3[1]) annotation (Line(points={{-31.8,20},{-30,20},
          {-30,18.6},{-24.4,18.6}}, color={0,0,127}));
  connect(qConRo1.y, mulRo1.u2[1]) annotation (Line(points={{-29.7,25},{-28,25},
          {-28,20},{-24.4,20}}, color={0,0,127}));
  connect(mulRo1.u1[1], qRadRo1.y) annotation (Line(points={{-24.4,21.4},{-26,
          21.4},{-26,29},{-29.7,29}}, color={0,0,127}));
  connect(qLatRo2.y, mulRo2.u3[1]) annotation (Line(points={{26.2,24},{30,24},{
          30,28.6},{31.6,28.6}}, color={0,0,127}));
  connect(qConRo2.y, mulRo2.u2[1]) annotation (Line(points={{26.3,29},{30,29},{
          30,30},{31.6,30}}, color={0,0,127}));
  connect(mulRo2.u1[1], qRadRo2.y) annotation (Line(points={{31.6,31.4},{32,
          31.4},{32,33},{26.3,33}}, color={0,0,127}));
  connect(mulRo2.y, ro2.qGai_flow) annotation (Line(points={{36.2,30},{38,30},{
          38,22},{41.36,22},{41.36,21.2}}, color={0,0,127}));
  connect(qLatRo3.y, mulRo3.u3[1]) annotation (Line(points={{28.2,-54},{30,-54},
          {30,-51.4},{33.6,-51.4}}, color={0,0,127}));
  connect(qConRo3.y, mulRo3.u2[1]) annotation (Line(points={{28.3,-49},{30,-49},
          {30,-50},{33.6,-50}}, color={0,0,127}));
  connect(mulRo3.u1[1], qRadRo3.y) annotation (Line(points={{33.6,-48.6},{30,-48.6},
          {30,-45},{28.3,-45}}, color={0,0,127}));
  connect(mulRo3.y, ro3.qGai_flow) annotation (Line(points={{38.2,-50},{40,-50},
          {40,-52},{41.36,-52},{41.36,-50.8}}, color={0,0,127}));
  connect(qLatLiv.y, mulLiv.u3[1]) annotation (Line(points={{-115.8,30},{-110,
          30},{-110,32.6},{-110.4,32.6}}, color={0,0,127}));
  connect(qConLiv.y, mulLiv.u2[1]) annotation (Line(points={{-115.7,35},{-110,
          35},{-110,34},{-110.4,34}}, color={0,0,127}));
  connect(mulLiv.u1[1], qRadLiv.y) annotation (Line(points={{-110.4,35.4},{-114,
          35.4},{-114,39},{-115.7,39}}, color={0,0,127}));
  connect(mulLiv.y, liv.qGai_flow) annotation (Line(points={{-105.8,34},{-104,
          34},{-104,26},{-96.64,26},{-96.64,25.2}}, color={0,0,127}));
  connect(uShaLiv.y, repLiv.u)
    annotation (Line(points={{-113.8,46},{-110.4,46}}, color={0,0,127}));
  connect(repLiv.y[1], liv.uSha[1]) annotation (Line(points={{-105.8,46},{-100,
          46},{-100,28.88},{-96.64,28.88}}, color={0,0,127}));
  connect(repLiv.y[2], liv.uSha[2]) annotation (Line(points={{-105.8,46},{-100,
          46},{-100,29.52},{-96.64,29.52}}, color={0,0,127}));
  connect(uShaRo1.y, repRo1.u)
    annotation (Line(points={{-31.8,36},{-28.4,36}}, color={0,0,127}));
  connect(repRo1.y[1], ro1.uSha[1]) annotation (Line(points={{-23.8,36},{-20,36},
          {-20,25.2},{-16.64,25.2}}, color={0,0,127}));
  connect(uShaRo2.y, repRo2.u)
    annotation (Line(points={{28.2,40},{29.6,40}}, color={0,0,127}));
  connect(repRo2.y[1], ro2.uSha[1]) annotation (Line(points={{34.2,40},{40,40},
          {40,25.2},{41.36,25.2}}, color={0,0,127}));
  connect(uShaRo3.y, repRo3.u)
    annotation (Line(points={{28.2,-36},{29.6,-36}}, color={0,0,127}));
  connect(repRo3.y[1], ro3.uSha[1]) annotation (Line(points={{34.2,-36},{36,-36},
          {36,-44},{38,-44},{38,-46.8},{41.36,-46.8}}, color={0,0,127}));
  connect(uShaBth.y, repBth.u)
    annotation (Line(points={{-29.8,-38},{-28.4,-38}}, color={0,0,127}));
  connect(repBth.y[1], bth.uSha[1]) annotation (Line(points={{-23.8,-38},{-22,-38},
          {-22,-46.8},{-18.64,-46.8}}, color={0,0,127}));
  connect(mulHal.y, hal.qGai_flow) annotation (Line(points={{20.2,-10},{43.36,
          -10},{43.36,-6.8}}, color={0,0,127}));
  connect(qRadHal.y, mulHal.u1[1]) annotation (Line(points={{12.1,-7},{14,-7},{
          14,-8},{15.6,-8},{15.6,-8.6}}, color={0,0,127}));
  connect(qConHal.y, mulHal.u2[1]) annotation (Line(points={{12.1,-9},{12.1,-10},
          {15.6,-10}}, color={0,0,127}));
  connect(qLatHal.y, mulHal.u3[1]) annotation (Line(points={{12.1,-11},{15.6,
          -11},{15.6,-11.4}}, color={0,0,127}));
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
  connect(multiplex3_Combles.y, ati.qGai_flow) annotation (Line(points={{-239.8,
          -8},{-234,-8},{-234,-6.8},{-228.64,-6.8}}, color={0,0,127}));
  connect(ati.surf_surBou[1], gar.surf_conBou[1]) annotation (Line(points={{-221.52,
          -15.9429},{-222,-15.9429},{-222,-76},{-127.6,-76},{-127.6,-54.6}},
        color={191,0,0}));
  connect(ati.surf_surBou[2], liv.surf_conBou[1]) annotation (Line(points={{-221.52,
          -15.8286},{-222,-15.8286},{-222,-76},{-82,-76},{-82,4},{-85.6,4},{
          -85.6,15.3333}},
        color={191,0,0}));
  connect(ati.surf_surBou[3], ro1.surf_conBou[1]) annotation (Line(points={{-221.52,
          -15.7143},{-221.52,-44},{-176,-44},{-176,6},{-5.6,6},{-5.6,11.3333}},
        color={191,0,0}));
  connect(ati.surf_surBou[4], ro2.surf_conBou[1]) annotation (Line(points={{-221.52,
          -15.6},{-221.52,-44},{-176,-44},{-176,6},{52.4,6},{52.4,11.3333}},
        color={191,0,0}));
  connect(ati.surf_surBou[5], ro3.surf_conBou[1]) annotation (Line(points={{-221.52,
          -15.4857},{-221.52,-76},{52.4,-76},{52.4,-60.6}}, color={191,0,0}));
  connect(ati.surf_surBou[6], bth.surf_conBou[1]) annotation (Line(points={{-221.52,
          -15.3714},{-221.52,-76},{-7.6,-76},{-7.6,-60.7}}, color={191,0,0}));
  connect(ati.surf_surBou[7], hal.surf_conBou[1]) annotation (Line(points={{-221.52,
          -15.2571},{-192,-15.2571},{-192,-32},{54,-32},{54,-16},{54.4,-16},{
          54.4,-16.7429}},
        color={191,0,0}));
  connect(gar.surf_surBou[1], liv.surf_conBou[2]) annotation (Line(points={{-131.52,
          -53.6},{-131.52,-54},{-132,-54},{-132,-76},{-82,-76},{-82,4},{-85.6,4},
          {-85.6,15.6}},
        color={191,0,0}));
  connect(liv.surf_surBou[1], ro1.surf_conBou[2]) annotation (Line(points={{-89.52,
          16.1333},{-89.52,8},{-6,8},{-6,12},{-5.6,12},{-5.6,11.6}}, color={191,
          0,0}));
  connect(liv.surf_surBou[2], bth.surf_conBou[2]) annotation (Line(points={{-89.52,
          16.4},{-89.52,8},{-82,8},{-82,-74},{-7.6,-74},{-7.6,-60.5}}, color={191,
          0,0}));
  connect(liv.surf_surBou[3], hal.surf_conBou[6]) annotation (Line(points={{-89.52,
          16.6667},{-89.52,8},{86,8},{86,-16},{62,-16},{62,-16.1714},{54.4,
          -16.1714}}, color={191,0,0}));
  connect(ro1.surf_surBou[1], hal.surf_conBou[2]) annotation (Line(points={{-9.52,
          12.2},{-9.52,8},{86,8},{86,-16},{70,-16},{70,-16.6286},{54.4,-16.6286}},
        color={191,0,0}));
  connect(ro1.surf_surBou[2], ro2.surf_conBou[2]) annotation (Line(points={{-9.52,
          12.6},{-9.52,8},{52.4,8},{52.4,11.6}}, color={191,0,0}));
  connect(ro2.surf_surBou[1], hal.surf_conBou[3]) annotation (Line(points={{48.48,
          12.4},{48.48,8},{86,8},{86,-16},{70,-16},{70,-16.5143},{54.4,-16.5143}},
        color={191,0,0}));
  connect(ro3.surf_surBou[1], bth.surf_conBou[3]) annotation (Line(points={{48.48,
          -59.8},{48.48,-74},{-7.6,-74},{-7.6,-60.3}}, color={191,0,0}));
  connect(ro3.surf_surBou[2], hal.surf_conBou[4]) annotation (Line(points={{48.48,
          -59.4},{48.48,-74},{86,-74},{86,-16},{70,-16},{70,-16.4},{54.4,-16.4}},
        color={191,0,0}));
  connect(bth.surf_surBou[1], hal.surf_conBou[5]) annotation (Line(points={{-11.52,
          -59.6},{-11.52,-74},{86,-74},{86,-16},{70,-16},{70,-16.2857},{54.4,
          -16.2857}},
        color={191,0,0}));
  connect(weaDat.weaBus, hal.weaBus) annotation (Line(
      points={{-276,56},{59.16,56},{59.16,-2.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, ati.weaBus) annotation (Line(
      points={{-276,56},{-212.84,56},{-212.84,-2.84}},
      color={255,204,51},
      thickness=0.5));
  connect(prescribedText.port, thConLiv.port_a) annotation (Line(points={{-128,
          64},{-94,64},{-94,37},{-92,37}}, color={191,0,0}));
  connect(thConLiv.port_b, liv.heaPorAir) annotation (Line(points={{-86,37},{
          -86,36},{-84,36},{-84,24},{-88.4,24},{-88.4,22}}, color={191,0,0}));
  connect(thConRo1.port_b, ro1.heaPorAir) annotation (Line(points={{-6,33},{-6,
          32},{-4,32},{-4,20},{-8.4,20},{-8.4,18}}, color={191,0,0}));
  connect(thConRo2.port_b, ro2.heaPorAir) annotation (Line(points={{52,33},{54,
          33},{54,20},{49.6,20},{49.6,18}}, color={191,0,0}));
  connect(thConRo3.port_b, ro3.heaPorAir) annotation (Line(points={{50,-39},{54,
          -39},{54,-52},{49.6,-52},{49.6,-54}}, color={191,0,0}));
  connect(thConBth.port_b, bth.heaPorAir) annotation (Line(points={{-8,-39},{-6,
          -39},{-6,-52},{-10.4,-52},{-10.4,-54}}, color={191,0,0}));
  connect(prescribedText.port, thConRo1.port_a) annotation (Line(points={{-128,
          64},{-16,64},{-16,33},{-12,33}}, color={191,0,0}));
  connect(prescribedText.port, thConRo2.port_a) annotation (Line(points={{-128,
          64},{42,64},{42,33},{46,33}}, color={191,0,0}));
  connect(prescribedText.port, thConHal.port_a) annotation (Line(points={{-128,
          64},{86,64},{86,-4},{72,-4},{72,-5}}, color={191,0,0}));
  connect(prescribedText.port, thConRo3.port_a) annotation (Line(points={{-128,
          64},{86,64},{86,-32},{38,-32},{38,-39},{44,-39}}, color={191,0,0}));
  connect(prescribedText.port, thConBth.port_a) annotation (Line(points={{-128,
          64},{86,64},{86,-32},{-16,-32},{-16,-39},{-14,-39}}, color={191,0,0}));
  connect(weaBus, weaDat.weaBus) annotation (Line(
      points={{-164,56},{-276,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, prescribedText.T) annotation (Line(
      points={{-164,56},{-154,56},{-154,64},{-136.8,64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(realExpression11.y, dooLiv.y) annotation (Line(points={{-53.7,-11},{-45.45,
          -11},{-45.45,-10.5}}, color={0,0,127}));
  connect(dooRo1.y, realExpression11.y) annotation (Line(points={{-10.5,2.45},{
          -10.5,4},{-48,4},{-48,-11},{-53.7,-11}}, color={0,0,127}));
  connect(dooRo2.y, realExpression11.y) annotation (Line(points={{27.5,2.45},{
          27.5,4},{-48,4},{-48,-11},{-53.7,-11}}, color={0,0,127}));
  connect(dooRo3.y, realExpression11.y) annotation (Line(points={{29.5,-23.45},
          {29.5,-30},{-48,-30},{-48,-11},{-53.7,-11}}, color={0,0,127}));
  connect(dooRo2.port_b2, ro2.ports[1]) annotation (Line(points={{24.8,2},{26,2},
          {26,6},{38,6},{38,10},{44,10},{44,12.8}}, color={0,127,255}));
  connect(dooRo2.port_a1, ro2.ports[2]) annotation (Line(points={{30.2,2},{32,2},
          {32,6},{38,6},{38,10},{44,10},{44,13.6}}, color={0,127,255}));
  connect(dooRo2.port_b1, hal.ports[1]) annotation (Line(points={{30.2,-7},{
          30.2,-15.4667},{46,-15.4667}}, color={0,127,255}));
  connect(dooRo2.port_a2, hal.ports[2]) annotation (Line(points={{24.8,-7},{
          24.8,-15.2},{46,-15.2}}, color={0,127,255}));
  connect(dooRo3.port_a2, hal.ports[3]) annotation (Line(points={{32.2,-14},{46,
          -14},{46,-14.9333}}, color={0,127,255}));
  connect(dooRo3.port_b1, hal.ports[4]) annotation (Line(points={{26.8,-14},{46,
          -14},{46,-14.6667}}, color={0,127,255}));
  connect(dooBth.port_a2, hal.ports[5]) annotation (Line(points={{-7.8,-14},{46,
          -14},{46,-14.4}}, color={0,127,255}));
  connect(dooBth.port_b1, hal.ports[6]) annotation (Line(points={{-13.2,-14},{
          16,-14},{16,-14.1333},{46,-14.1333}}, color={0,127,255}));
  connect(dooRo1.port_b1, hal.ports[7]) annotation (Line(points={{-7.8,-7},{-6,
          -7},{-6,-14},{18,-14},{18,-13.8667},{46,-13.8667}}, color={0,127,255}));
  connect(dooRo1.port_a2, hal.ports[8]) annotation (Line(points={{-13.2,-7},{
          -12,-7},{-12,-13.6},{46,-13.6}}, color={0,127,255}));
  connect(dooLiv.port_b1, hal.ports[9]) annotation (Line(points={{-36,-7.8},{
          -18,-7.8},{-18,-13.3333},{46,-13.3333}}, color={0,127,255}));
  connect(dooRo3.port_b2, ro3.ports[1]) annotation (Line(points={{32.2,-23},{
          32.2,-59.2},{44,-59.2}}, color={0,127,255}));
  connect(dooRo3.port_a1, ro3.ports[2]) annotation (Line(points={{26.8,-23},{
          26.8,-58.4},{44,-58.4}}, color={0,127,255}));
  connect(dooBth.port_a1, bth.ports[1]) annotation (Line(points={{-13.2,-23},{-13.2,
          -32},{-16,-32},{-16,-59.2}}, color={0,127,255}));
  connect(dooBth.port_b2, bth.ports[2]) annotation (Line(points={{-7.8,-23},{-7.8,
          -32},{-16,-32},{-16,-58.4}}, color={0,127,255}));
  connect(dooRo1.port_b2, ro1.ports[1]) annotation (Line(points={{-13.2,2},{-14,
          2},{-14,12.8}}, color={0,127,255}));
  connect(dooRo1.port_a1, ro1.ports[2])
    annotation (Line(points={{-7.8,2},{-14,2},{-14,13.6}}, color={0,127,255}));
  connect(dooLiv.port_a2, hal.ports[10]) annotation (Line(points={{-36,-13.2},{
          6,-13.2},{6,-13.0667},{46,-13.0667}}, color={0,127,255}));

  connect(THal.port, hal.heaPorAir)
    annotation (Line(points={{60,-10},{51.6,-10}}, color={191,0,0}));
  connect(T_Combles.port, ati.heaPorAir)
    annotation (Line(points={{-210,-10},{-220.4,-10}}, color={191,0,0}));
  connect(conCooRo2.T, TRo2.T) annotation (Line(points={{67.68,15},{66,15},{66,
          18},{64,18}}, color={0,0,127}));
  connect(conCooRo3.T, TRo3.T)
    annotation (Line(points={{67.68,-39},{64,-39},{64,-54}}, color={0,0,127}));
  connect(conCooBth.T, TBth.T)
    annotation (Line(points={{5.68,-47},{4,-47},{4,-54}}, color={0,0,127}));
  connect(temSoil.y, T_sol.T) annotation (Line(points={{32.4,84},{39.2,84}},
                color={0,0,127}));
  connect(T_sol.port, liv.surf_conBou[3]) annotation (Line(points={{48,84},{60,
          84},{60,64},{86,64},{86,8},{-85.6,8},{-85.6,15.8667}},
        color={191,0,0}));
  connect(T_sol.port, ro1.surf_conBou[3]) annotation (Line(points={{48,84},{60,
          84},{60,64},{86,64},{86,8},{-5.6,8},{-5.6,11.8667}},     color={191,0,
          0}));
  connect(T_sol.port, ro2.surf_conBou[3]) annotation (Line(points={{48,84},{60,
          84},{60,64},{86,64},{86,8},{52.4,8},{52.4,11.8667}},            color=
         {191,0,0}));
  connect(T_sol.port, ro3.surf_conBou[2]) annotation (Line(points={{48,84},{60,
          84},{60,64},{86,64},{86,-74},{52.4,-74},{52.4,-60.2}},
                                                             color={191,0,0}));
  connect(T_sol.port,bth. surf_conBou[4]) annotation (Line(points={{48,84},{60,
          84},{60,64},{86,64},{86,-74},{-7.6,-74},{-7.6,-60.1}},
        color={191,0,0}));
  connect(T_sol.port, hal.surf_conBou[7]) annotation (Line(points={{48,84},{60,
          84},{60,64},{86,64},{86,-16.0571},{54.4,-16.0571}},     color={191,0,0}));
  connect(T_sol.port, gar.surf_conBou[2]) annotation (Line(points={{48,84},{60,
          84},{60,64},{86,64},{86,-76},{-127.6,-76},{-127.6,-54.2}},     color={
          191,0,0}));
  connect(dooBth.y, realExpression11.y) annotation (Line(points={{-10.5,-23.45},
          {-10.5,-30},{-48,-30},{-48,-11},{-53.7,-11}}, color={0,0,127}));
  connect(thConHal.port_b, hal.heaPorAir) annotation (Line(points={{66,-5},{64,
          -5},{64,-6},{51.6,-6},{51.6,-10}}, color={191,0,0}));
  connect(conCooRo1.P, ro1.heaPorAir) annotation (Line(points={{14,15},{16,15},
          {16,22},{0,22},{0,18},{-8.4,18}},color={191,0,0}));
  connect(conCooRo2.P, ro2.heaPorAir) annotation (Line(points={{72,15},{76,15},
          {76,22},{58,22},{58,18},{49.6,18}},color={191,0,0}));
  connect(conCooRo3.P, ro3.heaPorAir) annotation (Line(points={{72,-39},{78,-39},
          {78,-60},{60,-60},{60,-56},{49.6,-56},{49.6,-54}},          color={191,
          0,0}));
  connect(conCooBth.P,bth. heaPorAir) annotation (Line(points={{10,-47},{18,-47},
          {18,-60},{2,-60},{2,-54},{-10.4,-54}},          color={191,0,0}));
  connect(conCooLiv.P, liv.heaPorAir) annotation (Line(points={{-62,19},{-60,19},
          {-60,28},{-78,28},{-78,22},{-88.4,22}},                   color={191,0,
          0}));
  connect(conCooLiv.T, TLiv.T) annotation (Line(points={{-66.32,19},{-70.4,19},
          {-70.4,22},{-74,22}}, color={0,0,127}));
  connect(expCooRo1.y, conCooRo1.TSet) annotation (Line(points={{6.2,12},{9.68,
          12},{9.68,14.3333}}, color={0,0,127}));
  connect(expCooRo2.y, conCooRo2.TSet) annotation (Line(points={{64.2,10},{
          67.68,10},{67.68,14.3333}}, color={0,0,127}));
  connect(expCooRo3.y, conCooRo3.TSet) annotation (Line(points={{62.2,-38},{64,
          -38},{64,-39.6667},{67.68,-39.6667}}, color={0,0,127}));
  connect(expCooBth.y, conCooBth.TSet) annotation (Line(points={{2.2,-46},{4,
          -46},{4,-47.6667},{5.68,-47.6667}}, color={0,0,127}));
  connect(weaDat.weaBus, gar.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{-122.84,-94},{-122.84,-40.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,bth. weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{-2.84,-94},{-2.84,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, ro3.weaBus) annotation (Line(
      points={{-276,56},{-164,56},{-164,-94},{57.16,-94},{57.16,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(radRo1.port_b, valRo1.port_a) annotation (Line(points={{-8,-123},{-8,
          -123},{-6,-123}}, color={0,127,255}));
  connect(realExpression19.y, conHeaRo1.T) annotation (Line(points={{-17.7,-143},
          {-16,-143},{-16,-140},{-12.64,-140}},color={0,0,127}));
  connect(realExpression20.y, conHeaRo1.TSet) annotation (Line(points={{-17.7,
          -139},{-14,-139},{-14,-138.667},{-12.64,-138.667}}, color={0,0,127}));
  connect(radRo2.port_b, valRo2.port_a) annotation (Line(points={{50,-123},{50,
          -123},{52,-123}}, color={0,127,255}));
  connect(realExpression21.y, conHeaRo2.T) annotation (Line(points={{38.3,-143},
          {44,-143},{44,-140},{47.52,-140}},color={0,0,127}));
  connect(realExpression22.y, conHeaRo2.TSet) annotation (Line(points={{38.3,
          -139},{44,-139},{44,-138.667},{47.52,-138.667}}, color={0,0,127}));
  connect(radRo3.port_b, valRo3.port_a) annotation (Line(points={{52,-203},{52,
          -203},{54,-203}}, color={0,127,255}));
  connect(conHeaRo3.yHea, valRo3.y) annotation (Line(points={{56.6,-222},{59,
          -222},{59,-209}}, color={0,0,127}));
  connect(realExpression24.y, conHeaRo3.TSet) annotation (Line(points={{40.3,
          -219},{44,-219},{44,-220.667},{49.52,-220.667}}, color={0,0,127}));
  connect(radBth.port_b, valBth.port_a)
    annotation (Line(points={{-2,-203},{4,-203}}, color={0,127,255}));
  connect(conHeaBth.yHea, valBth.y)
    annotation (Line(points={{-5.4,-220},{9,-220},{9,-209}}, color={0,0,127}));
  connect(realExpression25.y, conHeaBth.T) annotation (Line(points={{-19.7,-221},
          {-16,-221},{-16,-220},{-12.48,-220}},color={0,0,127}));
  connect(realExpression26.y, conHeaBth.TSet) annotation (Line(points={{-19.7,
          -217},{-16,-217},{-16,-218.667},{-12.48,-218.667}}, color={0,0,127}));
  connect(inSplVal2.port_2, radRo1.port_a) annotation (Line(points={{-26,-123},
          {-26,-123},{-22,-123}}, color={0,127,255}));
  connect(inSplVal3.port_2, radRo2.port_a)
    annotation (Line(points={{34,-123},{36,-123}}, color={0,127,255}));
  connect(inSplVal2.port_3,inSplVal3. port_1) annotation (Line(points={{-31,
          -128},{-32,-128},{-32,-156},{22,-156},{22,-123},{24,-123}}, color=
         {0,127,255}));
  connect(inSplVal4.port_1,inSplVal3. port_3) annotation (Line(points={{-16,
          -169},{-20,-169},{-20,-158},{29,-158},{29,-128}},
                            color={0,127,255}));
  connect(inSplVal5.port_1,inSplVal4. port_3) annotation (Line(points={{24,
          -203},{24,-203},{22,-203},{22,-174},{-11,-174}}, color={0,127,255}));
  connect(inSplVal5.port_2, radRo3.port_a)
    annotation (Line(points={{34,-203},{38,-203}}, color={0,127,255}));
  connect(inSplVal5.port_3, radBth.port_a) annotation (Line(points={{29,-208},{
          30,-208},{30,-244},{-38,-244},{-38,-203},{-16,-203}}, color={0,127,
          255}));
  connect(valRo1.port_b, outSplVal2.port_1)
    annotation (Line(points={{4,-123},{6,-123}}, color={0,127,255}));
  connect(valRo3.port_b, outSplVal5.port_1)
    annotation (Line(points={{64,-203},{66,-203}}, color={0,127,255}));
  connect(valBth.port_b, outSplVal5.port_3) annotation (Line(points={{14,-203},
          {18,-203},{18,-244},{71,-244},{71,-208}}, color={0,127,255}));
  connect(outSplVal5.port_2,outSplVal4. port_3) annotation (Line(points={{
          76,-203},{78,-203},{78,-204},{78,-192},{78,-190},{33,-190},{33,
          -174}}, color={0,127,255}));
  connect(radHal.port_b, outSplVal4.port_1)
    annotation (Line(points={{24,-169},{28,-169}}, color={0,127,255}));
  connect(conHeaRo2.yHea, valRo2.y) annotation (Line(points={{54.6,-140},{57,
          -140},{57,-129}}, color={0,0,127}));
  connect(valRo2.port_b, outSplVal3.port_1)
    annotation (Line(points={{62,-123},{64,-123}}, color={0,127,255}));
  connect(outSplVal3.port_2,outSplVal2. port_3) annotation (Line(points={{74,-123},
          {42,-123},{42,-186},{11,-186},{11,-128}},           color={0,127,255}));
  connect(outSplVal4.port_2,outSplVal3. port_3) annotation (Line(points={{38,-169},
          {38,-174},{78,-174},{78,-134},{69,-134},{69,-128}},
                                                    color={0,127,255}));
  connect(inSplVal4.port_2,res. port_a)
    annotation (Line(points={{-6,-169},{-2,-169}}, color={0,127,255}));
  connect(res.port_b, radHal.port_a)
    annotation (Line(points={{6,-169},{10,-169}}, color={0,127,255}));
  connect(conHeaRo1.yHea, valRo1.y) annotation (Line(points={{-3.2,-140},{-1,
          -140},{-1,-129}}, color={0,0,127}));
  connect(realExpression30.y, conHeaLiv.TSet) annotation (Line(points={{-73.7,
          -143},{-72,-143},{-72,-142.667},{-68.64,-142.667}}, color={0,0,127}));
  connect(realExpression31.y,conHeaLiv. T) annotation (Line(points={{-73.7,-147},
          {-71.85,-147},{-71.85,-144},{-68.64,-144}},color={0,0,127}));
  connect(conHeaLiv.yHea, valLiv.y) annotation (Line(points={{-59.2,-144},{-56,
          -144},{-56,-125},{-59,-125}}, color={0,0,127}));
  connect(inSplVal1.port_2,rad_Salon. port_a) annotation (Line(points={{-82,
          -119},{-80,-119}},      color={0,127,255}));
  connect(valLiv.port_b, outSplVal1.port_1) annotation (Line(points={{-54,-119},
          {-54,-119},{-52,-119}}, color={0,127,255}));
  connect(inSplVal1.port_3,inSplVal2. port_1) annotation (Line(points={{-85,
          -122},{-86,-122},{-86,-130},{-38,-130},{-38,-123},{-36,-123}},
        color={0,127,255}));
  connect(outSplVal2.port_2,outSplVal1. port_2) annotation (Line(points={{16,-123},
          {18,-123},{18,-122},{18,-154},{-42,-154},{-42,-119}}, color={0,127,255}));
  connect(rad_Salon.port_b, valLiv.port_a)
    annotation (Line(points={{-66,-119},{-64,-119}}, color={0,127,255}));
  connect(rad_Salon.heatPortCon,heatFlowSensor_Salon_Conv. port_a) annotation (
      Line(points={{-74.4,-113.96},{-74.4,-112.98},{-76,-112.98},{-76,-104}},
        color={191,0,0}));
  connect(heatFlowSensor_Salon_Conv.port_b, liv.heaPorAir) annotation (Line(
        points={{-76,-96},{-74,-96},{-74,-74},{-82,-74},{-82,8},{-80,8},{-80,22},
          {-88.4,22}},          color={191,0,0}));
  connect(rad_Salon.heatPortRad,heatFlowSensor_Salon_Rad. port_a) annotation (
      Line(points={{-71.6,-113.96},{-71.6,-112.98},{-70,-112.98},{-70,-104}},
        color={191,0,0}));
  connect(heatFlowSensor_Salon_Rad.port_b, liv.heaPorRad) annotation (Line(
        points={{-70,-96},{-70,-76},{-82,-76},{-82,20.48},{-88.4,20.48}},
                                      color={191,0,0}));
  connect(radRo1.heatPortRad, heatFlowSensor_Chambre1_Rad.port_a) annotation (
      Line(points={{-13.6,-117.96},{-13.6,-114.98},{-10,-114.98},{-10,-104}},
        color={191,0,0}));
  connect(heatFlowSensor_Chambre1_Rad.port_b, ro1.heaPorRad) annotation (Line(
        points={{-10,-96},{86,-96},{86,8},{0,8},{0,16},{-4,16},{-4,16.48},{-8.4,
          16.48}},       color={191,0,0}));
  connect(radRo1.heatPortCon, heatFlowSensor_Chambre1_Conv.port_a) annotation (
      Line(points={{-16.4,-117.96},{-16.4,-115.98},{-16,-115.98},{-16,-104}},
        color={191,0,0}));
  connect(heatFlowSensor_Chambre1_Conv.port_b, ro1.heaPorAir) annotation (Line(
        points={{-16,-96},{86,-96},{86,8},{0,8},{0,18},{-8.4,18}},
        color={191,0,0}));
  connect(radRo2.heatPortCon, heatFlowSensor_Chambre2_Conv.port_a) annotation (
      Line(points={{41.6,-117.96},{41.6,-116.98},{40,-116.98},{40,-104}}, color=
         {191,0,0}));
  connect(heatFlowSensor_Chambre2_Conv.port_b, ro2.heaPorAir) annotation (Line(
        points={{40,-96},{86,-96},{86,8},{58,8},{58,18},{49.6,18}},
        color={191,0,0}));
  connect(radRo2.heatPortRad, heatFlowSensor_Chambre2_Rad.port_a) annotation (
      Line(points={{44.4,-117.96},{44.4,-115.98},{46,-115.98},{46,-104}}, color=
         {191,0,0}));
  connect(heatFlowSensor_Chambre2_Rad.port_b, ro2.heaPorRad) annotation (Line(
        points={{46,-96},{86,-96},{86,8},{58,8},{58,16},{54,16},{54,16.48},{
          49.6,16.48}},  color={191,0,0}));
  connect(radHal.heatPortCon, heatFlowSensor_Couloir_Conv.port_a) annotation (
      Line(points={{15.6,-163.96},{15.6,-153.98},{14,-153.98},{14,-104}}, color=
         {191,0,0}));
  connect(heatFlowSensor_Couloir_Conv.port_b, hal.heaPorAir) annotation (Line(
        points={{14,-96},{14,-98},{86,-98},{86,-14},{60,-14},{60,-10},{51.6,-10}},
        color={191,0,0}));
  connect(radHal.heatPortRad, heatFlowSensor_Couloir_Rad.port_a) annotation (
      Line(points={{18.4,-163.96},{18.4,-104},{20,-104}}, color={191,0,0}));
  connect(heatFlowSensor_Couloir_Rad.port_b, hal.heaPorRad) annotation (Line(
        points={{20,-96},{86,-96},{86,-14},{60,-14},{60,-12},{51.6,-12},{51.6,
          -11.52}},       color={191,0,0}));
  connect(radBth.heatPortCon, heatFlowSensor_SDB_Conv.port_a) annotation (Line(
        points={{-10.4,-197.96},{-10.4,-195.98},{-12,-195.98},{-12,-194}},
        color={191,0,0}));
  connect(heatFlowSensor_SDB_Conv.port_b,bth. heaPorAir) annotation (Line(
        points={{-12,-186},{-12,-180},{86,-180},{86,-76},{-2,-76},{-2,-54},{
          -10.4,-54}},
                 color={191,0,0}));
  connect(radBth.heatPortRad, heatFlowSensor_SDB_Rad.port_a) annotation (Line(
        points={{-7.6,-197.96},{-7.6,-195.98},{-6,-195.98},{-6,-194}}, color={
          191,0,0}));
  connect(heatFlowSensor_SDB_Rad.port_b,bth. heaPorRad) annotation (Line(points={{-6,-186},
          {-6,-180},{86,-180},{86,-76},{-2,-76},{-2,-55.52},{-10.4,-55.52}},
        color={191,0,0}));
  connect(radRo3.heatPortCon, heatFlowSensor_Chambre3_Conv.port_a) annotation (
      Line(points={{43.6,-197.96},{43.6,-196.98},{42,-196.98},{42,-194}}, color=
         {191,0,0}));
  connect(heatFlowSensor_Chambre3_Conv.port_b, ro3.heaPorAir) annotation (Line(
        points={{42,-186},{42,-178},{86,-178},{86,-74},{60,-74},{60,-54},{49.6,-54}},
        color={191,0,0}));
  connect(radRo3.heatPortRad, heatFlowSensor_Chambre3_Rad.port_a) annotation (
      Line(points={{46.4,-197.96},{46.4,-196.98},{48,-196.98},{48,-194}}, color=
         {191,0,0}));
  connect(heatFlowSensor_Chambre3_Rad.port_b, ro3.heaPorRad) annotation (Line(
        points={{48,-186},{48,-178},{86,-178},{86,-74},{60,-74},{60,-55.52},{49.6,
          -55.52}}, color={191,0,0}));
  connect(THal.T, conCooHal.T) annotation (Line(points={{64,-10},{68,-10},{68,
          -9},{73.68,-9}}, color={0,0,127}));
  connect(conCooHal.TSet, expCooHal.y) annotation (Line(points={{73.68,-9.66667},
          {70.7,-9.66667},{70.7,-12},{70.2,-12}}, color={0,0,127}));
  connect(conCooHal.P, hal.heaPorAir) annotation (Line(points={{78,-9},{86,-9},
          {86,-14},{60,-14},{60,-10},{51.6,-10}}, color={191,0,0}));
  connect(spl.port_1, temRet.port_b) annotation (Line(points={{-108,-175},{-108,
          -174},{-102,-174}}, color={0,127,255}));
  connect(spl.port_3, valBoi.port_3)
    annotation (Line(points={{-113,-170},{-113,-144}}, color={0,127,255}));
  connect(weaBus.TDryBul,heaCha. TOut) annotation (Line(
      points={{-164,56},{-164,-94},{-146,-94},{-146,-110.8},{-144.4,-110.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(realExpression29.y,heaCha. TRoo_in) annotation (Line(points={{-149.7,
          -113},{-146,-113},{-146,-113.2},{-144.38,-113.2}}, color={0,0,127}));
  connect(valBoi.port_2, temSup.port_a)
    annotation (Line(points={{-108,-139},{-104,-139}}, color={0,127,255}));
  connect(boi.port_b, valBoi.port_1) annotation (Line(points={{-129.8,-139.091},
          {-124,-139.091},{-124,-139},{-118,-139}}, color={0,127,255}));
  connect(spl.port_2, boi.port_a) annotation (Line(points={{-118,-175},{-118,
          -176},{-156,-176},{-156,-139.091},{-150.4,-139.091}},
                                                          color={0,127,255}));
  connect(temSup.port_b, massFlowRate.port_a) annotation (Line(points={{-94,
          -139},{-92,-139},{-92,-130},{-91,-130}},
                                             color={0,127,255}));
  connect(temRet.port_a, pumEmiSystem.port_b) annotation (Line(points={{-94,-174},
          {-92,-174},{-92,-175},{-88,-175}}, color={0,127,255}));
  connect(pumEmiSystem.port_a, outSplVal1.port_3) annotation (Line(points={{-78,
          -175},{-78,-174},{-47,-174},{-47,-124}}, color={0,127,255}));
  connect(booDHW.y, boi.Mode_ECS) annotation (Line(points={{-177.4,-162},{-158,
          -162},{-158,-146.909},{-152,-146.909}}, color={255,0,255}));
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
  connect(SetSecurityBoiler.y, conBoiSaf.TSet) annotation (Line(points={{-313.3,
          -178},{-308.04,-178},{-308.04,-180.167}}, color={0,0,127}));
  connect(booleanToReal1.u,realToBoolean1. y) annotation (Line(points={{-269.2,-182},
          {-273.4,-182}},            color={255,0,255}));
  connect(conBoiSaf.yHea, realToBoolean1.u) annotation (Line(points={{-292.7,-182.5},
          {-286.35,-182.5},{-286.35,-182},{-287.2,-182}}, color={0,0,127}));
  connect(booleanToReal1.y,product1. u2) annotation (Line(points={{-255.4,-182},
          {-240,-182}},                color={0,0,127}));
  connect(conHeaModeBoiler.y, switch4.u1) annotation (Line(points={{-259.4,-216},
          {-244.7,-216},{-244.7,-221.2},{-235.2,-221.2}}, color={0,0,127}));
  connect(switch4.u3, BoilerSafetyMode.y) annotation (Line(points={{-235.2,-230.8},
          {-242,-230.8},{-242,-244},{-245.3,-244}}, color={0,0,127}));
  connect(onOffController.y, switch4.u2) annotation (Line(points={{-275,-232},{-246,
          -232},{-246,-226},{-235.2,-226}}, color={255,0,255}));
  connect(HeaSetLiv.y, conHeaModeBoiler.u_s) annotation (Line(points={{-328.1,-210},
          {-306,-210},{-306,-216},{-273.2,-216}}, color={0,0,127}));
  connect(expTLiv.y, conHeaModeBoiler.u_m) annotation (Line(points={{-326.1,-247},
          {-266,-247},{-266,-223.2}}, color={0,0,127}));
  connect(boi.T, conBoiSaf.T) annotation (Line(points={{-128.2,-134},{-122,-134},
          {-122,-130},{-216,-130},{-216,-144},{-336,-144},{-336,-182.267},{
          -308.04,-182.267}},
                    color={0,0,127}));
  connect(expTLiv.y, onOffController.u) annotation (Line(points={{-326.1,-247},
          {-314,-247},{-314,-238},{-298,-238}}, color={0,0,127}));
  connect(product1.y, switch1.u1) annotation (Line(points={{-217,-176},{-208,-176},
          {-208,-152},{-256,-152},{-256,-115},{-251,-115}}, color={0,0,127}));
  connect(product1.y, greaterThreshold.u) annotation (Line(points={{-217,-176},{
          -208,-176},{-208,-152},{-308,-152},{-308,-119},{-301,-119}}, color={0,
          0,127}));
  connect(switch4.y, product1.u1) annotation (Line(points={{-221.4,-226},{-218,
          -226},{-218,-196},{-248,-196},{-248,-170},{-240,-170}},
                                                            color={0,0,127}));
  connect(expTLiv.y, conPumHea.T) annotation (Line(points={{-326.1,-247},{-314,
          -247},{-314,-199.2},{-208.8,-199.2}},
                                            color={0,0,127}));
  connect(bou.ports[1], temRet.port_a) annotation (Line(points={{-102,-190},{
          -94,-190},{-94,-174}},
                             color={0,127,255}));
  connect(expCooLiv.y, conCooLiv.TSet) annotation (Line(points={{-73.8,16},{-70,
          16},{-70,18.3333},{-66.32,18.3333}}, color={0,0,127}));
  connect(switch1.y, boi.y) annotation (Line(points={{-239.5,-119},{-184,-119},
          {-184,-134},{-152,-134}}, color={0,0,127}));
  connect(TRo1.T, conCooRo1.T) annotation (Line(points={{6,18},{8,18},{8,15},{
          9.68,15}}, color={0,0,127}));
  connect(HeaSetLiv.y, onOffController.reference) annotation (Line(points={{-328.1,
          -210},{-306,-210},{-306,-226},{-298,-226}}, color={0,0,127}));
  connect(massFlowRate.port_b, inSplVal1.port_1) annotation (Line(points={{-91,
          -124},{-92,-124},{-92,-119},{-88,-119}}, color={0,127,255}));
  connect(schGeneral.HeaSetRT12, reaTSetHea.u) annotation (Line(points={{-352,
          38},{-336,38},{-336,43},{-332.6,43}}, color={0,0,127}));
  connect(schGeneral.CooSetRT12, reaTSetCoo.u) annotation (Line(points={{-352,
          34.6},{-346,34.6},{-346,33},{-332.6,33}}, color={0,0,127}));
  connect(realExpression13.y,reaHeaLiv. u)
    annotation (Line(points={{-77.7,-157},{-70.6,-157}}, color={0,0,127}));
  connect(realExpression15.y, reaHeaRo1.u)
    annotation (Line(points={{-17.7,-149},{-10.6,-149}}, color={0,0,127}));
  connect(realExpression16.y, reaHeaRo2.u)
    annotation (Line(points={{38.3,-149},{45.4,-149}}, color={0,0,127}));
  connect(realExpression18.y, reaHeaRo3.u)
    annotation (Line(points={{40.3,-231},{45.4,-231}}, color={0,0,127}));
  connect(realExpression23.y, conHeaRo3.T) annotation (Line(points={{40.3,-225},
          {42.15,-225},{42.15,-222},{49.52,-222}},color={0,0,127}));
  connect(realExpression27.y, reaHeaBth.u)
    annotation (Line(points={{-19.7,-229},{-14.6,-229}}, color={0,0,127}));
  connect(realExpression32.y, reaHeaHal.u)
    annotation (Line(points={{48.3,-169},{51.4,-169}}, color={0,0,127}));
  connect(realExpression28.y, reaTHal.u)
    annotation (Line(points={{66.3,-169},{69.4,-169}}, color={0,0,127}));
  connect(T_Combles.T, reaTAti.u) annotation (Line(points={{-206,-10},{-202,-10},
          {-202,-1},{-196.6,-1}}, color={0,0,127}));
  connect(TGar.T, reaTGar.u) annotation (Line(points={{-116,-48},{-114,-48},{-114,
          -47},{-110.6,-47}}, color={0,0,127}));
  connect(weaDat.weaBus, weatherStation.weaBus) annotation (Line(
      points={{-276,56},{-214,56},{-214,79.9},{-199.9,79.9}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,infRo1. weaBus) annotation (Line(
      points={{-276,56},{-42,56},{-42,10},{-24,10}},
      color={255,204,51},
      thickness=0.5));
  connect(infRo1.ports_b, ro1.ports[3:4]) annotation (Line(points={{-20.2,10},{
          -16,10},{-16,15.2},{-14,15.2}}, color={0,127,255}));
  connect(infRo2.ports_b, ro2.ports[3:4]) annotation (Line(points={{35.8,12},{
          42,12},{42,15.2},{44,15.2}}, color={0,127,255}));
  connect(infRo2.weaBus, weaDat.weaBus) annotation (Line(
      points={{32,12},{18,12},{18,56},{-276,56}},
      color={255,204,51},
      thickness=0.5));
  connect(infRo3.ports_b, ro3.ports[3:4]) annotation (Line(points={{35.8,-70},{
          42,-70},{42,-56.8},{44,-56.8}}, color={0,127,255}));
  connect(infRo3.weaBus, weaDat.weaBus) annotation (Line(
      points={{32,-70},{30,-70},{30,-94},{-164,-94},{-164,56},{-276,56}},
      color={255,204,51},
      thickness=0.5));
  connect(nightSch1.y, genCO2Ro1.occFrac)
    annotation (Line(points={{-29.7,14},{-24.4,14}}, color={0,0,127}));
  connect(genCO2Ro1.y, ro1.C_flow[1]) annotation (Line(points={{-19.8,14},{-18,
          14},{-18,19.12},{-16.64,19.12}}, color={0,0,127}));
  connect(nightSch2.y, genCO2Ro2.occFrac)
    annotation (Line(points={{28.3,16},{31.6,16}}, color={0,0,127}));
  connect(genCO2Ro2.y, ro2.C_flow[1]) annotation (Line(points={{36.2,16},{38,16},
          {38,19.12},{41.36,19.12}}, color={0,0,127}));
  connect(nightSch3.y, genCO2Ro3.occFrac)
    annotation (Line(points={{28.3,-66},{31.6,-66}}, color={0,0,127}));
  connect(genCO2Ro3.y, ro3.C_flow[1]) annotation (Line(points={{36.2,-66},{40,
          -66},{40,-52.88},{41.36,-52.88}}, color={0,0,127}));
  connect(infHal.ports_b, hal.ports[11:12]) annotation (Line(points={{39.8,-6},
          {42,-6},{42,-12.5333},{46,-12.5333}}, color={0,127,255}));
  connect(extBth.ports_b, bth.ports[3:4]) annotation (Line(points={{-24.2,-60},
          {-20,-60},{-20,-56.8},{-16,-56.8}}, color={0,127,255}));
  connect(extBth.weaBus, bth.weaBus) annotation (Line(
      points={{-28,-60},{-32,-60},{-32,-94},{-2.84,-94},{-2.84,-46.84}},
      color={255,204,51},
      thickness=0.5));
  connect(infHal.weaBus, hal.weaBus) annotation (Line(
      points={{36,-6},{34,-6},{34,0},{48,0},{48,-2.84},{59.16,-2.84}},
      color={255,204,51},
      thickness=0.5));
  connect(daySch.y, genCO2Liv.occFrac)
    annotation (Line(points={{-111.7,22},{-108.4,22}}, color={0,0,127}));
  connect(genCO2Liv.y, liv.C_flow[1]) annotation (Line(points={{-103.8,22},{
          -102,22},{-102,23.12},{-96.64,23.12}}, color={0,0,127}));
  connect(dooLiv.port_a1, liv.ports[1]) annotation (Line(points={{-45,-7.8},{-94,
          -7.8},{-94,16.72}}, color={0,127,255}));
  connect(dooLiv.port_b2, liv.ports[2]) annotation (Line(points={{-45,-13.2},{-94,
          -13.2},{-94,17.36}}, color={0,127,255}));
  connect(extLiv.ports_b, liv.ports[3:5]) annotation (Line(points={{-104.2,18},
          {-100,18},{-100,19.28},{-94,19.28}}, color={0,127,255}));
  connect(extLiv.weaBus, liv.weaBus) annotation (Line(
      points={{-108,18},{-132,18},{-132,56},{-80.84,56},{-80.84,29.16}},
      color={255,204,51},
      thickness=0.5));
  connect(infAti.ports_b, ati.ports[1:3]) annotation (Line(points={{-234.2,-24},
          {-230,-24},{-230,-12.9333},{-226,-12.9333}}, color={0,127,255}));
  connect(infAti.weaBus, weaDat.weaBus) annotation (Line(
      points={{-238,-24},{-266,-24},{-266,56},{-276,56}},
      color={255,204,51},
      thickness=0.5));
  connect(infGar.ports_b, gar.ports[1:3]) annotation (Line(points={{-144.2,-56},
          {-140,-56},{-140,-50.9333},{-136,-50.9333}}, color={0,127,255}));
  connect(infGar.weaBus, gar.weaBus) annotation (Line(
      points={{-148,-56},{-152,-56},{-152,-94},{-122.84,-94},{-122.84,-40.84}},
      color={255,204,51},
      thickness=0.5));

  connect(temSup.T, reaTSup.u) annotation (Line(points={{-99,-133.5},{-99,-128},
          {-101.2,-128}}, color={0,0,127}));
  connect(reaTSup.y, conHeaTSup.T) annotation (Line(points={{-110.4,-128},{-124,
          -128},{-124,-111.867},{-122.48,-111.867}}, color={0,0,127}));
  connect(heaCha.TSup, oveTSetSup.u) annotation (Line(points={{-139.8,-110.8},{
          -137.2,-110.8},{-137.2,-111},{-134.6,-111}}, color={0,0,127}));
  connect(oveTSetSup.y, conHeaTSup.TSet) annotation (Line(points={{-127.7,-111},
          {-123.9,-111},{-123.9,-110.667},{-122.48,-110.667}}, color={0,0,127}));
  connect(conHeaTSup.yHea, oveMixValSup.u) annotation (Line(points={{-115.4,
          -112},{-113,-112},{-113,-115.4}}, color={0,0,127}));
  connect(oveMixValSup.y, valBoi.y)
    annotation (Line(points={{-113,-122.3},{-113,-133}}, color={0,0,127}));
  connect(conPumHea.yHea, oveEmiPum.u)
    annotation (Line(points={{-197,-199},{-190.6,-199}}, color={0,0,127}));
  connect(oveEmiPum.y, pumEmiSystem.m_flow_in) annotation (Line(points={{-183.7,
          -199},{-83,-199},{-83,-181}}, color={0,0,127}));
  connect(boi.m_PompeCirc, pumEmiSystem.m_flow_in) annotation (Line(points={{-152,
          -143.636},{-168,-143.636},{-168,-199},{-83,-199},{-83,-181}},
        color={0,0,127}));
  connect(HeaSetLiv.y, oveTSetPum.u) annotation (Line(points={{-328.1,-210},{
          -314,-210},{-314,-206},{-238.8,-206}}, color={0,0,127}));
  connect(oveTSetPum.y, conPumHea.TSet) annotation (Line(points={{-229.6,-206},
          {-226,-206},{-226,-201},{-208.8,-201}}, color={0,0,127}));
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
          extent={{-156,8},{-114,-44}},
          lineColor={28,108,200},
          textString="Garage (Gar)"),
        Text(
          extent={{-34,74},{4,22}},
          lineColor={28,108,200},
          textString="Room1 (Ro1)"),
        Text(
          extent={{36,-52},{74,-110}},
          lineColor={28,108,200},
          textString="Room3 (Ro3)"),
        Text(
          extent={{20,72},{56,22}},
          lineColor={28,108,200},
          textString="Room2 (Ro2)"),
        Text(
          extent={{-30,-64},{14,-98}},
          lineColor={28,108,200},
          textString="Bathroom (Bth)"),
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
          extent={{-256,22},{-220,-6}},
          lineColor={28,108,200},
          textString="Attic (Ati)"),
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
          extent={{-30,-88},{6,-136}},
          lineColor={28,108,200},
          textString="Room1 (Ro1)"),
        Text(
          extent={{42,-86},{78,-138}},
          lineColor={28,108,200},
          textString="Room2 (Ro2)"),
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
          extent={{30,-210},{70,-266}},
          lineColor={28,108,200},
          textString="Room3 (Ro3)"),
        Text(
          extent={{-42,-156},{-16,-188}},
          lineColor={28,108,200},
          textString="Hall (Hal)"),
        Text(
          extent={{-98,-36},{-40,-86}},
          lineColor={28,108,200},
          textString="Living room (Liv)"),
        Text(
          extent={{-32,-220},{12,-256}},
          lineColor={28,108,200},
          textString="Bathroom (Bth)"),
        Text(
          extent={{48,16},{74,-12}},
          lineColor={28,108,200},
          textString="Hall (Hal)"),
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
          extent={{-128,-202},{-66,-270}},
          lineColor={28,108,200},
          textString="Living room (Liv)")}),
    Documentation(info="<html>
<p>
This is the multi zone residential hydronic emulator model
of BOPTEST.
</p>
<h3>Building Design and Use</h3>
<h4>Architecture</h4>
<p>
The emulator building model represents a residential French
dwelling compliant with the French Thermal regulation of 2012,
i.e. the French national building energy regulation. Therefore,
the typology is defined to be representative of French new
dwellings. 
The area not including the unconditioned attic and unconditioned 
garage is of 81.08 m&sup2;.
The following figure shows the building layout and
a sketch of the hydraulic system. The coloured elements in the scheme
represent the controllable components
through the BOPTEST interface. The dimensions are provided in metres.

</p>
<p align=\"center\">
<img alt=\"Simulated residential dwelling\"
src=\"../../Resources/layout.png\">
</p>

<p>
The orientation of each building was chosen to maximize the natural light during winter.
Thus, the main surface of windows of the building is south oriented.
The building consists of six thermal zones that are actively controlled and two unconditioned
zones:
</p>
<ul>
<li>1 Living room/kitchen (<b>Liv</b>) </li>
<li>3 Bedrooms: two south facing (<b>Ro1</b>, <b>Ro2</b>), and one north facing (<b>Ro3</b>) </li>
<li>1 Bathroom (<b>Bth</b>) </li>
<li>1 Hallway/corridor (<b>Hal</b>) serving the sleeping area: bedrooms and bathroom </li>
<li>1 Unconditioned garage (<b>Gar</b>) </li>
<li>1 Unconditioned attic (<b>Ati</b>) </li>
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
The thermal bridges effect is modeled through thermal resistances that are
parameterized with the length of the bridge element and a thermal coefficient (<i>k_PT</i>).
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
During the periods that the building is occupied, the occupants are considered to be either
all in the living room during day-time, or distributed in their rooms during night-time.
There is a short transition period (one hour) on the switching between day- and night-time when
the living room and bedrooms are considered to be occupied to half of their nominal capacity each.
A reduction of 30&percnt; of the internal loads due to occupants is observed during the night-time.
</p>
<p>
On a yearly basis, the building is considered unoccupied one week at the end of December and
two weeks in August.
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
day long during weekends. Otherwise, this level is reduced by 80&percnt;.
</p>
<h4>Climate data</h4>
<p>
The model uses a climate file containing one year
of weather data for Bordeaux, France  (FRA_Bordeaux.075100_IWEC.mos).
The ground temperature is assumed to be a sinusoidal signal with an amplitude
of 2&deg;C oscilating with a yearly period around 15&deg;C.
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
<p>
The building is in cooling mode until March 29th (day 88 of the year), and from October 28th (day 301 of the year).
During this period, ideal cooling is considered in all conditioned zones with a PI controller in each zone.
This controller provides the cooling thermal power required to comply with the cooling setpoint in every zone.
</p>
<h4>Equipment specifications and performance maps</h4>
<p>
The boiler uses an efficiency curve constant with coefficient 0.9.
The heating system circulation pump uses an efficiency curve that is function of the
mass flow rate of water through the emission system.
Air cooling is modeled with a constant energy efficiency ratio of 3.
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
The emission circuit pump is modulated by a PI controller
that observes the indoor air temperature setpoint (from the occupancy schedule) and the measured indoor
air temperature from the thermostat in the living room.
</li>
<li>
There is one radiator per zone with a motorized valve controlled by a PI controller
that follows the air zone temperature setpoint. Only the hallway zone has no valve and its hydronic
circuit remains always open to ensure that there iswater flow. This is a typical layout that avoids
vacuum failures when all valves are closed while the distribution pump is working.
</li>
</ul>

<h3>Model IO's</h3>
<h4>Inputs</h4>
<p>The model inputs are: </p>
<ul>
<li>
<code>boi_oveBoi_u</code> [1] [min=0.0, max=1.0]: Boiler control signal for part load ratio
</li>
<li>
<code>conCooBth_oveCoo_u</code> [1] [min=0.0, max=1.0]: Cooling control signal as fraction of maximum for zone Bth
</li>
<li>
<code>conCooBth_oveTSetCoo_u</code> [K] [min=283.15, max=303.15]: Air temperature cooling setpoint for zone Bth
</li>
<li>
<code>conCooHal_oveCoo_u</code> [1] [min=0.0, max=1.0]: Cooling control signal as fraction of maximum for zone Hal
</li>
<li>
<code>conCooHal_oveTSetCoo_u</code> [K] [min=283.15, max=303.15]: Air temperature cooling setpoint for zone Hal
</li>
<li>
<code>conCooLiv_oveCoo_u</code> [1] [min=0.0, max=1.0]: Cooling control signal as fraction of maximum for zone Liv
</li>
<li>
<code>conCooLiv_oveTSetCoo_u</code> [K] [min=283.15, max=303.15]: Air temperature cooling setpoint for zone Liv
</li>
<li>
<code>conCooRo1_oveCoo_u</code> [1] [min=0.0, max=1.0]: Cooling control signal as fraction of maximum for zone Ro1
</li>
<li>
<code>conCooRo1_oveTSetCoo_u</code> [K] [min=283.15, max=303.15]: Air temperature cooling setpoint for zone Ro1
</li>
<li>
<code>conCooRo2_oveCoo_u</code> [1] [min=0.0, max=1.0]: Cooling control signal as fraction of maximum for zone Ro2
</li>
<li>
<code>conCooRo2_oveTSetCoo_u</code> [K] [min=283.15, max=303.15]: Air temperature cooling setpoint for zone Ro2
</li>
<li>
<code>conCooRo3_oveCoo_u</code> [1] [min=0.0, max=1.0]: Cooling control signal as fraction of maximum for zone Ro3
</li>
<li>
<code>conCooRo3_oveTSetCoo_u</code> [K] [min=283.15, max=303.15]: Air temperature cooling setpoint for zone Ro3
</li>
<li>
<code>conHeaBth_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating valve for zone Bth
</li>
<li>
<code>conHeaBth_oveTSetHea_u</code> [K] [min=283.15, max=368.15]: Air temperature heating setpoint for zone Bth
</li>
<li>
<code>conHeaLiv_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating valve for zone Liv
</li>
<li>
<code>conHeaLiv_oveTSetHea_u</code> [K] [min=283.15, max=368.15]: Air temperature heating setpoint for zone Liv
</li>
<li>
<code>conHeaRo1_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating valve for zone Ro1
</li>
<li>
<code>conHeaRo1_oveTSetHea_u</code> [K] [min=283.15, max=368.15]: Air temperature heating setpoint for zone Ro1
</li>
<li>
<code>conHeaRo2_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating valve for zone Ro2
</li>
<li>
<code>conHeaRo2_oveTSetHea_u</code> [K] [min=283.15, max=368.15]: Air temperature heating setpoint for zone Ro2
</li>
<li>
<code>conHeaRo3_oveActHea_u</code> [1] [min=0.0, max=1.0]: Actuator signal for heating valve for zone Ro3
</li>
<li>
<code>conHeaRo3_oveTSetHea_u</code> [K] [min=283.15, max=368.15]: Air temperature heating setpoint for zone Ro3
</li>
<li>
<code>oveEmiPum_u</code> [1] [min=0.0, max=1.0]: Control signal to the circulation pump of the emission system
</li>
<li>
<code>oveMixValSup_u</code> [1] [min=0.0, max=1.0]: Actuator signal for 0three-way mixing valve controlling supply water temperature to radiators
</li>
<li>
<code>oveTSetPum_u</code> [K] [min=283.15, max=368.15]: Heating zone air temperature setpoint used to control circulation pump of the emission system
</li>
<li>
<code>oveTSetSup_u</code> [K] [min=283.15, max=368.15]: Supply water temperature setpoint to radiators
</li>
</ul>

<h4>Outputs</h4>
<p>The model outputs are: </p>
<ul>
<li>
<code>boi_reaGasBoi_y</code> [W] [min=None, max=None]: Boiler gas power use
</li>
<li>
<code>boi_reaPpum_y</code> [W] [min=None, max=None]: Boiler pump electrical power use
</li>
<li>
<code>conCooBth_reaCoo_y</code> [1] [min=None, max=None]: Cooling control signal measurement as fraction of maximum for zone Bth
</li>
<li>
<code>conCooBth_reaPCoo_y</code> [W] [min=None, max=None]: Cooling electrical power use in zone Bth
</li>
<li>
<code>conCooHal_reaCoo_y</code> [1] [min=None, max=None]: Cooling control signal measurement as fraction of maximum for zone Hal
</li>
<li>
<code>conCooHal_reaPCoo_y</code> [W] [min=None, max=None]: Cooling electrical power use in zone Hal
</li>
<li>
<code>conCooLiv_reaCoo_y</code> [1] [min=None, max=None]: Cooling control signal measurement as fraction of maximum for zone Liv
</li>
<li>
<code>conCooLiv_reaPCoo_y</code> [W] [min=None, max=None]: Cooling electrical power use in zone Liv
</li>
<li>
<code>conCooRo1_reaCoo_y</code> [1] [min=None, max=None]: Cooling control signal measurement as fraction of maximum for zone Ro1
</li>
<li>
<code>conCooRo1_reaPCoo_y</code> [W] [min=None, max=None]: Cooling electrical power use in zone Ro1
</li>
<li>
<code>conCooRo2_reaCoo_y</code> [1] [min=None, max=None]: Cooling control signal measurement as fraction of maximum for zone Ro2
</li>
<li>
<code>conCooRo2_reaPCoo_y</code> [W] [min=None, max=None]: Cooling electrical power use in zone Ro2
</li>
<li>
<code>conCooRo3_reaCoo_y</code> [1] [min=None, max=None]: Cooling control signal measurement as fraction of maximum for zone Ro3
</li>
<li>
<code>conCooRo3_reaPCoo_y</code> [W] [min=None, max=None]: Cooling electrical power use in zone Ro3
</li>
<li>
<code>conHeaBth_reaActHea_y</code> [1] [min=None, max=None]: Actuator signal measurement for heating valve for zone Bth
</li>
<li>
<code>conHeaBth_reaTZon_y</code> [K] [min=None, max=None]: Air temperature of zone Bth
</li>
<li>
<code>conHeaLiv_reaActHea_y</code> [1] [min=None, max=None]: Actuator signal measurement for heating valve for zone Liv
</li>
<li>
<code>conHeaLiv_reaTZon_y</code> [K] [min=None, max=None]: Air temperature of zone Liv
</li>
<li>
<code>conHeaRo1_reaActHea_y</code> [1] [min=None, max=None]: Actuator signal measurement for heating valve for zone Ro1
</li>
<li>
<code>conHeaRo1_reaTZon_y</code> [K] [min=None, max=None]: Air temperature of zone Ro1
</li>
<li>
<code>conHeaRo2_reaActHea_y</code> [1] [min=None, max=None]: Actuator signal measurement for heating valve for zone Ro2
</li>
<li>
<code>conHeaRo2_reaTZon_y</code> [K] [min=None, max=None]: Air temperature of zone Ro2
</li>
<li>
<code>conHeaRo3_reaActHea_y</code> [1] [min=None, max=None]: Actuator signal measurement for heating valve for zone Ro3
</li>
<li>
<code>conHeaRo3_reaTZon_y</code> [K] [min=None, max=None]: Air temperature of zone Ro3
</li>
<li>
<code>extBth_reaCO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone Bth
</li>
<li>
<code>extLiv_reaCO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone Liv
</li>
<li>
<code>infAti_reaCO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone Ati
</li>
<li>
<code>infGar_reaCO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone Gar
</li>
<li>
<code>infHal_reaCO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone Hal
</li>
<li>
<code>infRo1_reaCO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone Ro1
</li>
<li>
<code>infRo2_reaCO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone Ro2
</li>
<li>
<code>infRo3_reaCO2RooAir_y</code> [ppm] [min=None, max=None]: Air CO2 concentration of zone Ro3
</li>
<li>
<code>reaHeaBth_y</code> [W] [min=None, max=None]: Heating delivered to Bth
</li>
<li>
<code>reaHeaHal_y</code> [W] [min=None, max=None]: Heating delivered to Hal
</li>
<li>
<code>reaHeaLiv_y</code> [W] [min=None, max=None]: Heating delivered to Liv
</li>
<li>
<code>reaHeaRo1_y</code> [W] [min=None, max=None]: Heating delivered to Ro1
</li>
<li>
<code>reaHeaRo2_y</code> [W] [min=None, max=None]: Heating delivered to Ro2
</li>
<li>
<code>reaHeaRo3_y</code> [W] [min=None, max=None]: Heating delivered to Ro3
</li>
<li>
<code>reaTAti_y</code> [K] [min=None, max=None]: Air temperature of zone Ati
</li>
<li>
<code>reaTGar_y</code> [K] [min=None, max=None]: Air temperature of zone Gar
</li>
<li>
<code>reaTHal_y</code> [K] [min=None, max=None]: Air temperature of zone Hal
</li>
<li>
<code>reaTSetCoo_y</code> [K] [min=None, max=None]: Building cooling air setpoint temperature
</li>
<li>
<code>reaTSetHea_y</code> [K] [min=None, max=None]: Building heating air setpoint temperature
</li>
<li>
<code>reaTSup_y</code> [K] [min=None, max=None]: Supply water temperature measurement to radiators
</li>
<li>
<code>weatherStation_reaWeaCeiHei_y</code> [m] [min=None, max=None]: Cloud cover ceiling height measurement
</li>
<li>
<code>weatherStation_reaWeaCloTim_y</code> [s] [min=None, max=None]: Day number with units of seconds
</li>
<li>
<code>weatherStation_reaWeaHDifHor_y</code> [W/m2] [min=None, max=None]: Horizontal diffuse solar radiation measurement
</li>
<li>
<code>weatherStation_reaWeaHDirNor_y</code> [W/m2] [min=None, max=None]: Direct normal radiation measurement
</li>
<li>
<code>weatherStation_reaWeaHGloHor_y</code> [W/m2] [min=None, max=None]: Global horizontal solar irradiation measurement
</li>
<li>
<code>weatherStation_reaWeaHHorIR_y</code> [W/m2] [min=None, max=None]: Horizontal infrared irradiation measurement
</li>
<li>
<code>weatherStation_reaWeaLat_y</code> [rad] [min=None, max=None]: Latitude of the location
</li>
<li>
<code>weatherStation_reaWeaLon_y</code> [rad] [min=None, max=None]: Longitude of the location
</li>
<li>
<code>weatherStation_reaWeaNOpa_y</code> [1] [min=None, max=None]: Opaque sky cover measurement
</li>
<li>
<code>weatherStation_reaWeaNTot_y</code> [1] [min=None, max=None]: Sky cover measurement
</li>
<li>
<code>weatherStation_reaWeaPAtm_y</code> [Pa] [min=None, max=None]: Atmospheric pressure measurement
</li>
<li>
<code>weatherStation_reaWeaRelHum_y</code> [1] [min=None, max=None]: Outside relative humidity measurement
</li>
<li>
<code>weatherStation_reaWeaSolAlt_y</code> [rad] [min=None, max=None]: Solar altitude angle measurement
</li>
<li>
<code>weatherStation_reaWeaSolDec_y</code> [rad] [min=None, max=None]: Solar declination angle measurement
</li>
<li>
<code>weatherStation_reaWeaSolHouAng_y</code> [rad] [min=None, max=None]: Solar hour angle measurement
</li>
<li>
<code>weatherStation_reaWeaSolTim_y</code> [s] [min=None, max=None]: Solar time
</li>
<li>
<code>weatherStation_reaWeaSolZen_y</code> [rad] [min=None, max=None]: Solar zenith angle measurement
</li>
<li>
<code>weatherStation_reaWeaTBlaSky_y</code> [K] [min=None, max=None]: Black-body sky temperature measurement
</li>
<li>
<code>weatherStation_reaWeaTDewPoi_y</code> [K] [min=None, max=None]: Dew point temperature measurement
</li>
<li>
<code>weatherStation_reaWeaTDryBul_y</code> [K] [min=None, max=None]: Outside drybulb temperature measurement
</li>
<li>
<code>weatherStation_reaWeaTWetBul_y</code> [K] [min=None, max=None]: Wet bulb temperature measurement
</li>
<li>
<code>weatherStation_reaWeaWinDir_y</code> [rad] [min=None, max=None]: Wind direction measurement
</li>
<li>
<code>weatherStation_reaWeaWinSpe_y</code> [m/s] [min=None, max=None]: Wind speed measurement
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
The model uses moist air despite that no condensation is modeled in any of the used components.
Also, latent heat gain by occupants is not modeled.
</p>
<h4>Pressure-flow models</h4>
<p>
A circulation loop with one parallel branch per zone is used to model the heating emission system.
</p>
<h4>Infiltration models</h4>
<p>
Mechanical ventilation from outside air and air exchange between zones are considered in the model.
The total value of the volumetric airflow exchanged is established according to the French
national regulations.
Specifically, outside fresh air is infiltrated in the garage and the attic at a rate of 0.5 ACH.
In the living room and bedrooms the total infiltrated air is of 113.4 m3/h, which is distributed
proportionally to the area of these zones.
There is not infiltration considered in the bathroom nor the hallway.
80&percnt; of the infiltrated air is exhausted through a fan in the bathroom.
This fan is not controllable and its electricity use is neglected.
The other 20&percnt; of the infiltrated air is assumed to be leaked in the living room.

</p>
<h4>Other assumptions</h4>
<p>
The CO2 generation in each zone is based on number of occupants in that zone.
CO2 generation is 0.004 L/s per person (Table 5, Persily and De Jonge 2017)
and density of CO2 assumed to be 1.8 kg/m^3, making CO2 generation 7.2e-6 kg/s per person.
Outside air CO2 concentration is 400 ppm. However, CO2 concentration is not controlled for in the model.
</p>
<p>
Persily, A. and De Jonge, L. (2017).
Carbon dioxide generation rates for building occupants.
Indoor Air, 27, 868–879.  https://doi.org/10.1111/ina.12383.
</p>

<h3>Scenario Information</h3>
<h4>Time Periods</h4>
<p>
The <b>Peak Heat Day</b> (specifier for <code>/scenario</code> API is <code>'peak_heat_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with the
maximum 15-minute system heating load in the year.
</ul>
<ul>
Start Time: Day 30.
</ul>
<ul>
End Time: Day 44.
</ul>
</p>
<p>
The <b>Typical Heat Day</b> (specifier for <code>/scenario</code> API is <code>'typical_heat_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with day with
the maximum 15-minute system heating load that is closest from below to the
median of all 15-minute maximum heating loads of all days in the year.
Only days in which the heating system is active was considered in determining
the median.
</ul>
<ul>
Start Time: Day 318.
</ul>
<ul>
End Time: Day 332.
</ul>
</p>
<p>
<h4>Energy Pricing</h4>
<p>
All pricing scenarios include the same constant value for transmission fees and taxes
of each commodity. The used value is the typical price that household users pay
for the network, taxes and levies, as calculateed by Eurostat and obtained from:
<a href=\"https://eur-lex.europa.eu/legal-content/EN/TXT/PDF/?uri=CELEX:52020DC0951&from=EN\">
\"The energy prices and costs in Europe report\"</a>.
For the assumed location of the test case, this value is of
0.125 EUR/kWh for electricity and of 0.042 for gas.
</p>
<h5>Constant electricity price profile</h5> (specifier for <code>/scenario</code> API is <code>'constant'</code>) profile is:
<p>
The constant electricity price scenario uses a constant price of 0.108 EUR/kWh,
as obtained from the Engie's \"Elec Ajust\" deal before taxes (HTT) in
<a href=\"https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-elec-ajust.pdf\">
https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-elec-ajust.pdf</a>
(accessed on July 2020).
The tariff used is the one for households with contracted power installations higher than 6 kVA.
Adding up the transmission fees and taxes, the final constant electricity price is
of 0.233 EUR/kWh.
</p>
<h5>Dynamic electricity price profile</h5> (specifier for <code>/scenario</code> API is <code>'dynamic'</code>) profile is:
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
Adding up the transmission fees and taxes, the final dynamic electricity prices are
of 0.251 EUR/kWh during on-peak periods and of 0.211 during off-peak periods.
</p>
<h5>Highly dynamic electricity price profile</h5> (specifier for <code>/scenario</code> API is <code>'highly_dynamic'</code>) profile is:
<p>
For the highly dynamic scenario, the French day-ahead prices of 2019 are used.
Obtained from:
<a href=\"https://www.epexspot.com/en\">
https://www.epexspot.com/en</a>
The prices are parsed and exported using this repository:
<a href=\"https://github.com/JavierArroyoBastida/epex-spot-data\">
https://github.com/JavierArroyoBastida/epex-spot-data</a>.
Notice that the same constant transmission fees and taxes of 0.125 EUR/kWh are
added up on top of these prices.
</p>
<h5>Gas price profile</h5>
<p>
The gas price is assumed constant and of 0.0491 EUR/kWh
as obtained from the \"Gaz Energie Garantie 1 an\" deal for gas in
<a href=\"https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-sommaire-gaz-energie-garantie.pdf\">
https://particuliers.engie.fr/content/dam/pdf/fiches-descriptives/fiche-descriptive-sommaire-gaz-energie-garantie.pdf</a>
(accessed on July 2020).
Price before taxes (HTT) for a contracted anual tariff between 0 - 6000 kWh.
Adding up the transmission fees and taxes the final constant gas price is
of 0.0911 EUR/kWh.
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
June 07, 2021 by Javier Arroyo:<br/>
Correct schema in documentation.
</li>
<li>
April 24, 2021 by David Blum:<br/>
Add scenario time periods.
</li>
<li>
March 19, 2021 by David Blum:<br/>
Add CO2 to infiltration boundary conditions and initialize CO2 in zones.
Change IBPSA signal exchange blocks and weather reader to use Buildings Library.
</li>
<li>
February 26, 2021 by Javier Arroyo:<br/>
Add transmission fees and taxes to pricing scenarios.
</li>
<li>
February 04, 2021 by Javier Arroyo:<br/>
Improve documentation.
</li>
<li>
January 29, 2021 by Javier Arroyo:<br/>
Add CO2 generation and readings.
</li>
<li>
December 08, 2020 by Javier Arroyo:<br/>
Add weather station.
</li>
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
      StopTime=31536000,
      Interval=300,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file="Scripts/plot_temp.mos" "plot_temp"));
end TestCase;
