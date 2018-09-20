within ;
model SimpleRC_Input
  "A simple thermal R1C1 model with sinusoidal outside air temperature and heating input."
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(C=1e6)
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor res(R=0.01)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTZone
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTOut
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Sine souTOut(
    freqHz=1/(3600*24),
    offset=273.15 + 20,
    amplitude=10)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeat
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Interfaces.RealInput QHeat "Heating input to zone"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Math.Gain eff(k=1/0.99)
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Blocks.Continuous.Integrator intEHeat(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Blocks.Math.MultiSum EHVAC(nu=1)  "Total HVAC energy"
    annotation (Placement(transformation(extent={{60,-110},{80,-90}})));
  Modelica.Blocks.Interfaces.RealOutput ETotFan "Total fan energy"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput ETotHVAC
    annotation (Placement(transformation(extent={{100,-110},{120,-90}})));
  Modelica.Blocks.Interfaces.RealOutput ETotHea "Total heating energy"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput ETotCoo "Total cooling energy"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput ETotPum "Total pump energy"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TRooAir "Room air temperature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput PPum
    "Electrical power consumed by the pumps"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput PCoo
    "Electrical power consumed by the cooling equipment"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput PHea
    "Electrical power consumed by the heating equipment"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput PFan
    "Electrical power consumed by the supply fan"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(res.port_b, cap.port)
    annotation (Line(points={{0,0},{20,0}}, color={191,0,0}));
  connect(cap.port, senTZone.port)
    annotation (Line(points={{20,0},{40,0}}, color={191,0,0}));
  connect(preTOut.port, res.port_a)
    annotation (Line(points={{-40,0},{-20,0}}, color={191,0,0}));
  connect(souTOut.y, preTOut.T)
    annotation (Line(points={{-79,0},{-62,0}}, color={0,0,127}));
  connect(preHeat.port, cap.port)
    annotation (Line(points={{-20,-40},{20,-40},{20,0}}, color={191,0,0}));
  connect(preHeat.Q_flow, QHeat)
    annotation (Line(points={{-40,-40},{-120,-40}}, color={0,0,127}));
  connect(eff.u, QHeat) annotation (Line(points={{-42,-60},{-80,-60},{-80,-40},
          {-120,-40}}, color={0,0,127}));
  connect(eff.y, intEHeat.u)
    annotation (Line(points={{-19,-60},{18,-60}}, color={0,0,127}));
  connect(intEHeat.y, ETotHea) annotation (Line(points={{41,-60},{72,-60},{72,
          -60},{110,-60}}, color={0,0,127}));
  connect(PHea, intEHeat.u) annotation (Line(points={{110,80},{70,80},{70,-28},
          {0,-28},{0,-60},{18,-60}}, color={0,0,127}));
  connect(senTZone.T, TRooAir)
    annotation (Line(points={{60,0},{110,0}}, color={0,0,127}));
  connect(const.y, PFan) annotation (Line(points={{-79,90},{80,90},{80,100},{
          110,100}}, color={0,0,127}));
  connect(const.y, PPum) annotation (Line(points={{-79,90},{80,90},{80,40},{110,
          40}}, color={0,0,127}));
  connect(const.y, PCoo) annotation (Line(points={{-79,90},{80,90},{80,60},{110,
          60}}, color={0,0,127}));
  connect(const.y, ETotFan) annotation (Line(points={{-79,90},{80,90},{80,-20},
          {110,-20}}, color={0,0,127}));
  connect(ETotPum, ETotFan) annotation (Line(points={{110,-40},{80,-40},{80,-20},
          {110,-20}}, color={0,0,127}));
  connect(ETotCoo, ETotFan) annotation (Line(points={{110,-80},{80,-80},{80,-20},
          {110,-20}}, color={0,0,127}));
  connect(intEHeat.y, EHVAC.u[1]) annotation (Line(points={{41,-60},{50,-60},{
          50,-100},{60,-100}}, color={0,0,127}));
  connect(EHVAC.y, ETotHVAC) annotation (Line(points={{81.7,-100},{92,-100},{92,
          -100},{110,-100}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.2")));
end SimpleRC_Input;
