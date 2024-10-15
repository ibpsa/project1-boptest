within IDEAS.Experimental.Electric.Photovoltaics.Examples;
model Test_PvVoltageCtrl "Tester for the PV voltage control model"
extends Modelica.Icons.Example;
  Components.PvVoltageCtrlGeneral_InputVGrid
    pvVoltageCtrlGeneral_InputVGrid_2_1
    annotation (Placement(transformation(extent={{-16,8},{4,28}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=36,
    offset=230,
    freqHz=0.85e-2)
    annotation (Placement(transformation(extent={{-80,-26},{-60,-6}})));
  Modelica.Blocks.Sources.Constant const(k=300)
    annotation (Placement(transformation(extent={{-88,48},{-68,68}})));
equation
  connect(sine.y, pvVoltageCtrlGeneral_InputVGrid_2_1.VGrid) annotation (Line(
      points={{-59,-16},{-38,-16},{-38,12},{-16,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, pvVoltageCtrlGeneral_InputVGrid_2_1.PInit) annotation (Line(
      points={{-67,58},{-52,58},{-52,24},{-16,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, pvVoltageCtrlGeneral_InputVGrid_2_1.QInit) annotation (Line(
      points={{-67,58},{-66,58},{-66,38},{-52,38},{-52,20},{-16,20}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end Test_PvVoltageCtrl;
