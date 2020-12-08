###This module is an example julia-based testing interface.  It uses the
###``requests`` package to make REST API calls to the test case container,
###which mus already be running.  A controller is tested, which is 
###imported from a different module.  

# GENERAL PACKAGE IMPORT
# ----------------------
using HTTP, JSON, CSV, DataFrames, Dates

# TEST CONTROLLER IMPORT
# ----------------------
include("./controllers.jl")
using .sup

# SETUP TEST CASE
# ---------------
# Set URL for testcase
url = "http://127.0.0.1:5000"
length = 48 * 3600
step = 3600
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
start = Dates.now()
# Initialize test case simulation
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
       u = sup.initialize()
    else
    # Compute next control signal
       u = sup.compute_control(y)
    end
    # Advance in simulation
    res=HTTP.post("$url/advance", ["Content-Type" => "application/json"], JSON.json(u);retry_non_idempotent=true).body
    global y = JSON.parse(String(res))
end

println("Test case complete.")
time=(now()-start).value/1000.
println("Elapsed time of test was $time seconds.")

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
TRooAir  = [x-273.15 for x in res["y"]["TRooAir_y"]] # convert K --> C
CO2RooAir  = [x for x in res["y"]["CO2RooAir_y"]]
TSetRooHea   = [x-273.15 for x in res["u"]["oveTSetRooHea_u"]] # convert K --> C
TSetRooCoo   = [x-273.15 for x in res["u"]["oveTSetRooCoo_u"]] # convert K --> C
PFan  = res["y"]["PFan_y"]
PCoo  = res["y"]["PCoo_y"]
PHea  = res["y"]["PHea_y"]
PPum  = res["y"]["PPum_y"]
tab=DataFrame([time,TRooAir,CO2RooAir,TSetRooHea,TSetRooCoo,PFan,PCoo,PHea,PPum],[:time,:TRooAir,:CO2RooAir,:TSetRooHea,:TSetRooCoo,:PFan,:PCoo,:PHea,:PPum])
CSV.write("result_testcase2.csv",tab)
tab_kpi = DataFrame([[kpi["ener_tot"]], [kpi["tdis_tot"]], [kpi["idis_tot"]], [kpi["cost_tot"]], [kpi["time_rat"]], [kpi["emis_tot"]]], [:ener_tot, :tdis_tot, :idis_tot, :cost_tot, :time_rat, :emis_tot])
CSV.write("kpi_testcase2.csv",tab_kpi)
