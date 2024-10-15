within IDEAS.Buildings.Data.Frames;
record Wood "Old wooden frame"
  extends IDEAS.Buildings.Data.Interfaces.Frame(
    U_value=2.27);
      annotation (Documentation(info="<html>
<p>
Wooden window frame. U value may vary.
</p>
</html>"));
end Wood;
