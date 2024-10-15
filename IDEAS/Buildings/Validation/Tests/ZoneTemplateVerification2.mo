within IDEAS.Buildings.Validation.Tests;
model ZoneTemplateVerification2
  "More accurate model that splits up window in two parts, which should make it identical to case900"
  extends ZoneTemplateVerification(case900Template(
      A_winA=6,
      nSurfExt=1,
      outA(A=9.6)));

    IDEAS.Buildings.Components.Window win(
    final A=6,
    redeclare final parameter IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazing,
    final inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    redeclare replaceable IDEAS.Buildings.Components.Shading.None shaType,
    redeclare final parameter IDEAS.Buildings.Data.Frames.None fraType,
    frac=0) "Second window for imitating case 900"
    annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={11,-14})));
equation
  connect(win.propsBus_a, case900Template.proBusExt[1]) annotation (
      Line(
      points={{9,-9.83333},{9,0},{2,0}},
      color={255,204,51},
      thickness=0.5));
  annotation (__Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Validation/Tests/ZoneTemplateVerification2.mos"
        "Simulate and plot"), experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end ZoneTemplateVerification2;
