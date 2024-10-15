within IDEAS.Buildings.Data.Glazing.Specialized;
record OPTIWHITE_6_11011 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.898;
10,0.898;
20,0.897;
30,0.894;
40,0.887;
50,0.868;
60,0.820;
70,0.702;
80,0.437;
90,0.000],
final SwAbs= [0,0.026;
10,0.026;
20,0.027;
30,0.028;
40,0.029;
50,0.030;
60,0.032;
70,0.033;
80,0.033;
90,0.000],final SwTransDif=0.820,
final SwAbsDif={0.032},
final U_value=5.69,
final g_value=0.828) "OPTIWHITE_6(U-design =5.69 g-design =0.828)
";
