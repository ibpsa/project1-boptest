within IDEAS.Experimental.Electric.Distribution.AC.Examples.Components;
model Transformer
  import IDEAS;

  parameter Modelica.SIunits.Temperature THsRef = 326.6;
  parameter Modelica.SIunits.Temperature TToRef = 314.44;

  IDEAS.Experimental.Electric.Distribution.AC.Components.MvLvTransformer_3P
    transformer_MvLv(redeclare
      IDEAS.Experimental.Electric.Data.TransformerImp.Transfo_100kVA
      transformer)
    annotation (Placement(transformation(extent={{60,0},{40,20}})));
  IDEAS.Experimental.Electric.BaseClasses.AC.WattsLaw wattsLaw(numPha=3)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Sources.Sine step(
    amplitude=100000,
    startTime=0,
    offset=50000,
    freqHz=0.00001)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant const
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(transformer_MvLv.pin_lv_p, wattsLaw.vi) annotation (Line(
      points={{40,16},{28,16},{28,10},{20,10}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(wattsLaw.Q, const.y) annotation (Line(
      points={{0,8},{-20,8},{-20,-10},{-39,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wattsLaw.P, step.y) annotation (Line(
      points={{0,12},{-20,12},{-20,30},{-39,30}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Transformer;
