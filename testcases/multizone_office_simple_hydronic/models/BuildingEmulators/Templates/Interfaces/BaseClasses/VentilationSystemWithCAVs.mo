within BuildingEmulators.Templates.Interfaces.BaseClasses;
partial model VentilationSystemWithCAVs
  extends BuildingEmulators.Templates.Interfaces.BaseClasses.VentilationSystemWithAHUs;
  Modelica.Blocks.Sources.Constant cav(k=1)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));

equation
   for i in 1:nZones loop
  connect(cav.y, vav_ret[i].y)
    annotation (Line(points={{-139,60},{-100,60},{-100,32}}, color={0,0,127}));
  connect(cav.y, vav_sup[i].y) annotation (Line(points={{-139,60},{-80,60},{-80,
          0},{-100,0},{-100,-8}}, color={0,0,127}));
    end for;
end VentilationSystemWithCAVs;
