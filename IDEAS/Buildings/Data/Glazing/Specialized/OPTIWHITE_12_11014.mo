within IDEAS.Buildings.Data.Glazing.Specialized;
record OPTIWHITE_12_11014 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.012, epsLw_b=0.4)},final SwTrans=[0,0.870;
10,0.870;
20,0.868;
30,0.865;
40,0.856;
50,0.836;
60,0.788;
70,0.673;
80,0.415;
90,0.000],
final SwAbs= [0,0.054;
10,0.054;
20,0.055;
30,0.057;
40,0.059;
50,0.062;
60,0.065;
70,0.067;
80,0.067;
90,0.000],final SwTransDif=0.788,
final SwAbsDif={0.065},
final U_value=5.56,
final g_value=0.804) "OPTIWHITE_12(U-design =5.56 g-design =0.804)
";
