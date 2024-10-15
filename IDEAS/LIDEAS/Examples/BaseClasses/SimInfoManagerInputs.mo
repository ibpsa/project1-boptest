within IDEAS.LIDEAS.Examples.BaseClasses;
model SimInfoManagerInputs
  extends IDEAS.BoundaryConditions.SimInfoManager(weaDat(
      TDryBulSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      TDewPoiSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      relHumSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      winSpeSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      winDirSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      HSou=IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor));

  parameter String fileNameLocalWeather=Modelica.Utilities.Files.loadResource(
      "modelica://IDEAS/Resources/weatherdata/CustomWeatherFiles/example.txt") "Path to the local weather file";
  Modelica.Blocks.Tables.CombiTable1Ds localWeather(
    final tableOnFile=true,
    final smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    tableName="data",
    final fileName=fileNameLocalWeather,
    final columns={2,3,4,5,6,7,8,9,10}) "Data reader"
    annotation (Placement(transformation(extent={{-52,-20},{-32,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=time) "Time"
    annotation (Placement(transformation(extent={{-84,-20},{-64,0}})));
equation
  connect(localWeather.y[1], weaDat.TDryBul_in) annotation (Line(points={{-31,-10},
          {-26,-10},{-26,-81},{-81,-81}},     color={0,0,127}));
  connect(localWeather.y[2], weaDat.TDewPoi_in) annotation (Line(points={{-31,-10},
          {-26,-10},{-26,-78.8},{-81,-78.8}},   color={0,0,127}));
  connect(localWeather.y[4], weaDat.winSpe_in) annotation (Line(points={{-31,-10},
          {-26,-10},{-26,-93.9},{-81,-93.9}},   color={0,0,127}));
  connect(localWeather.y[5], weaDat.winDir_in) annotation (Line(points={{-31,-10},
          {-26,-10},{-26,-96},{-81,-96}},     color={0,0,127}));
  connect(localWeather.y[6], weaDat.relHum_in) annotation (Line(points={{-31,-10},
          {-26,-10},{-26,-85},{-81,-85}},     color={0,0,127}));
  connect(localWeather.y[7], weaDat.HDirNor_in) annotation (Line(points={{-31,-10},
          {-31,35.1},{-81,35.1},{-81,-101}},  color={0,0,127}));
  connect(localWeather.y[8], weaDat.HDifHor_in) annotation (Line(points={{-31,-10},
          {-26,-10},{-26,-97.6},{-81,-97.6}},   color={0,0,127}));

  connect(realExpression.y, localWeather.u) annotation (Line(points={{-63,-10},
          {-58,-10},{-54,-10}},                     color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html>
<p>This extension of the SimInfoManager allows to use a custom text input file for the weather data instead of the TMY3 weather data loaded by the SimInfoManager.</p>
<p>The text file should have the following structure. It should start with:</p>
<p>double data(xx,10)</p>
<p>where xx should be replaced by the number of time entries (number of rows).</p>
<p>The following lines should have 10 tab-separated columns containing following values:</p>
<p>time [s], ambiant temperature [K], dew point temperature [K], 
atmospheric pressure [bar], wind speed [m/s], wind bearing [deg] (between 0 and 360), 
relative humidity [-] (between 0 and 1), direct normal sun irradiance [W/m2], 
diffuse horizontal irradiance [W/m2] and weather the measurement is trusted 
or not (even though nothing is done in modelica with the last column).</p>
<p>Once the custom text file is created, give the correct path to the 
<code><i>fileNameLocalWeather</i> parameter.</code></p>
</html>"),
    experiment(StopTime=1000));
end SimInfoManagerInputs;
