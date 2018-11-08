within ;
model TestFMU "Test model to run FMU"
  Modelica.Blocks.Sources.Constant actU(k=2.5) "Actuator signal"
    annotation (Placement(transformation(extent={{-80,22},{-60,42}})));
  Modelica.Blocks.Sources.BooleanConstant actAct(k=false)
    "Activation of actuator overwrite"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Constant TSet(k=5.5) "Set point signal"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Sources.BooleanConstant setAct(k=true)
    "Activation of set point overwrite"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  TestOverWrite_ExportedModel_fmu emu "Emulator"
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation
  connect(emu.oveWriAct_activate, actAct.y) annotation (Line(points={{-8.4,6},{
          -34,6},{-34,70},{-59,70}}, color={255,0,255}));
  connect(actU.y, emu.oveWriAct_u) annotation (Line(points={{-59,32},{-36,32},{
          -36,2},{-8.4,2}}, color={0,0,127}));
  connect(setAct.y, emu.oveWriSet_activate) annotation (Line(points={{-59,-10},
          {-36,-10},{-36,-2},{-8.4,-2}}, color={255,0,255}));
  connect(TSet.y, emu.oveWriSet_u) annotation (Line(points={{-59,-50},{-34,-50},
          {-34,-6},{-8.4,-6}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.2")));
end TestFMU;
