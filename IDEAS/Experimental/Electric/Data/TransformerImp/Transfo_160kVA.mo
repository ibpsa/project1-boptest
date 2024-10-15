within IDEAS.Experimental.Electric.Data.TransformerImp;
record Transfo_160kVA =
                IDEAS.Experimental.Electric.Data.Interfaces.TransformerImp (
    Sn=160e3,
    P0=260,
    Zd=0.0204 + 0.0675*Modelica.ComplexMath.j) "160 kVA transformer";
