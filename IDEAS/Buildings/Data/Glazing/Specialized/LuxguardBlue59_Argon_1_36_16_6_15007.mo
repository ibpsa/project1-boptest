within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardBlue59_Argon_1_36_16_6_15007 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.353;
10,0.355;
20,0.349;
30,0.342;
40,0.332;
50,0.314;
60,0.275;
70,0.202;
80,0.094;
90,0.000],
final SwAbs= [0,0.347, 0.0,0.047;
10,0.351, 0.0,0.048;
20,0.358, 0.0,0.048;
30,0.362, 0.0,0.049;
40,0.362, 0.0,0.050;
50,0.363, 0.0,0.051;
60,0.371, 0.0,0.050;
70,0.371, 0.0,0.044;
80,0.296, 0.0,0.033;
90,0.001, 0.0,0.000],final SwTransDif=0.275,
final SwAbsDif={0.371,0.0,0.050},
final U_value=1.36,
final g_value=0.339) "LuxguardBlue59_Argon_1_36_16_6(U-design =1.36 g-design =0.339)
";
