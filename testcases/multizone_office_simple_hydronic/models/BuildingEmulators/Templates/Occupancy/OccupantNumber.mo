within BuildingEmulators.Templates.Occupancy;
model OccupantNumber "Model with a typical occupancy profile in non-residential buildings"
  extends BuildingEmulators.Templates.Interfaces.BaseClasses.Occupant;


  Modelica.Blocks.Sources.CombiTimeTable occPro(
    table=[0,0;1,0;2,0;3,0;4,0;5,0;6,0;7,0.6;8,0.9;9,0.95;10,1;11,1;12,0.9;13,0.9;14,1;15,0.9;16,0.6;17,0.4;18,0.3;19,0;20,0;21,0;22,0;23,0;24,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale=3600)
    "Normalized occupancy profile"
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));

  Modelica.Blocks.Math.Gain occGain(k=maxOcc)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  parameter Real maxOcc
  "Maximum number of occupants";

  parameter Real split[nZones] = 1/nZones*ones(nZones)
  "Splitof the occupancy between zones";

  Modelica.Blocks.Math.MultiProduct multiProduct(nu=4)
    annotation (Placement(transformation(extent={{24,4},{36,16}})));
  outer IDEAS.Utilities.Time.CalendarTime calTim
    annotation (Placement(transformation(extent={{-200,-100},{-180,-80}})));
  Modelica.Blocks.Sources.RealExpression weekend(y=if (calTim.weekDay == 6) or (calTim.weekDay == 7)
         then 0 else 1)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.RealExpression summer(y=if (calTim.month == 7) or (calTim.weekDay ==8)
         then 0.5 else 1) "Occupancy halved in summer due to holidays"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.RealExpression holidays(y=if
        (calTim.month == 1 and calTim.day == 1)
        or (calTim.month == 4 and calTim.day == 17)
        or (calTim.month == 4 and calTim.day == 18)
        or (calTim.month == 5 and calTim.day == 1)
        or (calTim.month == 5 and calTim.day == 26)
        or (calTim.month == 6 and calTim.day == 5)
        or (calTim.month == 6 and calTim.day == 6)
        or (calTim.month == 7 and calTim.day == 21)
        or (calTim.month == 8 and calTim.day == 15)
        or (calTim.month == 11 and calTim.day == 1)
        or (calTim.month == 11 and calTim.day == 11)
        or (calTim.month == 12 and calTim.day == 25)
        then 0 else 1) "Occupancy halved in summer due to holidays"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));

//initial equation
   // Assert that the split sum is == 1
//  assert(sum(split) > 1.0 and sum(split) < 1.0,
//      "The split sum is different than one. Please check");

   parameter Modelica.Units.SI.HeatFlowRate qAppIdle = 125+300+2*150+450 "appliances iddle internal gains (printer + copier + 2x projectors + coffe machine)";

   parameter Modelica.Units.SI.HeatFlowRate qAppOcc = 75 + 80 "appliances occupied internal gains (one monitor and workstation per occupant)";

  Modelica.Units.SI.HeatFlowRate qApp[nZones] = qAppOcc*nOcc + qAppIdle*ones(nZones) "appliances internal gains";

  parameter Real fraRadApp = 0.3 "radiative heat transfer by appliances";

equation

  heatPortCon.Q_flow = -qApp.*(1-fraRadApp);
  heatPortRad.Q_flow = -qApp.*(fraRadApp);


  nOcc = multiProduct.y.*split "Piece-wise multiplication to distribute the occupants per zone";
  TSet = (273.15 + 21)*ones(nZones);
  mDHW60C = 0 "Non-residential building, no DHW needs";

  connect(occPro.y[1], occGain.u)
    annotation (Line(points={{-39,10},{-22,10}}, color={0,0,127}));
  connect(occGain.y, multiProduct.u[1]) annotation (Line(points={{1,10},{12,10},
          {12,8.425},{24,8.425}},
                                color={0,0,127}));
  connect(weekend.y, multiProduct.u[2]) annotation (Line(points={{-39,-30},{14,-30},
          {14,9.475},{24,9.475}}, color={0,0,127}));
  connect(summer.y, multiProduct.u[3]) annotation (Line(points={{-39,-50},{14,-50},
          {14,10.525},{24,10.525}}, color={0,0,127}));
  connect(holidays.y, multiProduct.u[4]) annotation (Line(points={{-39,-70},{14,
          -70},{14,8},{18,8},{18,10},{24,10},{24,11.575}}, color={0,0,127}));
end OccupantNumber;
