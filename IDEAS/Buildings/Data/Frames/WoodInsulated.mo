within IDEAS.Buildings.Data.Frames;
record WoodInsulated "Low U value wooden frame"
extends IDEAS.Buildings.Data.Interfaces.Frame(
    U_value=0.7);
     annotation (Documentation(info="<html>
<p>
Well insulated wooden window frame. 
</p>
<p>U value from: https://windows.lbl.gov/adv_sys/NTNU-LBNL-EuropeanFramesReport.pdf</p>
</html>"));

end WoodInsulated;
