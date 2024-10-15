within IDEAS.Buildings.Validation.BaseClasses.HeatingSystem;
model Deadband_650 "BESTEST deadband heating system"
  extends IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem(
    final nEmbPorts = 0, final nLoads=1, final nTemSen = nZones);

  parameter Modelica.SIunits.Volume[nZones] VZones;
  parameter Real mSenFac = 5 "Correction factor for thermal mass in zone";
  parameter Real[nZones] C = VZones * mSenFac * 1012 * 1.204;

protected
  IDEAS.BoundaryConditions.Occupants.Components.Schedule occ(occupancy=3600*{7,18},
      firstEntryOccupied=true) "Occupancy shedule";
  parameter Modelica.SIunits.Temperature Tcool=300.15 "Cooling on above 27degC";
  parameter Modelica.SIunits.Power Pmax = 40*230
    "Maximum power that can be provided by feeder: 40A fuse";

equation
  for i in 1:nZones loop
    if Tcool < TSensor[i] then
      heatPortCon[i].Q_flow = min(-0.1*C[i]*(Tcool - TSensor[i])*(if occ.occupied then 1 else 0),Pmax);
    else
      heatPortCon[i].Q_flow = 0;
    end if;
    heatPortRad[i].Q_flow = 0;
  end for;

  heatPortEmb.Q_flow = zeros(nEmbPorts);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200,
            -100},{200,100}}), graphics), Documentation(revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>
January 14, 2017 by Filip Jorissen:<br/>
Added upper bound for cooling power to avoid 
non-linear algebraic loop without solution in electric grid.
</li>
</ul>
</html>"));
end Deadband_650;
