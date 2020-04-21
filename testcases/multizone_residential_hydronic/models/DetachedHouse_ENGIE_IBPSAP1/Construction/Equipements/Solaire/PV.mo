within DetachedHouse_ENGIE_IBPSAP1.Construction.Equipements.Solaire;
model PV

 parameter Modelica.SIunits.Area A_PV=1500 "Surface PV";

  PVmodule                                 pVmodule(S=A_PV/(pVmodule.Ns*
        pVmodule.Np))
    annotation (Placement(transformation(extent={{34,-2},{54,16}})));
  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil(
    til=0.34906585039887,
    lat=0.65798912800186,
    azi=-0.78539816339745) "Diffuse irradiation on tilted surface"
    annotation (Placement(transformation(extent={{-50,12},{-30,32}})));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(
    til=0.34906585039887,
    lat=0.65798912800186,
    azi=-0.78539816339745) "Direct irradiation on tilted surface"
    annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
  Modelica.Blocks.Math.Add G "Total irradiation on tilted surface"
    annotation (Placement(transformation(extent={{-14,-8},{6,12}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(rotation=0, extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Interfaces.RealOutput P "Puissance"
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
equation

  connect(HDifTil.H,G. u1) annotation (Line(
      points={{-29,22},{-26,22},{-26,8},{-16,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil.H,G. u2) annotation (Line(
      points={{-29,-18},{-26,-18},{-26,-4},{-16,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weaBus, HDifTil.weaBus) annotation (Line(points={{-80,0},{-60,0},{-60,
          22},{-50,22}}, color={255,204,51}));
  connect(weaBus, HDirTil.weaBus) annotation (Line(points={{-80,0},{-60,0},{-60,
          -18},{-50,-18}}, color={255,204,51}));
  connect(pVmodule.Tamb, weaBus.TDryBul) annotation (Line(points={{32,11.14},{8,
          11.14},{8,34},{-66,34},{-66,0},{-80,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pVmodule.Pmpp, P) annotation (Line(points={{56.9,11.41},{66.45,11.41},
          {66.45,0},{90,0}}, color={0,0,127}));
  connect(G.y, pVmodule.E)
    annotation (Line(points={{7,2},{32,2},{32,2.32}}, color={0,0,127}));
  connect(P, P) annotation (Line(points={{90,0},{90,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-80,-40},{80,40}})), Icon(
        coordinateSystem(extent={{-80,-40},{80,40}})));
end PV;
