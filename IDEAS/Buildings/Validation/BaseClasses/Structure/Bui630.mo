within IDEAS.Buildings.Validation.BaseClasses.Structure;
model Bui630 "BESTEST Building model case 630"

  extends IDEAS.Buildings.Validation.BaseClasses.Structure.Bui620(
    win(
      redeclare replaceable IDEAS.Buildings.Components.Shading.Box shaType(
      each hWin=2.0,
      each wWin=3.0,
      each wLeft=0,
      each wRight = 0,
      each ovDep=1.0,
      each ovGap=0.35,
      each finGap = 0,
      each finDep=1.0,
      each hFin=0.35)));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,-100},
            {150,100}}),       graphics));
end Bui630;
