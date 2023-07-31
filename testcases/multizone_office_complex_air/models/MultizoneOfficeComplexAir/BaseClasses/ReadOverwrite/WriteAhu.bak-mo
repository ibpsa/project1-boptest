within MultizoneOfficeComplexAir.BaseClasses.ReadOverwrite;
model WriteAhu "Collection of AHU overwrite points for BOPTEST"
  Modelica.Blocks.Interfaces.RealInput ySupFan_in "Supply fan speed setpoint"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput yCoo_in "Cooling coil control signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput TSupSet_in
    "Supply air temperature setpoint"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite ySupFan(description=
        "Supply fan speed setpoint for AHU", u(
      unit="1",
      min=0,
      max=1)) "Supply fan speed setpoint for AHU"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite yCoo(description=
        "Cooling coil valve control signal for AHU",
                                       u(
      unit="1",
      min=0,
      max=1)) "Cooling coil control signal"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite TSupSet(description=
        "Supply air temperature setpoint for AHU",
                                           u(
      unit="K",
      min=285.15,
      max=313.15)) "Supply air temperature setpoint"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite dpSet(description=
        "Supply duct pressure setpoint for AHU",
                                         u(
      unit="Pa",
      min=50,
      max=410)) "Supply duct pressure setpoint"
    annotation (Placement(transformation(extent={{0,-92},{20,-72}})));
  Modelica.Blocks.Interfaces.RealInput dpSet_in "Supply duct pressure setpoint"
    annotation (Placement(transformation(extent={{-140,-102},{-100,-62}}),
        iconTransformation(extent={{-140,-102},{-100,-62}})));
  Modelica.Blocks.Interfaces.RealOutput ySupFan_out "Supply fan speed setpoint"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput yCoo_out "Cooling coil control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput TSupSet_out
    "Supply air temperature setpoint"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput dpSet_out
    "Supply duct pressure setpoint"
    annotation (Placement(transformation(extent={{100,-92},{120,-72}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite yOA(description=
        "Outside air damper position setpoint for AHU",
      u(
      unit="1",
      min=0,
      max=1)) "Outside air damper position setpoint"
    annotation (Placement(transformation(extent={{0,-130},{20,-110}})));
  Modelica.Blocks.Interfaces.RealOutput yOA_out
    "Outside air damper position septoint"
    annotation (Placement(transformation(extent={{100,-130},{120,-110}})));
  Modelica.Blocks.Interfaces.RealOutput yRet_out
    "Return air damper position septoint"
    annotation (Placement(transformation(extent={{100,-170},{120,-150}})));
  Modelica.Blocks.Interfaces.RealInput yOA_in
    "Outside air damper position septoint"
    annotation (Placement(transformation(extent={{-140,-140},{-100,-100}}),
        iconTransformation(extent={{-140,-140},{-100,-100}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite yRet(description=
        "Return air damper position setpoint for AHU",
      u(
      unit="1",
      min=0,
      max=1)) "Return air damper position setpoint"
    annotation (Placement(transformation(extent={{0,-170},{20,-150}})));
  Modelica.Blocks.Interfaces.RealInput yRet_in
    "Return air damper position septoint"
    annotation (Placement(transformation(extent={{-140,-180},{-100,-140}}),
        iconTransformation(extent={{-140,-180},{-100,-140}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite yRetFan(description=
        "Return fan speed setpoint for AHU", u(
      unit="1",
      min=0,
      max=1)) "Return fan speed setpoint for AHU"
    annotation (Placement(transformation(extent={{0,32},{20,52}})));
  Modelica.Blocks.Interfaces.RealInput yRetFan_in "Return fan speed setpoint"
    annotation (Placement(transformation(extent={{-140,22},{-100,62}}),
        iconTransformation(extent={{-140,22},{-100,62}})));
  Modelica.Blocks.Interfaces.RealOutput yRetFan_out "Return fan speed setpoint"
    annotation (Placement(transformation(extent={{100,32},{120,52}})));
equation
  connect(yOA.u,yOA_in)
    annotation (Line(points={{-2,-120},{-120,-120}},
                                                   color={0,0,127}));
  connect(yOA.y, yOA_out)
    annotation (Line(points={{21,-120},{110,-120}},
                                                  color={0,0,127}));
  connect(yRet.y, yRet_out)
    annotation (Line(points={{21,-160},{110,-160}}, color={0,0,127}));
  connect(yRet_in,yRet. u) annotation (Line(points={{-120,-160},{-2,-160}},
                            color={0,0,127}));
  connect(yRetFan_in, yRetFan.u)
    annotation (Line(points={{-120,42},{-2,42}}, color={0,0,127}));
  connect(yCoo_in, yCoo.u)
    annotation (Line(points={{-120,0},{-2,0}}, color={0,0,127}));
  connect(TSupSet_in, TSupSet.u)
    annotation (Line(points={{-120,-40},{-2,-40}}, color={0,0,127}));
  connect(dpSet_in, dpSet.u)
    annotation (Line(points={{-120,-82},{-2,-82}}, color={0,0,127}));
  connect(dpSet.y, dpSet_out)
    annotation (Line(points={{21,-82},{110,-82}}, color={0,0,127}));
  connect(TSupSet.y, TSupSet_out)
    annotation (Line(points={{21,-40},{110,-40}}, color={0,0,127}));
  connect(yCoo.y, yCoo_out)
    annotation (Line(points={{21,0},{110,0}}, color={0,0,127}));
  connect(yRetFan.y, yRetFan_out)
    annotation (Line(points={{21,42},{110,42}}, color={0,0,127}));
  connect(ySupFan.y, ySupFan_out) annotation (Line(points={{21,70},{62,70},{62,
          70},{110,70}}, color={0,0,127}));
  connect(ySupFan_in, ySupFan.u)
    annotation (Line(points={{-120,70},{-2,70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -180},{100,100}}),                                  graphics={
          Rectangle(
          extent={{-100,100},{100,-180}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-36,-54},{30,-94}},
          lineColor={0,0,0},
          textString="Write
AHU"),  Text(
          extent={{-160,106},{140,146}},
          textString="%name",
          textColor={0,0,255})}),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -180},{100,100}})));
end WriteAhu;
