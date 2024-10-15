within IDEAS.BoundaryConditions.Examples;
model SimInfoManagerPerez "Perez checks"
  extends SimInfoManager;
  annotation (experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end SimInfoManagerPerez;
