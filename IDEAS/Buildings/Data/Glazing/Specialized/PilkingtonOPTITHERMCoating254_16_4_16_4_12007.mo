within IDEAS.Buildings.Data.Glazing.Specialized;
record PilkingtonOPTITHERMCoating254_16_4_16_4_12007 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=5,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.387;
10,0.386;
20,0.382;
30,0.376;
40,0.367;
50,0.348;
60,0.304;
70,0.216;
80,0.086;
90,0.000],
final SwAbs= [0,0.186, 0.0,0.077, 0.0,0.079;
10,0.187, 0.0,0.078, 0.0,0.080;
20,0.188, 0.0,0.079, 0.0,0.081;
30,0.191, 0.0,0.081, 0.0,0.081;
40,0.194, 0.0,0.084, 0.0,0.079;
50,0.199, 0.0,0.088, 0.0,0.076;
60,0.206, 0.0,0.092, 0.0,0.072;
70,0.214, 0.0,0.095, 0.0,0.059;
80,0.206, 0.0,0.081, 0.0,0.029;
90,0.000, 0.0,0.000, 0.0,0.000],final SwTransDif=0.304,
final SwAbsDif={0.206,0.0,0.092,0.0,0.072},
final U_value=0.87,
final g_value=0.419) "PilkingtonOPTITHERMCoating254_16_4_16_4(U-design =0.87 g-design =0.419)
";
