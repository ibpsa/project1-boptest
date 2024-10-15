within IDEAS.Examples.PPD12.Data;
record Ppd12WestShadingSecond
  "Ppd shading model for west side, second floor"
  extends Ppd12WestShadingGnd(
    hTopWin=9.7,
    hBui=2.9+1.6+2+2.2+1+2.5,
    L=14);
end Ppd12WestShadingSecond;
