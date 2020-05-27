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
notation.

Thermal discomfort in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   The thermal discomfort is the integral of the deviation of the
   temperature with respect to a predefined comfort range during a
   given period of time.  The units are :math:`Kh` and is
   quantified as:

   .. math:: D(t_0, t_f) = \sum_{z\in \mathbb{Z}} \int_{t_0}^{t_f} \left \|s_z (t) \right \| dt

   Where :math:`D(t_0, t_f)` is the total discomfort between the initial
   time :math:`t_0` and the final time :math:`t_f`; :math:`z` is the zone index for
   the set of zones in the building :math:`\mathbb{Z}`; :math:`s_z(t)` is the
   deviation (slack) from the lower and upper set point temperatures
   established in zone :math:`z`.

Total building energy use in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   This KPI is the measure of the total building site energy use in :math:`kWh`
   when accounting for the sum of all energy vectors present in the test
   case building. Each test case determines the energy vectors and conversion factors
   necessary for HVAC (heating, cooling, fans, pumps), lighting, etc. 
   The mathematical formulation for this KPI is the following:

   .. math:: E(t_0, t_f) = \sum_{i\in \xi} \int_{t=t_0}^{t=t_f}\ P_i(t) dt

   Where :math:`E(t_0, t_f)` is the total amount of energy use from the
   initial time :math:`t_0` up to the final time :math:`t_f`; :math:`\xi` denotes
   the set of equipment in the system with an associated energy use of
   any type; finally, :math:`P_i` is the instantaneous power used by the
   energy vector :math:`i`.

Total Building CO2 emissions in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   This KPI is the measure of the total amount of source CO2 emissions in 
   :math:`kg` when accounting for the sum of all energy vectors in the test
   case building, each using an emission factor profile based on the source of energy. 
   The emission factors are to be related with the energy mix associated with 
   the location of the test case building. According to this, the total 
   amount of CO2 emissions are calculated as:

   .. math:: \epsilon (t_0, t_f) = \sum_{i\in \xi} \int_{t=t_0}^{t=t_f}e_i(t)P_i(t) dt 

   Where :math:`\epsilon (t_0, t_f)` is the equivalent total amount of CO2
   emissions during the period of time between :math:`t_0` and :math:`t_f`.
   :math:`e_i` is the emission factor of component :math:`i` and has units of
   :math:`kg_{CO_2}/kW`.

Total operational cost in a given period of time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   This KPI is the measure of the total operational cost in :math:`\$` when 
   accounting for the sum of all energy vectors in the test case building, 
   each using a price profile based on the source of energy and given tariff 
   archetype.  Three tariff archetypes are defined:
   constant, moderately dynamic (e.g. day/peak and night/off-peak pricing), 
   and highly dynamic (e.g. real-time pricing).

   .. math:: C^\tau(t_0, t_f) = \sum_{i\in \xi}\int_{t=t_0}^{t=t_f}p_i^\tau(t) P_i(t) dt

   Where :math:`C^\tau(t_0, t_f)` is the total cost during the period
   between time :math:`t_0` and :math:`t_f` with a tariff :math:`\tau`; :math:`p_i^\tau`
   is the price profile of equipment :math:`i` with a tariff :math:`\tau` and
   has units of :math:`\$/kW`.

Capability of the controller to steer flexibility
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   A controller capable to estimate and steer the flexibility available
   in a building supposes an added value since it would be able to
   provide ancillary services to the grid. However, the estimation of
   this KPI is particularly challenging because of the dependency of
   flexibility on the previous actions and on the current estate. For
   this reason, BOPTEST is focused on quantifying how good a controller
   is able to follow an artificial external signal within a predefined
   scenario where boundary conditions are given. In this test, the
   controller is stressed to modify the behavior of the building
   according to such signal.

   It is worth noting that we are evaluating the capability of the
   controller to steer flexibility, and not the quantity of flexibility
   available in the building. The latter is a property of the building
   itself, while we are interested in evaluating the controller.

   TO BE DISCUSSED.

-  The variable used as external signal could be:

   -  Real price profile. I guess this is the most logic since is what
      an aggregator would normally use to communicate with the
      buildings.

   -  Virtual price profile.

   -  Imposed energy use.

   -  Imposed temperature setpoint.

   -  Share of renewable energies.

-  The shape used as external signal could be:

   -  Step.

   -  Variable profile over a day.

-  There are different possible parameters to be measured out of the
   response of the building. These could be:

   -  Amount of electrical energy that the building deviates from a
      baseline during the requested flexibility period. It is important
      to account here for the rebound factor.

   -  Time constant: in case of imposed setpoint and step signal, the
      period of time that the controller needs to reach a percentage of
      the setpoint.

Installation metrics
~~~~~~~~~~~~~~~~~~~~

   The installation metrics refer to the effort and cost required to get
   the controller settled and running. Many aspects play a role in this
   sense. They are intrinsically subjective and therefore require
   qualitative measures. Moreover, these metrics are provided by the
   client who should specify within the following categories:

