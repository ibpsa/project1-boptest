within MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite;
model ReadChilledWater
  "Collection of Chilled Water System measurements for BOPTEST"

  Buildings.Utilities.IO.SignalExchange.Read dp(
    description="Differential pressure of chilled/hot water measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Differential pressure of chilled/hot water measurement"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  Buildings.Utilities.IO.SignalExchange.Read TCHW_sup(
    description="Chilled water supply temperature measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Chilled water supply temperature measurement"
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));

  Modelica.Blocks.Interfaces.RealInput dp_in
    "Differential pressure of chilled/hot water measurement"
    annotation (Placement(transformation(extent={{-140,80},{-100,120}}),
        iconTransformation(extent={{-140,80},{-100,120}})));
  Modelica.Blocks.Interfaces.RealInput TCHW_sup_in
    "CHW/HW temperature measurement"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPPum(
    description="Chilled water plant pump power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Block for outputting the chilled water plant"
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPChi(
    description="Multiple chiller power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))  "Block for outputting the multiple chillers"
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));

  Modelica.Blocks.Interfaces.RealInput PPum_in "Water pump power"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}})));
  Modelica.Blocks.Interfaces.RealInput PChi_in  "Chiller power "
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPCooTow(
    description="Multiple cooling tower power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))  "Block for outputting the multiple cooling towers"
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));

  Modelica.Blocks.Interfaces.RealInput PCooTow_in  "Cooling tower power "
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Utilities.IO.SignalExchange.Read TCHW_ret(
    description="Chilled water return temperature measurement",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Chilled water return temperature measurement"
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));

  Modelica.Blocks.Interfaces.RealInput TCHW_ret_in
    "CHW/HW temperature measurement" annotation (Placement(transformation(
          extent={{-140,50},{-100,90}}), iconTransformation(extent={{-140,50},{-100,
            90}})));
  Buildings.Utilities.IO.SignalExchange.Read mCHW_tot(
    description="Total chilled water mass flow rate ",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="kg/s")) "Total chilled water mass flow rate"
    annotation (Placement(transformation(extent={{-10,130},{10,150}})));

  Modelica.Blocks.Interfaces.RealInput mCHW_tot_in
    annotation (Placement(transformation(extent={{-140,120},{-100,160}})));
equation
  connect(dp.u, dp_in)
    annotation (Line(points={{-12,100},{-120,100}},
                                                  color={0,0,127}));
  connect(TCHW_sup_in, TCHW_sup.u)
    annotation (Line(points={{-120,30},{-12,30}}, color={0,0,127}));
  connect(reaPPum.u, PPum_in)
    annotation (Line(points={{-12,-10},{-120,-10}},
                                                  color={0,0,127}));
    connect(reaPChi.u, PChi_in)
    annotation (Line(points={{-12,-50},{-120,-50}}, color={0,0,127}));
    connect(reaPCooTow.u, PCooTow_in)
    annotation (Line(points={{-12,-80},{-120,-80}}, color={0,0,127}));

  connect(TCHW_ret_in, TCHW_ret.u) annotation (Line(points={{-120,70},{-68,70},{
          -68,70},{-12,70}}, color={0,0,127}));
  connect(mCHW_tot.u, mCHW_tot_in)
    annotation (Line(points={{-12,140},{-120,140}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,160}}), graphics={Rectangle(
          extent={{-100,160},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-32,24},{34,-16}},
          lineColor={0,0,0},
          textString="Read
Wat"),  Text(
          extent={{-148,160},{152,200}},
          textString="%name",
          textColor={0,0,255})}),Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,160}})));
end ReadChilledWater;
