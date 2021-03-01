within ;
package MultiZoneResidentialHydronic "Package for the development of the multi zone residential hydronic building model BOPTEST test case"

  import Buildings;
  import Construction;











  annotation (uses(Modelica(version="3.2.3"),
      Modelica_StateGraph2(version="2.0.3"),
      Construction(version="3"),
      ModelicaServices(version="3.2.3"),
    ARTEMIS(version="1"),
    Buildings(version="8.0.0"),
    IBPSA(version="3.0.0")),
    version="2",
    conversion(from(version="", script="ConvertFromARTEMIS_.mos"),
      noneFromVersion="1"));
end MultiZoneResidentialHydronic;
