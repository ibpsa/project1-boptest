within ;
package DetachedHouse_ENGIE_IBPSAP1

  import Buildings;
  import Construction;











  annotation (uses(Modelica(version="3.2.2"),
      Modelica_StateGraph2(version="2.0.3"),
      Construction(version="3"),
      ModelicaServices(version="3.2.2"),
    ARTEMIS(version="1"),
    Buildings(version="6.0.0"),
    IBPSA(version="3.0.0")),
    version="2",
    conversion(from(version="", script="ConvertFromARTEMIS_.mos"),
      noneFromVersion="1"));
end DetachedHouse_ENGIE_IBPSAP1;
