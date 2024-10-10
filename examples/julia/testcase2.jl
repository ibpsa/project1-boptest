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
url = "http://127.0.0.1:80"
length = 48 * 3600
step = 3600
# ---------------

# GET TEST INFORMATION
# --------------------
println("TEST CASE INFORMATION ------------- \n")
# Test id
res = HTTP.post("$url/testcases/testcase2/select")
testid = JSON.parse(String(res.body))["testid"]
testid_status = res.status
if testid_status == 200
    println("TestID:\t\t\t$testid")
end
# Test case name
res = HTTP.get("$url/name/$testid")
name_status = res.status
name = JSON.parse(String(res.body))["payload"]
if name_status == 200
    println("Name:\t\t\t$name['name']")
end
# Inputs available
res = HTTP.get("$url/inputs/$testid")
inputs_status = res.status
inputs = JSON.parse(String(res.body))["payload"]
if inputs_status == 200
    println("Control Inputs:\t\t\t$inputs")
end
# Measurements available
res = HTTP.get("$url/measurements/$testid")
measurements_status = res.status
measurements = JSON.parse(String(res.body))["payload"]
if measurements_status == 200
    println("Measurements:\t\t\t$measurements")
end

# Default simulation step
res = HTTP.get("$url/step/$testid")
step_def_status = res.status
step_def = JSON.parse(String(res.body))["payload"]
if step_def_status == 200
    println("Default Simulation Step:\t$step_def")
end

# RUN TEST CASE
#----------
start = Dates.now()
# Initialize test case simulation
res = HTTP.put("$url/initialize/$testid",["Content-Type" => "application/json"], JSON.json(Dict("start_time" => 0,"warmup_period" => 0)))
initialize_status = res.status
initialize_result=JSON.parse(String(res.body))["payload"]
if initialize_status == 200
   println("Successfully initialized the simulation")
end



# Set simulation step

res = HTTP.put("$url/step/$testid",["Content-Type" => "application/json"], JSON.json(Dict("step" => step)))
if res.status == 200
   println("Setting simulation step to $step")
end

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
    res = HTTP.post("$url/advance/$testid", ["Content-Type" => "application/json"], JSON.json(u);retry_non_idempotent=true)
	global y = JSON.parse(String(res.body))["payload"]
	if res.status == 200
        println("Successfully advanced the simulation")
    end
end

println("Test case complete.")
time=(now()-start).value/1000.
println("Elapsed time of test
 was $time seconds.")

# VIEW RESULTS
# ------------
# Report KPIs
res = HTTP.get("$url/kpi/$testid")
if  res.status == 200
   kpi = JSON.parse(String(res.body))["payload"]
end
println("KPI RESULTS \n-----------")
for key in keys(kpi)
   if isnothing(kpi[key])
       println("$key: nothing")
   else
       println("$key: $(kpi[key])")
   end
end

# ------------
# POST PROCESS RESULTS
# --------------------
# Get result data
res = JSON.parse(String(HTTP.put("$url/results/$testid", ["Content-Type" => "application/json","connecttimeout"=>30.0], JSON.json(Dict("point_names" => ["TRooAir_y"],"start_time" => 0, "final_time" => length));retry_non_idempotent=true).body))["payload"]
time = [x/3600 for x in res["time"]] # convert s --> hr
TRooAir  = [x-273.15 for x in res["TRooAir_y"]] # convert K --> C
res = JSON.parse(String(HTTP.put("$url/results/$testid", ["Content-Type" => "application/json","connecttimeout"=>30.0], JSON.json(Dict("point_names" => ["CO2RooAir_y"],"start_time" => 0, "final_time" => length));retry_non_idempotent=true).body))["payload"]
CO2RooAir  = [x for x in res["CO2RooAir_y"]]
res = JSON.parse(String(HTTP.put("$url/results/$testid", ["Content-Type" => "application/json","connecttimeout"=>30.0], JSON.json(Dict("point_names" => ["oveTSetRooHea_u"],"start_time" => 0, "final_time" => length));retry_non_idempotent=true).body))["payload"]
TSetRooHea   = [x-273.15 for x in res["oveTSetRooHea_u"]] # convert K --> C
res = JSON.parse(String(HTTP.put("$url/results/$testid", ["Content-Type" => "application/json","connecttimeout"=>30.0], JSON.json(Dict("point_names" => ["oveTSetRooCoo_u"],"start_time" => 0, "final_time" => length));retry_non_idempotent=true).body))["payload"]
TSetRooCoo   = [x-273.15 for x in res["oveTSetRooCoo_u"]] # convert K --> C
res = JSON.parse(String(HTTP.put("$url/results/$testid", ["Content-Type" => "application/json","connecttimeout"=>30.0], JSON.json(Dict("point_names" => ["PFan_y"],"start_time" => 0, "final_time" => length));retry_non_idempotent=true).body))["payload"]
PFan  = res["PFan_y"]
res = JSON.parse(String(HTTP.put("$url/results/$testid", ["Content-Type" => "application/json","connecttimeout"=>30.0], JSON.json(Dict("point_names" => ["PCoo_y"],"start_time" => 0, "final_time" => length));retry_non_idempotent=true).body))["payload"]
PCoo  = res["PCoo_y"]
res = JSON.parse(String(HTTP.put("$url/results/$testid", ["Content-Type" => "application/json","connecttimeout"=>30.0], JSON.json(Dict("point_names" => ["PHea_y"],"start_time" => 0, "final_time" => length));retry_non_idempotent=true).body))["payload"]
PHea  = res["PHea_y"]
res = JSON.parse(String(HTTP.put("$url/results/$testid", ["Content-Type" => "application/json","connecttimeout"=>30.0], JSON.json(Dict("point_names" => ["PPum_y"],"start_time" => 0, "final_time" => length));retry_non_idempotent=true).body))["payload"]
PPum  = res["PPum_y"]
tab=DataFrame([time,TRooAir,CO2RooAir,TSetRooHea,TSetRooCoo,PFan,PCoo,PHea,PPum],[:time,:TRooAir,:CO2RooAir,:TSetRooHea,:TSetRooCoo,:PFan,:PCoo,:PHea,:PPum])
CSV.write("result_testcase2.csv",tab)
tab_kpi = DataFrame([[kpi["ener_tot"]], [kpi["tdis_tot"]], [kpi["idis_tot"]], [kpi["cost_tot"]], [kpi["time_rat"]], [kpi["emis_tot"]],[kpi["pele_tot"]]], [:ener_tot, :tdis_tot, :idis_tot, :cost_tot, :time_rat, :emis_tot, :pele_tot])
CSV.write("kpi_testcase2.csv",tab_kpi)

# SHUT DOWN TEST CASE
# -------------------------------------------------------------------------
res = HTTP.put("$url/stop/$testid")
if  res.status == 200
    println("Done shutting down test case.")
else
    println("Error shutting down test case.")
end