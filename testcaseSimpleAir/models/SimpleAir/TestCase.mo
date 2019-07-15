within SimpleAir;
model TestCase "Testcase model"
  BaseClasses.Case900FF case900FF
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  BaseClasses.FanCoilUnit fanCoilUnit
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(fanCoilUnit.supplyAir, case900FF.supplyAir)
    annotation (Line(points={{20,8},{30,8},{30,2},{52,2}}, color={0,127,255}));
  connect(case900FF.returnAir, fanCoilUnit.returnAir) annotation (Line(points={
          {52,-2},{30,-2},{30,-8},{20,-8}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestCase;
