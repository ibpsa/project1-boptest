within IDEAS.Buildings.Data.Glazing.Specialized;
record InterpaneIPLUSNeutralR24_16_4_14002 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.462;
10,0.465;
20,0.458;
30,0.450;
40,0.438;
50,0.415;
60,0.364;
70,0.266;
80,0.125;
90,0.000],
final SwAbs= [0,0.243, 0.0,0.028;
10,0.246, 0.0,0.028;
20,0.254, 0.0,0.028;
30,0.260, 0.0,0.029;
40,0.262, 0.0,0.029;
50,0.266, 0.0,0.030;
60,0.283, 0.0,0.029;
70,0.302, 0.0,0.026;
80,0.259, 0.0,0.019;
90,0.002, 0.0,0.000],final SwTransDif=0.364,
final SwAbsDif={0.283,0.0,0.029},
final U_value=1.14,
final g_value=0.403) "InterpaneIPLUSNeutralR24_16_4(U-design =1.14 g-design =0.403)
";
