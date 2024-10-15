within IDEAS.Buildings.Data.Glazing.Specialized;
record PilkingtonOPTITHERMSCoating34_16_4_12003 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.485;
10,0.485;
20,0.483;
30,0.480;
40,0.474;
50,0.462;
60,0.434;
70,0.361;
80,0.189;
90,0.000],
final SwAbs= [0,0.137, 0.0,0.109;
10,0.138, 0.0,0.109;
20,0.140, 0.0,0.109;
30,0.144, 0.0,0.110;
40,0.149, 0.0,0.110;
50,0.155, 0.0,0.108;
60,0.161, 0.0,0.103;
70,0.165, 0.0,0.089;
80,0.162, 0.0,0.061;
90,0.000, 0.0,0.000],final SwTransDif=0.434,
final SwAbsDif={0.161,0.0,0.103},
final U_value=1.12,
final g_value=0.531) "PilkingtonOPTITHERMSCoating34_16_4(U-design =1.12 g-design =0.531)
";
