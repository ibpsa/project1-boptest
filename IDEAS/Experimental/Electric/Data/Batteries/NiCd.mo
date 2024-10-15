within IDEAS.Experimental.Electric.Data.Batteries;
record NiCd = IDEAS.Experimental.Electric.Data.Interfaces.BatteryType (
    eta_in=0.95,
    eta_out=0.98,
    eta_c=0.65,
    eta_d=1,
    alpha_sd=0.05,
    e_c=10,
    e_d=10) "NiCd";
