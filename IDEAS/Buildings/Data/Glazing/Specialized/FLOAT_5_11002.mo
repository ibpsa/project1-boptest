within IDEAS.Buildings.Data.Glazing.Specialized;
record FLOAT_5_11002 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.005, epsLw_b=0.4)},final SwTrans=[0,0.810;
10,0.809;
20,0.807;
30,0.802;
40,0.791;
50,0.769;
60,0.721;
70,0.611;
80,0.368;
90,0.000],
final SwAbs= [0,0.120;
10,0.121;
20,0.123;
30,0.127;
40,0.132;
50,0.137;
60,0.143;
70,0.146;
80,0.140;
90,0.000],final SwTransDif=0.721,
final SwAbsDif={0.143},
final U_value=5.96,
final g_value=0.759) "FLOAT_5(U-design =5.96 g-design =0.759)
";
