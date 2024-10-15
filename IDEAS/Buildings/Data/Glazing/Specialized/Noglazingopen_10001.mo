within IDEAS.Buildings.Data.Glazing.Specialized;
record Noglazingopen_10001 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=1,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.001, epsLw_b=0.4)},final SwTrans=[0,1.000;
10,1.000;
20,1.000;
30,1.000;
40,1.000;
50,1.000;
60,1.000;
70,1.000;
80,1.000;
90,1.000],
final SwAbs= [0,0.000;
10,0.000;
20,0.000;
30,0.000;
40,0.000;
50,0.000;
60,0.000;
70,0.000;
80,0.001;
90,0.000],final SwTransDif=1.000,
final SwAbsDif={0.000},
final U_value=5.95,
final g_value=1.000) "Noglazingopen(U-design =5.95 g-design =1.000)
";
