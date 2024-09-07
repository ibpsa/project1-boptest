within FRP.RTUVAV.Component;
model thermostat_T
    parameter Modelica.SIunits.Temperature SP_TCSP=273.15+24; // zone cooling setpoint 72F
    parameter Modelica.SIunits.Temperature SP_TCSP_setback=273.15+24; // zone cooling setpoint setback 75F
    parameter Modelica.SIunits.Temperature SP_THSP=273.15+20; // zone heating setpoint 68F
    parameter Modelica.SIunits.Temperature SP_THSP_setback=273.15+18; // zone heating setpoint setback 64.4F
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable CoolingSP(
    table=[0,SP_TCSP; 3600*8,SP_TCSP; 3600*18,SP_TCSP; 3600*24,SP_TCSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone cooling setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-144,-34},{-110,0}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.TimeTable HeatingSP(
    table=[0,SP_THSP; 3600*8,SP_THSP; 3600*18,SP_THSP; 3600*24,SP_THSP],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic)
    "Zone heating setpoint temperature [K]"
    annotation (Placement(transformation(extent={{-144,12},{-110,46}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveTSetCoo(u(unit="K"),
                        description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,-28},{-60,-8}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveTSetHea(description="Zone temperature setpoint for heating", u(unit=
          "K"))         "Overwrite for zone heating setpoint"
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));
  Modelica.Blocks.Interfaces.RealOutput TZonCoolingSet_out
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput TZonHeatingSet_out
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
equation
  connect(HeatingSP.y[1], oveTSetHea.u) annotation (Line(points={{-106.6,29},{
          -92,29},{-92,40},{-84,40}},
                                    color={0,0,127}));
  connect(CoolingSP.y[1], oveTSetCoo.u) annotation (Line(points={{-106.6,-17},{
          -92,-17},{-92,-18},{-82,-18}},
                                       color={0,0,127}));
  connect(oveTSetHea.y, TZonHeatingSet_out)
    annotation (Line(points={{-61,40},{110,40}}, color={0,0,127}));
  connect(oveTSetCoo.y, TZonCoolingSet_out) annotation (Line(points={{-59,-18},
          {26,-18},{26,-20},{110,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,58},{100,-66}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid), Text(
          extent={{-78,22},{76,-32}},
          lineColor={255,255,255},
          fillColor={102,44,145},
          fillPattern=FillPattern.None,
          textString="Thermostat",
          textStyle={TextStyle.Bold})}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-100},{100,100}})));
end thermostat_T;
