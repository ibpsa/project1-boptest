within BESTESTHydronic;
model TestCase "Single zone residential hydronic example model"
  extends IDEAS.Examples.IBPSA.SingleZoneResidentialHydronic;
  annotation (experiment(StopTime=604800));
end TestCase;
