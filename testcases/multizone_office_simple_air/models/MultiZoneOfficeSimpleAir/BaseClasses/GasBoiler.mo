within MultiZoneOfficeSimpleAir.BaseClasses;
model GasBoiler "Gas boiler model"
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";
  parameter String descriptor "Descriptor of boiler";
  Modelica.Blocks.Sources.Constant TSetHws(k=273.15 + 45)
    "Hot water supply temperature set point"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Fluid.Interfaces.FluidPort_a ret(redeclare package Medium = MediumW)
                                            "Return water port"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b sup(redeclare package Medium = MediumW)
                                            "Supply water port"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Buildings.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0,
    QMax_flow=QMax_flow)
    annotation (Placement(transformation(extent={{40,-30},{20,-10}})));
  Modelica.Blocks.Math.Gain eff(k=1/0.9)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Interfaces.RealOutput PGas "Gas power"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPGas(description="Gas power consumed by boiler for "
         + descriptor,
                 KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower)
    "Gas power consumed by boiler"
    annotation (Placement(transformation(extent={{72,90},{92,110}})));
  parameter Modelica.SIunits.HeatFlowRate QMax_flow=Modelica.Constants.inf
    "Maximum heat flow rate for heating (positive)";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
  Buildings.Fluid.Sources.Boundary_pT
                            souHea(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=318.15,
    nPorts=1) "Source for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-42,-78})));
  Buildings.Fluid.Sources.Boundary_pT
                            sinHea(
    redeclare package Medium = MediumW,
    p=300000,
    T=318.15,
    nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-78})));
equation
  connect(hea.port_a, ret) annotation (Line(points={{40,-20},{60,-20},{60,0},{100,
          0}}, color={0,127,255}));
  connect(TSetHws.y, hea.TSet) annotation (Line(points={{-79,90},{48,90},{48,-12},
          {42,-12}}, color={0,0,127}));
  connect(hea.Q_flow, eff.u) annotation (Line(points={{19,-12},{10,-12},{10,30},
          {18,30}}, color={0,0,127}));
  connect(eff.y, reaPGas.u) annotation (Line(points={{41,30},{60,30},{60,100},{70,
          100}}, color={0,0,127}));
  connect(reaPGas.y, PGas)
    annotation (Line(points={{93,100},{110,100}}, color={0,0,127}));
  connect(hea.port_b, sinHea.ports[1]) annotation (Line(points={{20,-20},{-10,
          -20},{-10,-68}}, color={0,127,255}));
  connect(souHea.ports[1], sup)
    annotation (Line(points={{-42,-68},{-42,0},{-100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GasBoiler;
