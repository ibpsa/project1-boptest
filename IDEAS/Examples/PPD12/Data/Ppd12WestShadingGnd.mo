within IDEAS.Examples.PPD12.Data;
record Ppd12WestShadingGnd "Ppd shading model for west side, ground floor"
  extends Buildings.Components.Shading.Interfaces.ShadingProperties(
    controlled=false,
    shaType=IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.BuildingShade,
    L=10,
    dh=hBui-hTopWin);
  parameter Modelica.SIunits.Length hBui = 2.9+1.6+2+2.2+1+0.5 "Height of line-of-sight point of opposite building that casts shadow";
  parameter Modelica.SIunits.Length hTopWin = 2.9 "Height difference between street level and bottom of window";
    //Shading model representing shading from roof tip (9.3m high, 12m horizontal distance to windows)
    //of the opposite building on the west side
    //window bottom on ground floor is 1.2 m above the ground
  annotation (Documentation(info="<html>
<p>Distances:</p>
<p>Pavement to top window ground floor: 2.9m</p>
<p>Top window ground floor to bottom window 1st floor: 1.6m</p>
<p>Bottom window 1st floor to top window 1st floor: 2m.</p>
<p>Top window 1st floor to edge glazing: 10 cm</p>
<p>Top window 1st floor to bottom window 2nd floor: 2.2m</p>
<p>Window height 2nd floor: 1m</p>
</html>"));
end Ppd12WestShadingGnd;
