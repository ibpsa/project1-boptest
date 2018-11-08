##########################################################################
# Script to simulate Modelica models with Dymola.
#
##########################################################################
from buildingspy.simulate.Simulator import Simulator
s = Simulator("TestFMU", "dymola")
#s.showGUI()
#s.exitSimulator(False)
s.simulate()
