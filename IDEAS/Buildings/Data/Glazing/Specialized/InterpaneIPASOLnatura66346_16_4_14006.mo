within IDEAS.Buildings.Data.Glazing.Specialized;
record InterpaneIPASOLnatura66346_16_4_14006 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.300;
10,0.302;
20,0.298;
30,0.292;
40,0.285;
50,0.270;
60,0.237;
70,0.173;
80,0.081;
90,0.000],
final SwAbs= [0,0.331, 0.0,0.012;
10,0.335, 0.0,0.012;
20,0.340, 0.0,0.012;
30,0.343, 0.0,0.012;
40,0.343, 0.0,0.013;
50,0.343, 0.0,0.013;
60,0.348, 0.0,0.012;
70,0.345, 0.0,0.011;
80,0.272, 0.0,0.009;
90,0.002, 0.0,0.000],final SwTransDif=0.237,
final SwAbsDif={0.348,0.0,0.012},
final U_value=1.08,
final g_value=0.266) "InterpaneIPASOLnatura66346_16_4(U-design =1.08 g-design =0.266)
";
