Core KPI Specification and Calculation
======================================

Core KPIs
------------

The following KPI definitions constitute the core KPIs to be calculated
in every test case, and documentation of the KPI considered during the
development phase is provided in the Appendix (See :ref:`SecAppKpi`).
During the IBPSA expert meetings, these core KPIs have been selected as the most
representative and relevant indicators to compare different control
approaches for buildings. Additional KPIs may be calculated and used for
specific purposes, but the core KPIs are considered the basis for
assessing the performance of a controller. The definitions consist of a
description, mathematical formula for quantification, and KPI tagging
notation.  Note that floor areas used for normalization are calculated
according to the definitions of the
Commercial Buildings Energy Consumption Survey (see https://www.eia.gov/consumption/commercial/terminology.php)
and Residential Energy Consumption Survey (see https://www.eia.gov/consumption/residential/reports/2015/squarefootage/).

Thermal discomfort in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   The thermal discomfort is the integral of the deviation of the
   temperature with respect to a predefined comfort range during a
   given period of time averaged over all zones.
   The units are :math:`K.h/zone` and is quantified as:

   .. math:: D(t_0, t_f) = \frac{\sum_z^N \int_{t_0}^{t_f} \left \|s_z (t) \right \| dt}{N}

   Where :math:`D(t_0, t_f)` is the total discomfort between the initial
   time :math:`t_0` and the final time :math:`t_f`; :math:`z` is the zone index out
   of :math:`N` zones in the building; :math:`s_z(t)` is the
   deviation (slack) from the lower and upper set point temperatures
   established in zone :math:`z`.

Energy use in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   This KPI is the measure of the site HVAC energy use in :math:`kWh/m^2`
   when accounting for the sum of all energy vectors present in the test
   case HVAC system. Each test case determines the energy vectors and conversion factors
   necessary for HVAC (heating, cooling, fans, pumps).
   The mathematical formulation for this KPI is the following:

   .. math:: E(t_0, t_f) = \frac{\sum_{i\in \xi} \int_{t=t_0}^{t=t_f}\ P_i(t) dt}{A}

   Where :math:`E(t_0, t_f)` is the total amount of energy use from the
   initial time :math:`t_0` up to the final time :math:`t_f`; :math:`\xi` denotes
   the set of equipment in the system with an associated energy use of
   any type; finally, :math:`P_i` is the instantaneous power used by the
   energy vector :math:`i`; :math:`A` is the total floor area of the building.

Peak electricity demand in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   This KPI is the measure of the site HVAC peak electricity use in :math:`kW/m^2`
   when accounting for the sum of all electrical equipment present in the test
   case HVAC system.
   The mathematical formulation for this KPI is the following:

   .. math:: P_E(t_0, t_f) = \frac{\max_{15}[\sum_{i\in I} P_i(t)]}{A}

   Where :math:`P_E(t_0, t_f)` is the peak electricity demand from the
   initial time :math:`t_0` up to the final time :math:`t_f`; :math:`I` denotes
   the set of equipment in the system with an associated energy use of
   electricity; :math:`P_i` is the instantaneous power used by the
   equipment :math:`i`; :math:`A` is the total floor area of the building; and
   :math:`max_{15}[]` indicates the maximum value after taking the average of each 15 minute interval.

Peak gas demand in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   This KPI is the measure of the site HVAC peak gas use in :math:`kW/m^2`
   when accounting for the sum of all gas equipment present in the test
   case HVAC system.
   The mathematical formulation for this KPI is the following:

   .. math:: P_G(t_0, t_f) = \frac{\max_{15}[\sum_{i\in I} P_i(t)]}{A}

   Where :math:`P_G(t_0, t_f)` is the peak gas demand from the
   initial time :math:`t_0` up to the final time :math:`t_f`; :math:`I` denotes
   the set of equipment in the system with an associated energy use of
   gas; :math:`P_i` is the instantaneous power used by the
   equipment :math:`i`; :math:`A` is the total floor area of the building; and
   :math:`max_{15}[]` indicates the maximum value after taking the average of each 15 minute interval.

Peak district heating demand in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   This KPI is the measure of the site HVAC peak district heating use in :math:`kW/m^2`
   when accounting for the sum of all district heating equipment present in the test
   case HVAC system.
   The mathematical formulation for this KPI is the following:

   .. math:: P_{DH}(t_0, t_f) = \frac{\max_{15}[\sum_{i\in I} P_i(t)]}{A}

   Where :math:`P_{DH}(t_0, t_f)` is the peak district heating demand from the
   initial time :math:`t_0` up to the final time :math:`t_f`; :math:`I` denotes
   the set of equipment in the system with an associated energy use of
   district heating; :math:`P_i` is the instantaneous power used by the
   equipment :math:`i`; :math:`A` is the total floor area of the building; and
   :math:`max_{15}[]` indicates the maximum value after taking the average of each 15 minute interval.

CO2 emissions in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   This KPI is the measure of the amount of source CO2 emissions in
   :math:`kgCO_2/m^2` when accounting for the sum of all energy vectors in the test
   case HVAC system, each using an emission factor profile based on the source of energy.
   The emission factors are to be related with the energy mix associated with
   the location of the test case building. According to this, the
   CO2 emissions are calculated as:

   .. math:: \epsilon (t_0, t_f) = \frac{\sum_{i\in \xi} \int_{t=t_0}^{t=t_f}e_i(t)P_i(t) dt}{A}

   Where :math:`\epsilon (t_0, t_f)` is the equivalent total amount of CO2
   emissions during the period of time between :math:`t_0` and :math:`t_f`.
   :math:`e_i` is the emission factor of component :math:`i` and has units of
   :math:`kgCO_2/kWh`; :math:`A` is the total floor area of the building.

Operational cost in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   This KPI is the measure of the HVAC operational cost in :math:`\$/m^2` when
   accounting for the sum of all energy vectors in the test case HVAC system,
   each using a price profile based on the source of energy and given tariff
   archetype.  Three tariff archetypes are defined:
   constant, moderately dynamic (e.g. day/peak and night/off-peak pricing),
   and highly dynamic (e.g. real-time pricing).

   .. math:: C^\tau(t_0, t_f) = \frac{\sum_{i\in \xi}\int_{t=t_0}^{t=t_f}p_i^\tau(t) P_i(t) dt}{A}

   Where :math:`C^\tau(t_0, t_f)` is the total cost during the period
   between time :math:`t_0` and :math:`t_f` with a tariff :math:`\tau`; :math:`p_i^\tau`
   is the price profile of equipment :math:`i` with a tariff :math:`\tau` and
   has units of :math:`\$/kWh`; :math:`A` is the total floor area of the building.

Indoor air quality violation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   The indoor air quality violation is the integral of the deviation of the
   CO2 concentration above a predefined threshold during a
   given period of time averaged over all zones.  The units are :math:`ppm.h/m^2` and is
   quantified as:

   .. math:: \Phi(t_0, t_f) = \frac{\sum_{z\in \mathbb{Z}} \int_{t_0}^{t_f} \phi_z(t) dt}{N}

   .. math:: \phi_z(t)=\gamma_z(t)-\gamma_{r,z}(t), \quad if \quad\gamma_z(t)>\gamma_{r,z}(t)

   .. math:: \phi_z(t)=0, \quad if \quad \gamma_z(t) \leq \gamma_{r,z}(t)

   Where
   :math:`\Phi` is the total violation of carbon dioxide CO2
   concentration in :math:`ppmh` between the initial time :math:`t_0` and the final
   time :math:`t_f`. :math:`z` is the zone index out
   of :math:`N` zones in the building. :math:`\phi_z` is the deviation of measured
   zone CO2 concentration :math:`\gamma_z` from the zone CO2 concentration
   threshold :math:`\gamma_{r,z}`.

Computational time ratio
~~~~~~~~~~~~~~~~~~~~~~~~

   The computational time at simulation step :math:`k`, :math:`t_c(k)`, is the real time
   required by the controller to compute the control inputs between simulation
   steps :math:`k` and :math:`k-1`.  It needs to be shorter than the duration of the
   simulation step of that iteration, :math:`T_s(k)`.
   The ratio between :math:`t_c(k)` and :math:`T_s(k)` helps indicate the
   practicality of the controller as well as potential for increasing
   computational time.  This is called the computational time ratio.

   As the computational time and the simulation step duration may not be the
   same for every simulation step, an average of the computational time ratio from
   all of the simulation steps that take place between the initial time :math:`t_0`
   and the final time :math:`t_f` for which this KPI is calculated. Thus,
   the computational time ratio is computed as follows:

   .. math:: t(t_0,t_f) = \frac{\sum_{k=1}^{n}\frac{t_c(k)}{T_s(k)}}{n}

   Where :math:`n` is the number of simulation steps that take place between
   :math:`t_0` and :math:`t_f`.

Actuator travel
~~~~~~~~~~~~~~~~~~~~~~~~

   The actuator travel quantifies the overall movement of HVAC system actuators.
   This measure is important to assess the wear and tear of the equipment, 
   because frequent and erratic switching of control
   signals can lead to equipment damages and shorter equipment lifespan. 

   We use displacement, which measures the total distance the actuator travels 
   in its control signal over the entire evaluation period. 
   This metric is calculated by integrating the absolute value of the rate of change
   of the actuator position :math:`y(t)`, and is both straightforward to compute and
   independent of arbitrary thresholds. The displacement is defined as follows:

   .. math:: D = \int_{t_0}^{t_f} \left| y'(t) \right| \, dt

   where :math:`D` represents the displacement over the time period
   :math:`[t_0, t_f]`. :math:`y'(t)` is the time derivative of actuator position
   :math:`y(t)`, representing the rate of change in position.
   
   To compute the final KPI value across multiple actuators, the average displacement is used:  

   .. math::  D_\text{avg} = \frac{1}{N} \sum_{i=1}^{N} D_i  

   where :math:`N` is the number of actuators and :math:`D_i` is the displacement of actuator :math:`i`.  
   
Installation metrics
~~~~~~~~~~~~~~~~~~~~

   The installation metrics refer to the effort and cost required to get
   the controller settled and running. Many aspects play a role in this
   sense. They are intrinsically subjective and therefore require
   qualitative measures. Therefore, these metrics are provided by the
   controller developer in the form of a simple score
   according to the following categories.  These categories may be refined in
   the future.

.. csv-table:: Installation Metrics
   :file: tables/installation_metrics.csv
   :class: longtable
   :widths: 30,20,20,20,20,20,20
   :align: left

Maximum allowed capital cost
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   The maximum allowed capital cost is the installation cost that would
   lead to a maximum payback period of 5 years. The reason to calculate
   the maximum allowed capital cost instead of the payback period
   directly is because of the subjectiveness associated with the
   installation metrics. The qualitative nature of the installation
   metrics could hamper the quantification of the payback period. On the
   contrary, the maximum allowed capital cost to obtain a fixed payback
   period of 5 years can be objectively quantified if a baseline
   controller is established as a reference. First, the operational
   savings per year are calculated as:

   .. math:: S_{1 year} = C_{1 year}^{old}-C_{1 year}^{new}

   These savings are computed as the difference between the operational
   cost of the old controller (the baseline) and the new controller.
   Notice the way to calculate these costs is the same as defined in the
   total operational cost KPI defined before for a given time period of
   one year and the selected tariff. The maximum allowed capital cost
   for the controller to get a payback period of 5 years is then
   calculated as:

   .. math:: CAPEX_{max}^{5 years} = 5 S_{1 year}

   The judgement of whether it is worth to install the new controller
   relies on the BOPTEST user, who can use the objective quantification
   of this KPI to take the decision.

Calculation Module
---------------------

A KPI calculation module is implemented that calculates the core KPIs
during the test case simulation by computing KPIs on the fly in order to
provide feedback to the controller or only for informative purposes.
Upon deployment of the test case, the module first use the KPI JSON
(kpis.json) to associate model output names with the appropriate KPIs
through the specified KPI annotations.
