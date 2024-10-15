within IDEAS.Examples.Tutorial;
model Example9 "Adding CO2-controlled ventilation"
  extends Example7(
    redeclare package Medium = IDEAS.Media.Air(extraPropertiesNames={"CO2"}),
    rectangularZoneTemplate(
      redeclare OccSched occNum(k=2),
      redeclare Buildings.Components.OccupancyType.OfficeWork occTyp),
    rectangularZoneTemplate1(
      redeclare Buildings.Components.Occupants.Fixed occNum(nOccFix=1),
      redeclare Buildings.Components.OccupancyType.OfficeWork occTyp),
    pumpSec(nominalValuesDefineDefaultPressureCurve=true),
    pumpPrim(nominalValuesDefineDefaultPressureCurve=true));


  Fluid.Actuators.Dampers.PressureIndependent vavSup(
    redeclare package Medium = Medium,
    m_flow_nominal=100*1.2/3600,
    dpDamper_nominal=50,
    dpFixed_nominal=50) "Supply VAV for first zone"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Fluid.Actuators.Dampers.PressureIndependent vavSup1(
    redeclare package Medium = Medium,
    m_flow_nominal=100*1.2/3600,
    dpDamper_nominal=50,
    dpFixed_nominal=50) "Supply VAV for second zone"
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Fluid.Actuators.Dampers.PressureIndependent vavRet(
    redeclare package Medium = Medium,
    m_flow_nominal=100*1.2/3600,
    dpDamper_nominal=50,
    dpFixed_nominal=50) "Return VAV for first zone"
    annotation (Placement(transformation(extent={{-100,20},{-120,40}})));
  Fluid.Actuators.Dampers.PressureIndependent vavRet1(
    redeclare package Medium = Medium,
    m_flow_nominal=100*1.2/3600,
    dpDamper_nominal=50,
    dpFixed_nominal=50) "Return VAV for second zone"
    annotation (Placement(transformation(extent={{-100,-60},{-120,-40}})));
  Fluid.Movers.FlowControlled_dp fanSup(
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    nominalValuesDefineDefaultPressureCurve=true,
    redeclare package Medium = Medium,
    dp_nominal=200,
    m_flow_nominal=vavSup.m_flow_nominal + vavSup1.m_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)     "Supply fan"
    annotation (Placement(transformation(extent={{-220,10},{-200,30}})));
  Fluid.Movers.FlowControlled_dp fanRet(
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    nominalValuesDefineDefaultPressureCurve=true,
    redeclare package Medium = Medium,
    dp_nominal=200,
    m_flow_nominal=vavRet.m_flow_nominal + vavRet1.m_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)     "Return fan"
    annotation (Placement(transformation(extent={{-200,-30},{-220,-10}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=fanSup.m_flow_nominal,
    m2_flow_nominal=fanRet.m_flow_nominal,
    dp1_nominal=100,
    dp2_nominal=100) "Heat exchanger with constant heat recovery effectivity"
    annotation (Placement(transformation(extent={{-250,-10},{-230,10}})));
  Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.1,
    k=0.005,
    reverseActing=false,
    Ti=300) annotation (Placement(transformation(extent={{-40,80},{-60,100}})));
  Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.1,
    k=0.005,
    reverseActing=false,
    Ti=300) annotation (Placement(transformation(extent={{-40,0},{-60,20}})));
  Modelica.Blocks.Sources.Constant ppmSet(k=1000)
    annotation (Placement(transformation(extent={{40,80},{20,100}})));
  Fluid.Sources.OutsideAir outsideAir(redeclare package Medium = Medium,
    azi=0,
    nPorts=2) "Source model that takes properties from SimInfoManager"
    annotation (Placement(transformation(extent={{-280,10},{-260,-10}})));
protected
  model OccSched "Simple occupancy schedule"
    extends IDEAS.Buildings.Components.Occupants.BaseClasses.PartialOccupants(final useInput=false);

    parameter Real k "Number of occupants";
    Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Modelica.Blocks.Sources.RealExpression occ(y=if calTim.weekDay < 6 and (
          calTim.hour > 7 and calTim.hour < 18) then k else 0)
      "Number of occupants present"
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  equation
    connect(occ.y, nOcc)
      annotation (Line(points={{1,0},{120,0}}, color={0,0,127}));
  end OccSched;


equation
  connect(vavSup.port_a, fanSup.port_b) annotation (Line(points={{-120,60},{-180,
          60},{-180,20},{-200,20}}, color={0,127,255}));
  connect(vavSup1.port_a, fanSup.port_b) annotation (Line(points={{-120,-10},{-180,
          -10},{-180,20},{-200,20}}, color={0,127,255}));
  connect(fanRet.port_a, vavRet1.port_b) annotation (Line(points={{-200,-20},{-160,
          -20},{-160,-50},{-120,-50}}, color={0,127,255}));
  connect(fanRet.port_a, vavRet.port_b) annotation (Line(points={{-200,-20},{-160,
          -20},{-160,30},{-120,30}}, color={0,127,255}));
  connect(hex.port_b1, fanSup.port_a) annotation (Line(points={{-230,6},{-230,20},
          {-220,20}}, color={0,127,255}));
  connect(hex.port_a2, fanRet.port_b) annotation (Line(points={{-230,-6},{-230,-20},
          {-220,-20}}, color={0,127,255}));
  connect(conPID.y, vavSup.y)
    annotation (Line(points={{-61,90},{-110,90},{-110,72}}, color={0,0,127}));
  connect(vavRet.y, vavSup.y)
    annotation (Line(points={{-110,42},{-110,72},{-110,72}}, color={0,0,127}));
  connect(vavRet1.y, vavSup1.y)
    annotation (Line(points={{-110,-38},{-110,2}}, color={0,0,127}));
  connect(vavSup1.y, conPID1.y)
    annotation (Line(points={{-110,2},{-110,10},{-61,10}}, color={0,0,127}));
  connect(rectangularZoneTemplate1.ppm, conPID1.u_m) annotation (Line(points={{11,
          -30},{14,-30},{14,-2},{-50,-2}}, color={0,0,127}));
  connect(rectangularZoneTemplate.ppm, conPID.u_m) annotation (Line(points={{11,30},
          {14,30},{14,78},{-50,78}},     color={0,0,127}));
  connect(ppmSet.y, conPID.u_s)
    annotation (Line(points={{19,90},{-38,90}}, color={0,0,127}));
  connect(ppmSet.y, conPID1.u_s) annotation (Line(points={{19,90},{-20,90},{-20,
          10},{-38,10}}, color={0,0,127}));
  connect(outsideAir.ports[1], hex.port_b2) annotation (Line(points={{-260,-2},
          {-250,-2},{-250,-6}}, color={0,127,255}));
  connect(outsideAir.ports[2], hex.port_a1) annotation (Line(points={{-260,2},{
          -252,2},{-252,6},{-250,6}}, color={0,127,255}));
  connect(vavSup.port_b, rectangularZoneTemplate.ports[1]) annotation (Line(
        points={{-100,60},{-2,60},{-2,40},{0,40}}, color={0,127,255}));
  connect(vavRet.port_a, rectangularZoneTemplate.ports[2]) annotation (Line(
        points={{-100,30},{-14,30},{-14,40},{0,40}}, color={0,127,255}));
  connect(vavSup1.port_b, rectangularZoneTemplate1.ports[1])
    annotation (Line(points={{-100,-10},{0,-10},{0,-20}}, color={0,127,255}));
  connect(vavRet1.port_a, rectangularZoneTemplate1.ports[2]) annotation (Line(
        points={{-100,-50},{-34,-50},{-34,-20},{0,-20}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-280,-100},{280,100}})), Icon(
        coordinateSystem(extent={{-280,-100},{280,100}})),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=0.00011,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/Example9.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
November 21, 2020 by Filip Jorissen:<br/>
Avoiding warnings for default pressure curves and due to using port_a and port_b.
</li>
<li>
September 21, 2019 by Filip Jorissen:<br/>
Using OutsideAir.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1052\">#1052</a>.
</li>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>", info="<html>
<p>
Adding CO2-controlled ventilation system.
</p>
</html>"));
end Example9;
