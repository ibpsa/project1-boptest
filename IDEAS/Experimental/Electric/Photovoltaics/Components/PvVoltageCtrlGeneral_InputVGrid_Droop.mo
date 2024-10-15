within IDEAS.Experimental.Electric.Photovoltaics.Components;
block PvVoltageCtrlGeneral_InputVGrid_Droop "Basic droop controller"

  extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Real VMax=248 "Final voltage, from here eta=0";
  parameter Real timeOff=300;
  parameter Real VStart=243 "Initial voltage for droop control";
  parameter Integer numPha=1
    "1 or 3, just indicates if it's a single or 3 phase PV system";
  output Real eta(start=1);
  output Boolean droop(start=false,fixed=true);

  //Boolean switch(start = true, fixed=true) "if true, system is producing";

  Modelica.Blocks.Interfaces.RealInput PInit
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput QInit
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealOutput PFinal
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealOutput QFinal
    annotation (Placement(transformation(extent={{90,10},{110,30}})));

  //  discrete Real restartTime( start=-1, fixed=true)
  //   "system is off until time>restartTime";

public
  Modelica.Blocks.Interfaces.RealInput VGrid
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
equation
  when VGrid > VStart then
    droop = true;
  end when;

  if droop then
    eta = 0.5;
  else
    eta = 1;
  end if;

  PFinal = PInit*eta;
  QFinal = QInit;

  annotation (Diagram(graphics));
end PvVoltageCtrlGeneral_InputVGrid_Droop;
