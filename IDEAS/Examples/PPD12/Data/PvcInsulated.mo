within IDEAS.Examples.PPD12.Data;
record PvcInsulated "Low U value PVC frame ppd12"
    extends IDEAS.Buildings.Data.Interfaces.Frame(
    U_value=1.2);
      annotation (Documentation(info="<html>
<p>From: https://windows.lbl.gov/adv_sys/NTNU-LBNL-EuropeanFramesReport.pdf</p>
</html>"));
end PvcInsulated;
