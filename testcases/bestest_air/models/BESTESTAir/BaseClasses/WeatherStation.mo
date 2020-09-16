within BESTESTAir.BaseClasses;
model WeatherStation
  "Implements a weather station taking weather measurements"
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus "Weather data"
    annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-112,
            -14},{-86,12}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaTDryBul(description="Outside drybulb temperature measurement",
      y(unit="K")) "Outside drybulb temperature measurement"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaRelHum(description="Outside relative humidity measurement",
      y(unit="1")) "Outside relative humidity measurement"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaWinSpe(description="Wind speed measurement",
      y(unit="m/s")) "Wind speed measurement"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaWinDir(description="Wind direction measurement",
      y(unit="rad")) "Wind direction measurement"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaHGloHor(description="Global horizontal solar irradiation measurement",
      y(unit="W/m2")) "Global horizontal solar irradiation measurement"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaNTot(description="Sky cover measurement",
      y(unit="1")) "Sky cover measurement"
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  IBPSA.Utilities.IO.SignalExchange.Read reaPAtm(description="Atmospheric pressure measuremen",
      y(unit="Pa")) "Atmospheric pressure measurement"
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
equation
  connect(weaBus.TDryBul, reaTDryBul.u) annotation (Line(
      points={{-100,0},{-60,0},{-60,90},{-2,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.relHum, reaRelHum.u) annotation (Line(
      points={{-100,0},{-60,0},{-60,60},{-2,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.winSpe, reaWinSpe.u) annotation (Line(
      points={{-100,0},{-60,0},{-60,30},{-2,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.winDir, reaWinDir.u) annotation (Line(
      points={{-100,0},{-52,0},{-52,0},{-2,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.HGloHor, reaHGloHor.u) annotation (Line(
      points={{-100,0},{-60,0},{-60,-30},{-2,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.nTot, reaNTot.u) annotation (Line(
      points={{-100,0},{-60,0},{-60,-60},{-2,-60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.pAtm, reaPAtm.u) annotation (Line(
      points={{-100,0},{-60,0},{-60,-90},{-2,-90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,159},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-52,28},{-48,-80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-52,82},{-54,26},{22,20},{40,14},{62,-6},{70,-4},{74,4},{48,
              32},{20,58},{-52,82}},
          lineColor={0,0,0},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-64,82},{-42,26}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WeatherStation;
