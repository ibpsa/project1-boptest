within IDEAS.Examples.TwinHouses.BaseClasses.Data.Constructions;
record PvcInsulated "Frame TTH U 1.0"
  extends IDEAS.Buildings.Data.Interfaces.Frame(U_value=1);
      annotation (Documentation(info="<html>
<p>From: https://windows.lbl.gov/adv_sys/NTNU-LBNL-EuropeanFramesReport.pdf</p>
</html>"));
end PvcInsulated;
