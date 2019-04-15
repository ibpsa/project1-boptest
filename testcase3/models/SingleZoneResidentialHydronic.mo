within ;
package SingleZoneResidentialHydronic

  model SingleZoneResidentialHydronicBOPTESTwithBaseline
    "Single zone residential hydronic example model for BOPTEST"
    extends Modelica.Icons.Example;
    package Medium = IDEAS.Media.Water;
    IDEAS.Buildings.Validation.Cases.Case900Template case900Template
      "Case 900 BESTEST model"
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
    inner IDEAS.BoundaryConditions.SimInfoManager sim
      "Simulation information manager for climate data"
      annotation (Placement(transformation(extent={{-100,120},{-80,140}})));
    IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
      redeclare package Medium = Medium,
      T_a_nominal=273.15 + 70,
      T_b_nominal=273.15 + 50,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      Q_flow_nominal=2000,
      dp_nominal=10000)    "Radiator" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-30,10})));
    IDEAS.Fluid.HeatExchangers.Heater_T hea(
      redeclare package Medium = Medium,
      m_flow_nominal=pump.m_flow_nominal,
      dp_nominal=10000)
                    "Ideal heater"
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
    IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      redeclare
        IDEAS.Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per,
      addPowerToMedium=false,
      nominalValuesDefineDefaultPressureCurve=true,
      use_inputFilter=false,
      massFlowRates={0,0.05},
      redeclare package Medium = Medium,
      m_flow_nominal=rad.m_flow_nominal,
      inputType=IDEAS.Fluid.Types.InputType.Constant,
      constantMassFlowRate=0.05) "Hydronic pump"
      annotation (Placement(transformation(extent={{0,-20},{20,0}})));

    IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
          Medium) "Absolute pressure boundary"
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Modelica.Blocks.Interfaces.RealOutput Q
      "Thermal power use of heater"
      annotation (Placement(transformation(extent={{140,50},{160,70}})));
    Modelica.Blocks.Interfaces.RealOutput TZone
      "Zone operative temperature"
      annotation (Placement(transformation(extent={{140,-10},{160,10}})));
    IBPSA.Utilities.IO.SignalExchange.Read pumpRead(KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
                                                                  y(unit="W"))
      annotation (Placement(transformation(extent={{120,-70},{140,-50}})));
    IBPSA.Utilities.IO.SignalExchange.Read heaRead(KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower,
                                                                 y(unit="W"))
      annotation (Placement(transformation(extent={{120,20},{140,40}})));
    IBPSA.Utilities.IO.SignalExchange.Read TRooAir(KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
                                                                   y(unit="K"))
      annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveTsup(u(unit="K"))
      annotation (Placement(transformation(extent={{90,30},{70,50}})));
    IBPSA.Utilities.IO.SignalExchange.Read TSupRead(KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
                                                             y(unit="K"))
      annotation (Placement(transformation(extent={{62,30},{42,50}})));
    Modelica.Blocks.Sources.Constant TSet_lower(y(unit="K"), k=273.15 + 22)
      "Set point"
      annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
    IDEAS.Controls.Discrete.HysteresisRelease con(revert=true, use_input=true)
      annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
    Modelica.Blocks.Sources.Constant TSet_upper(y(unit="K"), k=273.15 + 24)
      "Set point"
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Modelica.Blocks.Math.Gain gain(k=50)
      annotation (Placement(transformation(extent={{1,81},{19,99}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=2)
      annotation (Placement(transformation(extent={{70,80},{90,100}})));
    Modelica.Blocks.Sources.Constant const(k=273.15 + 20)
      annotation (Placement(transformation(extent={{30,120},{50,140}})));
  equation
    connect(rad.heatPortCon, case900Template.gainCon) annotation (Line(points={{-37.2,
            12},{-49.4,12},{-49.4,7},{-60,7}},
                                           color={191,0,0}));
    connect(rad.heatPortRad, case900Template.gainRad) annotation (Line(points={{-37.2,8},
            {-47.4,8},{-47.4,4},{-60,4}},color={191,0,0}));
    connect(hea.port_b, rad.port_a)
      annotation (Line(points={{0,30},{-30,30},{-30,20}}, color={0,127,255}));
    connect(pump.port_a, rad.port_b)
      annotation (Line(points={{0,-10},{-30,-10},{-30,0}}, color={0,127,255}));
    connect(pump.port_b, hea.port_a) annotation (Line(points={{20,-10},{40,-10},
            {40,30},{20,30}},
                          color={0,127,255}));
    connect(bou.ports[1], pump.port_a)
      annotation (Line(points={{-20,-30},{0,-30},{0,-10}}, color={0,127,255}));
    connect(hea.Q_flow, Q) annotation (Line(points={{-1,38},{-8,38},{-8,60},{
            150,60}},
          color={0,0,127}));
    connect(case900Template.TSensor, TZone) annotation (Line(points={{-59,12},{
            84.5,12},{84.5,0},{150,0}},
                                 color={0,0,127}));
    connect(Q, heaRead.u) annotation (Line(points={{150,60},{108,60},{108,30},{
            118,30}}, color={0,0,127}));
    connect(TSet_lower.y, con.uLow) annotation (Line(points={{-79,50},{-61.5,50},
            {-61.5,82},{-42,82}},
                                color={0,0,127}));
    connect(TSet_upper.y, con.uHigh) annotation (Line(points={{-79,80},{-63.5,
            80},{-63.5,86},{-42,86}},
                                color={0,0,127}));
    connect(con.y, gain.u)
      annotation (Line(points={{-19,90},{-0.8,90}},
                                                  color={0,0,127}));
    connect(const.y, multiSum.u[1]) annotation (Line(points={{51,130},{63.5,130},
            {63.5,93.5},{70,93.5}},
                                  color={0,0,127}));
    connect(TRooAir.u, TZone) annotation (Line(points={{118,-30},{110,-30},{110,
            0},{150,0}}, color={0,0,127}));
    connect(gain.y, multiSum.u[2]) annotation (Line(points={{19.9,90},{38.55,90},
            {38.55,86.5},{70,86.5}},
                                 color={0,0,127}));
    connect(TSupRead.y, hea.TSet) annotation (Line(points={{41,40},{30,40},{30,
            38},{22,38}}, color={0,0,127}));
    connect(oveTsup.y, TSupRead.u)
      annotation (Line(points={{69,40},{64,40}}, color={0,0,127}));
    connect(multiSum.y, oveTsup.u) annotation (Line(points={{91.7,90},{104.15,
            90},{104.15,40},{92,40}}, color={0,0,127}));
    connect(pump.P, pumpRead.u) annotation (Line(points={{21,-1},{60.5,-1},{
            60.5,-60},{118,-60}}, color={0,0,127}));
    connect(con.u, case900Template.TSensor) annotation (Line(points={{-42,90},{
            -50,90},{-50,12},{-59,12}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -80},{140,140}})),                                   Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{140,
              140}})),
      experiment(
        StopTime=2.4192e+006,
        __Dymola_NumberOfIntervals=5000,
        __Dymola_Algorithm="Lsodar"),
      Documentation(info="<html>
<p>
This is a single zone hydronic system model 
for WP 1.2 of IBPSA project 1.
</p>
</html>",   revisions="<html>
<ul>
<li>
January 22nd, 2019 by Filip Jorissen:<br/>
Revised implementation by adding external inputs.
</li>
<li>
May 2, 2018 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
  end SingleZoneResidentialHydronicBOPTESTwithBaseline;

  model SingleZoneResidentialHydronicFromIDEAS
    extends IDEAS.Examples.IBPSA.SingleZoneResidentialHydronic;
  end SingleZoneResidentialHydronicFromIDEAS;
  annotation (uses(Modelica(version="3.2.2"),
      IDEAS(version="2.0.0"),
      IBPSA(version="3.0.0")));
end SingleZoneResidentialHydronic;
