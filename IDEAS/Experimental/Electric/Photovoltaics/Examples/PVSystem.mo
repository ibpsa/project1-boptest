within IDEAS.Experimental.Electric.Photovoltaics.Examples;
model PVSystem
  "Only a PV system, see python script for generating profiles from this model"
  extends Modelica.Icons.Example;
  parameter SI.Angle inc=40/180*Modelica.Constants.pi
    annotation (evaluate=False);
  parameter SI.Angle azi=45/180*Modelica.Constants.pi
    annotation (evaluate=False);

  IDEAS.Experimental.Electric.Photovoltaics.PVSystemGeneral pVSystemGeneral(
    amount=20,
    inc=inc,
    azi=azi) annotation (Placement(transformation(extent={{-38,4},{-18,24}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(f=50, V=230) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-98,78},{-78,98}})));
equation
  connect(pVSystemGeneral.pin[1], voltageSource.pin_p) annotation (Line(
      points={{-17.8,18},{40,18},{40,10}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource.pin_n, ground.pin) annotation (Line(
      points={{40,-10},{40,-30}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end PVSystem;
