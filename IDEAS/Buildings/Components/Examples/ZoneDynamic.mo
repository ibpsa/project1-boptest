within IDEAS.Buildings.Components.Examples;
model ZoneDynamic
  extends ZoneStatic(dummyConnection1(surfCon=100), dummyConnection(
      iSolDir=100,
      iSolDif=10,
      T=Medium.T_default + 10));
  annotation (__Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/ZoneDynamic.mos"
        "Simulate and plot"), experiment(
      StopTime=10000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end ZoneDynamic;
