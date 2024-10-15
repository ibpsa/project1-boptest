within IDEAS.Buildings.Validation.BaseClasses.HeatingSystem;
model Deadband "BESTEST deadband heating system"
  extends IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem(
    final nEmbPorts = 0, final nLoads=0,
    final nTemSen = nZones);

  parameter Modelica.SIunits.Volume[nZones] VZones;
  parameter Real mSenFac = 5 "Correction factor for thermal mass in zone";
  parameter Real[nZones] C = VZones * mSenFac * 1012 * 1.204;
  parameter Modelica.SIunits.Power Pmax = 40*230
    "Maximum power that can be provided by feeder: 40A fuse";

protected
  parameter Modelica.SIunits.Temperature Theat=293.15 "Heating on below 20degC";
  parameter Modelica.SIunits.Temperature Tcool=300.15 "Cooling on above 27degC";

equation
  for i in 1:nZones loop
    if Theat > TSensor[i] then
      heatPortCon[i].Q_flow = min(-0.1*C[i]*(Theat - TSensor[i]),Pmax);
    elseif Tcool < TSensor[i] then
      heatPortCon[i].Q_flow = min(-0.1*C[i]*(Tcool - TSensor[i]),Pmax);
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
</ul>
</html>"));
end Deadband;
