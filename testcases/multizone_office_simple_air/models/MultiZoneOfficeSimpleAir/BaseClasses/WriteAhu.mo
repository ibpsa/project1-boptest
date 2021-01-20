within MultiZoneOfficeSimpleAir.BaseClasses;
model WriteAhu "Collection of AHU overwrite points for BOPTEST"
  Modelica.Blocks.Interfaces.RealInput uFan_in "Supply fan speed setpoint"
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  Modelica.Blocks.Interfaces.RealInput uHea_in "Heating coil control signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput uCoo_in "Cooling coil control signal"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput TSupSet_in
    "Supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite uFan(description=
        "Supply fan speed setpoint for AHU",
                                     u(
      unit="1",
      min=0,
      max=1)) "Supply fan speed setpoint for AHU"
    annotation (Placement(transformation(extent={{0,110},{20,130}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite uCoo(description=
        "Cooling coil control signal for AHU",
                                       u(
      unit="1",
      min=0,
      max=1)) "Cooling coil control signal"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite uHea(description=
        "Heating coil control signal for AHU",
                                       u(
      unit="1",
      min=0,
      max=1)) "Heating coil control signal"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite TSupSet(description=
        "Supply air temperature setpoint for AHU",
                                           u(
      unit="K",
      min=285.15,
      max=313.15)) "Supply air temperature setpoint"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite dpSet(description=
        "Supply duct pressure setpoint for AHU",
                                         u(
      unit="Pa",
      min=50,
      max=410)) "Supply duct pressure setpoint"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Interfaces.RealInput dpSet_in "Supply duct pressure setpoint"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealOutput yFan "Supply fan speed setpoint"
    annotation (Placement(transformation(extent={{100,110},{120,130}})));
  Modelica.Blocks.Interfaces.RealOutput yHea "Heating coil control signal"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput yCoo "Cooling coil control signal"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput TSupSet_out
    "Supply air temperature setpoint"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput dpSet_out
    "Supply duct pressure setpoint"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite uOA(description=
        "Outside air damper position setpoint for AHU",
      u(
      unit="1",
      min=0,
      max=1)) "Outside air damper position setpoint"
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Modelica.Blocks.Interfaces.RealOutput yOA
    "Outside air damper position septoint"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput yRet
    "Return air damper position septoint"
    annotation (Placement(transformation(extent={{100,-130},{120,-110}})));
  Modelica.Blocks.Interfaces.RealInput uOA_in
    "Outside air damper position septoint"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite uRet(description=
        "Return air damper position setpoint for AHU",
      u(
      unit="1",
      min=0,
      max=1)) "Return air damper position setpoint"
    annotation (Placement(transformation(extent={{0,-130},{20,-110}})));
  Modelica.Blocks.Interfaces.RealInput uRet_in
    "Return air damper position septoint"
    annotation (Placement(transformation(extent={{-140,-140},{-100,-100}})));
equation
  connect(dpSet.u, dpSet_in) annotation (Line(
      points={{-2,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uFan_in, uFan.u) annotation (Line(
      points={{-120,120},{-2,120}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uHea_in, uHea.u) annotation (Line(
      points={{-120,80},{-61,80},{-2,80}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uCoo_in, uCoo.u) annotation (Line(
      points={{-120,40},{-61,40},{-2,40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TSupSet_in, TSupSet.u) annotation (Line(
      points={{-120,0},{-2,0}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uFan.y, yFan) annotation (Line(
      points={{21,120},{110,120}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uHea.y, yHea) annotation (Line(
      points={{21,80},{110,80}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uCoo.y, yCoo) annotation (Line(
      points={{21,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(TSupSet.y, TSupSet_out) annotation (Line(
      points={{21,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(dpSet.y, dpSet_out) annotation (Line(
      points={{21,-40},{110,-40}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(uOA.u, uOA_in)
    annotation (Line(points={{-2,-80},{-120,-80}}, color={0,0,127}));
  connect(uOA.y, yOA)
    annotation (Line(points={{21,-80},{110,-80}}, color={0,0,127}));
  connect(uRet.y, yRet)
    annotation (Line(points={{21,-120},{110,-120}}, color={0,0,127}));
  connect(uRet_in, uRet.u) annotation (Line(points={{-120,-120},{-62,-120},{-62,
          -120},{-2,-120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},
            {100,140}}),                                        graphics={
          Rectangle(
          extent={{-100,140},{100,-140}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,174},{52,140}},
          lineColor={28,108,200},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={
            {-100,-140},{100,140}})));
end WriteAhu;
