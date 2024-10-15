within IDEAS.Buildings.Data.Glazing.Specialized;
record InterpaneIPASOLsofia59456_16_4_14013 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.458;
10,0.461;
20,0.454;
30,0.446;
40,0.434;
50,0.411;
60,0.360;
70,0.263;
80,0.123;
90,0.000],
final SwAbs= [0,0.276, 0.0,0.030;
10,0.279, 0.0,0.030;
20,0.287, 0.0,0.031;
30,0.293, 0.0,0.031;
40,0.294, 0.0,0.032;
50,0.299, 0.0,0.032;
60,0.315, 0.0,0.031;
70,0.331, 0.0,0.027;
80,0.279, 0.0,0.020;
90,0.002, 0.0,0.000],final SwTransDif=0.360,
final SwAbsDif={0.315,0.0,0.031},
final U_value=1.31,
final g_value=0.405) "InterpaneIPASOLsofia59456_16_4(U-design =1.31 g-design =0.405)
";
