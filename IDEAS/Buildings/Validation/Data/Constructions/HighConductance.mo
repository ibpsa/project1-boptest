within IDEAS.Buildings.Validation.Data.Constructions;
record HighConductance "BESTEST high conductance wall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Validation.Data.Materials.Glass_200(d=0.003175),
      IDEAS.Buildings.Data.Materials.Air(d=0.013),
      IDEAS.Buildings.Validation.Data.Materials.Glass_200(d=0.003175)});

end HighConductance;
