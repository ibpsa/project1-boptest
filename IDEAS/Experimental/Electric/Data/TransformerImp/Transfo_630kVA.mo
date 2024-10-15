within IDEAS.Experimental.Electric.Data.TransformerImp;
record Transfo_630kVA =
                IDEAS.Experimental.Electric.Data.Interfaces.TransformerImp (
    Sn=630e3,
    P0=745,
    Zd=0.00416 + 0.0198*Modelica.ComplexMath.j) "630 kVA transformer";
