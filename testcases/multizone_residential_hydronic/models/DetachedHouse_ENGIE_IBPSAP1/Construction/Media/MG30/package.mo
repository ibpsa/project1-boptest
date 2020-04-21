within DetachedHouse_ENGIE_IBPSAP1.Construction.Media;
package MG30 "Mono ethylène glycol 30%"
  extends Modelica.Media.Incompressible.TableBased(
    mediumName="MG30",
    T_min=Modelica.SIunits.Conversions.from_degC(-20),
    T_max=Modelica.SIunits.Conversions.from_degC(100),
    TinK=false,
    T0=273.15,
    tableDensity=[-10,1056;0,1054;10,1051;20,1047;30,1043;40,1039;50,1033;60,1027;70,1021;80,1015;90,1008;100,1002],
    tableHeatCapacity=[-10,3660;0,3680;10,3700;20,3720;30,3740;40,3760;50,3780;60,3800;70,3820;80,3840;90,3860;100,3880],
    tableConductivity=[-10,0.472;0,0.476;10,0.479;20,0.481;30,0.483;40,0.485;50,0.487;60,0.489;70,0.491;80,0.494;90,0.498;100,0.502],
    tableViscosity=[-10,0.00803;0,0.00516;10,0.00357;20,0.00262;30,0.00198;40,0.00156;50,0.00124;60,0.00103;70,0.00082;80,0.00071;90,0.0003;100,0.0003],
    tableVaporPressure=[80,30e3;100,70e3]);

    annotation (Documentation(info="<html>

</html>"));
end MG30;
