within IDEAS.Buildings.Components.Occupants;
block AreaWeightedInput
  "Number of occupants equals zone input yOcc, multiplied with zone surface area"
  extends IDEAS.Buildings.Components.Occupants.Input(gain(k=A));

  annotation (Documentation(revisions="<html>
<ul>
<li>
March 28, 2019 by Filip Jorissen:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/998\">#998</a>.
</li>
</ul>
</html>", info="<html>
<p>
This block allows defining the occupancy externally, 
by using the zone model input <code>yOcc</code>.
The value of <code>yOcc</code> is internally multiplied
by the zone surface area.
This simplifies the workflow when the user wants to 
compute a zone occupancy that linearly depends on the
zone surface area.
</p>
</html>"));
end AreaWeightedInput;
