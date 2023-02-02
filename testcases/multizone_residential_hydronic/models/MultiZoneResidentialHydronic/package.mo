within ;
package MultiZoneResidentialHydronic "Package for the development of the multi zone residential hydronic building model BOPTEST test case"

  import Buildings;
  import Construction;











  annotation (uses(Modelica(version="4.0.0"),
    ARTEMIS(version="1"),
    Buildings(version="9.1.0")),
    version="2",
    conversion(from(version="", script="ConvertFromARTEMIS_.mos"),
      noneFromVersion="1"));
end MultiZoneResidentialHydronic;
