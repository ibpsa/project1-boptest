within IDEAS.Buildings.Data.Glazing.Specialized;
record Insulating_Kr_1_174_63_2106 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Krypton(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.462;
10,0.465;
20,0.458;
30,0.448;
40,0.436;
50,0.412;
60,0.360;
70,0.263;
80,0.121;
90,0.000],
final SwAbs= [0,0.114, 0.0,0.186;
10,0.114, 0.0,0.188;
20,0.116, 0.0,0.195;
30,0.120, 0.0,0.199;
40,0.125, 0.0,0.198;
50,0.132, 0.0,0.197;
60,0.139, 0.0,0.199;
70,0.146, 0.0,0.186;
80,0.147, 0.0,0.118;
90,0.000, 0.0,0.000],final SwTransDif=0.360,
final SwAbsDif={0.139,0.0,0.199},
final U_value=1.14,
final g_value=0.542) "Insulating_Kr_1_174_63(U-design =1.14 g-design =0.542)
";
