within IDEAS.Buildings.Components.Shading.Interfaces;
type ShadingType = enumeration(
    None
       "None",
    BuildingShade
                "Buildings shade",
    Overhang
           "Overhang",
    SideFins
           "Side fins",
    Box
      "Box: overhang and side fins",
    Screen
         "Screen",
    OverhangAndScreen
                    "Overhang and screen",
    BoxAndScreen
          "Box and screen",
    HorizontalFins
          "Horizontal fins",
    OverhangAndHorizontalFins
          "Overhang and horizontal fins",
    Shading
          "Shading") annotation (Documentation(revisions="<html>
<ul>
<li>
May 4 2018, by Iago Cupeiro:<br/>
Extended with HorizontalFins and OverhangAndHorizontalFins models.
</li>
</ul>
</html>"));
