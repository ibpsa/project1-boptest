within FRP.RTUVAV.Component;
model thermostat_T_2ndtfloor
    parameter Modelica.SIunits.Temperature SP_TCSP=273.15+24; // zone cooling setpoint 72F
    parameter Modelica.SIunits.Temperature SP_TCSP_setback=273.15+24; // zone cooling setpoint setback 75F
    parameter Modelica.SIunits.Temperature SP_THSP=273.15+20; // zone heating setpoint 68F
    parameter Modelica.SIunits.Temperature SP_THSP_setback=273.15+18; // zone heating setpoint setback 64.4F
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP204(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP204(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo204(u(unit="K"),
      description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea204(description=
        "Zone temperature setpoint for heating", u(unit="K"))
    "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out204
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-48},{32,-32}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out204
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-18},{32,-2}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP205(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-110},{-120,-90}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP205(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo205(u(unit="K"),
      description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea205(description=
        "Zone temperature setpoint for heating", u(unit="K"))
    "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out105
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-108},{32,-92}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out205
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-78},{32,-62}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP206(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-170},{-120,-150}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP206(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-140},{-120,-120}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo206(u(unit="K"),
      description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,-170},{-60,-150}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea206(description=
        "Zone temperature setpoint for heating", u(unit="K"))
    "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-80,-140},{-60,-120}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out206
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-168},{32,-152}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out206
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-138},{32,-122}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP203(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP203(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo203(u(unit="K"),
      description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea203(description=
        "Zone temperature setpoint for heating", u(unit="K"))
    "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out203
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,12},{32,28}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out203
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,42},{32,58}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP202(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,70},{-120,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP202(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,100},{-120,120}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo202(u(unit="K"),
      description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea202(description=
        "Zone temperature setpoint for heating", u(unit="K"))
    "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out202
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,72},{32,88}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out202
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,102},{32,118}})));
equation
  connect(HeatingSP204.y[1], oveTSetHea204.u)
    annotation (Line(points={{-118,-10},{-82,-10}}, color={0,0,127}));
  connect(CoolingSP204.y[1], oveTSetCoo204.u)
    annotation (Line(points={{-118,-40},{-82,-40}}, color={0,0,127}));
  connect(oveTSetHea204.y, TZonHeatingSet_out204)
    annotation (Line(points={{-59,-10},{24,-10}}, color={0,0,127}));
  connect(oveTSetCoo204.y, TZonCoolingSet_out204)
    annotation (Line(points={{-59,-40},{24,-40}}, color={0,0,127}));
  connect(HeatingSP205.y[1], oveTSetHea205.u)
    annotation (Line(points={{-118,-70},{-82,-70}}, color={0,0,127}));
  connect(CoolingSP205.y[1], oveTSetCoo205.u)
    annotation (Line(points={{-118,-100},{-82,-100}}, color={0,0,127}));
  connect(oveTSetHea205.y, TZonHeatingSet_out205)
    annotation (Line(points={{-59,-70},{24,-70}}, color={0,0,127}));
  connect(oveTSetCoo205.y, TZonCoolingSet_out105)
    annotation (Line(points={{-59,-100},{24,-100}}, color={0,0,127}));
  connect(HeatingSP206.y[1], oveTSetHea206.u)
    annotation (Line(points={{-118,-130},{-82,-130}}, color={0,0,127}));
  connect(CoolingSP206.y[1], oveTSetCoo206.u)
    annotation (Line(points={{-118,-160},{-82,-160}}, color={0,0,127}));
  connect(oveTSetHea206.y, TZonHeatingSet_out206)
    annotation (Line(points={{-59,-130},{24,-130}}, color={0,0,127}));
  connect(oveTSetCoo206.y, TZonCoolingSet_out206)
    annotation (Line(points={{-59,-160},{24,-160}}, color={0,0,127}));
  connect(HeatingSP203.y[1], oveTSetHea203.u)
    annotation (Line(points={{-118,50},{-82,50}}, color={0,0,127}));
  connect(CoolingSP203.y[1], oveTSetCoo203.u)
    annotation (Line(points={{-118,20},{-82,20}}, color={0,0,127}));
  connect(oveTSetHea203.y, TZonHeatingSet_out203)
    annotation (Line(points={{-59,50},{24,50}}, color={0,0,127}));
  connect(oveTSetCoo203.y, TZonCoolingSet_out203)
    annotation (Line(points={{-59,20},{24,20}}, color={0,0,127}));
  connect(HeatingSP202.y[1], oveTSetHea202.u)
    annotation (Line(points={{-118,110},{-82,110}}, color={0,0,127}));
  connect(CoolingSP202.y[1], oveTSetCoo202.u)
    annotation (Line(points={{-118,80},{-82,80}}, color={0,0,127}));
  connect(oveTSetHea202.y, TZonHeatingSet_out202)
    annotation (Line(points={{-59,110},{24,110}}, color={0,0,127}));
  connect(oveTSetCoo202.y, TZonCoolingSet_out202)
    annotation (Line(points={{-59,80},{24,80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -180},{20,140}}),
                         graphics={Rectangle(
          extent={{-160,134},{20,-180}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid), Text(
          extent={{-152,4},{2,-50}},
          lineColor={255,255,255},
          fillColor={102,44,145},
          fillPattern=FillPattern.None,
          textStyle={TextStyle.Bold},
          textString="Thermostat
2nd Floor")}),                           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-180},{20,140}})));
end thermostat_T_2ndtfloor;
