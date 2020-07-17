within MultiZoneResidentialHydronic.Building.Schedules;
model Schedules_MI_ZoneJour "French thermal regulation schedules"

parameter Modelica.SIunits.Temperature SetHeaOccup=19+273.15
    "Heating setpoint during occupation";
parameter Modelica.SIunits.Temperature SetHeaInoccupa=16+273.15
    "Heating setpoint during inoccupation for less than 48 hours";
parameter Modelica.SIunits.Temperature SetHeaInoccupb=7+273.15
    "Heating setpoint during inoccupation for less than 48 hours";
parameter Modelica.SIunits.Temperature SetHeaFictif=2+273.15
    "Heating setpoint during no heating period";

parameter Real delta_ST=1.8
    "Delta pour prendre en compte la variation spatio-temporelle";

  Modelica.Blocks.Interfaces.RealOutput HeaSetRT12(unit="K")
                                                   "Heating setpoint"
    annotation (Placement(transformation(extent={{100,80},{120,100}}),
        iconTransformation(extent={{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealOutput OccupRateRT12 "Occupancy rate"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{90,-12},{110,8}})));
  Modelica.Blocks.Interfaces.RealOutput OtherLoadsRateRT12
    "Internal loads rate"
    annotation (Placement(transformation(extent={{100,-82},{120,-62}}),
        iconTransformation(extent={{90,-74},{110,-54}})));
  Modelica.Blocks.Interfaces.RealOutput LightRT12 "Lighting permission"
    annotation (Placement(transformation(extent={{100,-62},{120,-42}}),
        iconTransformation(extent={{90,-42},{110,-22}})));
  Schedules_RT2012_MI schedules_RT2012_MI(
    SetHeaOccup=SetHeaOccup,
    SetHeaInoccupa=SetHeaInoccupa,
    SetHeaInoccupb=SetHeaInoccupb,
    SetHeaFictif=SetHeaFictif)
    annotation (Placement(transformation(extent={{-84,36},{-12,100}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-44,-10},{-32,2}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realTrue=0.5)
    annotation (Placement(transformation(extent={{-44,-30},{-32,-18}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-18,-24},{2,-4}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=0.1)
    annotation (Placement(transformation(extent={{52,24},{62,34}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal2
    annotation (Placement(transformation(extent={{68,24},{78,34}})));
  Modelica.Blocks.Math.Product product3
    annotation (Placement(transformation(extent={{44,-60},{60,-44}})));
  Modelica.Blocks.Math.Product product4
    annotation (Placement(transformation(extent={{44,-80},{60,-64}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{38,92},{50,104}})));
  Modelica.Blocks.Sources.Constant SetHeaOccupa(k=schedules_RT2012_MI.SetHeaOccup
         + delta_ST)
    "Heating setpoint"
    annotation (Placement(transformation(extent={{18,102},{26,110}})));
  Modelica.Blocks.Sources.Constant SetHeaInoccup(k=schedules_RT2012_MI.SetHeaInoccupa
         + delta_ST)
    "Inoccupation for less than 48 hours"
    annotation (Placement(transformation(extent={{18,86},{26,94}})));
  Modelica.Blocks.Sources.Constant SetHeafictifa(k=schedules_RT2012_MI.SetHeaFictif)
    "Heating setpoint"
    annotation (Placement(transformation(extent={{60,80},{68,88}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{78,86},{90,98}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
        schedules_RT2012_MI.Noheating.occupied)
    annotation (Placement(transformation(extent={{58,88},{68,98}})));
  Buildings.Controls.SetPoints.OccupancySchedule ZoneJour_100(
    period=604800,
    occupancy=3600*{8,10,18,22,32,34,42,46,56,58,66,70,80,82,90,94,104,106,
        114,118,128,142,152,166},
    firstEntryOccupied=true) "Occupation de la zone jour a 100%"
    annotation (Placement(transformation(extent={{-70,-10},{-60,0}})));
  Buildings.Controls.SetPoints.OccupancySchedule ZoneJour_50(
    firstEntryOccupied=true,
    occupancy=3600*{7,8,22,23},
    period=86400) "Occupation de la zone jour a 50%"
    annotation (Placement(transformation(extent={{-70,-30},{-60,-20}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1(
                                                   threshold=0.1)
    annotation (Placement(transformation(extent={{6,94},{14,102}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{34,62},{46,74}})));
  Modelica.Blocks.Sources.Constant SetHeaOccupa1(k=schedules_RT2012_MI.SetCooOccup
         + delta_ST)
    "Heating setpoint"
    annotation (Placement(transformation(extent={{14,72},{22,80}})));
  Modelica.Blocks.Sources.Constant SetHeaInoccup1(k=schedules_RT2012_MI.SetCooInoccupa
         + delta_ST)
    "Inoccupation for less than 48 hours"
    annotation (Placement(transformation(extent={{12,56},{20,64}})));
  Modelica.Blocks.Sources.Constant SetHeafictifa1(k=schedules_RT2012_MI.SetCooFictif)
    "Heating setpoint"
    annotation (Placement(transformation(extent={{56,50},{64,58}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{74,56},{86,68}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=
        schedules_RT2012_MI.Nocooling.occupied)
    annotation (Placement(transformation(extent={{54,58},{64,68}})));
  Modelica.Blocks.Interfaces.RealOutput CooSetRT12
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,52},{120,72}})));
equation

  connect(booleanToReal.y, add.u1) annotation (Line(points={{-31.4,-4},{-28,
          -4},{-28,-8},{-20,-8}}, color={0,0,127}));
  connect(booleanToReal1.y, add.u2) annotation (Line(points={{-31.4,-24},{
          -28,-24},{-28,-20},{-20,-20}}, color={0,0,127}));
  connect(product.y, OccupRateRT12)
    annotation (Line(points={{43,0},{110,0}}, color={0,0,127}));
  connect(add.y, product.u2) annotation (Line(points={{3,-14},{10,-14},{10,
          -6},{20,-6}}, color={0,0,127}));
  connect(schedules_RT2012_MI.OccupRateRT12, product.u1) annotation (Line(
        points={{-12,64.5091},{12,64.5091},{12,62},{12,18},{12,6},{20,6}},
        color={0,0,127}));
  connect(product.y, realToBoolean.u) annotation (Line(points={{43,0},{46,0},
          {46,2},{46,29},{51,29}}, color={0,0,127}));
  connect(realToBoolean.y, booleanToReal2.u) annotation (Line(points={{62.5,
          29},{65.25,29},{67,29}}, color={255,0,255}));
  connect(product4.y, OtherLoadsRateRT12) annotation (Line(points={{60.8,
          -72},{110,-72},{110,-72}}, color={0,0,127}));
  connect(product3.y, LightRT12)
    annotation (Line(points={{60.8,-52},{110,-52}}, color={0,0,127}));
  connect(booleanToReal2.y, product3.u2) annotation (Line(points={{78.5,29},
          {92,29},{92,-28},{28,-28},{28,-56.8},{42.4,-56.8}}, color={0,0,
          127}));
  connect(booleanToReal2.y, product4.u2) annotation (Line(points={{78.5,29},
          {92,29},{92,-28},{28,-28},{28,-76.8},{42.4,-76.8}}, color={0,0,
          127}));
  connect(schedules_RT2012_MI.LightRT12, product3.u1) annotation (Line(
        points={{-12,55.7818},{-2,55.7818},{-2,56},{8,56},{8,-47.2},{42.4,-47.2}},
                   color={0,0,127}));
  connect(schedules_RT2012_MI.OtherLoadsRateRT12, product4.u1) annotation (
      Line(points={{-12,46.4727},{-4,46.4727},{-4,46},{6,46},{6,-67.2},{42.4,
          -67.2}},      color={0,0,127}));
  connect(SetHeaInoccup.y,switch1. u3) annotation (Line(
      points={{26.4,90},{30,90},{30,93.2},{36.8,93.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetHeaOccupa.y,switch1. u1)
                                     annotation (Line(
      points={{26.4,106},{30,106},{30,102.8},{36.8,102.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetHeafictifa.y,switch3. u3) annotation (Line(
      points={{68.4,84},{72,84},{72,87.2},{76.8,87.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch1.y, switch3.u1) annotation (Line(points={{50.6,98},{76.8,
          98},{76.8,96.8}}, color={0,0,127}));
  connect(switch3.y, HeaSetRT12) annotation (Line(points={{90.6,92},{94,92},
          {94,90},{96,90},{96,90},{110,90},{110,90}}, color={0,0,127}));
  connect(booleanExpression.y, switch3.u2) annotation (Line(points={{68.5,
          93},{73.25,93},{73.25,92},{76.8,92}}, color={255,0,255}));
  connect(ZoneJour_100.occupied, booleanToReal.u) annotation (Line(points={
          {-59.5,-8},{-52,-8},{-52,-4},{-45.2,-4}}, color={255,0,255}));
  connect(ZoneJour_50.occupied, booleanToReal1.u) annotation (Line(points={
          {-59.5,-28},{-52,-28},{-52,-24},{-45.2,-24}}, color={255,0,255}));
  connect(realToBoolean1.y, switch1.u2) annotation (Line(points={{14.4,98},
          {25.25,98},{36.8,98}}, color={255,0,255}));
  connect(realToBoolean1.u, schedules_RT2012_MI.OccupRateRT12) annotation (
      Line(points={{5.2,98},{0,98},{0,64.5091},{-12,64.5091}}, color={0,0,
          127}));
  connect(SetHeaInoccup1.y, switch2.u3) annotation (Line(
      points={{20.4,60},{24,60},{24,63.2},{32.8,63.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetHeaOccupa1.y, switch2.u1) annotation (Line(
      points={{22.4,76},{26,76},{26,72},{30,72},{30,72.8},{32.8,72.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetHeafictifa1.y, switch4.u3) annotation (Line(
      points={{64.4,54},{58,54},{58,57.2},{72.8,57.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch2.y,switch4. u1) annotation (Line(points={{46.6,68},{72.8,
          68},{72.8,66.8}}, color={0,0,127}));
  connect(booleanExpression1.y, switch4.u2) annotation (Line(points={{64.5,
          63},{70,63},{70,62},{72.8,62}}, color={255,0,255}));
  connect(realToBoolean1.y,switch2. u2) annotation (Line(points={{14.4,98},
          {32.8,98},{32.8,68}},  color={255,0,255}));
  connect(switch4.y, CooSetRT12)
    annotation (Line(points={{86.6,62},{110,62}}, color={0,0,127}));
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
<h4>Schedules (day use)</h4>
<p>Conventional (building energy regulation compliance calculation) for the French context. </p>
<p>Weekly based and then repeated over the entire year (1 week of holiday in December and in August).</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><br>Day / Hour </p><p>Occupancy (occpied=1; unoccupied=0)</p></td>
<td><p>1</p></td>
<td><p>2</p></td>
<td><p>3</p></td>
<td><p>4</p></td>
<td><p>5</p></td>
<td><p>6</p></td>
<td><p>7</p></td>
<td><p>8</p></td>
<td><p>9</p></td>
<td><p>10</p></td>
<td><p>11</p></td>
<td><p>12</p></td>
<td><p>13</p></td>
<td><p>14</p></td>
<td><p>15</p></td>
<td><p>16</p></td>
<td><p>17</p></td>
<td><p>18</p></td>
<td><p>19</p></td>
<td><p>20</p></td>
<td><p>21</p></td>
<td><p>22</p></td>
<td><p>23</p></td>
<td><p>24</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>2</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>3</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>4</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>5</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>6</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>7</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
</table>
<p><br><br><br><br><br>Year starts on Monday</p>
<p>Week/Month 1 2 3 4 5 6 7 8 9 10 11 12</p>
<p>1 1 1 1 1 1 1 1 0 1 1 1 1</p>
<p>2 1 1 1 1 1 1 1 0 1 1 1 1</p>
<p>3 1 1 1 1 1 1 1 1 1 1 1 1</p>
<p>4 1 1 1 1 1 1 1 1 1 1 1 0</p>
<p>5 1 1 1 1 </p>
</html>"));
end Schedules_MI_ZoneJour;
