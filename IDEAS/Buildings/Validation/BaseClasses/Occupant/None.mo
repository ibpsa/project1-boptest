within IDEAS.Buildings.Validation.BaseClasses.Occupant;
model None "None"
  extends IDEAS.Templates.Interfaces.BaseClasses.Occupant(
    final nLoads=1,
    P={0},
    Q={0});

equation
  for i in 1:nZones loop
    heatPortCon[i].Q_flow = 0;
    heatPortRad[i].Q_flow = 0;
    TSet[i] = 273.15;
  end for;
  mDHW60C = 0;

  annotation (Diagram(graphics), Documentation(revisions="<html>
<ul>
<li>
July 25, 2018 by Filip Jorissen:<br/>
Fixed bug in assignment of <code>P</code> and <code>Q</code>.
This is for
<a href=\"https://github.com/open-ideas/IDEAS/issues/869\">#869</a>.
</li>
</ul>
</html>"));
end None;
