within IDEAS.Airflow.AHU.BaseClasses;
record Adsolair14200
  "Adsolair type 58 parameters for a unit with a nominal volumetric flow rate of 14200 m3/h"
  extends IDEAS.Airflow.AHU.BaseClasses.AdsolairData(
    pressure(V_flow={5423,7537,9958,12256,14857,17121,19042,20649}/3600, dp={
          1385,1350,1290,1195,1021,838,653,470}),
    hydraulicEfficiency(V_flow={5341,6743,9230,11651,14412,17383,20235}/3600,
        eta={0.45,0.51,0.6,0.72,0.7,0.72,0.6}),
    motorEfficiency(V_flow={5341,20235}/3600, eta={0.887,0.887}),
    use_powerCharacteristic=false,
    speed_rpm_nominal=1800,
    m1_flow_nominal=4.69,
    m2_flow_nominal=4.69,
    dT_compressor=37.1 - 10.8,
    G_condensor=46700/(37.1 - 35.2),
    G_evaporator=40400/(16.7 - 10.8),
    fraPmin=0.1,
    N_top=1726,
    N_bottom=1774,
    Kv_3wayValveHeater=6.3,
    m_flow_3way_nominal=1660/3600,
    epsHeating=0.53,
    m1_flow_nominal_heater=13775/3600*(101300/287/(273.15 + 15.6)),
    m2_flow_nominal_heater=2150/3600,
    dp1_nominal_heater=33,
    dp2_nominal_heater=4200,
    epsCooling=0.497,
    m1_flow_nominal_cooler=13507/3600*(101300/287/(273.15 + 8)),
    m2_flow_nominal_cooler=3520/3600,
    dp1_nominal_cooler=55,
    dp2_nominal_cooler=4700,
    dp_nominal_top=dp_filter_dumped,
    dp_nominal_bottom=dp_filter_fresh + dp_filter_pulsion + dp1_nominal_heater
         + dp1_nominal_cooler,
    dp_nominal_top_recup=(211 + dp_condenser),
    dp_nominal_bottom_recup=197 + dp_evaporator,
    dp_adiabatic=60,
    eps_adia_on=0.9,
    eps_adia_off=0.79,
    A_dam_byp_top=w_unit*w_blade*2,
    A_dam_rec_top=w_unit*w_blade*8,
    A_dam_byp_bot=w_unit*w_blade*4,
    A_dam_rec_bot=w_unit*w_blade*7,
    A_byp_top_min=A_dam_byp_top,
    A_byp_bot_min=0.15*w_unit,
    UA_adia_on=14000,
    UA_adia_off=23000);
  constant Modelica.SIunits.Pressure dp_filter_fresh = 33;
  constant Modelica.SIunits.Pressure dp_filter_pulsion = 70;
  constant Modelica.SIunits.Pressure dp_filter_dumped = 46;
  constant Modelica.SIunits.Pressure dp_evaporator = 63;
  constant Modelica.SIunits.Pressure dp_condenser = 76;
  constant Modelica.SIunits.Length w_unit = 1.7 "Unit width";
  constant Modelica.SIunits.Length w_blade = 1.2/10 "Width single damper blade";
  annotation (Documentation(revisions="<html>
<ul>
<li>
October 11, 2016, by Filip Jorissen:<br/>
Added first implementation.
</li>
</ul>
</html>"));
end Adsolair14200;
