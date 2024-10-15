within IDEAS.Buildings;
package Validation "BESTEST Validation"


extends Modelica.Icons.SensorsPackage;

/*

BESTEST Validation
==================

Following package contain a number of models for BESTEST verification of the buildings components.


IEA BESTEST
-----------

In the BESTEST project, a method was developed for systematically testing whole-building energy
simulation programs and diagnosing the sources of predictive disagreement. Field trials of the method
were conducted with a number of "reference" programs selected by the participants to represent the best
state-of-the-art detailed simulation capability available in the United States and Europe. These included
BLAST, DOE2, ESP; SERIRES, S3PAS, TASE, and TRNSYS. 

The method consists of a series of carefully specified test case buildings that progress
systematically from the extremely simple to the relatively realistic. Output values for the cases, such as
annual loads, annual maximum and minimum temperatures, annual peak loads, and some hourly data are
compared, and used in conjunction with diagnostic logic to determine the algorithms responsible for
predictive differences. The more realistic cases, although geometrically simple, test the ability of the
programs to model effects such as thermal mass, direct solar gain windows, window-shading devices,
internally generated heat. infiltration, sunspaces, earth coupling, and deadband and setback thermostat
control. The more simplified cases facilitate diagnosis by allowing excitation of certain heat-transfer
mechanisms.


Implemented cases
-----------------

- Cases 600, 600FF, 610, 620, 630, 640, 650 and 650FF are modeled in the BESTEST 600 Series.

- Cases 900, 900FF, 910, 920, 930, 940, 950 and 950FF are modeled in the BESTEST 600 Series.


Reference
=========

R.Judkoff & J.Neymark (1995). International Energy Agency Building Energy SImulation Test (BESTEST) 
and Diagnostic Method

*/






end Validation;
