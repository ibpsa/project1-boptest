within IDEAS.Buildings.Data.Glazing.Specialized;
record OPTIWHITE_8_11012 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.008, epsLw_b=0.4)},final SwTrans=[0,0.890;
10,0.890;
20,0.889;
30,0.886;
40,0.878;
50,0.859;
60,0.811;
70,0.694;
80,0.431;
90,0.000],
final SwAbs= [0,0.034;
10,0.034;
20,0.035;
30,0.036;
40,0.038;
50,0.039;
60,0.041;
70,0.043;
80,0.043;
90,0.000],final SwTransDif=0.811,
final SwAbsDif={0.041},
final U_value=5.64,
final g_value=0.821) "OPTIWHITE_8(U-design =5.64 g-design =0.821)
";
