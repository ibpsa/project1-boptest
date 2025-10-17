within OU44Emulator.Models.Validation;
model RealOccupancy
  extends BuildingControl(occupancy(
      tableOnFile=true,
      tableName="occ",
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://OU44Emulator/Resources/occ.txt"),
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
      startTime=3*3600 + 3600*24));

  annotation (experiment(
      StopTime=31536000,
      Interval=900,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),                         Diagram(
        coordinateSystem(extent={{-260,-240},{240,220}}),          graphics={
        Rectangle(
          extent={{-192,168},{-44,100}},
          lineColor={28,108,200},
          lineThickness=1),
        Rectangle(
          extent={{-74,-54},{56,-140}},
          lineColor={28,108,200},
          lineThickness=1),
        Text(
          extent={{-196,164},{-112,160}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Occupancy model"),
        Text(
          extent={{134,-66},{228,-72}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Temperature set point"),
        Text(
          extent={{-38,-144},{60,-150}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Radiator water circuit"),
        Rectangle(extent={{-206,18},{-174,-12}}, pattern=LinePattern.None),
        Line(
          points={{-170,42},{-154,42}},
          color={28,108,200},
          thickness=0.5,
          arrow={Arrow.Open,Arrow.None}),
        Text(
          extent={{-240,48},{-170,38}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Air handling unit"),
        Text(
          extent={{-136,20},{-76,16}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Infiltration"),
        Text(
          extent={{-28,102},{32,98}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          fontSize=12,
          textString="Zone model"),
        Line(
          points={{0,96},{0,82}},
          color={28,108,200},
          thickness=0.5,
          arrow={Arrow.Open,Arrow.None}),
        Line(
          points={{-88,18},{-76,18}},
          color={28,108,200},
          thickness=0.5,
          arrow={Arrow.Open,Arrow.None})}),
    Icon(coordinateSystem(extent={{-260,-240},{240,220}})));
end RealOccupancy;
