within IDEAS.Buildings.Data.Frames;
record PvcInsulated "Low U value PVC frame"
    extends IDEAS.Buildings.Data.Interfaces.Frame(
    U_value=0.75);
      annotation (Documentation(info="<html>
<p>
Well insulated PVC window frame. 
</p>
<p>U value from: https://windows.lbl.gov/adv_sys/NTNU-LBNL-EuropeanFramesReport.pdf</p>
</html>"));
end PvcInsulated;
