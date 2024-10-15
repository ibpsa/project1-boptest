within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardNatural62Argon_1_26_16_6_15002 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_b=0.4)},final SwTrans=[0,0.377;
10,0.379;
20,0.373;
30,0.365;
40,0.355;
50,0.335;
60,0.294;
70,0.215;
80,0.100;
90,0.000],
final SwAbs= [0,0.288, 0.0,0.051;
10,0.291, 0.0,0.051;
20,0.298, 0.0,0.052;
30,0.303, 0.0,0.052;
40,0.303, 0.0,0.053;
50,0.306, 0.0,0.054;
60,0.318, 0.0,0.053;
70,0.327, 0.0,0.047;
80,0.268, 0.0,0.035;
90,0.001, 0.0,0.000],final SwTransDif=0.294,
final SwAbsDif={0.318,0.0,0.053},
final U_value=1.31,
final g_value=0.356) "LuxguardNatural62Argon_1_26_16_6(U-design =1.31 g-design =0.356)
";
