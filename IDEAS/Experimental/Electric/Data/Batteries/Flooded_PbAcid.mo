within IDEAS.Experimental.Electric.Data.Batteries;
record Flooded_PbAcid = IDEAS.Experimental.Electric.Data.Interfaces.BatteryType
    (
    eta_in=0.95,
    eta_out=0.98,
    eta_c=0.82,
    eta_d=1,
    alpha_sd=0.05,
    e_c=0.1,
    e_d=1) "Flooded PbAcid";
