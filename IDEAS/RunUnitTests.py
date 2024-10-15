#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Jul 18 18:29:36 2013

@author: u0088104
"""

import buildingspy as BP
import buildingspy.development.regressiontest as r
import os
import sys
# sys.path.append("E:\work\python\BuildingsPy")

import buildingspy as BP
import buildingspy.development.regressiontest as rt



"""
 If this file is not ran from the Modelicalibrary home directory (which 
 contains the package.mo-file) Set working directory to that directory.
 The working directory is copied to a temp directory where the simulations are
 run. Output from the temperorary directories is gathered and stored in the current 
 directory under dymola.log. 
"""
# os.chdir("E:\work\modelica\IDEAS\IDEAS")

tester=r.Tester()

""" number of parallel processes started."""
#tester.setSinglePackage("IDEAS.Fluid.Geothermal")
#tester.setNumberOfThreads(2)

""" Html validation on/off"""
# tester.validate_html = False

""" Run the unittest
Outputs will be rendered"""
tester.run()
