import pymodelica
from pyfmi import load_fmu
from pymodelica import compile_fmu

fmu=compile_fmu('IDEAS.Buildings.Examples.ZoneExample', compiler_log_level='i')
model=load_fmu(fmu)
opts=model.simulate_options()
res = model.simulate(options=opts, start_time=0, final_time=1e5)

