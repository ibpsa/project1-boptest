within singlezone_commercial_air;
model FF "Free floating"
  extends Modelica.Icons.Example;

  BaseClasses.EnvelopeModel envelopeModel(lat=weaDat.lat)
    annotation (Placement(transformation(extent={{-14,-20},{72,65}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam="./USA_NY_New.York-J.F.Kennedy.Intl.AP.744860_TMY3.mos",
      computeWetBulbTemperature=false)
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=0,
        origin={42,74})));
equation
  connect(weaDat.weaBus, envelopeModel.weaBus) annotation (Line(
      points={{36,74},{-32,74},{-32,63.3},{-13.14,63.3}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FF;
