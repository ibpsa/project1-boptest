within IDEAS.Buildings.Data.Frames;
record Pvc "Old PVC frame"
  extends IDEAS.Buildings.Data.Interfaces.Frame(
    U_value=1.7);
     annotation (Documentation(info="<html>
<p>
PVC window frame. U value may vary.
</p>
</html>"));
end Pvc;
