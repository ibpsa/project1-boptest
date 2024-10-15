within IDEAS.Examples.TwinHouses.BaseClasses.HeatingSystems;
model ElectricHeating_Twinhouse_alt
  "Electric heating Twinhouse| alternative temperature or heat input"

  extends IDEAS.Templates.Interfaces.BaseClasses.HeatingSystem(
    P={QHeaSys/COP},
    QHeaSys=sum(IDEAL_heating_rad.Q_flow)+sum(IDEAL_heating_con.Q_flow),
    nLoads=1,nZones=7,nEmbPorts=0);

  parameter Integer exp = 1 "Experiment number: 1 or 2";
  parameter Integer bui = 1 "Building number 1 (N2), 2 (O5)";
  parameter Real[nZones] Crad "thermal mass of radiator";
  parameter Real[nZones] Kemission "heat transfer coefficient";
  parameter Real COP=1;
  Modelica.SIunits.Power[nZones] Qhea;
  final parameter Real frad=0.3 "radiative fraction";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nZones] IDEAL_heating_con
    annotation (Placement(transformation(extent={{8,-12},{-12,8}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nZones] IDEAL_heating_rad
    annotation (Placement(transformation(extent={{6,-44},{-14,-24}})));
  HeatingSchedule heaSche(final exp=exp, final bui=bui)
                          "Heating schedule"
    annotation (Placement(transformation(extent={{88,64},{56,34}})));
initial equation
  assert(exp==1 or exp==2, "Only experiment numbers 1 or 2 are supported.");
  assert(not
            (exp==2 and bui==2), "Combination of exp=2 and bui=2 does not exist");

equation
  Qhea = IDEAL_heating_rad.Q_flow+IDEAL_heating_con.Q_flow;
  for i in 1:nZones loop
  IDEAL_heating_rad[i].Q_flow =frad*min(heaSche.y[i], Q_design[i]);
  IDEAL_heating_con[i].Q_flow=(1 - frad)*min(heaSche.y[i], Q_design[i]);
  end for;


  connect(IDEAL_heating_con.port, heatPortCon) annotation (Line(
      points={{-12,-2},{-106,-2},{-106,20},{-200,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(IDEAL_heating_rad.port, heatPortRad) annotation (Line(
      points={{-14,-34},{-108,-34},{-108,-20},{-200,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TSensor, heaSche.TSensor) annotation (Line(points={{-204,-60},{-48,-60},
          {104,-60},{104,49},{89.6,49}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-200,-100},
            {200,100}})));
end ElectricHeating_Twinhouse_alt;
