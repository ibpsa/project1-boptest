within IDEAS.Buildings.Data.Glazing;
record EpcSingle =
              IDEAS.Buildings.Data.Interfaces.Glazing (
    final nLay=1,
    final mats={
      Materials.Glass(d=0.0038)},
    final SwTrans=[0, 0.845;
                  10, 0.844;
                  20, 0.843;
                  30, 0.839;
                  40, 0.830;
                  50, 0.809;
                  60, 0.761;
                  70, 0.649;
                  80, 0.398;
                  90, 0.000],
    final SwAbs=[0, 0.078;
                10, 0.078;
                20, 0.079;
                30, 0.082;
                40, 0.085;
                50, 0.088;
                60, 0.092;
                70, 0.094;
                80, 0.090;
                90, 0.000],
    final SwTransDif=0.765,
    final SwAbsDif={0.085},
    final U_value=5.8,
    final g_value=0.88)
    "Uncoated single glazing (U = 5.8)"
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
<p>WINDOW v7.3.4.0 Glazing System Thermal and Optical Properties 11/15/15 11:58:59</p>
<p><br/><br/>ID      : 1</p>
<p>Name    : Single</p>
<p>Tilt    : 90.0</p>
<p>Glazings: 1</p>
<p>KEFF    : 1.0003</p>
<p>Width   : 3.759</p>
<p>Uvalue  : 5.81</p>
<p>SHGCc   : 0.88</p>
<p>SCc     : 1.01</p>
<p>Vtc     : 0.90</p>
<p>RHG     : 658.98</p>
<p><br/><br/><br/>Layer Data for Glazing System &apos;1 Single&apos;</p>
<p><br/>ID     Name            D(mm) Tsol  1 Rsol 2 Tvis  1 Rvis 2  Tir  1 Emis 2 Keff</p>
<p>------ --------------- ----- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----</p>
<p>Outside</p>
<p> 12014FClear4mm.grm   #  3.8 .845 .078 .078 .899 .085 .085 .000 .840 .840 1.00  </p>
<p>Inside</p>
<p><br/><br/>Environmental Conditions: 4 CEN</p>
<p><br/>          Tout   Tin  WndSpd   Wnd Dir   Solar  Tsky  Esky</p>
<p>          (C)    (C)   (m/s)            (W/m2)  (C)</p>
<p>         -----  ----  ------  --------  ------  ----  ----</p>
<p>Uvalue     0.0  20.0    5.50  Windward     0.0   0.0  1.00</p>
<p>Solar     30.0  25.0    2.75  Windward   500.0  30.0  1.00</p>
<p><br/>Optical Properties for Glazing System &apos;1 Single&apos;</p>
<p><br/>Angle      0    10    20    30    40    50    60    70    80    90 Hemis</p>
<p><br/>Vtc  : 0.899 0.899 0.898 0.896 0.889 0.870 0.822 0.705 0.441 0.000 0.822</p>
<p>Rf   : 0.085 0.085 0.085 0.087 0.093 0.111 0.158 0.274 0.538 1.000 0.150</p>
<p>Rb   : 0.085 0.085 0.085 0.087 0.093 0.111 0.158 0.274 0.538 1.000 0.150</p>
<p><br/>Tsol : 0.845 0.844 0.843 0.839 0.830 0.809 0.761 0.649 0.398 0.000 0.765</p>
<p>Rf   : 0.078 0.078 0.078 0.080 0.086 0.103 0.147 0.258 0.512 1.000 0.139</p>
<p>Rb   : 0.078 0.078 0.078 0.080 0.086 0.103 0.147 0.258 0.512 1.000 0.139</p>
<p><br/>Abs1 : 0.078 0.078 0.079 0.082 0.085 0.088 0.092 0.094 0.090 0.000 0.085</p>
<p><br/>SHGCc: 0.876 0.875 0.874 0.871 0.863 0.844 0.798 0.686 0.434 0.000 0.799</p>
<p><br/>Tdw-K  :  0.736</p>
<p>Tdw-ISO:  0.845</p>
<p>Tuv    :  0.726</p>
<p><br/><br/><br/><br/><br/>      Temperature Distribution (degrees C)</p>
<p>        Winter         Summer</p>
<p>       Out   In       Out   In</p>
<p>      ----  ----     ----  ----</p>
<p>Lay1   5.0   5.5     31.0  30.9   </p>
</html>"));
