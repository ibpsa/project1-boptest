within IDEAS.Buildings.Validation.BaseClasses.Structure;
model Bui620 "BESTEST Building model case 620"
  extends IDEAS.Buildings.Validation.BaseClasses.Structure.Bui600(
    win(azi={IDEAS.Types.Azimuth.W,IDEAS.Types.Azimuth.E}),
    wall(A =   {21.6,10.2,21.6,10.2}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,
            -100},{150,100}})));
end Bui620;
