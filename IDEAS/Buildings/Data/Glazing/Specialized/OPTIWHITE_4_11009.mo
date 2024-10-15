within IDEAS.Buildings.Data.Glazing.Specialized;
record OPTIWHITE_4_11009 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.906;
10,0.906;
20,0.905;
30,0.903;
40,0.896;
50,0.877;
60,0.829;
70,0.711;
80,0.444;
90,0.000],
final SwAbs= [0,0.017;
10,0.017;
20,0.017;
30,0.018;
40,0.019;
50,0.020;
60,0.021;
70,0.022;
80,0.022;
90,0.000],final SwTransDif=0.829,
final SwAbsDif={0.021},
final U_value=5.74,
final g_value=0.834) "OPTIWHITE_4(U-design =5.74 g-design =0.834)
";
