within IDEAS.Examples.TwinHouses.BaseClasses.Data;
model ValidationDataExp2 "Model that reads all validation data for Twinhouse"

final parameter Integer exp = 2 "Experiment number: 1 or 2";
parameter Integer bui = 1 "Building number 1 (N2), 2 (O5)";

final parameter String filNam = "validationdataExp2.txt";
final parameter String dirPath = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/measurements/")    annotation(Evaluate=true);
Modelica.Blocks.Sources.CombiTimeTable data(
tableOnFile=true,
columns=2:68,
smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2,
extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
final fileName=dirPath+filNam,
    tableName="data")
"input for solGloHor and solDifHor measured at TTH"
annotation (Placement(transformation(extent={{-100,60},{-80,80}})));

Real cellar_AT= data.y[1] + 273.15;
Real kitchen_AT= data.y[2] + 273.15;
Real doorway_AT= data.y[3] + 273.15;
Real parents_AT= data.y[4] + 273.15;
Real living_h010cm_AT= data.y[5] + 273.15;
Real living_h110cm_AT= data.y[6] + 273.15;
Real living_GT= data.y[7] + 273.15;
Real living_rH_h110cm= data.y[8];
Real living_h170cm_AT= data.y[9] + 273.15;
Real corridor_AT= data.y[10] + 273.15;
Real bath_h010_AT= data.y[11] + 273.15;
Real bath_h110_AT= data.y[12] + 273.15;
Real bath_h170_AT= data.y[13] + 273.15;
Real child_h010_AT= data.y[14] + 273.15;
Real child_h110_AT= data.y[15] + 273.15;
Real child_h170_AT= data.y[16] + 273.15;
Real attic_west_h010_AT= data.y[17] + 273.15;
Real attic_west_h110_AT= data.y[18] + 273.15;
Real attic_west_h170_AT= data.y[19] + 273.15;
Real attic_east_h010_AT= data.y[20] + 273.15;
Real attic_east_h110_AT= data.y[21] + 273.15;
Real attic_east_h170_AT= data.y[22] + 273.15;
Real heat_elP_kitchen= data.y[23];
Real Kitchen_heat_exchange_with_ductwork= data.y[24];
Real heat_elP_doorway= data.y[25];
Real heat_elP_parents_room= data.y[26];
Real heat_elP_living_room= data.y[27];
Real heat_elP_bath_room= data.y[28];
Real heat_elP_children_room= data.y[29];
Real vent_SUA_fan_elP= data.y[30];
Real vent_SUA_VFR= data.y[31];
Real vent_SUA_AT= data.y[32] + 273.15;
Real living_SUA_AT= data.y[33] + 273.15;
Real vent_EHA_fan_elP= data.y[34];
Real vent_EHA_VFR= data.y[35];
Real vent_EHA_AT= data.y[36] + 273.15;
Real vent_thP= data.y[37];
Real living_westfacade_S_IS_T= data.y[38] + 273.15;
Real living_facade_west_S_IS_HF= data.y[39];
Real living_westfacade_S_BL1_T= data.y[40] + 273.15;
Real living_facade_west_S_BL1_HF= data.y[41];
Real living_westfacade_S_ES_T= data.y[42] + 273.15;
Real living_window_west_IS_T= data.y[43] + 273.15;
Real living_window_west_S_IS_HF= data.y[44];
Real living_window_south_IS_T= data.y[45] + 273.15;
Real living_window_south_IS_HF= data.y[46];
Real child_facade_south_IS_T= data.y[47] + 273.15;
Real child_facade_south_IS_HF= data.y[48];
Real child_window_south_IS_T= data.y[49] + 273.15;
Real child_window_south_IS_HF= data.y[50];
Real child_facade_east_IS_T= data.y[51] + 273.15;
Real child_facade_east_IS_HF= data.y[52];
Real Ambient_temperature= data.y[53] + 273.15;
Real Solar_radiation_global_horizontal= data.y[54];
Real Solar_radiation_diffuse_horizontal= data.y[55];
Real longwave_downward_radiation_= data.y[56];
Real Solar_radiation_north_vertical= data.y[57];
Real Solar_radiation_east_vertical= data.y[58];
Real Solar_radiation_south_vertical= data.y[59];
Real Solar_radiation_west_vertical= data.y[60];
Real wind_direction= data.y[61];
Real wind_speed= data.y[62];
Real relative_humidity= data.y[63];
Real ground_temperature_0cm= data.y[64] + 273.15;
Real ground_temperature_50cm= data.y[65] + 273.15;
Real ground_temperature_100cm= data.y[66] + 273.15;
Real ground_temperature_200cm= data.y[67] + 273.15;
end ValidationDataExp2;
