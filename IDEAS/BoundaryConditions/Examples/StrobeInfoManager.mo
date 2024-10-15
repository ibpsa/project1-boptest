within IDEAS.BoundaryConditions.Examples;
model StrobeInfoManager "Unit test for SimInfoManager"
  import IDEAS;
  extends Modelica.Icons.Example;
  inner IDEAS.BoundaryConditions.Occupants.Extern.StrobeInfoManager strobe(
    nOcc=10,
    FilNam_P="P.txt",
    FilNam_Q="Q.txt",
    FilNam_mDHW="mDHW.txt",
    FilNam_QCon="QCon.txt",
    FilNam_QRad="QRad.txt",
    FilNam_TSet="sh_day.txt",
    FilNam_TSet2="sh_night.txt",
    filDir=Modelica.Utilities.Files.loadResource("modelica://IDEAS") +
        "/Resources/strobe/",
    startTime(displayUnit="d") = 0)
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  annotation (
    experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/BoundaryConditions/Examples/StrobeInfoManager.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
December 20, 2017 by Bram van der Heijde:<br/>
First implementation.
</li>
</ul>
</html>"));
end StrobeInfoManager;
