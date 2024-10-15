within IDEAS.Experimental.Electric.Photovoltaics.Components.Elements;
model absorption

  parameter Modelica.SIunits.Irradiance solRef=1000
    "radiation under reference conditions";
  parameter Real K=4 "glazing extinction coefficient, /m";
  parameter Modelica.SIunits.Length d=2*10^(-3) "pane thickness, m";
  parameter Real eff=0.166 "solar cell efficiency";
  parameter Real UA=36.2325
    "Loss coefficient describing convection and radiation losses";
  final parameter Modelica.SIunits.Irradiance solAbsRef=solRef*exp(-K*d);

  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));

  extends Modelica.Blocks.Interfaces.BlockIcon;

  Modelica.Blocks.Interfaces.RealInput IamDir
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput IamDif
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput IamRef
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
  Modelica.Blocks.Interfaces.RealInput solDir annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={20,100})));
  Modelica.Blocks.Interfaces.RealInput solDif annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={60,100})));
  Modelica.Blocks.Interfaces.RealOutput solAbs
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealOutput T
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
protected
  Modelica.SIunits.Irradiance solTot;
  Real albedo=11.895 - 0.042*sim.TeAv;

algorithm
  solTot := solDir + solDif;

  if noEvent(solTot >= 10) then
    solAbs := solAbsRef*(solDir/solRef*IamDir + solDif/solRef*IamDif);
  else
    solAbs := 0;
  end if;
  T := sim.Te + solAbs*(exp(-K*d)/UA)*(1 - eff/exp(-K*d));

  annotation (Diagram(graphics));
end absorption;
