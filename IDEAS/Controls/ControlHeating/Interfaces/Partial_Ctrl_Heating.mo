within IDEAS.Controls.ControlHeating.Interfaces;
partial model Partial_Ctrl_Heating
  "Partial for a heating control algorithm without TES"

  /* 
  This partial class contains the temperature control algorithm. It has to be extended
  in order to be complete controller.  
  */

  parameter SI.Temperature TRoo_nominal = 273.15 + 21
    "Room temperature at nominal condition";
  parameter SI.Temperature TSupNom "Nominal heating curve supply temperature";
  parameter Modelica.SIunits.TemperatureDifference dTSupRetNom=10
    "Nominal difference between supply and return water temperatures";
  parameter Modelica.SIunits.TemperatureDifference dTHeaterSet(min=0) = 2
    "Difference between heating curve setpoint and heater setpoint";
  parameter Modelica.SIunits.Time timeFilter=43200
    "Time constant for filter on ambient temperature";
  parameter SI.Temperature TSupMin=273.15 + 30
    "Minimum supply temperature if enabled";
  parameter Boolean minSup=true
    "true to limit the supply temperature on the lower side";
  parameter SI.TemperatureDifference dTOutHeaBal=0 "Offset for heating curve";
  parameter SI.Temperature TOut_nominal=273.15 - 8 "Outside temperature";
  parameter Modelica.SIunits.TemperatureDifference corFac_val = 0
    "correction term for TSet of the heating curve";

  HeatingCurves.HeatingCurveFilter heatingCurve(
    timeFilter=timeFilter,
    TSup_nominal=TSupNom,
    TRet_nominal=TSupNom - dTSupRetNom,
    redeclare IDEAS.Utilities.Math.MovingAverage filter(period=timeFilter),
    TSupMin=TSupMin,
    minSup=minSup,
    TRoo_nominal=TRoo_nominal,
    TOut_nominal=TOut_nominal,
    use_TRoo_in=true,
    dTOutHeaBal=dTOutHeaBal)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Interfaces.RealOutput THeaterSet(final quantity="ThermodynamicTemperature",unit="K",displayUnit="degC", min=0,start=283.15)
    "Heat pump set temperature" annotation (Placement(transformation(extent={{80,0},{
            100,20}}),          iconTransformation(extent={{80,0},{100,20}})));

  Modelica.Blocks.Interfaces.RealOutput THeaCur(final quantity="ThermodynamicTemperature",unit="K",displayUnit="degC", min=0)
    "Heating curve setpoint"
    annotation (Placement(transformation(extent={{90,30},{110,50}}),
        iconTransformation(extent={{90,30},{110,50}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
    annotation (Placement(transformation(extent={{-60,46},{-40,66}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=heatingCurve.TSup + dTHeaterSet)
    annotation (Placement(transformation(extent={{-44,0},{0,20}})));

  Modelica.Blocks.Interfaces.RealInput TRoo_in1(final quantity="ThermodynamicTemperature",unit="K",displayUnit="degC", min=0)
    "Room air temperature set point"
    annotation (Placement(transformation(extent={{-120,24},{-80,64}}),
        iconTransformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Sources.RealExpression corHeaCur(y=corFac_val)
    "Correction term on the heating curve"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
equation
  connect(realExpression.y, heatingCurve.TOut) annotation (Line(
      points={{-39,56},{-22,56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatingCurve.TRoo_in, TRoo_in1) annotation (Line(
      points={{-21.9,44},{-100,44}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false),                             graphics={
        Text(
          extent={{-151,147},{149,107}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name"),
          Rectangle(
          extent={{120,60},{-80,-60}},
          lineColor={135,135,135},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-80,60},{-80,-60},{-40,0},{-80,60}},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={135,135,135})}),
                               Diagram(coordinateSystem(extent={{-100,-100},{
            100,100}},
                  preserveAspectRatio=false), graphics));
end Partial_Ctrl_Heating;
