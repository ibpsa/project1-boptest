within BESTESTHydronic;
model TestCase "Single zone residential hydronic example model"
  extends IDEAS.Examples.IBPSA.SingleZoneResidentialHydronic(
    pumSetExt(u(
        min=0,
        max=1,
        unit="1")),
    outputP(y(unit="W")),
    outputCO2(y(unit="ppm")),
    outputT(y(unit="K")),
    outputQ(y(unit="W")),
    TSetExt(u(
        min=273.15 + 20,
        max=273.15 + 80,
        unit="K")));
  annotation (experiment(StopTime=604800));
end TestCase;
