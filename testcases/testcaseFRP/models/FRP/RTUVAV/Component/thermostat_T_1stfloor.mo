within FRP.RTUVAV.Component;
model thermostat_T_1stfloor
    parameter Modelica.SIunits.Temperature SP_TCSP=273.15+24; // zone cooling setpoint 72F
    parameter Modelica.SIunits.Temperature SP_TCSP_setback=273.15+24; // zone cooling setpoint setback 75F
    parameter Modelica.SIunits.Temperature SP_THSP=273.15+20; // zone heating setpoint 68F
    parameter Modelica.SIunits.Temperature SP_THSP_setback=273.15+18; // zone heating setpoint setback 64.4F
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP104(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP104(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo104(u(unit="K"),
      description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea104(description=
        "Zone temperature setpoint for heating", u(unit="K"))
    "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out104
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-48},{32,-32}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out104
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-18},{32,-2}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP105(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-110},{-120,-90}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP105(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo105(u(unit="K"),
      description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea105(description=
        "Zone temperature setpoint for heating", u(unit="K"))
    "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out105
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-108},{32,-92}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out105
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-78},{32,-62}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP106(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-170},{-120,-150}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP106(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,-140},{-120,-120}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo106(u(unit="K"),
      description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,-170},{-60,-150}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea106(description=
        "Zone temperature setpoint for heating", u(unit="K"))
    "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-80,-140},{-60,-120}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out106
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-168},{32,-152}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out106
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,-138},{32,-122}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP103(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP103(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo103(u(unit="K"),
      description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea103(description=
        "Zone temperature setpoint for heating", u(unit="K"))
    "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out103
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,12},{32,28}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out103
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,42},{32,58}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP102(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,70},{-120,90}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP102(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-140,100},{-120,120}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetCoo102(u(unit="K"),
      description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSetHea102(description=
        "Zone temperature setpoint for heating", u(unit="K"))
    "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out102
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,72},{32,88}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out102
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{16,102},{32,118}})));
equation
  connect(HeatingSP104.y[1], oveTSetHea104.u)
    annotation (Line(points={{-118,-10},{-82,-10}}, color={0,0,127}));
  connect(CoolingSP104.y[1], oveTSetCoo104.u)
    annotation (Line(points={{-118,-40},{-82,-40}}, color={0,0,127}));
  connect(oveTSetHea104.y, TZonHeatingSet_out104)
    annotation (Line(points={{-59,-10},{24,-10}}, color={0,0,127}));
  connect(oveTSetCoo104.y, TZonCoolingSet_out104)
    annotation (Line(points={{-59,-40},{24,-40}}, color={0,0,127}));
  connect(HeatingSP105.y[1], oveTSetHea105.u)
    annotation (Line(points={{-118,-70},{-82,-70}}, color={0,0,127}));
  connect(CoolingSP105.y[1], oveTSetCoo105.u)
    annotation (Line(points={{-118,-100},{-82,-100}}, color={0,0,127}));
  connect(oveTSetHea105.y, TZonHeatingSet_out105)
    annotation (Line(points={{-59,-70},{24,-70}}, color={0,0,127}));
  connect(oveTSetCoo105.y, TZonCoolingSet_out105)
    annotation (Line(points={{-59,-100},{24,-100}}, color={0,0,127}));
  connect(HeatingSP106.y[1], oveTSetHea106.u)
    annotation (Line(points={{-118,-130},{-82,-130}}, color={0,0,127}));
  connect(CoolingSP106.y[1], oveTSetCoo106.u)
    annotation (Line(points={{-118,-160},{-82,-160}}, color={0,0,127}));
  connect(oveTSetHea106.y, TZonHeatingSet_out106)
    annotation (Line(points={{-59,-130},{24,-130}}, color={0,0,127}));
  connect(oveTSetCoo106.y, TZonCoolingSet_out106)
    annotation (Line(points={{-59,-160},{24,-160}}, color={0,0,127}));
  connect(HeatingSP103.y[1], oveTSetHea103.u)
    annotation (Line(points={{-118,50},{-82,50}}, color={0,0,127}));
  connect(CoolingSP103.y[1], oveTSetCoo103.u)
    annotation (Line(points={{-118,20},{-82,20}}, color={0,0,127}));
  connect(oveTSetHea103.y, TZonHeatingSet_out103)
    annotation (Line(points={{-59,50},{24,50}}, color={0,0,127}));
  connect(oveTSetCoo103.y, TZonCoolingSet_out103)
    annotation (Line(points={{-59,20},{24,20}}, color={0,0,127}));
  connect(HeatingSP102.y[1], oveTSetHea102.u)
    annotation (Line(points={{-118,110},{-82,110}}, color={0,0,127}));
  connect(CoolingSP102.y[1], oveTSetCoo102.u)
    annotation (Line(points={{-118,80},{-82,80}}, color={0,0,127}));
  connect(oveTSetHea102.y, TZonHeatingSet_out102)
    annotation (Line(points={{-59,110},{24,110}}, color={0,0,127}));
  connect(oveTSetCoo102.y, TZonCoolingSet_out102)
    annotation (Line(points={{-59,80},{24,80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -180},{20,140}}),
                         graphics={Rectangle(
          extent={{-160,134},{20,-180}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid), Text(
          extent={{-158,12},{12,-58}},
          lineColor={255,255,255},
          fillColor={102,44,145},
          fillPattern=FillPattern.None,
          textStyle={TextStyle.Bold},
          textString="Thermostat
1st Floor")}),                           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-180},{20,140}})));
end thermostat_T_1stfloor;
