within IDEAS.Templates.Structure;
model Case900FloorHeating "Case900 with floor heating"
  extends IDEAS.Templates.Structure.Case900(
    nEmb=1,
    floor(redeclare IDEAS.Buildings.Data.Constructions.InsulatedFloorHeating constructionType));
equation
  connect(floor.port_emb[1], heatPortEmb[1]) annotation (Line(points={{-10,-14.5},
          {-4,-14.5},{-4,-30},{110,-30},{110,60},{150,60}}, color={191,0,0}));
end Case900FloorHeating;
