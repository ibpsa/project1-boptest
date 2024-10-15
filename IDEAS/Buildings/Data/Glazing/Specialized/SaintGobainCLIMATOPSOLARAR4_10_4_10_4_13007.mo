within IDEAS.Buildings.Data.Glazing.Specialized;
record SaintGobainCLIMATOPSOLARAR4_10_4_10_4_13007 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=5,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.456;
10,0.456;
20,0.450;
30,0.445;
40,0.437;
50,0.415;
60,0.359;
70,0.250;
80,0.111;
90,0.000],
final SwAbs= [0,0.149, 0.0,0.013, 0.0,0.128;
10,0.150, 0.0,0.014, 0.0,0.128;
20,0.153, 0.0,0.014, 0.0,0.129;
30,0.155, 0.0,0.014, 0.0,0.129;
40,0.155, 0.0,0.015, 0.0,0.127;
50,0.157, 0.0,0.015, 0.0,0.123;
60,0.163, 0.0,0.016, 0.0,0.112;
70,0.168, 0.0,0.016, 0.0,0.088;
80,0.140, 0.0,0.016, 0.0,0.046;
90,0.000, 0.0,0.000, 0.0,0.000],final SwTransDif=0.359,
final SwAbsDif={0.163,0.0,0.016,0.0,0.112},
final U_value=0.63,
final g_value=0.474) "SaintGobainCLIMATOPSOLARAR4_10_4_10_4(U-design =0.63 g-design =0.474)
";
