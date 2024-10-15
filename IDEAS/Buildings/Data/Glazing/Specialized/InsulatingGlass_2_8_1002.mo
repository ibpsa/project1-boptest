within IDEAS.Buildings.Data.Glazing.Specialized;
record InsulatingGlass_2_8_1002 = IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Air(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.693;
10,0.692;
20,0.688;
30,0.681;
40,0.666;
50,0.633;
60,0.565;
70,0.426;
80,0.197;
90,0.000],
final SwAbs= [0,0.101, 0.0,0.080;
10,0.102, 0.0,0.080;
20,0.104, 0.0,0.081;
30,0.107, 0.0,0.083;
40,0.112, 0.0,0.086;
50,0.118, 0.0,0.087;
60,0.126, 0.0,0.087;
70,0.137, 0.0,0.079;
80,0.143, 0.0,0.058;
90,0.000, 0.0,0.000],final SwTransDif=0.565,
final SwAbsDif={0.126,0.0,0.087},
final U_value=3.07,
final g_value=0.635) "InsulatingGlass_2_8(U-design =3.07 g-design =0.635)
";
