within IDEAS.Buildings.Validation.BaseClasses.Structure;
model Bui900 "BESTEST Building model case 900"

  extends IDEAS.Buildings.Validation.BaseClasses.Structure.Bui600(
    wall(redeclare each parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall constructionType),
    floor(redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyFloor constructionType));

   annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,
            -100},{150,100}}), graphics));
end Bui900;
