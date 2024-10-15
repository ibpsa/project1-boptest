within IDEAS.BoundaryConditions.Occupants.Standards;
model ISO13790
  extends IDEAS.Templates.Interfaces.BaseClasses.Occupant(
    P = {heatPortCon[1].Q_flow + heatPortRad[1].Q_flow},
    Q = {0},
    nZones=1,
    nLoads=1);

  parameter Modelica.SIunits.Area[nZones] AFloor=ones(nZones)*100
    "Floor area of different zones";

protected
  final parameter Modelica.SIunits.Time interval=3600 "Time interval";
  final parameter Modelica.SIunits.Time period=86400/interval
    "Number of intervals per repetition";
  final parameter Real[3] QDay(unit="W/m2") = {8,20,2}
    "Specific power for dayzone";
  Integer t "Time interval";

algorithm
  when sample(0, interval) then
    t := if pre(t) + 1 <= period then pre(t) + 1 else 1;
  end when;

equation
  mDHW60C = 0;
  heatPortRad.Q_flow = heatPortCon.Q_flow;

  if noEvent(t <= 7 or t >= 23) then
    heatPortCon.Q_flow = -AFloor*QDay[3]*0.5;
    TSet = ones(nZones)*(18 + 273.15);
  elseif noEvent(t > 7 and t <= 17) then
    heatPortCon.Q_flow = -AFloor*QDay[1]*0.5;
    TSet = ones(nZones)*(16 + 273.15);
  else
    heatPortCon.Q_flow = -AFloor*QDay[2]*0.5;
    TSet = ones(nZones)*(21 + 273.15);
  end if;

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
end ISO13790;
