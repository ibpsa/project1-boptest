within IDEAS.Buildings.Validation.BaseClasses.Structure;
model Bui600 "BESTEST Building model case 600"

  extends IDEAS.Buildings.Validation.BaseClasses.Structure.BaseClasses.Bui(
    wall(A={21.6,16.2,9.6,16.2}),
    gF(nSurf=8));

  IDEAS.Buildings.Components.Window[2] win(
    final A={6,6},
    redeclare final parameter IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazing,
    final inc={IDEAS.Types.Tilt.Wall,IDEAS.Types.Tilt.Wall},
    azi={aO+IDEAS.Types.Azimuth.S,aO+IDEAS.Types.Azimuth.S},
    redeclare replaceable IDEAS.Buildings.Components.Shading.None shaType,
    redeclare final parameter IDEAS.Buildings.Data.Frames.None fraType,
    each frac=0)
    annotation (Placement(transformation(
        extent={{-5.5,-9.49999},{5.5,9.49997}},
        rotation=90,
        origin={10.5,-14.5})));

equation

  connect(win.propsBus_a, gF.propsBus[7:8]) annotation (Line(
      points={{8.60001,-9.91667},{8.60001,28},{40,28}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
   annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,-100},
            {150,100}})), Documentation(revisions="<html>
<ul>
<li>
March 8, 2017 by Filip Jorissen:<br/>
Added angle for offsetting building rotation.
This is for 
<a href=https://github.com/open-ideas/IDEAS/issues/689>#689</a>.
</li>
</ul>
</html>"));
end Bui600;
