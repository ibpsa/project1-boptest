within IDEAS.Buildings.Data.Glazing.Specialized;
record OPTIWHITE_15_11015 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.015, epsLw_b=0.4)},final SwTrans=[0,0.852;
10,0.852;
20,0.850;
30,0.846;
40,0.837;
50,0.816;
60,0.768;
70,0.654;
80,0.401;
90,0.000],
final SwAbs= [0,0.073;
10,0.073;
20,0.075;
30,0.077;
40,0.080;
50,0.084;
60,0.088;
70,0.090;
80,0.089;
90,0.000],final SwTransDif=0.768,
final SwAbsDif={0.088},
final U_value=5.50,
final g_value=0.789) "OPTIWHITE_15(U-design =5.50 g-design =0.789)
";
