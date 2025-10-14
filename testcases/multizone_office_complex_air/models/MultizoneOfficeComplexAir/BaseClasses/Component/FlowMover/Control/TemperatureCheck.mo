within MultizoneOfficeComplexAir.BaseClasses.Component.FlowMover.Control;
model TemperatureCheck "Controller for constant speed fans or pumps"
  parameter Integer numTemp(min=1) = 1
      "The size of the temeprature vector";

  Modelica.Blocks.Interfaces.RealInput Temp[numTemp]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput On
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput CooSetPoi[numTemp]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput HeaSetPoi[numTemp]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  parameter Modelica.Units.SI.TemperatureDifference dTCycCon = 0.2
    "Temperature difference for trigerring the cycle control";
algorithm
 for i in 1:numTemp loop
    if (Temp[i] > CooSetPoi[i] + dTCycCon) or (Temp[i] < HeaSetPoi[i] - dTCycCon) then
       On := true;
       break;
     end if;
   On := false;
   end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-66,50},{62,-48}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="CyclingControl"),
        Text(
          extent={{-156,106},{144,146}},
          textString="%name",
          textColor={0,0,255})}),        Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(info="<html>

</html>"));
end TemperatureCheck;
