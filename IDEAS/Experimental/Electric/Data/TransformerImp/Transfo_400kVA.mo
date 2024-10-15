within IDEAS.Experimental.Electric.Data.TransformerImp;
record Transfo_400kVA =
                IDEAS.Experimental.Electric.Data.Interfaces.TransformerImp (
    Sn=400e3,
    P0=515,
    Zd=0.00740 + 0.0291*Modelica.ComplexMath.j) "400 kVA transformer";
