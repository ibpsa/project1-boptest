within BuildingEmulators.Components;
model IdealProduction "Ideal production model which assumes a linear efficiency curve"
    extends IDEAS.Fluid.Interfaces.PrescribedOutlet(show_T = true, allowFlowReversal=false);
    outer .IDEAS.BoundaryConditions.SimInfoManager sim "Simulation information manager for climate data" annotation(Placement(transformation(extent = {{-100.0,80.0},{-80.0,100.0}},rotation = 0.0,origin = {0.0,0.0})));
    parameter Boolean boiler = true
    "if true, gas boiler whose efficiency only depends on the inlet temperature; if false, chiller/heat pump whose efficiency depends on inlet and ambient temperatures";
    parameter Boolean heating = false
     "if true, heat pump, else chiller";
    .Modelica.Blocks.Interfaces.RealOutput P(unit = "W") "Energy used by the production component" annotation(Placement(transformation(extent = {{100.0,-70.0},{120.0,-50.0}},rotation = 0.0,origin = {0.0,0.0})));
    .Modelica.Blocks.Interfaces.RealInput TSetIn(unit = "K", displayUnit="degC");
    parameter Real A = if boiler then 2.46575 else A_vcrs "Intercept of the linear expression";
    parameter Real B = if boiler then -0.005 else B_vcrs "Rate of change with the inlet temperature";
    parameter Real C = if boiler then 0 else C_vcrs  "Rate of change with the ambient temperature";
    parameter Real A_vcrs = if heating then -15.11 else -68.5 "Intercept of the linear expression of the vapor-compression refrigeration system";
    parameter Real B_vcrs = if heating then -0.05 else 0.4 "Rate of change with th inlet temperature of the vapor-compression refrigeration system";
    parameter Real C_vcrs = if heating then 0.125 else -4/30  "Rate of change with the ambient temperature of the vapor-compression refrigeration system";
    parameter Real conPoint = 273.15+45 "Condensation point for the gas boiler";
    Real linear_expression = A + B*TSetIn + C*sim.Te "linear dependency of the production system";
    Real eff = if boiler then linear_expression + 0.1/(1+exp(TSetIn-conPoint)) else linear_expression "efficiency of the production system";
    .Modelica.Blocks.Sources.RealExpression effExp(y = abs(Q_flow / eff)) annotation(Placement(transformation(extent = {{20.0,-70.0},{40.0,-50.0}},origin = {0.0,0.0},rotation = 0.0)));
    //\frac{0.1}{\left(1+\exp\left(x-C\right)\right)}+2.46575-0.005x
equation
    TSet=TSetIn;
    if not use_TSet then
        TSet = 0;
    end if;
    connect(effExp.y,P) annotation(Line(points = {{41,-60},{110,-60}},color = {0,0,127}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics={  Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name"),Line(origin={85,-51},points={{14.999967066252296,-8.950839008652679},{-5,-9},{-5,9},{-15,9}},color={22,0,255})}));
end IdealProduction;
