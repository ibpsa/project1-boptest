within IDEAS.Buildings.Validation.BaseClasses.Structure;
model Bui910 "BESTEST Building model case 910"

  extends IDEAS.Buildings.Validation.BaseClasses.Structure.Bui610(
    wall(redeclare each parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall constructionType),
    floor(redeclare final parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyFloor constructionType));

 annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,
            -100},{150,100}}), graphics));
end Bui910;
