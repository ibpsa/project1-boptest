within IDEAS.Experimental.Electric.Data.Batteries;
record LiIon = IDEAS.Experimental.Electric.Data.Interfaces.BatteryType (
    eta_in=0.95,
    eta_out=0.98,
    eta_c=0.92,
    eta_d=1,
    alpha_sd=0.03,
    e_c=10,
    e_d=20) "Li-ion";
