within IDEAS.Buildings.Components.Validations;
model WindowEN673 "Verifies U value of a glazing record"
  extends Modelica.Icons.Example;
  inner SimInfoManagerFixedBC sim(TDryBulFixed=TOut)
    "SimInfoManager with fixed temperatures"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  replaceable package Medium = IDEAS.Media.Air "Air medium";
  parameter SI.Temperature TZone=273.15 + 20
    "Fixed interior temperature";
  parameter SI.Temperature TOut=273.15
    "Fixed exterior temperature";

  Modelica.SIunits.CoefficientOfHeatTransfer U_EN673=windowEN673.layMul.port_a.Q_flow/
      (TZone - TOut)/windowEN673.A;
  Modelica.SIunits.CoefficientOfHeatTransfer U_default=window.layMul.port_a.Q_flow/
      (TZone - TOut)/window.A;

  IDEAS.Buildings.Components.Window windowEN673(
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=1,
    nWin=1,
    frac=0,
    gainDif(k=0),
    gainDir(k=0),
    linIntCon_a=false,
    linExtCon=false,
    linExtRad=false,
    eCon(linearise=true, hConExtLin=25),
    skyRad(
      Tenv_nom=0,
      linearise=true,
      heaRad(dT_nom=0)),
    intCon_a(dT_nominal=3.759),
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    redeclare Data.Glazing.Ins2Ar2020 glazing)
    "Window model with modifications to be better in line with EN673"
    annotation (Placement(transformation(extent={{-16,-20},{-4,0}})));

  IDEAS.Buildings.Components.Zone zone(
    redeclare package Medium = Medium,
    V=1,
    hZone=1,
    redeclare InterzonalAirFlow.FixedPressure interzonalAirFlow,
    energyDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    linIntRad=true,
    nSurf=6)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));

  IDEAS.Buildings.Components.BoundaryWall boundaryWall(
    redeclare Data.Constructions.CavityWall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=50,
    use_T_fixed=true,
    T_fixed=TZone,
    T_start=TZone) "Large wall for setting radiative temperature"
    annotation (Placement(transformation(extent={{-16,40},{-4,60}})));
  IDEAS.Buildings.Components.BoundaryWall boundaryWall1(
    redeclare Data.Constructions.CavityWall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    A=50,
    use_T_fixed=true,
    T_fixed=TZone,
    azi=IDEAS.Types.Azimuth.W,
    T_start=TZone) "Large wall for setting radiative temperature"
    annotation (Placement(transformation(extent={{56,40},{44,60}})));
  IDEAS.Buildings.Components.BoundaryWall boundaryWall2(
    redeclare Data.Constructions.CavityWall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    A=50,
    use_T_fixed=true,
    T_fixed=TZone,
    azi=IDEAS.Types.Azimuth.N,
    T_start=TZone) "Large wall for setting radiative temperature"
    annotation (Placement(transformation(extent={{56,8},{44,28}})));
  IDEAS.Buildings.Components.BoundaryWall boundaryWall3(
    redeclare Data.Constructions.CavityWall constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    A=50,
    use_T_fixed=true,
    T_fixed=TZone,
    azi=IDEAS.Types.Azimuth.E,
    T_start=TZone) "Large wall for setting radiative temperature"
    annotation (Placement(transformation(extent={{-16,8},{-4,28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TFix(T=TZone)
    "Fixed air temperature"
    annotation (Placement(transformation(extent={{80,-20},{60,0}})));
  IDEAS.Buildings.Components.Window window(
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=1,
    gainDir(k=0),
    gainDif(k=0),
    redeclare Data.Glazing.Ins2Ar2020 glazing,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
                  "Window without modifications"
    annotation (Placement(transformation(extent={{-16,-40},{-4,-20}})));
protected
  model SimInfoManagerFixedBC
    extends IDEAS.BoundaryConditions.SimInfoManager(weaDat(
        TDryBulSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
        TDryBul=TDryBulFixed,
        TBlaSkySou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
        TBlaSky=TDryBulFixed));

    parameter SI.Temperature TDryBulFixed=293.15
      "Dry bulb temperature (used if TDryBul=Parameter)";
  end SimInfoManagerFixedBC;
initial equation
  // custom initial equation since fixed temperature boundary equation
  // requires DynamicFreeInitial
  zone.port_b.Xi_outflow[1]=0;
equation

  connect(windowEN673.propsBus_a, zone.propsBus[1]) annotation (Line(
      points={{-5,-8},{18,-8},{18,-4.33333},{20,-4.33333}},
      color={255,204,51},
      thickness=0.5));
  connect(zone.propsBus[2], boundaryWall.propsBus_a) annotation (Line(
      points={{20,-5},{20,52},{-5,52}},
      color={255,204,51},
      thickness=0.5));
  connect(boundaryWall1.propsBus_a, zone.propsBus[3]) annotation (Line(
      points={{45,52},{20,52},{20,-5.66667}},
      color={255,204,51},
      thickness=0.5));
  connect(boundaryWall2.propsBus_a, zone.propsBus[4]) annotation (Line(
      points={{45,20},{20,20},{20,-6.33333}},
      color={255,204,51},
      thickness=0.5));
  connect(boundaryWall3.propsBus_a, zone.propsBus[5]) annotation (Line(
      points={{-5,20},{20,20},{20,-7}},
      color={255,204,51},
      thickness=0.5));
  connect(TFix.port, zone.gainCon) annotation (Line(points={{60,-10},{50,-10},{50,
          -13},{40,-13}}, color={191,0,0}));
  connect(window.propsBus_a, zone.propsBus[6]) annotation (Line(
      points={{-5,-28},{20,-28},{20,-7.66667}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(
      StopTime=1000000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),        Documentation(revisions="<html>
<ul>
<li>
July 20, 2020, by Filip Jorissen:<br/>
Updated glazing type.
</li>
<li>
September 22, 2019, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model modifies the default implementation of the window to be more in line with EN673. 
E.g. the exterior and interior total convective heat transfer coefficients are changed. 
The resulting U-value is computed as <code>U_EN673</code> and can be compared to
the default implementation <code>U_default</code>.
The interior air cavity heat transfer coefficient computations are unchanged, 
which explains the different results with the standard.
</p>
<p>
This model can be used to verify that <code>U_EN673</code> is sufficiently close to the
expect U value of the glazing system. When this is not the case, you likely made an implementation
error with the coating (= long wave emissivity) implementation.
Furthermore, this model can be used to check what the wind speed and 
temperature-dependent U-value is. 
</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Validations/WindowEN673.mos"
        "Simulate and plot"));
end WindowEN673;
