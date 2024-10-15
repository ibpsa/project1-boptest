within IDEAS.Buildings.Data.Glazing.Specialized;
record OPTIWHITE_10_11013 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.0099, epsLw_b=0.4)},final SwTrans=[0,0.869;
10,0.868;
20,0.867;
30,0.863;
40,0.855;
50,0.835;
60,0.787;
70,0.671;
80,0.414;
90,0.000],
final SwAbs= [0,0.058;
10,0.058;
20,0.059;
30,0.061;
40,0.064;
50,0.067;
60,0.069;
70,0.072;
80,0.070;
90,0.001],final SwTransDif=0.787,
final SwAbsDif={0.069},
final U_value=5.64,
final g_value=0.804) "OPTIWHITE_10(U-design =5.64 g-design =0.804)
";
