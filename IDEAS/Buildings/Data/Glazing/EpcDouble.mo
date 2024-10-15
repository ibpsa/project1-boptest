within IDEAS.Buildings.Data.Glazing;
record EpcDouble =
              IDEAS.Buildings.Data.Interfaces.Glazing (
    final nLay=3,
    final checkLowPerformanceGlazing=false,
    final mats={
      Materials.Glass(d=0.0038),
      Materials.Air(d=0.012),
      Materials.Glass(d=0.0038)},
    final SwTrans=[0, 0.721;
                  10, 0.720;
                  20, 0.718;
                  30, 0.711;
                  40, 0.697;
                  50, 0.665;
                  60, 0.596;
                  70, 0.454;
                  80, 0.218;
                  90, 0.000],
    final SwAbs=[0, 0.082, 0, 0.062;
                10, 0.082, 0, 0.062;
                20, 0.084, 0, 0.063;
                30, 0.086, 0, 0.065;
                40, 0.090, 0, 0.067;
                50, 0.094, 0, 0.068;
                60, 0.101, 0, 0.067;
                70, 0.108, 0, 0.061;
                80, 0.112, 0, 0.045;
                90, 0.000, 0, 0.000],
    final SwTransDif=0.619,
    final SwAbsDif={0.093, 0,  0.063},
    final U_value=2.9,
    final g_value=0.78)
    "Uncoated double glazing 4/12/4 (U = 2.9)"
  annotation (Documentation(revisions="<html>
<ul>
<li>
September 22, 2019, by Filip Jorissen:<br/>
Revised documentation.
</li>
<li>
September 2, 2015, by Filip Jorissen:<br/>
Moved epsLw definition to solid layer to be consistent 
with changed implementation of MultiLayerLucent.
</li>
</ul>
</html>", info="<html>
<p>WINDOW v7.3.4.0 Glazing System Thermal and Optical Properties 11/15/15 12:01:44</p>
<p><br/><br/>ID      : 1</p>
<p>Name    : Single</p>
<p>Tilt    : 90.0</p>
<p>Glazings: 2</p>
<p>KEFF    : 0.1069</p>
<p>Width   : 19.518</p>
<p>Uvalue  : 2.85</p>
<p>SHGCc   : 0.78</p>
<p>SCc     : 0.90</p>
<p>Vtc     : 0.81</p>
<p>RHG     : 582.06</p>
<p><br/><br/><br/>Layer Data for Glazing System &apos;1 Single&apos;</p>
<p><br/>ID     Name            D(mm) Tsol  1 Rsol 2 Tvis  1 Rvis 2  Tir  1 Emis 2 Keff</p>
<p>------ --------------- ----- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----</p>
<p>Outside</p>
<p> 12014 Clear4mm.grm   #  3.8 .845 .078 .078 .899 .085 .085 .000 .840 .840 1.00  </p>
<p>       1 Air            12.0                                              .069  </p>
<p> 12014 Clear4mm.grm   #  3.8 .845 .078 .078 .899 .085 .085 .000 .840 .840 1.00  </p>
<p>Inside</p>
<p><br/><br/>Environmental Conditions: 4 CEN</p>
<p><br/>          Tout   Tin  WndSpd   Wnd Dir   Solar  Tsky  Esky</p>
<p>          (C)    (C)   (m/s)            (W/m2)  (C)</p>
<p>         -----  ----  ------  --------  ------  ----  ----</p>
<p>Uvalue     0.0  20.0    5.50  Windward     0.0   0.0  1.00</p>
<p>Solar     30.0  25.0    2.75  Windward   500.0  30.0  1.00</p>
<p><br/>Optical Properties for Glazing System &apos;1 Single&apos;</p>
<p><br/>Angle      0    10    20    30    40    50    60    70    80    90 Hemis</p>
<p><br/>Vtc  : 0.814 0.814 0.812 0.808 0.796 0.766 0.693 0.538 0.274 0.000 0.712</p>
<p>Rf   : 0.154 0.154 0.155 0.158 0.168 0.197 0.268 0.422 0.686 1.000 0.242</p>
<p>Rb   : 0.154 0.154 0.155 0.158 0.168 0.197 0.268 0.422 0.686 1.000 0.242</p>
<p><br/>Tsol : 0.721 0.720 0.718 0.711 0.697 0.665 0.596 0.454 0.218 0.000 0.619</p>
<p>Rf   : 0.135 0.135 0.135 0.138 0.147 0.172 0.236 0.376 0.625 1.000 0.214</p>
<p>Rb   : 0.134 0.135 0.135 0.138 0.147 0.172 0.236 0.376 0.625 1.000 0.214</p>
<p><br/>Abs1 : 0.082 0.082 0.084 0.086 0.090 0.094 0.101 0.108 0.112 0.000 0.093</p>
<p>Abs2 : 0.062 0.062 0.063 0.065 0.067 0.068 0.067 0.061 0.045 0.000 0.063</p>
<p><br/>SHGCc: 0.780 0.780 0.778 0.773 0.761 0.732 0.664 0.520 0.276 0.000 0.682</p>
<p><br/>Tdw-K  :  0.609</p>
<p>Tdw-ISO:  0.743</p>
<p>Tuv    :  0.579</p>
<p><br/><br/><br/><br/><br/>      Temperature Distribution (degrees C)</p>
<p>        Winter         Summer</p>
<p>       Out   In       Out   In</p>
<p>      ----  ----     ----  ----</p>
<p>Lay1   2.5   2.7     34.0  34.0   </p>
<p>Lay2  12.7  12.9     32.7  32.6   </p>
</html>"));
