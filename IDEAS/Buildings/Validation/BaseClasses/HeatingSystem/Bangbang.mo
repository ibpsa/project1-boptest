within IDEAS.Buildings.Validation.BaseClasses.HeatingSystem;
model Bangbang "BESTEST bang-bang heating system"
  extends IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem(
    final nEmbPorts = 0, final nLoads=1, final nTemSen = nZones);

  parameter Modelica.SIunits.Volume[nZones] VZones;
  parameter Real mSenFac = 5 "Correction factor for thermal mass in zone";
  parameter Real[nZones] C = VZones * mSenFac * 1012 * 1.204;

protected
  parameter Modelica.SIunits.Temperature Theat=293.15 "Heating on below 20degC";
  parameter Modelica.SIunits.Temperature Tcool=293.15 "Cooling on above 27degC";

equation
  for i in 1:nZones loop
    if Theat > TSensor[i] then
      heatPortCon[i].Q_flow = -100*C[i]*(Theat - TSensor[i]);
    elseif Tcool < TSensor[i] then
      heatPortCon[i].Q_flow = -100*C[i]*(Tcool - TSensor[i]);
    else
      heatPortCon[i].Q_flow = 0;
    end if;

    heatPortRad[i].Q_flow = 0;
  end for;
  heatPortEmb.Q_flow=zeros(nEmbPorts);


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
end Bangbang;
