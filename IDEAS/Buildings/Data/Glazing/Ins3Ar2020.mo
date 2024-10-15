within IDEAS.Buildings.Data.Glazing;
record Ins3Ar2020 =
                IDEAS.Buildings.Data.Interfaces.Glazing (
    final nLay=5,
    final mats={Materials.Glass(d=0.006),
                Materials.Argon(d=0.016),
                Materials.Glass(d=0.006, epsLw_b=0.022),
                Materials.Argon(d=0.016),
                Materials.Glass(d=0.006, epsLw_b=0.022)},
    final SwTrans=[0, 0.285;
                  10, 0.288;
                  20, 0.280;
                  30, 0.271;
                  40, 0.260;
                  50, 0.241;
                  60, 0.198;
                  70, 0.127;
                  80, 0.047;
                  90, 0.000],
    final SwAbs=[0, 0.117, 0.0, 0.091, 0.0, 0.036;
                10, 0.117, 0.0, 0.092, 0.0, 0.037;
                20, 0.119, 0.0, 0.099, 0.0, 0.041;
                30, 0.123, 0.0, 0.104, 0.0, 0.043;
                40, 0.127, 0.0, 0.106, 0.0, 0.044;
                50, 0.133, 0.0, 0.110, 0.0, 0.045;
                60, 0.138, 0.0, 0.121, 0.0, 0.049;
                70, 0.140, 0.0, 0.130, 0.0, 0.048;
                80, 0.133, 0.0, 0.098, 0.0, 0.028;
                90, 0.000, 0.0, 0.000, 0.0, 0.000],
    final SwTransDif=0.223,
    final SwAbsDif={0.128, 0.0, 0.108, 0.0, 0.043},
    final U_value=0.569,
    final g_value=0.423)
  "Default triple: Saint Gobain Planitherm one AR 6/16/6/16/6 (U = 0.6 W/m2K, g = 0.423), good default for Belgium in 2020"
  annotation (Documentation(revisions="<html>
<ul>
<li>
July 20, 2020, by Filip Jorissen:<br/>
Triple glazing implementation that is in line with the commercially available glazing systems.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1114\">
#1114</a>
</li>
</ul>
</html>", info="<html>
<p>
Simple insulated triple glazing system with argon filling, without sun protecting coating. 
</p>
<p>
This glazing system consists of an external pane of 6 mm Saint Gobain Planiclear and
two internal panes Planitherm one of 6 mm, each with a 10%/90% air/argon cavity of 16 mm.
Spectral properties were computed using Window 7.7 with IGDB v73.
</p>
<h4> Detailed report: </h4>
<p>
BERKELEY LAB WINDOW v7.7.10.0 Glazing System Thermal and Optical Properties 07/20/20 13:01:51<br/>
<br/>
<br/>
ID      : 1<br/>
Name    : Single Clear<br/>
Tilt    : 90.0<br/>
Glazings: 3<br/>
KEFF    : 0.032 [W/m-K]<br/>
Width   : 50.000 [mm]<br/>
Uvalue  : 0.569 [W/m2-K]<br/>
SHGCc   : 0.368<br/>
SCc     : 0.423<br/>
Tvis    : 0.574<br/>
RHG     : 271.186 [W/m2]<br/>
<br/>
<br/>
<br/>
Layer Data for Glazing System '1 Single Clear'<br/>
<br/>
ID     Name            D(mm) Tsol  1 Rsol 2 Tvis  1 Rvis 2  Tir  1 Emis 2 Keff<br/>
------ --------------- ----- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----<br/>
Outside<br/>
 21013 PLANICLEAR 6mm.#  6.0 .849 .075 .075 .900 .081 .081 .000 .840 .840 1.00  <br/>
       9 Air (10%) / Ar 16.0 SF6:   0%      Ar:    0%                     .021  <br/>
 21415 PLANITHERM ONE #  6.0 .469 .456 .393 .778 .170 .178 .000 .022 .840 1.00  <br/>
       9 Air (10%) / Ar 16.0 SF6:   0%      Ar:    0%                     .021  <br/>
 21415 PLANITHERM ONE #  6.0 .469 .456 .393 .778 .170 .178 .000 .022 .840 1.00  <br/>
Inside<br/>
<br/>
<br/>
Environmental Conditions: 3 NFRC 100-2010 Summer<br/>
<br/>
          Tout   Tin  WndSpd   Wnd Dir   Solar  Tsky  Esky<br/>
          (C)    (C)   (m/s)            (W/m2)  (C)<br/>
         -----  ----  ------  --------  ------  ----  ----<br/>
Uvalue    32.0  24.0    2.75  Windward     0.0  32.0  1.00<br/>
Solar     32.0  24.0    2.75  Windward   783.0  32.0  1.00<br/>
<br/>
Optical Properties for Glazing System '1 Single Clear'<br/>
<br/>
Angle      0    10    20    30    40    50    60    70    80    90 Hemis<br/>
<br/>
Tvis : 0.574 0.580 0.564 0.546 0.525 0.484 0.398 0.252 0.092 0.000 0.448<br/>
Rfvis: 0.308 0.300 0.296 0.298 0.310 0.335 0.382 0.491 0.700 1.000 0.362<br/>
Rbvis: 0.321 0.312 0.305 0.306 0.317 0.336 0.367 0.437 0.609 0.999 0.352<br/>
<br/>
Tsol : 0.285 0.288 0.280 0.271 0.260 0.241 0.198 0.127 0.047 0.000 0.223<br/>
Rfsol: 0.470 0.465 0.461 0.459 0.463 0.472 0.494 0.555 0.695 1.000 0.488<br/>
Rbsol: 0.482 0.476 0.471 0.472 0.479 0.491 0.510 0.560 0.693 0.999 0.501<br/>
<br/>
Abs1 : 0.117 0.117 0.119 0.123 0.127 0.133 0.138 0.140 0.133 0.000 0.128<br/>
Abs2 : 0.091 0.092 0.099 0.104 0.106 0.110 0.121 0.130 0.098 0.000 0.108<br/>
Abs3 : 0.036 0.037 0.041 0.043 0.044 0.045 0.049 0.048 0.028 0.000 0.043<br/>
<br/>
SHGCc: 0.368 0.372 0.371 0.366 0.357 0.341 0.308 0.240 0.126 0.000 0.320<br/>
<br/>
Tdw-K  :  0.249<br/>
Tdw-ISO:  0.410<br/>
Tuv    :  0.156<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
      Temperature Distribution (degrees C)<br/>
        Winter         Summer<br/>
       Out   In       Out   In<br/>
      ----  ----     ----  ----<br/>
Lay1  31.8  31.7     37.9  38.4   <br/>
Lay2  28.3  28.3     58.5  58.5   <br/>
Lay3  24.7  24.7     33.3  33.0   
</p>
</html>"));
