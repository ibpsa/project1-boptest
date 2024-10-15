within IDEAS.Airflow.AHU.BaseClasses;
model AdsolairController
  extends IDEAS.Airflow.AHU.BaseClasses.AdsolairControllerInterface;
  parameter Modelica.SIunits.Time tau=60
    "Thermal time constant at nominal flow rate";

  Modelica.Blocks.Sources.BooleanExpression onAdiaExp(
    y=on
    and TSet < TIehInSup
    and (pre(onAdiaExp.y)
    or TSet < TIehOutSup and pre(damMax.y)))
    "Indirect evaporative cooling hysteresis status: 
    on when TSet not obtained and damper is at maximum position, 
    off when inlet temperature already satisfies set point"
    annotation (Placement(transformation(extent={{-100,50},{14,70}})));
  Modelica.Blocks.Sources.BooleanExpression onChiExp(
    y=on
    and onDelAdi.y
    and TSet < TIehOutSup
    and (pre(onChiExp.y) or TSet + 0.1 < TIehOutSup))
    "Active chiller hystersis status: 
    on when adia has been on for a while and temperature is still too low, 
    off when IEH outlet temp satisfies requirements"
    annotation (Placement(transformation(extent={{-100,28},{14,46}})));
  Modelica.Blocks.MathBoolean.OnDelay onDelAdi(delayTime=5*tau)
    "On delay before compressor may be activated"
    annotation (Placement(transformation(extent={{28,56},{36,64}})));
  Modelica.Blocks.Sources.BooleanExpression revAct(y=onAdiaExp.y or onChiExp.y or
        TIehOutSup < TIehInSup) "Reverse action"
    annotation (Placement(transformation(extent={{-100,38},{14,58}})));
  IDEAS.Airflow.AHU.BaseClasses.LimPidAdsolair damPid(
    useRevActIn=true,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    y_off=0,
    useKIn=true)
    "PI controller for dampers"
    annotation (Placement(transformation(extent={{30,0},{40,10}})));
  Modelica.Blocks.Math.Abs absdT
    "Absolute temperature difference between inlet streams"
    annotation (Placement(transformation(extent={{-2,0},{8,10}})));
  Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-16,0},{-6,10}})));
  Modelica.Blocks.Sources.RealExpression yBypTopExp(y=if not onAdiaExp.y and on
         and not onChiExp.y then 1 - damPid.y else 0)
    "Real expression for connecting to output"
    annotation (Placement(transformation(extent={{40,92},{80,104}})));
  Modelica.Blocks.Sources.RealExpression yRecTopExp(y=if on then 1 else 0)
    "Real expression for connecting to output"
    annotation (Placement(transformation(extent={{40,74},{80,86}})));
  Modelica.Blocks.Sources.RealExpression recupBoty(y=if on then (if onChiExp.y
         then 1 else min(2*damPid.y, 1)) else 0)
    "Real expression for connecting to output"
    annotation (Placement(transformation(extent={{40,52},{92,68}})));
  Modelica.Blocks.Sources.RealExpression bypassBoty(y=if on then (if onChiExp.y
         then 0 else min(2 - 2*damPid.y, 1)) else 0)
    "Real expression for connecting to output"
    annotation (Placement(transformation(extent={{40,32},{92,48}})));
  Modelica.Blocks.Interfaces.RealOutput yBypTop
    "Control signal of top bypass damper"
    annotation (Placement(transformation(extent={{100,88},{120,108}})));
  Modelica.Blocks.Interfaces.RealOutput yRecTop
    "Control signal of top IEH damper"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput yRecBot
    "Control signal of bottom IEH damper"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput yBypBot
    "Control signal of bottom bypass damper"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.BooleanOutput onAdia
    "Indirect evaporative cooling status" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-30})));
  Modelica.Blocks.Interfaces.BooleanOutput onChi "Chiller status" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-70})));
  IDEAS.Airflow.AHU.BaseClasses.LimPidAdsolair chiPid(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    revActPar=true,
    y_off=0.6,
    useKIn=false,
    k=0.1,
    Ti=240)   "Pi controller for chiller compressor"
    annotation (Placement(transformation(extent={{30,-24},{40,-14}})));
  Modelica.Blocks.Interfaces.RealOutput mod
    "Modulation signal of chiller compressor"
    annotation (Placement(transformation(extent={{100,-10},{140,30}})));
  Utilities.Math.InverseXRegularized inverseXRegularized(delta=0.1)
    annotation (Placement(transformation(extent={{14,0},{24,10}})));
  Modelica.Blocks.Sources.BooleanExpression damMax(y=damPid.y > 0.97 or damPid.y
         < 0.03) "Damper is at its limits -> next stage can be enabled"
    annotation (Placement(transformation(extent={{-100,66},{14,82}})));
  Modelica.Blocks.Continuous.Filter TFanFil(f_cut=1/60, order=1,
    init=Modelica.Blocks.Types.Init.InitialState)
    "Filter not integrated into temperature sensor since this leads to large time constants for low flow rates"
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
initial equation
  pre(onAdiaExp.y)=false;
  pre(onChiExp.y)=false;
  pre(damMax.y)=false;
