within BESTESTAir.BaseClasses;
model FanCoilUnit_T
  "Four-pipe fan coil unit model with direct temperature input"
  replaceable package Medium1 = Buildings.Media.Air(extraPropertiesNames={"CO2"});
  parameter Modelica.SIunits.MassFlowRate mAir_flow_nominal=0.55 "Nominal air flowrate" annotation (Dialog(group="Air"));
  parameter Modelica.SIunits.DimensionlessRatio COP = 3 "Assumed COP of chiller supplying chilled water to FCU in [W_thermal/W_electric]" annotation (Dialog(group="Plant"));
  parameter Modelica.SIunits.DimensionlessRatio eff = 0.9 "Assumed efficiency of gas boiler supplying hot water to FCU in [W_gas/W_thermal]" annotation (Dialog(group="Plant"));
  final parameter Modelica.SIunits.Pressure dpAir_nominal=185 "Nominal supply air pressure";
  Modelica.Fluid.Interfaces.FluidPort_a returnAir(redeclare final package
      Medium = Medium1) "Return air" annotation (Placement(transformation(
          extent={{130,-170},{150,-150}}),
                                        iconTransformation(extent={{130,-170},{
            150,-150}})));
  Modelica.Fluid.Interfaces.FluidPort_b supplyAir(redeclare final package
      Medium = Medium1) "Supply air"
    annotation (Placement(transformation(extent={{130,90},{150,110}}),
        iconTransformation(extent={{130,90},{150,110}})));

  Modelica.Blocks.Interfaces.RealInput uFan "Fan speed signal"
    annotation (Placement(transformation(extent={{-180,-60},{-140,-20}})));
  Buildings.Fluid.Sensors.MassFlowRate senSupFlo(redeclare package Medium =
        Medium1) "Supply flow meter"
    annotation (Placement(transformation(extent={{20,90},{40,110}})));
  Modelica.Blocks.Interfaces.RealOutput PFan "Fan electrical power consumption"
    annotation (Placement(transformation(extent={{140,130},{160,150}})));
  Modelica.Blocks.Interfaces.RealOutput PHea "Heating power"
    annotation (Placement(transformation(extent={{140,150},{160,170}})));
  Modelica.Blocks.Interfaces.RealOutput PCoo "Cooling power"
    annotation (Placement(transformation(extent={{140,170},{160,190}})));
  Modelica.Blocks.Math.Gain powHea(k=1/eff)
    annotation (Placement(transformation(extent={{-8,150},{12,170}})));
  Modelica.Blocks.Math.Gain powCoo(k=1/COP)
    annotation (Placement(transformation(extent={{-8,170},{12,190}})));
  Buildings.Utilities.IO.SignalExchange.Read reaFloSup(y(unit="kg/s"), description=
        "Supply air mass flow rate") "Read supply air flowrate"
    annotation (Placement(transformation(extent={{40,110},{60,130}})));
  Modelica.Blocks.Interfaces.RealInput TSup "Temperature of supply air"
    annotation (Placement(transformation(extent={{-180,20},{-140,60}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPCoo(
    y(unit="W"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    description="Cooling electrical power consumption")
    "Read power for cooling"
    annotation (Placement(transformation(extent={{70,170},{90,190}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPHea(
    y(unit="W"),
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
    description="Heating thermal power consumption") "Read power for heating"
    annotation (Placement(transformation(extent={{70,150},{90,170}})));

  Buildings.Utilities.IO.SignalExchange.Read reaPFan(
    y(unit="W"),
    description="Supply fan electrical power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
    "Read power for supply fan"
    annotation (Placement(transformation(extent={{70,130},{90,150}})));
  Modelica.Blocks.Math.Gain fanGai(k=mAir_flow_nominal) "Fan gain"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = Medium1,
    m_flow_nominal=mAir_flow_nominal,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    dp_nominal=dpAir_nominal) "Supply fan"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={12,-40})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium1,
    m_flow_nominal=mAir_flow_nominal,
    dp_nominal=dpAir_nominal) "Air system resistance"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,50})));
  Modelica.Blocks.Sources.RealExpression powCooThe(y=max(0, -senSupFlo.m_flow*(
        supplyAir.h_outflow - inStream(returnAir.h_outflow))))
                                                     "Cooling thermal power"
    annotation (Placement(transformation(extent={{-100,170},{-80,190}})));
  Modelica.Blocks.Sources.RealExpression powHeaThe(y=max(0, senSupFlo.m_flow*(
        supplyAir.h_outflow - inStream(returnAir.h_outflow))))
                                                     "Heating thermal power"
    annotation (Placement(transformation(extent={{-100,150},{-80,170}})));
  Buildings.Fluid.Sources.PropertySource_T coi(use_T_in=true, redeclare package
      Medium = Medium1) "Cooling and heating coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,0})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveTSup(description=
        "Supply air temperature setpoint", u(
      min=285.15,
      max=313.15,
      unit="K")) "Overwrite for supply air temperature signal"
    annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveFan(description=
        "Fan control signal as air mass flow rate normalized to the design air mass flow rate",
                                    u(
      min=0,
      max=1,
      unit="1")) "Overwrite for fan control signal"
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
equation
  connect(senSupFlo.m_flow, reaFloSup.u)
    annotation (Line(points={{30,111},{30,120},{38,120}},
                                                       color={0,0,127}));
  connect(powCoo.y, reaPCoo.u)
    annotation (Line(points={{13,180},{68,180}}, color={0,0,127}));
  connect(reaPCoo.y, PCoo)
    annotation (Line(points={{91,180},{150,180}}, color={0,0,127}));
  connect(powHea.y, reaPHea.u)
    annotation (Line(points={{13,160},{68,160}}, color={0,0,127}));
  connect(reaPHea.y, PHea)
    annotation (Line(points={{91,160},{150,160}}, color={0,0,127}));
  connect(reaPFan.y, PFan)
    annotation (Line(points={{91,140},{150,140}}, color={0,0,127}));
  connect(fanGai.y, fan.m_flow_in)
    annotation (Line(points={{-19,-40},{0,-40}},          color={0,0,127}));
  connect(reaPFan.u, fan.P)
    annotation (Line(points={{68,140},{4,140},{4,-29},{3,-29}},
                                                            color={0,0,127}));
  connect(res.port_b, senSupFlo.port_a)
    annotation (Line(points={{10,60},{10,100},{20,100}}, color={0,127,255}));
  connect(powCooThe.y, powCoo.u)
    annotation (Line(points={{-79,180},{-10,180}}, color={0,0,127}));
  connect(powHeaThe.y, powHea.u)
    annotation (Line(points={{-79,160},{-10,160}}, color={0,0,127}));
  connect(senSupFlo.port_b, supplyAir)
    annotation (Line(points={{40,100},{140,100}}, color={0,127,255}));
  connect(fan.port_b, coi.port_a)
    annotation (Line(points={{12,-30},{10,-30},{10,-10}}, color={0,127,255}));
  connect(coi.port_b, res.port_a)
    annotation (Line(points={{10,10},{10,40}}, color={0,127,255}));
  connect(fan.port_a, returnAir) annotation (Line(points={{12,-50},{12,-160},{
          140,-160}}, color={0,127,255}));
  connect(TSup, oveTSup.u)
    annotation (Line(points={{-160,40},{-122,40}}, color={0,0,127}));
  connect(uFan, oveFan.u)
    annotation (Line(points={{-160,-40},{-122,-40}}, color={0,0,127}));
  connect(oveTSup.y, coi.T_in) annotation (Line(points={{-99,40},{-60,40},{-60,
          -4},{-2,-4}}, color={0,0,127}));
  connect(oveFan.y, fanGai.u)
    annotation (Line(points={{-99,-40},{-42,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -180},{140,180}}),                                  graphics={
                                        Text(
        extent={{-150,184},{150,144}},
        textString="%name",
        lineColor={0,0,255}), Rectangle(
          extent={{-140,180},{140,-180}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-150,238},{150,198}},
        textString="%name",
        lineColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-180},{140,
            180}})),
    experiment(
      StartTime=20736000,
      StopTime=21600000,
      Interval=599.999616,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end FanCoilUnit_T;
