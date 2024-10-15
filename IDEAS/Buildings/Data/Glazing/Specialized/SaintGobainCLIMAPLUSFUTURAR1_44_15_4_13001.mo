within IDEAS.Buildings.Data.Glazing.Specialized;
record SaintGobainCLIMAPLUSFUTURAR1_44_15_4_13001 =
    IDEAS.Buildings.Data.Interfaces.Glazing (
final nLay=3,
final mats={ IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Air(d=0.015, epsLw_b=0.4),
 IDEAS.Buildings.Data.Materials.Glass(d=0.004, epsLw_b=0.4)},final SwTrans=[0,0.521;
10,0.524;
20,0.517;
30,0.508;
40,0.495;
50,0.472;
60,0.418;
70,0.312;
80,0.153;
90,0.000],
final SwAbs= [0,0.022, 0.0,0.102;
10,0.022, 0.0,0.104;
20,0.023, 0.0,0.112;
30,0.023, 0.0,0.117;
40,0.025, 0.0,0.119;
50,0.026, 0.0,0.123;
60,0.027, 0.0,0.135;
70,0.029, 0.0,0.142;
80,0.031, 0.0,0.105;
90,0.000, 0.0,0.000],final SwTransDif=0.418,
final SwAbsDif={0.027,0.0,0.135},
final U_value=1.52,
final g_value=0.529) "SaintGobainCLIMAPLUSFUTURAR1_44_15_4(U-design =1.52 g-design =0.529)
";
