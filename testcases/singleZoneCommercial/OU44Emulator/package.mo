within ;
package OU44Emulator "OU44 building model for IBPSA Project 1 BOPTEST"
  extends Buildings.BaseClasses.BaseIcon;

annotation (uses(
    ModelicaServices(version="3.2.2"),
    Modelica(version="3.2.2"),
      Buildings(version="5.0.1"),
      IBPSA(version="3.0.0")),
    version="2",
  conversion(noneFromVersion="", noneFromVersion="1"));
end OU44Emulator;
