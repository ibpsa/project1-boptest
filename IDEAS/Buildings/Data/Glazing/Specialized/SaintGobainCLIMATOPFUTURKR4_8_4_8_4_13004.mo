within IDEAS.Buildings.Data.Glazing.Specialized;
record SaintGobainCLIMATOPFUTURKR4_8_4_8_4_13004 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=5,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Krypton(d=0.008, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Krypton(d=0.008, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.330;
10,0.333;
20,0.324;
30,0.314;
40,0.303;
50,0.281;
60,0.235;
70,0.156;
80,0.063;
90,0.000],
final SwAbs= [0,0.195, 0.0,0.014, 0.0,0.065;
10,0.197, 0.0,0.014, 0.0,0.066;
20,0.207, 0.0,0.014, 0.0,0.070;
30,0.215, 0.0,0.015, 0.0,0.073;
40,0.218, 0.0,0.015, 0.0,0.073;
50,0.225, 0.0,0.015, 0.0,0.074;
60,0.246, 0.0,0.015, 0.0,0.076;
70,0.273, 0.0,0.015, 0.0,0.071;
80,0.241, 0.0,0.013, 0.0,0.043;
90,0.001, 0.0,0.000, 0.0,0.000],final SwTransDif=0.235,
final SwAbsDif={0.246,0.0,0.015,0.0,0.076},
final U_value=0.65,
final g_value=0.319) "SaintGobainCLIMATOPFUTURKR4_8_4_8_4(U-design =0.65 g-design =0.319)
";
