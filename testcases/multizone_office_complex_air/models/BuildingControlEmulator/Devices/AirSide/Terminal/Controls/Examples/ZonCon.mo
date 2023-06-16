within BuildingControlEmulator.Devices.AirSide.Terminal.Controls.Examples;
model ZonCon
  import BuildingControlEmulator;
extends Modelica.Icons.Example;
  BuildingControlEmulator.Devices.AirSide.Terminal.Controls.ZonCon
                                                           zonCon(
      MinFlowRateSetPoi=0.3, HeatingFlowRateSetPoi=0.5)
    annotation (Placement(transformation(extent={{-10,-10},{12,12}})));
  Modelica.Blocks.Sources.Constant TCooSetPoi(k=273.15 + 22)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Constant THeaSetPoi(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-82,-40},{-62,-20}})));
  Modelica.Blocks.Sources.Sine TZon(
    offset=273.15 + 21,
    amplitude=2,
    f=1/86400)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(TCooSetPoi.y, zonCon.TCooSetPoi) annotation (Line(
      points={{-59,30},{-30,30},{-30,7.6},{-12.2,7.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(THeaSetPoi.y, zonCon.THeaSetPoi) annotation (Line(
      points={{-61,-30},{-61,-30},{-30,-30},{-30,-5.6},{-12.2,-5.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TZon.y, zonCon.T) annotation (Line(
      points={{-59,0},{-12.2,0},{-12.2,1}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_NumberOfIntervals=1440));
end ZonCon;
