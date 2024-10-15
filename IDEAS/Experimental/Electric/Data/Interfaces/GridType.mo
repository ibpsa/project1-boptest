within IDEAS.Experimental.Electric.Data.Interfaces;
record GridType
  "Describes a grid using the layout matrix T_matrix and lengths and cable type vectors"
  extends IDEAS.Experimental.Electric.Data.Interfaces.GridImp(R=CabTyp.RCha .*
        LenVec*Pha/3, X=CabTyp.XCha .* LenVec*Pha/3);
  parameter Integer Pha;

  parameter Modelica.SIunits.Length LenVec[nNodes]
    "Vector with the Length of each branch in the network, first value is 0";
  parameter IDEAS.Experimental.Electric.Data.Interfaces.Cable CabTyp[nNodes]
    "Vector with the type of cable for each branch in the network, first value should be anything";

end GridType;