.. csv-table:: Installation Metrics
   :file: tables/installation_metrics.csv
   :class: longtable
   :widths: 30,20,20,20,20,20

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

Computational time ratio
~~~~~~~~~~~~~~~~~~~~~~~~

   The computational time at iteration :math:`k`, :math:`t_c(k)` is the time
   required by the controller to compute the inputs to control the
   building during that iteration. It needs to be shorter than the
   building-system sampling time period of that iteration, :math:`T_s(k)`.
   This sampling time is the real time lapse between two instants where
   the control input signal is computed and applied in the building. The
   ratio between both indicates the percentage of sampling time used by
   the controller to compute the inputs. In this sense, the
   computational time ratio is a good indicator of the scalability of
   the controller since explains the time left every sampling period
   that could be used to increase the controller complexity.

   As the computational time and the sampling time period may not be the
   same for every iteration, an average of these variables is used with
   all the iterations that take place between the initial time :math:`t_0`
   and the final time :math:`t_f` for which this KPI is calculated. Thus,
   the computational time ratio is computed as follows:

   .. math:: t(t_0,t_f) =\frac{\frac{\sum_{k=1}^{n}t_c(k)}{n}}{\frac{\sum_{k=1}^{n}T_s(k)}{n}}= \sum_{k=1}^{n}\frac{t_c(k)}{T_s(k)}

   Where :math:`n` is the number of iterations that take place between
   :math:`t_0` and :math:`t_f`.

Indoor air quality indicator 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   Indoor air quality (IAQ) is always a critical factor in the indoor
   environment that directly relates to occupant health, comfort, and
   productivity. Accurate evaluation of IAQ requires a set of
   measurements of the typical indoor air pollutants (such as
   Particulate Matter (*PM*), Volatile Organic Compounds (*VOCs*),
   Nitrogen Dioxide (*NO\ 2*), Formaldehyde, Radon (*Rn*), Biological
   Pollutants). Direct measurement of those pollutants are typically
   costly and physical modeling of those pollutants in the indoor
   environment are not well established. As a result, an alternative
   path is used to evaluate the IAQ by measuring the amount of fresh air
   via *CO\ 2*-based evaluation. From the perspective of building HVAC
   system operation and control, IAQ related control actions include
   controlling the ratio of fresh air intake and modifying the
   ventilation rate. Increasing the ventilation rate was found to be
   associated with reducing sick building syndrome symptoms. ASHRAE
   Standard 62.1 has setup the minimum requirement for fresh air intake.
   To evaluate if this requirement has been met, it can be directly
   calculated by measuring outside air flow rate, recirculating air flow
   rate, occupant numbers, and building area. This can be also
   indirectly estimated by measuring carbon dioxide concentration for a
   building mainly occupied by human beings. Thus, *CO\ 2* concentration
   has been used as control inputs in demand control ventilation.

   This metric is defined as the total time when *CO\ 2* concentration
   :math:`C_z(t_i)``\gamma_z` is higher than the ASHRAE recommended value
   :math:`C_r``\gamma_r` for all the zones in the whole building , during
   the time interval :math:`\{t_{0},t_{1}\}`:

   .. math:: Unmet_{CO_2} = \sum_{z \in Z}\sum_{t_i=t_0}^{t_1}s(t_i)

   .. math:: s(t_i)=1, if C_z(t_i)>C_r, \quad at \quad time \quad t_i

   .. math:: s(t_i)=0, if C_z(t_i) \leq C_r, \quad at \quad time \quad t_i

   Where :math:`C` denotes the concentration of carbon dioxide *CO\ 2* in
   ppm. For zone :math:`z`, the carbon dioxide concentration is :math:`C_z(t_i)`
   at time :math:`t_i`. Let :math:`a` denote the ambient environment. Let
   :math:`C_r` denotes the required *CO\ 2* concentration threshold from
   ASHRAE 62.1 (e.g., for office :math:`C_r`=700 ppm + :math:`a`).

   .. math:: \Phi(t_0, t_f) = \sum_{z\in \mathbb{Z}} \int_{t_0}^{t_f} \phi_z(t) dt

   .. math:: \phi_z(t)=\gamma_z(t)-\gamma_r, \quad if \quad\gamma_z(t)>\gamma_r

   .. math:: \phi_z(t)=0, \quad if \quad \gamma_z(t) \leq \gamma_r
   
   Where
   :math:`\Phi` is the total violation of carbon dioxide *CO\ 2*
   concentration in ppm*h between the initial time :math:`t_0` and the final
   time :math:`t_f`. :math:`z` is the zone index for the set of zones in the
   building :math:`\mathbb{Z}`. :math:`\phi_z` is the deviation of zone :math:`z`
   from the required *CO\2* concentration threshold from ASHRAE 62.1.

Calculation Module
---------------------

A KPI calculation module is implemented that calculates the core KPIs
during the test case simulation by computing KPIs on the fly in order to
provide feedback to the controller or only for informative purposes.
Upon deployment of the test case, the module first use the KPI JSON
(kpis.json) to associate model output names with the appropriate KPIs
through the specified KPI annotations.
