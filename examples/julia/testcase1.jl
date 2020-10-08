###This module is an example julia-based testing interface.  It uses the
###``requests`` package to make REST API calls to the test case container,
###which mus already be running.  A controller is tested, which is 
###imported from a different module.  


# GENERAL PACKAGE IMPORT
# ----------------------
using HTTP, JSON, CSV, DataFrames

# TEST CONTROLLER IMPORT
# ----------------------
include("./controllers.jl")
using .PID

# SETUP TEST CASE
# ---------------
# Set URL for testcase
url = "http://127.0.0.1:5000"
length = 48 * 3600
step = 300
# ---------------

# GET TEST INFORMATION
# --------------------
println("TEST CASE INFORMATION ------------- \n")
# Test case name
name = JSON.parse(String(HTTP.get("$url/name").body))
println("Name:\t\t\t$name")
# Inputs available
inputs = JSON.parse(String(HTTP.get("$url/inputs").body))
println("Control Inputs:\t\t\t$inputs")
# Measurements available
measurements = JSON.parse(String(HTTP.get("$url/measurements").body))
println("Measurements:\t\t\t$measurements")
# Default simulation step
step_def = JSON.parse(String(HTTP.get("$url/step").body))
println("Default Simulation Step:\t$step_def")

# RUN TEST CASE
#----------
println("Initializing test case simulation.")
res = HTTP.put("$url/initialize",["Content-Type" => "application/json"], JSON.json(Dict("start_time" => 0,"warmup_period" => 0)))
initialize_result=JSON.parse(String(res.body))
if !isnothing(initialize_result)
   println("Successfully initialized the simulation")
end

# Set simulation step
println("Setting simulation step to $step")
res = HTTP.put("$url/step",["Content-Type" => "application/json"], JSON.json(Dict("step" => step)))
println("Running test case ...")


# simulation loop
for i = 1:convert(Int, floor(length/step))
    if i<2
    # Initialize u
       u = PID.initialize()
    else
    # Compute next control signal
       u = PID.compute_control(y)
    end
    # Advance in simulation
    global y = JSON.parse(String(HTTP.post("$url/advance", ["Content-Type" => "application/json","connecttimeout"=>30.0], JSON.json(u);retry_non_idempotent=true).body))

end
println("Test case complete.")

# VIEW RESULTS
# ------------
# Report KPIs
kpi = JSON.parse(String(HTTP.get("$url/kpi").body))
println("KPI RESULTS \n-----------")
for key in keys(kpi)
   println("$key: $(kpi[key])")
end

# ------------
# POST PROCESS RESULTS
# --------------------
# Get result data
res = JSON.parse(String(HTTP.get("$url/results").body))
time = [x/3600 for x in res["y"]["time"]] # convert s --> hr
TZone = [x-273.15 for x in res["y"]["TRooAir_y"]] # convert K --> C
CO2Zone = [x for x in res["y"]["CO2RooAir_y"]]
PHeat = res["y"]["PHea_y"]
QHeat = res["u"]["oveAct_u"]
uAct = res["u"]["oveAct_activate"]
tab_res=DataFrame([time,TZone,CO2Zone,PHeat,QHeat,uAct],[:time,:TRooAir_y,:CO2RooAir_y,:PHea_y,:oveAct_u,:oveAct_activate])
CSV.write("result_testcase1.csv",tab_res)
tab_kpi = DataFrame([[kpi["ener_tot"]], [kpi["tdis_tot"]], [kpi["idis_tot"]], [kpi["cost_tot"]], [kpi["time_rat"]], [kpi["emis_tot"]]], [:ener_tot, :tdis_tot, :idis_tot, :cost_tot, :time_rat, :emis_tot])
CSV.write("kpi_testcase1.csv",tab_kpi)
