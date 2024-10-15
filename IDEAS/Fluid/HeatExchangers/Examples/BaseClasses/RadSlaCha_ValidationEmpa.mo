within IDEAS.Fluid.HeatExchangers.Examples.BaseClasses;
record RadSlaCha_ValidationEmpa "According to Koschenz, 2000, par 4.5.1"
  extends IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.RadiantSlabChar(
    T=0.25,
    d_a=0.02,
    s_r=0.0025,
    n1=10,
    n2=10,
    lambda_r=0.55);
end RadSlaCha_ValidationEmpa;
