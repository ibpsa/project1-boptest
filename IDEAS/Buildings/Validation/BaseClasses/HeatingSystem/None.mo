within IDEAS.Buildings.Validation.BaseClasses.HeatingSystem;
model None "None"
  extends IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem(
    final nEmbPorts = 0, final nLoads=1, nZones=1, final nTemSen = nZones);

equation
  for i in 1:nZones loop
    heatPortCon[i].Q_flow = 0;
    heatPortRad[i].Q_flow = 0;
  end for;
  heatPortEmb.Q_flow=zeros(nEmbPorts);


  annotation (Documentation(revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"));
end None;
