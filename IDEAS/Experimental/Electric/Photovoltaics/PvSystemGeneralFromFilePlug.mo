within IDEAS.Experimental.Electric.Photovoltaics;
model PvSystemGeneralFromFilePlug
  "PV system with separate shut-down controller and plug connector"

  parameter Real PNom "Nominal power, in Wp";
  parameter Integer prod=1;

  parameter Modelica.SIunits.Time timeOff=300;
  parameter Modelica.SIunits.Voltage VMax=253
    "Max grid voltage for operation of the PV system";

  parameter Integer numPha=1;
  output Real PInit;
  output Real PFinal;
  Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug plug(m=
       numPha) annotation (Placement(transformation(extent={{92,30},{112,50}},
          rotation=0)));

  IDEAS.Experimental.Electric.Photovoltaics.Components.ForInputFiles.SimpleDCAC_effP
    invertor(PNom=PNom)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  BaseClasses.AC.WattsLawPlug wattsLaw(numPha=numPha)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));

  replaceable Components.PvVoltageCtrlGeneral_InputVGrid pvVoltageCtrl(
    VMax=VMax,
    timeOff=timeOff,
    numPha=numPha)
    annotation (Placement(transformation(extent={{26,20},{46,40}})));
  outer
    IDEAS.Experimental.Electric.Photovoltaics.Components.ForInputFiles.PVProfileReader
    PV1 annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput VGrid
    annotation (Placement(transformation(extent={{74,-82},{114,-42}})));
equation
  invertor.P_dc = PV1.P_ratio*PNom;

  connect(wattsLaw.vi, plug) annotation (Line(
      points={{80,30},{92,30},{92,40},{102,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(invertor.P, pvVoltageCtrl.PInit) annotation (Line(
      points={{-19.4,36},{4,36},{4,36},{26.2,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(invertor.Q, pvVoltageCtrl.QInit) annotation (Line(
      points={{-19.6,32},{4,32},{4,32},{26.2,32}},
      color={0,0,127},
      smooth=Smooth.None));
  PInit = pvVoltageCtrl.PInit;
  PFinal = pvVoltageCtrl.PFinal;
  connect(pvVoltageCtrl.VGrid, VGrid) annotation (Line(
      points={{36,20},{36,-62},{94,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pvVoltageCtrl.PFinal, wattsLaw.P[1]) annotation (Line(
      points={{46.6,36},{60,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pvVoltageCtrl.QFinal, wattsLaw.Q[1]) annotation (Line(
      points={{46.6,32},{60,32}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(Bitmap(extent=[-90, 90; 90, -90], name=
            "modelica://IDEAS/Electric/PV.png")), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end PvSystemGeneralFromFilePlug;
