within IDEAS.Experimental.Electric.Data.TransformerImp;
record Transfo_100kVA =
                IDEAS.Experimental.Electric.Data.Interfaces.TransformerImp (
    Sn=100e3,
    P0=190,
    Zd=0.0333 + 0.106*Modelica.ComplexMath.j) "100 kVA transformer";
