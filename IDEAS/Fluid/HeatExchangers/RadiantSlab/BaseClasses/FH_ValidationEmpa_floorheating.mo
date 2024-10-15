within IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses;
record FH_ValidationEmpa_floorheating "According to Koschenz, 2000, par 4.5.1"
  extends IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.RadiantSlabChar(
    tabs=false,
    T=0.225,
    d_a=0.016,
    s_r=0.002,
    S_1=0.065,
    S_2=0.008001,
    n1=10,
    n2=10,
    lambda_r=0.035,
    lambda_b=0.6,
    lambda_i=0.036,
    d_i=0.05);
end FH_ValidationEmpa_floorheating;
