within IDEAS.Experimental.Electric.Photovoltaics.Extern;
model PvSystem
  "PV system with separate shut-down controller and plug connector"

  parameter Modelica.SIunits.Power PNom "Nominal power, in Wp";
  parameter Integer id=19
    "Which photovoltaic from the read profiles in the SimInfoManager";
  parameter Modelica.SIunits.Time timeOff=300;
  parameter Modelica.SIunits.Voltage VMax=248
    "Max grid voltage for operation of the PV system";
  parameter Integer numPha=1;

  Modelica.SIunits.Power PInit=invertor.P "Initial PV power before curtailing";
  Modelica.SIunits.Power PFinal=pvVoltageCtrl.PFinal
    "Effective PV power after curtailing";
  Modelica.SIunits.Power PLoss=PInit - PFinal "Effective curtailed PV power";

  replaceable Components.PvVoltageCtrlGeneral_InputVGrid pvVoltageCtrl(
    VMax=VMax,
    timeOff=timeOff,
    numPha=numPha) annotation (Placement(transformation(extent={{20,30},{40,50}})),
      choicesAllMatching=true);

  Modelica.Blocks.Interfaces.RealInput VGrid "Grid voltage for control"
    annotation (Placement(transformation(extent={{-116,30},{-96,50}})));

  IDEAS.Experimental.Electric.Photovoltaics.Components.ForInputFiles.SimpleDCAC_effP
    invertor(PNom=-PNom, P_dc_max=-PNom)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Sources.RealExpression PDc(y=strobe.tabPPv.y[id]/strobe.P_nominal
        *PNom)
    annotation (Placement(transformation(extent={{-88,50},{-40,70}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
  Modelica.Blocks.Interfaces.RealOutput Q
    annotation (Placement(transformation(extent={{96,10},{116,30}})));
  outer IDEAS.BoundaryConditions.Occupants.Extern.StrobeInfoManager strobe(final PPv=true)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  // A top-level "inner" strobe is required to work, otherwise tabPPv cannot be found
equation

  connect(invertor.P, pvVoltageCtrl.PInit) annotation (Line(
      points={{0.6,46},{20.2,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(invertor.Q, pvVoltageCtrl.QInit) annotation (Line(
      points={{0.4,42},{20.2,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pvVoltageCtrl.VGrid, VGrid) annotation (Line(
      points={{30,30},{30,22},{-40,22},{-40,40},{-106,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PDc.y, invertor.P_dc) annotation (Line(
      points={{-37.6,60},{-32,60},{-32,40},{-19.8,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pvVoltageCtrl.PFinal, P) annotation (Line(
      points={{40.6,46},{70,46},{70,60},{106,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pvVoltageCtrl.QFinal, Q) annotation (Line(
      points={{40.6,42},{70,42},{70,20},{106,20}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(graphics={Polygon(
          points={{-80,60},{-60,80},{60,80},{80,60},{80,-60},{60,-80},{-60,-80},
            {-80,-60},{-80,60}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),Line(
          points={{-40,80},{-40,-80}},
          color={0,0,0},
          smooth=Smooth.None),Line(
          points={{40,80},{40,-80}},
          color={0,0,0},
          smooth=Smooth.None),Text(
          extent={{-80,80},{80,-80}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="#")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                     graphics));
end PvSystem;
