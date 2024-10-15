within IDEAS.BoundaryConditions.Examples;
model SimInfoManager "Unit test for SimInfoManager"
  extends Modelica.Icons.Example;
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  annotation (
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/BoundaryConditions/Examples/SimInfoManager.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
September 22, 2016 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end SimInfoManager;
