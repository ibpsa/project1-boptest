within IDEAS.Airflow.AHU.BaseClasses;
model LimPidAdsolair
  extends Modelica.Blocks.Interfaces.SVcontrol;
  parameter Real y_off=0
    "Value of controller output while it is off";
  parameter Boolean useRevActIn = false "Use reverse action input"
    annotation(Evaluate=true);
  parameter Boolean revActPar = false "Reverse action"
    annotation(Dialog(enable=not useRevActIn));
  parameter Modelica.Blocks.Types.SimpleController controllerType=
         Modelica.Blocks.Types.SimpleController.PID "Type of controller";
  parameter Boolean useKIn = false
    "Use input for controller gain"
    annotation(Evaluate=true);
  parameter Real k(min=0, unit="1") = 1 "Gain of controller"
    annotation(Dialog(enable=not useKIn));
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=0.5
    "Time constant of Integrator block" annotation (Dialog(enable=
          controllerType == Modelica.Blocks.Types.SimpleController.PI or
          controllerType == Modelica.Blocks.Types.SimpleController.PID));
  parameter Modelica.SIunits.Time Td(min=0)=0.1
    "Time constant of Derivative block" annotation (Dialog(enable=
          controllerType == Modelica.Blocks.Types.SimpleController.PD or
          controllerType == Modelica.Blocks.Types.SimpleController.PID));
  parameter Real yMax(start=1)=1 "Upper limit of output";
  parameter Real yMin=0 "Lower limit of output";
  parameter Real wp(min=0) = 1 "Set-point weight for Proportional block (0..1)";
  parameter Real wd(min=0) = 0 "Set-point weight for Derivative block (0..1)"
       annotation(Dialog(enable=controllerType==.Modelica.Blocks.Types.SimpleController.PD or
                                controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Real Ni(min=100*Modelica.Constants.eps) = 0.9
    "Ni*Ti is time constant of anti-windup compensation"
     annotation(Dialog(enable=controllerType==.Modelica.Blocks.Types.SimpleController.PI or
                              controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Real Nd(min=100*Modelica.Constants.eps) = 10
    "The higher Nd, the more ideal the derivative block"
       annotation(Dialog(enable=controllerType==.Modelica.Blocks.Types.SimpleController.PD or
                                controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Modelica.Blocks.Types.InitPID initType= Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                     annotation(Evaluate=true,
      Dialog(group="Initialization"));
      // Removed as the Limiter block no longer uses this parameter.
      // parameter Boolean limitsAtInit = true
      //  "= false, if limits are ignored during initialization"
      // annotation(Evaluate=true, Dialog(group="Initialization"));
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation (Dialog(group="Initialization",
                enable=controllerType==.Modelica.Blocks.Types.SimpleController.PI or
                       controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation (Dialog(group="Initialization",
                         enable=controllerType==.Modelica.Blocks.Types.SimpleController.PD or
                                controllerType==.Modelica.Blocks.Types.SimpleController.PID));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(enable=initType == Modelica.Blocks.Types.InitPID.InitialOutput, group=
          "Initialization"));
  parameter Boolean strict=true "= true, if strict limits with noEvent(..)"
    annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));

  parameter IDEAS.Types.Reset reset = IDEAS.Types.Reset.Disabled
    "Type of controller output reset"
    annotation(Evaluate=true, Dialog(group="Integrator reset"));

  parameter Real y_reset=xi_start
    "Value to which the controller output is reset if the boolean trigger has a rising edge, used if reset == IDEAS.Types.Reset.Parameter"
    annotation(Dialog(enable=reset == IDEAS.Types.Reset.Parameter,
                      group="Integrator reset"));


  IDEAS.Controls.Continuous.LimPID conPID(reset=IDEAS.Types.Reset.Parameter,
      y_reset=y_off,
    controllerType=controllerType,
    k=1,
    Ti=Ti,
    Td=Td,
    yMax=yMax,
    yMin=yMin,
    wp=wp,
    wd=wd,
    Ni=Ni,
    Nd=Nd,
    initType=initType,
    xi_start=xi_start,
    xd_start=xd_start,
    y_start=y_start,
    reverseActing=true)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Interfaces.BooleanInput revActIn if
                                                    useRevActIn
    "Reverse action" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Math.Product revActS
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));

  Modelica.Blocks.MathBoolean.RisingEdge risingEdge
    "Reset integrator when re-enabling PID"
    annotation (Placement(transformation(extent={{0,12},{8,20}})));
  Modelica.Blocks.Interfaces.BooleanInput on
    "On/off signal of PID" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,100})));
  Modelica.Blocks.Math.Product revActM
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Constant const(k=y_off)
    annotation (Placement(transformation(extent={{38,-14},{50,-2}})));
  Modelica.Blocks.Interfaces.RealInput kIn if useKIn "Connector for k"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=(if revActIn_internal
         then -1 else 1)*k_internal)
    annotation (Placement(transformation(extent={{-100,-26},{-60,-6}})));
protected
  Modelica.Blocks.Interfaces.RealInput k_internal;
  Modelica.Blocks.Interfaces.BooleanInput revActIn_internal;


equation
  connect(k_internal,kIn);
  connect(revActIn,revActIn_internal);

  if not useKIn then
    k_internal=k;
  end if;
  if not useRevActIn then
    revActIn_internal=revActPar;
  end if;
  connect(risingEdge.y, conPID.trigger)
    annotation (Line(points={{8.8,16},{22,16},{22,18}}, color={255,0,255}));
  connect(revActM.u1, revActS.u1)
    annotation (Line(points={{-42,-24},{-42,-4},{-42,16}}, color={0,0,127}));
  connect(revActS.u2, u_s) annotation (Line(points={{-42,4},{-78,4},{-78,0},{-120,
          0}}, color={0,0,127}));
  connect(revActM.u2, u_m) annotation (Line(points={{-42,-36},{-48,-36},{-48,-120},
          {0,-120}}, color={0,0,127}));
  connect(revActS.y, conPID.u_s) annotation (Line(points={{-19,10},{12,10},{12,30},
          {18,30}}, color={0,0,127}));
  connect(revActM.y, conPID.u_m)
    annotation (Line(points={{-19,-30},{30,-30},{30,18}}, color={0,0,127}));
  connect(switch2.u1, conPID.y)
    annotation (Line(points={{58,8},{50,8},{50,30},{41,30}}, color={0,0,127}));
  connect(switch2.u2, risingEdge.u) annotation (Line(points={{58,0},{-10,0},{-10,
          16},{-1.6,16}}, color={255,0,255}));
  connect(const.y, switch2.u3)
    annotation (Line(points={{50.6,-8},{58,-8}}, color={0,0,127}));
  connect(switch2.y, y)
    annotation (Line(points={{81,0},{110,0},{110,0}}, color={0,0,127}));
  connect(risingEdge.u, on) annotation (Line(points={{-1.6,16},{-10,16},{-10,60},
          {-40,60},{-40,100}}, color={255,0,255}));
  connect(realExpression.y, revActM.u1) annotation (Line(points={{-58,-16},{-50,
          -16},{-50,-24},{-42,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
January 26, 2018, by Filip Jorissen:<br/>
Fixed bug in reverse action implementation.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/730\">#730</a>.
</li>
</ul>
</html>"));
end LimPidAdsolair;
