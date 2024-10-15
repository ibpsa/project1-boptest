within IDEAS.Buildings.Data.Glazing.Specialized;
record Single_5_8_1001 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.830;
10,0.829;
20,0.827;
30,0.823;
40,0.813;
50,0.792;
60,0.744;
70,0.632;
80,0.384;
90,0.000],
final SwAbs= [0,0.095;
10,0.096;
20,0.098;
30,0.101;
40,0.105;
50,0.109;
60,0.114;
70,0.117;
80,0.114;
90,0.000],final SwTransDif=0.744,
final SwAbsDif={0.114},
final U_value=5.95,
final g_value=0.774) "Single_5_8(U-design =5.95 g-design =0.774)
";
