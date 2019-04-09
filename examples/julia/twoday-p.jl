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
println("Resetting test case if needed.")
res = HTTP.put("$url/reset")

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
    res=HTTP.post("$url/advance", ["Content-Type" => "application/json"], JSON.json(u);retry_non_idempotent=true).body
    global y = JSON.parse(String(res))
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
PHeat = res["y"]["PHea_y"]
QHeat = res["u"]["oveAct_u"]
tab=DataFrame([time,TZone],[:time,:TRooAir_y])
CSV.write("result_testcase1.csv",tab)
