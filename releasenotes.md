# Release Notes

## BOPTEST v0.x.x

Released on xx/xx/xxx.

**The following changes are backwards-compatible and do not significantly change benchmark results:**

- Refactor python-based example tests to utilize a single BOPTEST interface script.  This is for [#279](https://github.com/ibpsa/project1-boptest/issues/279).
- Fix ``data/data_generator`` to produce correct set points for defined occupied and unnoccupied times. This is for [#368](https://github.com/ibpsa/project1-boptest/issues/368).
- Freeze IBPSA Modelica library version in creation of ``jm`` image for unit testing.  This is for [#371](https://github.com/ibpsa/project1-boptest/issues/371).
- Update test cases to use Buildings v8.0.0 and IDEAS v2.2.1.  This is for [#362](https://github.com/ibpsa/project1-boptest/issues/362).
- Add content to ``/docs/workshops`` for workshop at IBPSA Building Simulation 2021 Conference.  This is for [#348](https://github.com/ibpsa/project1-boptest/issues/348).
- Update README.md to add links to ``boptest-service`` and ``boptest-gym``.  This is for [#353](https://github.com/ibpsa/project1-boptest/issues/353).
- Fix path for documentation images for bestest_hydronic_heat_pump test case.  This is for [#351](https://github.com/ibpsa/project1-boptest/issues/351).

## BOPTEST v0.1.0

Released on 07/13/2021.

This is an initial development release.
