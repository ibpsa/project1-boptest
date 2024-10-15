within IDEAS.Buildings.Validation.BaseClasses.Structure;
model Bui195 "BESTEST Building model case 195"

  extends IDEAS.Buildings.Validation.BaseClasses.Structure.BaseClasses.Bui(
    gF(n50=0),
    wall(redeclare parameter Data.Constructions.LightWall_195 constructionType,
          A =   {21.6,16.2,21.6,16.2}),
    roof(redeclare parameter Data.Constructions.LightRoof_195 constructionType));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,
            -100},{150,100}})));
end Bui195;
