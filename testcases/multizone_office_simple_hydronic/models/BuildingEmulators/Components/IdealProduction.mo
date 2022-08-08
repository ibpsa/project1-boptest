within BuildingEmulators.Components;
model IdealProduction "Ideal production model which assumes a linear efficiency curve"
    extends IDEAS.Fluid.Interfaces.PrescribedOutlet(show_T = true, allowFlowReversal=false);
    outer .IDEAS.BoundaryConditions.SimInfoManager sim "Simulation information manager for climate data" annotation(Placement(transformation(extent = {{-100.0,80.0},{-80.0,100.0}},rotation = 0.0,origin = {0.0,0.0})));
    parameter Boolean chiller = false
    "if false, gas boiler whose efficiency only depends on the inlet temperature; if true, chiller whose efficiency depends on inlet and ambient temperatures";

    .Modelica.Blocks.Interfaces.RealOutput P(unit = "W") "Energy used by the production component" annotation(Placement(transformation(extent = {{100.0,-70.0},{120.0,-50.0}},rotation = 0.0,origin = {0.0,0.0})));

    .Modelica.Blocks.Interfaces.RealInput TSetIn(unit = "K", displayUnit="degC");


    parameter Real A = if chiller then -67 else 2.56575 "Intercept of the linear expression";
    parameter Real B = if chiller then 0.4 else -0.005 "Rate of change with the inlet temperature";
    parameter Real C = if chiller then -4/30 else 0 "Rate of change with the ambient temperature";

    Real eff = A + B*TSetIn + C*sim.Te "efficiency of the production system";

    .Modelica.Blocks.Sources.RealExpression effExp(y = Q_flow / eff) annotation(Placement(transformation(extent = {{20.0,-70.0},{40.0,-50.0}},origin = {0.0,0.0},rotation = 0.0)));


equation

    if use_TSet then
        connect(TSet,TSetIn);
    else
        TSetIn = 0;
    end if;

    connect(effExp.y,P) annotation(Line(points = {{41,-60},{110,-60}},color = {0,0,127}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics = {Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name"),Line(origin={85,-51},points={{14.999967066252296,-8.950839008652679},{-5,-9},{-5,9},{-15,9}},color={22,0,255})}));
end IdealProduction;
