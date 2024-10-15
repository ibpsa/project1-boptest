within IDEAS.Buildings.Data.Frames;
record PvcLineLoss "Old pvc frame with line losses"
  extends IDEAS.Buildings.Data.Frames.Pvc(
    redeclare parameter IDEAS.Buildings.Components.ThermalBridges.LineLosses briTyp);
  annotation (Documentation(revisions="<html>
<ul>
<li>
December 19, 2016 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Frame model that incorporates line losses.
</p>
</html>"));
end PvcLineLoss;
