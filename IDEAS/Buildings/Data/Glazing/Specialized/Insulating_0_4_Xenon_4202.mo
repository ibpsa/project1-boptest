within IDEAS.Buildings.Data.Glazing.Specialized;
record Insulating_0_4_Xenon_4202 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=5,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Air(d=0.008, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Air(d=0.008, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.268;
10,0.270;
20,0.263;
30,0.253;
40,0.243;
50,0.223;
60,0.183;
70,0.116;
80,0.042;
90,0.000],
final SwAbs= [0,0.327, 0.0,0.066, 0.0,0.108;
10,0.330, 0.0,0.066, 0.0,0.110;
20,0.339, 0.0,0.067, 0.0,0.112;
30,0.345, 0.0,0.068, 0.0,0.113;
40,0.347, 0.0,0.070, 0.0,0.110;
50,0.351, 0.0,0.071, 0.0,0.107;
60,0.367, 0.0,0.070, 0.0,0.101;
70,0.380, 0.0,0.064, 0.0,0.082;
80,0.313, 0.0,0.051, 0.0,0.041;
90,0.001, 0.0,0.000, 0.0,0.000],final SwTransDif=0.183,
final SwAbsDif={0.367,0.0,0.070,0.0,0.101},
final U_value=0.51,
final g_value=0.319) "Insulating_0_4_Xenon(U-design =0.51 g-design =0.319)
";
