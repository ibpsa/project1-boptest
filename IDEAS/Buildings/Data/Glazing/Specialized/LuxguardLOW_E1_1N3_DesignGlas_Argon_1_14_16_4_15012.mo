within IDEAS.Buildings.Data.Glazing.Specialized;
record LuxguardLOW_E1_1N3_DesignGlas_Argon_1_14_16_4_15012 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Argon(d=0.016, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.538;
10,0.541;
20,0.534;
30,0.524;
40,0.511;
50,0.486;
60,0.429;
70,0.319;
80,0.154;
90,0.000],
final SwAbs= [0,0.038, 0.0,0.100;
10,0.038, 0.0,0.102;
20,0.039, 0.0,0.110;
30,0.040, 0.0,0.116;
40,0.042, 0.0,0.118;
50,0.044, 0.0,0.122;
60,0.047, 0.0,0.134;
70,0.050, 0.0,0.142;
80,0.052, 0.0,0.103;
90,0.000, 0.0,0.000],final SwTransDif=0.429,
final SwAbsDif={0.047,0.0,0.134},
final U_value=1.12,
final g_value=0.546) "LuxguardLOW_E1_1N3_DesignGlas_Argon_1_14_16_4(U-design =1.12 g-design =0.546)
";
