within IDEAS.Buildings.Data.Frames;
record Aluminium "Old aluminium frame"
  extends IDEAS.Buildings.Data.Interfaces.Frame(
    U_value=5.68);
       annotation (Documentation(info="<html>
<p>
Aluminum window frame. U value may vary.
</p>
</html>"));

end Aluminium;
