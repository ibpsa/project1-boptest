---
layout: page
title: IBPSA Project 2
subtitle: Community Development and Usage of BOPTEST
hero_height: is-fullwidth
show_sidebar: false
menubar: ibpsa_menubar
permalink: /ibpsa/project/workplan/
---

<img src="../../../images/project2logo.png" alt="drawing" width="50%"/>

# Work Plan

The approved proposal can be found here: [PDF](/ibpsa_project/workplan/IBPSA_Project_BOPTEST_approved.pdf)

Summaries of the Project and tasks are described below.

### Overview (from proposal)
Needs for advanced and improved control strategies (CS) in building and
district energy systems are growing due to requirements for reducing energy use,
greenhouse gas emissions, and operating costs, providing flexibility to the
electrical grid, as well as ensuring performance of novel hybrid and collective
system architectures. Examples of such CS are advanced rule-based control,
Model Predictive Control (MPC) [Drg20], and Reinforcement Learning [Wan20].
However, while these and other CS show promise, three challenges slow their
widespread adoption:

1. The performance of each CS is typically demonstrated on individualized case
studies and quantified using different metrics, making it difficult to
benchmark and compare their performance, identify the most promising approaches,
and identify needed development.

2. Demonstrations in real buildings and district energy systems pose large
operational risks and difficult environments for controlled experiments.

3. Development of realistic simulation models for CS testing and evaluation
requires significant building science and modeling expertise not necessarily
held by experts from fields which could contribute to new CS development,
such as process control, optimization, and data science.

The building simulation (BS) community can address these challenges by
providing suites of publicly available, high-fidelity simulation models,
called emulators, to be used for benchmarking CS. Furthermore, providing a
comprehensive framework to deploy, interact with, and generate key performance
indicators (KPI) from these emulators would ensure their benchmarking
capability and make them readily available to related control and data
science fields outside of the BS community. There exists precedent for such an
approach within the BS field with the development of the BESTEST [Jud95] and
subsequent ASHRAE Standard 140 [ASH11] as well as the optimization fields
(e.g. Decision Tree for Optimization Software [Mit22]) and data science
(e.g. OpenAI Gym [Ope22]).

### Task 1: Outreach and Community Building
**Task Leader**: Javier Arroyo, Wedoco, Spain

This task will focus on activities that encourage, facilitate, and disseminate
BOPTEST usage, adoption, and feedback to development.

### Task 2: Methods and Infrastructure
**Task Leader**: David Blum, Lawrence Berkeley National Laboratory, USA

This task will focus on development and maintenance of core framework
software and closely related extensions in response to needs identified by
Project participants and community feedback. Related components include test
case and framework architecture specification, FMU simulation and data management,
KPI calculation, forecast delivery, API, online results sharing dashboard,
web-service, and interface extensions.

### Task 3: Test Cases
**Task Leader**: Ettore Zanetti, Lawrence Berkeley National Laboratory, USA

This task will focus on development and maintenance of benchmark emulators,
so-called “test cases.” Emulator development will continue to utilize the
Modelica language and Functional Mockup Interface (FMI) standard, particularly
open-source libraries that extend from the Modelica IBPSA Library developed
through IBPSA Project 1 WP1.1 and continuation Modelica Working Group.

### Task 4: Controller Testing
**Task Co-Leaders**: Esther Borkowski, ETH Zurich, Switzerland and Zhe Wang, Hong Kong University of Science and Technology, Hong Kong

This task will focus on testing and benchmarking CS developed by both
participants in this Project, and also comparison with CS developers external
to the Project, using the framework developed in Task 2 and test cases
developed in Task 3.

### Publication Acknowledgement
Publications resulting from IBPSA Project 2 should include the following acknowledgement text:

*This work emerged from the IBPSA Project 2, an international
project conducted under the umbrella of the International Building
Performance Simulation Association (IBPSA) to develop and
demonstrate the Building Optimization Testing Framework
(BOPTEST) for the testing, evaluating, and benchmarking of
building and community energy system controls.*

### References

| [ASH11] | ANSI/ASHRAE (2011). ANSI/ASHRAE Standard 140-2011. Standard Method of Test for the Evaluation of Building Energy Analysis Computer Programs. ASHRAE, Atlanta, GA. |
| [Drg20] | Drgoňa, J., Arroyo, J., Cupeiro Figueroa, I., Blum, D., Arendt, K., Kim, D., Ollé, E. P., Oravec, J., Wetter, M., Vrabie, D. L., and Helsen, L. (2020). All you need to know about model predictive control for buildings. Annual Reviews in Control, 50, 190–232. |
| [Jud95] | Judkoff, R. and Neymark, J. (1995). International Energy Agency Building Energy Simulation Test (BESTEST) and Diagnostic Method. Technical Report NREL/TP-172-6231, NREL, Golden, CO. Available online: http://www.nrel.gov/docs/legosti/old/6231.pdf. |
| [Mit22] | Mittelmann, H. D. (2022). Decision Tree for Optimization Software. Available online: http://plato.asu.edu/guide.html. |
| [Ope22] | OpenAI (2022). Gym. Available online: https://gym.openai.com. |
| [Wan20] | Wang, Z., and Hong, T. (2020). Reinforcement Learning for Building Controls: The Opportunities and Challenges. Applied Energy 269: 115036. |
