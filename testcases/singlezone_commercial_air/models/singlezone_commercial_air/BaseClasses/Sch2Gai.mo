within singlezone_commercial_air.BaseClasses;
model Sch2Gai
  "This block converts schedules (light,occupnacy, equipment) to gains in the order of radiative, convective and latent gains."
  parameter Real RadFraLig=0.7 "radiative heat gain fraction of light";
  parameter Real RadFraOcc=0.3 "radiative heat gain fraction of occuapnct heat gain";
  parameter Real RadFraEqu=0.5 "radiative heat gain fraction of equipement";

  parameter Real qlig= 9.584185835 "design light power density [W/m2]";
  parameter Real nOcc=30 "design number of occupants";
  parameter Real OccSen = 75 "Department or retail stores ASHRAE handbook of fundemantal (Chp.26, Table3), https://engineer-educators.com/topic/5-heat-gain-from-people-lights-and-appliances/";
  parameter Real OccLat = 55 "latent heat per person";
  parameter Real Qeqi= 1498.0615 "design equipment power [W]";

  parameter Real AFlo  "Floor Area";

  Modelica.Blocks.Interfaces.RealOutput qrad
  annotation (Placement(transformation(
          extent={{100,18},{152,70}}),  iconTransformation(extent={{100,18},{
            152,70}})));
  Modelica.Blocks.Interfaces.RealOutput qcon
  annotation (Placement(transformation(
          extent={{100,-26},{154,28}}), iconTransformation(extent={{100,-26},{154,
            28}})));
  Modelica.Blocks.Interfaces.RealOutput qlat annotation (Placement(transformation(
          extent={{100,-70},{158,-12}}),  iconTransformation(extent={{100,-70},
            {158,-12}})));
  Modelica.Blocks.Interfaces.RealInput u[3](min=0, max=1) "Light/Occupant/Equipemnt" annotation (Placement(transformation(
          extent={{-132,-36},{-68,28}}), iconTransformation(extent={{-132,-36},{
            -68,28}})));
equation
  qlat=u[2]*nOcc*OccLat/AFlo;

  qrad=(u[1]*qlig*AFlo*RadFraLig+
       u[2]*nOcc*OccSen*RadFraOcc+
       u[3]*Qeqi*RadFraEqu)/AFlo;

  qcon=(u[1]*qlig*AFlo*(1-RadFraLig)+
       u[2]*nOcc*OccSen*(1-RadFraOcc)+
       u[3]*Qeqi*(1-RadFraEqu))/AFlo
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-60,20},{0,-20}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid), Polygon(
          points={{0,20},{0,40},{60,0},{0,-42},{0,-22},{0,20}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
    annotation (Placement(transformation(extent={{-122,-24},{-82,16}})));
end Sch2Gai;
