---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

title: The Building Optimization Testing Framework (BOPTEST)
subtitle: A framework for building control performance benchmarking
hero_height: is-fullwidth
---

<p align="center">
    <img src="images/concept.png" alt="drawing" width="50%"/>
</p>

BOPTEST is designed to facilitate the performance evaluation and benchmarking of building control strategies.
It contains these key components:

1. **Run-Time Environment (RTE)**: Deployed with Docker and accessed with a RESTful HTTP API, use the RTE to set up tests, control building emulators, access data, and report KPIs.

2. **Test Case Repository**: A collection of ready-to-use building emulators representing a range of building types and HVAC systems.

3. **Key Performance Indicator (KPI) Reporting**: A set of KPIs is calculated by the the RTE using data from the building emulator being controlled.

Head over to the [Software](/software) page to start testing your control strategy or look at the [Results Dashboard](/dashboard) to view and compare tested control strategies.

Stay up to date on the latest [News](/news).


# Collaboration

The development of BOPTEST has resulted from an international collaboration of academic, national laboratory, and industry partners through [IBPSA Project 1](https://ibpsa.github.io/project1/index.html) Work Package 1.2.  Thank you to all of the contributing partners.
