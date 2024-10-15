within IDEAS.Buildings.Validation.Data.Glazing;
record GlaBesTest = IDEAS.Buildings.Data.Interfaces.PartialGlazing (
    final nLay=3,
    final mats={IDEAS.Buildings.Data.Materials.Glass(
          d=0.003175,
          epsLw=0.9,
          k=1.06),
        IDEAS.Buildings.Data.Materials.Air(d=0.013),
        IDEAS.Buildings.Data.Materials.Glass(
          d=0.003175,
          epsLw=0.9,
          k=1.06)},
    final SwTrans=[
          0, 0.747454;
          10, 0.746824;
          20, 0.744654;
          30, 0.739491;
          40, 0.729832;
          45, 0.720922;
          50, 0.707331;
          60, 0.652331;
          70, 0.516754;
          80, 0.263009;
          88.9, 0.00;
          90, 0.00],
    final SwAbs=[
        0,  0.0643, 0.0, 0.0522;
        20, 0.0659, 0.0, 0.0534;
        30, 0.0679, 0.0, 0.0548;
        40, 0.0708, 0.0, 0.0566;
        48, 0.0738, 0.0, 0.058;
        55, 0.0769, 0.0, 0.0587;
        57, 0.0779, 0.0, 0.0587;
        60, 0.0796, 0.0, 0.0585;
        63, 0.0815, 0.0, 0.0579;
        66, 0.0837, 0.0, 0.0568;
        68, 0.0852, 0.0, 0.0558;
        70, 0.0858, 0.0, 0.0544;
        72, 0.089,  0.0, 0.0521;
        75, 0.0911, 0.0, 0.0495;
        77.5, 0.0929, 0.0, 0.0457;
        80, 0.094, 0.0, 0.0413;
        82, 0.0937, 0.0, 0.0372;
        83.5, 0.0924, 0.0, 0.0335;
        85, 0.0892, 0.0, 0.0291;
        86, 0.0854, 0.0, 0.0254;
        87, 0.079,  0.0, 0.0205;
        88, 0.0671, 0.0, 0.0128;
        89, 0.0473, 0.0, 0.0043;
        89.5, 0.304, 0.0, 0.0004;
        89.99, 0.001,0.0, 0.0;
        90, 0.00, 0.0, 0.0],
    final U_value=3.0,
    final g_value=0.87,
    final SwAbsDif={0.0796,0.0,0.0585},
    final SwTransDif=0.652331) "BESTEST glazing" annotation (Documentation(
      revisions="<html>
<ul>
<li>
October 28, 2020, by Filip Jorissen:<br/>
Extending <code>PartialGlazing</code>, which does not show in Window dropdown.
</li>
</ul>
</html>"));
