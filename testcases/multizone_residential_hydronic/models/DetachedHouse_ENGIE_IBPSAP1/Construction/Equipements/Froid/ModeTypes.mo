within DetachedHouse_ENGIE_IBPSAP1.Construction.Equipements.Froid;
type ModeTypes = enumeration(
    c "charge only",
    d "discharge only",
    pc "direct production + charge",
    pd "direct production + discharge",
    p "direct production")
  "Enumeration to define the operating modes of storage"
                                              annotation (
    Documentation);
