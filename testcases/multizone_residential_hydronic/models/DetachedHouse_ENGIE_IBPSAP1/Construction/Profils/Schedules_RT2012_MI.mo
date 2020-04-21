within DetachedHouse_ENGIE_IBPSAP1.Construction.Profils;
model Schedules_RT2012_MI "French thermal regulation schedules"

parameter Modelica.SIunits.Temperature SetHeaOccup=19+273.15
    "Heating setpoint during occupation";
parameter Modelica.SIunits.Temperature SetHeaInoccupa=16+273.15
    "Heating setpoint during inoccupation for less than 48 hours";
parameter Modelica.SIunits.Temperature SetHeaInoccupb=7+273.15
    "Heating setpoint during inoccupation for less than 48 hours";
parameter Modelica.SIunits.Temperature SetHeaFictif=2+273.15
    "Heating setpoint during no heating period";
parameter Modelica.SIunits.Temperature SetCooOccup=26+273.15
    "Cooling setpoint during occupation";
parameter Modelica.SIunits.Temperature SetCooInoccupa=30+273.15
    "Cooling setpoint during inoccupation for less than 48 hours";
parameter Modelica.SIunits.Temperature SetCooInoccupb=30+273.15
    "Cooling setpoint during inoccupation for less than 48 hours";
