within IDEAS.Buildings.Data.Glazing.Specialized;
record InterpaneIPASOLgreen55276_16_4_14007 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.213;
10,0.215;
20,0.212;
30,0.208;
40,0.202;
50,0.192;
60,0.168;
70,0.122;
80,0.057;
90,0.000],
final SwAbs= [0,0.688, 0.0,0.007;
10,0.694, 0.0,0.007;
20,0.699, 0.0,0.007;
30,0.700, 0.0,0.007;
40,0.694, 0.0,0.007;
50,0.686, 0.0,0.007;
60,0.674, 0.0,0.007;
70,0.629, 0.0,0.006;
80,0.461, 0.0,0.005;
90,0.002, 0.0,0.000],final SwTransDif=0.168,
final SwAbsDif={0.674,0.0,0.007},
final U_value=1.26,
final g_value=0.215) "InterpaneIPASOLgreen55276_16_4(U-design =1.26 g-design =0.215)
";
