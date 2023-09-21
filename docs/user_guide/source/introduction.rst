==============
Introduction
==============

Purpose
=======
The goal of the Building Optimization Testing Framework (BOPTEST) is to
enable benchmarking of control strategies for building and district energy
systems, with a particular focus on heating, ventilation, and air-conditioning
(HVAC).  We believe that in doing so, we will facilitate the development and
adoption of new and improved control strategies for these systems that
will lead to cost, energy use, and carbon emission reduction for
energy infrastructures worldwide.  For example, control developers can understand
how new algorithms compare to the state-of-the-art, building owners can invest
in new control strategies with less risk knowing they have been tested, and
policy makers can set standard expectations of performance as well as invest
in further control development where needed.

Such a goal requires the use of simulation, since real buidings pose significant
operational risks for new control development and slow-changing, stochastic
operating conditions that make it difficult to perform controlled experiments
at scale.  However, simulation of realistic building and district energy systems
requires significant expertise in related physics modeling and
numerical simulation techniques and effort for development of such simulation
models fit for controls testing.  Such expertise, and corresponding resources
necessary to put forth the effort, are not shared by all stakeholders, particularly
control developers in fields outside that of building modeling and simulation.
Therefore, to be inclusive, such a goal also requires the enabling technology
to be easily accessible.

Technology
==========

BOPTEST consists of shareable, high-fidelity building emulators and boundary
conditions (so-called “test cases”) that are made rapidly and repeatably
accessible for control by test controllers through a developed
run-time environment (RTE).  The emulators themselves are modeled using validated
and well-documented Modelica [Mat97]_ component libraries for building and urban energy simulation
which extend from the Modelica IBPSA Library [Wet19]_.  Currently, those are the Modelica Buildings Library [Wet14]_
and IDEAS Library [Jor18]_.  The models are then exported using the Functional Mockup Interface (FMI) [Blo11]_
into Functional Mockup Units (FMU) for simulation within the RTE.
The use of Modelica enables the highest level of realism in
building control performance simulation to date, especially the explicit representation
of HVAC system pressure-flow networks and control logic.  The RTE is built using Python
and is deployable on local computing resources or as a public web-service
(called BOPTEST-Service) using Docker [Doc22]_.  It exposes a highly accessible HTTP
RESTful API for test subject controllers to interact with the emulators
through reading of measurement points and overwriting of control signals at
either the supervisory or local-loop (i.e. actuator) level.  The simulation
of the test cases within the RTE uses the PyFMI Python package [And16]_ for simulation
of FMUs.

For a detailed introduction and overview of BOPTEST software, see [Blu21]_.

References
----------

.. [And16] Andersson, C., Åkesson, J. and Führer, C. (2016). "PyFMI: A Python Package for Simulation of Coupled Dynamic Models with the Functional Mock-up Interface." Technical Report in Mathematical Sciences, nr. 2, vol. 2016, vol. LUTFNA-5008-2016, Centre for Mathematical Sciences, Lund University.

.. [Blo11] Blochwitz, T., Otter, M., Arnold, M., Bausch, C., Clauß, C., Elmqvist, H., Junghanns, A., Mauss, J., Monteiro, M., Neidhold, T., Neumerkel, D., Olsson, H., Peetz, J.-V., and Wolf, S. (2011). "The Functional Mockup Interface for Tool independent Exchange of Simulation Models." Proc. of the 8th International Modelica Conference. https://doi.org/10.3384/ecp11063105.

.. [Blu21]  Blum, D., Arroyo, J., Huang, S., Drgona, J., Jorissen, F., Walnum, H. T., Chen, Y., Benne, K., Vrabie, D., Wetter, M., and Helsen, L. (2021). “Building Optimization Testing Framework (BOPTEST) for Simulation-Based Benchmarking of Control Strategies in Buildings.” Journal of Building Performance Simulation, 14(5), 586-610. https://doi.org/10.1080/19401493.2021.1986574.

.. [Doc22] Docker. Available at https://www.docker.com/.

.. [Jor18] Jorissen, F., Reynders, G., Baetens, R., Picard, D., Saelens, D., and Helsen, L. (2018). “Implementation and Verification of the IDEAS Building Energy Simulation Library.” Journal of Building Performance Simulation, 11 (6), 669-688. https://doi.org/10.1080/19401493.2018.1428361.

.. [Mat97] Mattsson, S. E., and Elmqvist, H. (1997). "Modelica - An International Effort to Design the Next Generation Modeling Language." IFAC Proceedings Volumes, 30(4), 151–155. https://doi.org/10.1016/S1474-6670(17)43628-7.

.. [Wet14] Wetter, M., Zuo, W., Nouidui, T. S., and Pang, X. (2014). "Modelica Buildings library." Journal of Building Performance Simulation, 7(4):253-270. https://doi.org/10.1080/19401493.2013.765506.

.. [Wet19] Wetter, M., van Treeck, C., Helsen, L., Maccarini, A., Saelens, D., Robinson, D., and Schweiger, G. (2019). "IBPSA Project 1: BIM/GIS and Modelica framework for building and community energy system design and operation - ongoing developments, lessons learned and challenges." IOP Conference Series: Earth and Environmental Science, Vol. 323, p. 012114, September.
