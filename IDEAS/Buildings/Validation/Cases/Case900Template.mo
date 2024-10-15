within IDEAS.Buildings.Validation.Cases;
model Case900Template "Case 900 implementation using template"

  extends IDEAS.Buildings.Components.RectangularZoneTemplate(
    h=2.7,
    redeclare package Medium = IDEAS.Media.Air,
    n50=0.822*0.5*n50toAch,
    redeclare replaceable Components.ZoneAirModels.WellMixedAir airModel,
    T_start=293.15,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    hasWinCei=false,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.LightRoof conTypCei,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    redeclare Data.Constructions.HeavyFloor conTypFlo,
    redeclare Data.Constructions.HeavyWall conTypA,
    redeclare Data.Constructions.HeavyWall conTypB,
    redeclare Data.Constructions.HeavyWall conTypC,
    redeclare Data.Constructions.HeavyWall conTypD,
    hasWinA=true,
    fracA=0,
    redeclare IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazingA,
    redeclare IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties
      shaTypA,
    hasWinB=false,
    hasWinC=false,
    hasWinD=false,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    aziA=IDEAS.Types.Azimuth.S,
    mSenFac=0.822,
    l=8,
    w=6,
    A_winA=12)
    annotation (Placement(transformation(extent={{0,-20},{-20,0}})));


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
November 18, 2020 by Filip Jorissen:<br/>
Revised n50 value such that it cancels out <code>n50toAch</code>.
This is for 
<a href=https://github.com/open-ideas/IDEAS/issues/1081>#1081</a>.
</li>
<li>
March 26, 2018 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end Case900Template;
