within IDEAS.Fluid.HeatPumps.Data.PerformanceMaps;
record VitoCal300GBWS301dotA08
  "Viessmann Vitocal 300-G, type BW/BWS/BWC 301.A08 heat pump data"
  extends HeatPumps.BaseClasses.HeatPumpData(
    m1=3.4,
    m2=3.5,
    m1_flow_nominal=2600/3600,
    m2_flow_nominal=1800/3600,
    dp1_nominal=10000,
    dp2_nominal=10000,
    G=680/15,
    P_the_nominal=8000,
    T_evap_min=273.15 - 5,
    T_cond_max=273.15 + 60,
    copData={{0,268.15,273.15,275.15,283.15,288.15},{308.15,4.02,4.65,4.94,6.13,
        6.87},{318.15,3.02,3.45,3.69,4.66,5.27},{328.15,0,2.65,2.82,3.52,3.96},
        {333.15,0,0,2.44,3.06,3.45}},
    powerData={{0,268.15,273.15,275.15,283.15,288.15},{308.15,1710,1690,1690,
        1680,1670},{318.15,2170,2150,2140,2100,2080},{328.15,0,2690,2680,2630,
        2600},{333.15,0,0,2950,2920,2900}});
  annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
end VitoCal300GBWS301dotA08;
