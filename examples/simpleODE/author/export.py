##########################################################################
# Script to simulate Modelica models with JModelica.
#
##########################################################################
# Import the function for compilation of models and the load_fmu method
import pymodelica

if __name__=="__main__":
    # Increase memory
    pymodelica.environ['JVM_ARGS'] = '-Xmx4096m'
    fmu_name = pymodelica.compile_fmu("TestOverWrite.ExportedModel",
                                      version="2.0",
                                      compiler_log_level='warning',
                                      compiler_options = {"generate_html_diagnostics" : False})