equation
  connect(onDelAdi.u, onAdiaExp.y) annotation (Line(points={{26.4,60},{19.7,60}},
                color={255,0,255}));
  connect(add.u2, TEvaOut) annotation (Line(points={{-17,2},{-22,2},{-22,-90},{
          -104,-90}},
                  color={0,0,127}));
  connect(TIehInSup, add.u1) annotation (Line(points={{-104,-60},{-24,-60},{-24,
          8},{-17,8}},color={0,0,127}));
  connect(revAct.y, damPid.revActIn)
    annotation (Line(points={{19.7,48},{35,48},{35,10}}, color={255,0,255}));
  connect(yBypTopExp.y, yBypTop)
    annotation (Line(points={{82,98},{94,98},{110,98}}, color={0,0,127}));
  connect(yRecTopExp.y, yRecTop)
    annotation (Line(points={{82,80},{110,80}}, color={0,0,127}));
  connect(recupBoty.y, yRecBot)
    annotation (Line(points={{94.6,60},{99.3,60},{110,60}}, color={0,0,127}));
  connect(bypassBoty.y, yBypBot)
    annotation (Line(points={{94.6,40},{100.3,40},{110,40}}, color={0,0,127}));
  connect(damPid.u_s, TSet)
    annotation (Line(points={{29,5},{29,30},{-104,30}}, color={0,0,127}));
  connect(onAdiaExp.y, onAdia) annotation (Line(points={{19.7,60},{18,60},{18,26},
          {18,24},{120,24},{120,-30}}, color={255,0,255}));
  connect(onChi, onChiExp.y) annotation (Line(points={{120,-70},{19.7,-70},{19.7,
          37}}, color={255,0,255}));
  connect(absdT.u, add.y) annotation (Line(points={{-3,5},{-5.5,5}},
        color={0,0,127}));
  connect(chiPid.on, onChiExp.y) annotation (Line(points={{33,-14},{28,-14},{19.7,
          -14},{19.7,37}},                color={255,0,255}));
  connect(chiPid.u_s, TSet) annotation (Line(points={{29,-19},{-38,-19},{-38,30},
          {-104,30}}, color={0,0,127}));
  connect(chiPid.y, mod) annotation (Line(points={{40.5,-19},{60,-19},{60,10},{120,
          10}}, color={0,0,127}));
  connect(absdT.y, inverseXRegularized.u) annotation (Line(points={{8.5,5},{11.25,
          5},{11.25,5},{13,5}}, color={0,0,127}));
  connect(inverseXRegularized.y, damPid.kIn) annotation (Line(points={{24.5,5},{
          27.25,5},{27.25,8},{29,8}}, color={0,0,127}));
  connect(damPid.on, on) annotation (Line(points={{33,10},{34,10},{34,90},{-104,
          90}}, color={255,0,255}));
  connect(TFanFil.u, TFanOutSup)
    annotation (Line(points={{-72,0},{-104,0}}, color={0,0,127}));
  connect(TFanFil.y, damPid.u_m) annotation (Line(points={{-49,0},{-6,0},{-6,-1},
          {35,-1}}, color={0,0,127}));
  connect(TFanFil.y, chiPid.u_m) annotation (Line(points={{-49,0},{-42,0},{-42,
          -25},{35,-25}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
May 15, 2018, by Filip Jorissen:<br/>
Changes for setting unique initial conditions.
</li>
<li>
January 26, 2018, by Filip Jorissen:<br/>
Improved adsolair controller performance.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/751\">#751</a>,
<a href=\"https://github.com/open-ideas/IDEAS/issues/730\">#730</a>,
<a href=\"https://github.com/open-ideas/IDEAS/issues/729\">#729</a>,
<a href=\"https://github.com/open-ideas/IDEAS/issues/754\">#754</a>.
</li>
<li>
April 24, 2017, by Filip Jorissen:<br/>
Now extending from interface.
</li>
</ul>
</html>"));
end AdsolairController;
