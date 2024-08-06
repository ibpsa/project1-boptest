within BuildingEmulators.Templates.Ventilation;
model AirHandlingUnits "No ventilation"
  extends
    BuildingEmulators.Templates.Interfaces.BaseClasses.VentilationSystemWithWaterCircuit(
    nLoads=0);

  BuildingEmulators.Components.AirHandlingUnit[nVen] airHandlingUnit
    annotation (Placement(transformation(extent={{-124,-30},{8,36}})));
equation
  connect(portCoo_a, airHandlingUnit.portCoo_b) annotation (Line(points={{30,
          -100},{30,-60},{-87.04,-60},{-87.04,-29.34}}, color={0,127,255}));
  connect(portCoo_b, airHandlingUnit.portCoo_a) annotation (Line(points={{0,
          -100},{0,-60},{-100.9,-60},{-100.9,-29.34}}, color={0,127,255}));
  connect(portHea_b, airHandlingUnit.portHea_a) annotation (Line(points={{70,
          -100},{70,-60},{-67.9,-60},{-67.9,-29.34}}, color={0,127,255}));
  connect(portHea_a, airHandlingUnit.portHea_b) annotation (Line(points={{100,
          -100},{100,-50},{-54.04,-50},{-54.04,-29.34}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}})),           Icon(coordinateSystem(extent={{-200,
            -100},{200,100}})),
    Documentation(revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"));
end AirHandlingUnits;
