within IDEAS.Buildings.Validation.BaseClasses.HeatingSystem;
model ThermostatSetback "BESTEST thermostat setback heating system"

  extends IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem(
    final nEmbPorts = 0, final nLoads=1, final nTemSen = nZones);

  parameter Modelica.SIunits.Volume[nZones] VZones;
  parameter Real mSenFac = 5 "Correction factor for thermal mass in zone";
  parameter Real[nZones] C = VZones * mSenFac * 1012 * 1.204;
  parameter Modelica.SIunits.Power Pmax = 40*230
    "Maximum power that can be provided by feeder: 40A fuse";
protected
  IDEAS.BoundaryConditions.Occupants.Components.Schedule occ(occupancy=3600*{7,23},
      firstEntryOccupied=true) "Occupancy shedule";
  parameter Modelica.SIunits.Temperature Tbase=283.15
    "Heating on below 10degC if non-occupied";
  parameter Modelica.SIunits.Temperature Theat=293.15
    "Heating on below 20degC if occupied";
  parameter Modelica.SIunits.Temperature Tcool=300.15
    "Cooling on above 27degC always";

equation
  for i in 1:nZones loop
    if (Tbase > TSensor[i]) and not occ.occupied then
      heatPortCon[i].Q_flow = max(-0.1*C[i]*(Tbase - TSensor[i]),-Pmax);
    elseif (Theat > TSensor[i]) and occ.occupied then
      heatPortCon[i].Q_flow = max(-0.1*C[i]*(Theat - TSensor[i]),-Pmax);
    elseif (Tcool < TSensor[i]) then
      heatPortCon[i].Q_flow = min(-0.1*C[i]*(Tcool - TSensor[i]),Pmax);
    else
      heatPortCon[i].Q_flow = 0;
    end if;
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
end ThermostatSetback;
