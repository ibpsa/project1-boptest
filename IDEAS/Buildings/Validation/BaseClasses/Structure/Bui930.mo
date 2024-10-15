within IDEAS.Buildings.Validation.BaseClasses.Structure;
model Bui930 "BESTEST Building model case 930"

  extends IDEAS.Buildings.Validation.BaseClasses.Structure.Bui630(
    wall(redeclare each parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyWall constructionType),
    floor(redeclare final parameter IDEAS.Buildings.Validation.Data.Constructions.HeavyFloor constructionType));
 annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,-100},
            {150,100}}),       graphics));
end Bui930;