parameter Modelica.SIunits.Temperature SetCooFictif=32+273.15
    "Cooling setpoint during no heating period";

  Modelica.Blocks.MathBoolean.And OccupRT12a(nu=3) "Ocupancy permision"
    annotation (Placement(transformation(extent={{-64,-6},{-52,6}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-6,80},{6,92}})));
  Modelica.Blocks.Sources.Constant SetHeaOccupa(k=SetHeaOccup)
    "Heating setpoint"
    annotation (Placement(transformation(extent={{-26,90},{-18,98}})));
  Modelica.Blocks.Sources.Constant SetHeaInoccup(k=SetHeaInoccupa)
    "Inoccupation for less than 48 hours"
    annotation (Placement(transformation(extent={{-26,74},{-18,82}})));
  Modelica.Blocks.Logical.Switch HeaSetRT12a "Heating setpoint"
    annotation (Placement(transformation(extent={{16,64},{28,76}})));
  Modelica.Blocks.Sources.Constant SetHeaInoccup1(k=SetHeaInoccupb)
    "Inoccupation for more than 48 hours"
    annotation (Placement(transformation(extent={{-26,58},{-18,66}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-4,32},{8,44}})));
  Modelica.Blocks.Sources.Constant SetCooOccupa(k=SetCooOccup)
    "Cooling setpoint"
    annotation (Placement(transformation(extent={{-26,42},{-18,50}})));
  Modelica.Blocks.Sources.Constant SetCooInoccup(k=SetCooInoccupa)
    "Inoccupation for less than 48 hours"
    annotation (Placement(transformation(extent={{-26,26},{-18,34}})));
  Modelica.Blocks.Logical.Switch CooSetRTa "Cooling setpoint"
    annotation (Placement(transformation(extent={{16,16},{28,28}})));
  Modelica.Blocks.Sources.Constant SetCooInoccup1(k=SetCooInoccupb)
    "Inoccupation for more than 48 hours"
    annotation (Placement(transformation(extent={{-26,10},{-18,18}})));
  Modelica.Blocks.Interfaces.RealOutput HeaSetRT12(unit="K")
                                                   "Heating setpoint"
    annotation (Placement(transformation(extent={{100,80},{120,100}}),
        iconTransformation(extent={{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealOutput CooSetRT12(unit="K")
                                                   "Cooling setpoint"
    annotation (Placement(transformation(extent={{100,58},{120,78}}),
        iconTransformation(extent={{90,36},{110,56}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-2,-6},{10,6}})));
  Modelica.Blocks.Interfaces.RealOutput OccupRateRT12 "Occupancy rate"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{90,-12},{110,8}})));
  Modelica.Blocks.Interfaces.RealOutput OtherLoadsRateRT12
    "Internal loads rate"
    annotation (Placement(transformation(extent={{100,-82},{120,-62}}),
        iconTransformation(extent={{90,-74},{110,-54}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal4
    annotation (Placement(transformation(extent={{64,-58},{76,-46}})));
  Modelica.Blocks.Interfaces.RealOutput LightRT12 "Lighting permission"
    annotation (Placement(transformation(extent={{100,-62},{120,-42}}),
        iconTransformation(extent={{90,-42},{110,-22}})));
  Buildings.Controls.SetPoints.OccupancySchedule Noheating(
    firstEntryOccupied=false,
    period=365*24*3600,
    occupancy=3600*{2130,7232}) "Annual schedule"
    annotation (Placement(transformation(extent={{-90,104},{-80,114}})));
  Modelica.Blocks.Sources.Constant SetHeafictifa(k=SetHeaFictif)
    "Heating setpoint"
    annotation (Placement(transformation(extent={{40,98},{48,106}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{82,104},{94,116}})));
  Buildings.Controls.SetPoints.OccupancySchedule OccupWeeklySchedule(
    period=604800,
    occupancy=3600*{10,18,34,42,58,62,82,90,106,114},
    firstEntryOccupied=false) "Day schedule"
    annotation (Placement(transformation(extent={{-92,4},{-82,14}})));
  Buildings.Controls.SetPoints.OccupancySchedule OccupAnnualSchedule(
    firstEntryOccupied=false,
    period=31536000,
    occupancy=3600*{5089,5425,8593,8759.99999}) "Annual schedule"
    annotation (Placement(transformation(extent={{-92,-12},{-82,-2}})));
  Buildings.Controls.SetPoints.OccupancySchedule Nocooling(
    period=365*24*3600,
    occupancy=3600*{2130,7232},
    firstEntryOccupied=true) "Annual schedule"
    annotation (Placement(transformation(extent={{-90,52},{-80,62}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{82,48},{94,60}})));
  Modelica.Blocks.Sources.Constant SetCoofictifa(k=SetCooFictif)
    "Cooling setpoint"
    annotation (Placement(transformation(extent={{40,42},{48,50}})));
  Buildings.Controls.SetPoints.OccupancySchedule LightWeekSchedule(
    firstEntryOccupied=true,
    period=604800,
    occupancy=3600*{7,9,19,22,31,33,43,46,55,57,67,70,79,81,91,94,103,105,
        115,119,127,142,151,166}) "Light week schedule"
    annotation (Placement(transformation(extent={{-92,-52},{-82,-42}})));
  Modelica.Blocks.MathBoolean.And OccupRT12a1(
                                             nu=2) "Ocupancy permision"
    annotation (Placement(transformation(extent={{-30,-58},{-18,-46}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1
    annotation (Placement(transformation(extent={{64,-78},{76,-66}})));
equation
  connect(SetHeaInoccup.y, switch1.u3) annotation (Line(
      points={{-17.6,78},{-14,78},{-14,81.2},{-7.2,81.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetHeaOccupa.y, switch1.u1)
                                     annotation (Line(
      points={{-17.6,94},{-14,94},{-14,90.8},{-7.2,90.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetHeaInoccup1.y, HeaSetRT12a.u3)
                                           annotation (Line(
      points={{-17.6,62},{-12,62},{-12,65.2},{14.8,65.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch1.y, HeaSetRT12a.u1)
                                    annotation (Line(
      points={{6.6,86},{10,86},{10,74.8},{14.8,74.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetCooInoccup.y, switch2.u3) annotation (Line(
      points={{-17.6,30},{-14,30},{-14,33.2},{-5.2,33.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetCooOccupa.y, switch2.u1)
                                     annotation (Line(
      points={{-17.6,46},{-14,46},{-14,42.8},{-5.2,42.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetCooInoccup1.y, CooSetRTa.u3)
                                         annotation (Line(
      points={{-17.6,14},{-12,14},{-12,17.2},{14.8,17.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch2.y, CooSetRTa.u1)
                                  annotation (Line(
      points={{8.6,38},{10,38},{10,26.8},{14.8,26.8}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(booleanToReal4.y, LightRT12) annotation (Line(
      points={{76.6,-52},{110,-52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Noheating.occupied,switch3. u2) annotation (Line(
      points={{-79.5,106},{-22,106},{-22,110},{80.8,110}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(SetHeafictifa.y, switch3.u3) annotation (Line(
      points={{48.4,102},{60,102},{60,105.2},{80.8,105.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HeaSetRT12a.y,switch3. u1) annotation (Line(
      points={{28.6,70},{76,70},{76,114.8},{80.8,114.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch3.y, HeaSetRT12) annotation (Line(
      points={{94.6,110},{98,110},{98,90},{110,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(CooSetRTa.y, switch6.u1) annotation (Line(points={{28.6,22},{74,22},{74,
          32},{74,58.8},{80.8,58.8}},         color={0,0,127}));
  connect(SetCoofictifa.y, switch6.u3) annotation (Line(points={{48.4,46},{
          60,46},{60,49.2},{80.8,49.2}}, color={0,0,127}));
  connect(switch6.y, CooSetRT12) annotation (Line(points={{94.6,54},{96,54},
          {96,68},{110,68}}, color={0,0,127}));
  connect(OccupWeeklySchedule.occupied, OccupRT12a.u[1]) annotation (Line(
        points={{-81.5,6},{-70,6},{-70,2},{-64,2},{-64,2.8}}, color={255,0,255}));
  connect(OccupAnnualSchedule.occupied, OccupRT12a.u[2]) annotation (Line(
        points={{-81.5,-10},{-81.5,-10},{-70,-10},{-70,4.44089e-016},{-64,
          4.44089e-016}},
        color={255,0,255}));
  connect(booleanToReal.y, OccupRateRT12)
    annotation (Line(points={{10.6,0},{110,0}},         color={0,0,127}));
  connect(OccupRT12a.y, booleanToReal.u)
    annotation (Line(points={{-51.1,0},{-22,0},{-3.2,0}}, color={255,0,255}));
  connect(Nocooling.occupied, switch6.u2)
    annotation (Line(points={{-79.5,54},{80.8,54}}, color={255,0,255}));
  connect(OccupWeeklySchedule.occupied, OccupRT12a.u[3]) annotation (Line(
        points={{-81.5,6},{-70,6},{-70,2},{-64,2},{-64,-2.8}}, color={255,0,255}));
  connect(OccupWeeklySchedule.occupied, switch1.u2) annotation (Line(points={{-81.5,
          6},{-70,6},{-70,18},{-70,68},{-70,86},{-7.2,86}}, color={255,0,255}));
  connect(OccupWeeklySchedule.occupied, switch2.u2) annotation (Line(points={{-81.5,
          6},{-70,6},{-70,38},{-5.2,38}}, color={255,0,255}));
  connect(OccupAnnualSchedule.occupied, HeaSetRT12a.u2) annotation (Line(points={{-81.5,
          -10},{-70,-10},{-70,70},{14.8,70}},                  color={255,0,255}));
  connect(OccupAnnualSchedule.occupied, CooSetRTa.u2) annotation (Line(points={{-81.5,
          -10},{-70,-10},{-70,22},{14.8,22}},       color={255,0,255}));
  connect(LightWeekSchedule.occupied, OccupRT12a1.u[1]) annotation (Line(
        points={{-81.5,-50},{-70,-50},{-70,-49.9},{-30,-49.9}}, color={255,
          0,255}));
  connect(OccupRT12a.y, OccupRT12a1.u[2]) annotation (Line(points={{-51.1,0},
          {-50,0},{-50,-16},{-50,-54},{-40,-54},{-40,-54.1},{-30,-54.1}},
        color={255,0,255}));
  connect(OccupRT12a1.y, booleanToReal4.u) annotation (Line(points={{-17.1,
          -52},{-17.1,-52},{62.8,-52}}, color={255,0,255}));
  connect(booleanToReal1.y, OtherLoadsRateRT12) annotation (Line(points={{76.6,
          -72},{110,-72}},                color={0,0,127}));
  connect(booleanToReal1.u, OccupRT12a1.y) annotation (Line(points={{62.8,
          -72},{26,-72},{-12,-72},{-12,-52},{-17.1,-52}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,120}}), graphics={
        Rectangle(
          extent={{-100,120},{100,-100}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-94,34},{-26,40}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-30,34},{-24,90}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-30,84},{38,90}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{32,34},{38,90}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{32,34},{76,40}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-94,-34},{-10,-28}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-12,-34},{-6,22}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-10,16},{18,22}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{12,-34},{18,22}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{12,-34},{76,-28}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-132,-36},{-6,-64}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          textString="%name"),
        Text(
          extent={{92,93},{154,84}},
          lineColor={0,0,127},
          textString="HeaSetRT12"),
        Text(
          extent={{92,59},{154,50}},
          lineColor={0,0,127},
          textString="CooSetRT12"),
        Text(
          extent={{98,11},{160,2}},
          lineColor={0,0,127},
          textString="OccupRateRT12"),
        Text(
          extent={{104,-51},{166,-60}},
          lineColor={0,0,127},
          textString="OtherLoadsRateRT12"),
        Text(
          extent={{88,-23},{150,-32}},
          lineColor={0,0,127},
          textString="LightRt12
")}),
    Documentation(info="<html>
<h4>Profils du b&acirc;timent</h4>
<p>Ici, on retrouve diff&eacute;rents profils relatifs au fonctionnement du b&acirc;timent pour une maison individuelle respectant le fonctionnement d&eacute;fini par la RT2012 :  </p>
<ul>
<li>Consigne de chauffage</li>
<li>Consigne de climatisation</li>
<li>Occupation</li>
<li>Eclairage</li>
<li>Autres &eacute;quipements</li>
</ul>
</html>"));
end Schedules_RT2012_MI;
