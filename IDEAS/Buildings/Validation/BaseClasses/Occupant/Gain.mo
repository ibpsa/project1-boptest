within IDEAS.Buildings.Validation.BaseClasses.Occupant;
model Gain "BESTEST fixed internal gains by occupants"
  extends IDEAS.Templates.Interfaces.BaseClasses.Occupant(
    P={QNom},
    final nLoads=1);

protected
  parameter Modelica.SIunits.HeatFlowRate QNom = 200 "Baseload internal gain";

equation
  for i in 1:nZones loop
    heatPortCon[i].Q_flow = -QNom*0.40;
    heatPortRad[i].Q_flow = -QNom*0.60;
    TSet[i] = 273.15;
  end for;
  mDHW60C = 0;

  annotation (Diagram(graphics));
end Gain;
