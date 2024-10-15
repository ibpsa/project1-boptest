within IDEAS.Experimental.Electric.Data.Interfaces.DirectCurrent;
record GridType
  "Describes a grid using the layout matrix T_matrix and lengths and cable type vectors"

extends GridImp(R=CabTyp.RCha .* LenVec);

parameter Modelica.SIunits.Length LenVec[nNodes]
    "Vector with the Length of each branch in the network, first value is 0";
parameter Cable CabTyp[nNodes]
    "Vector with the type of cable for each branch in the network, first value should be anything";

end GridType;
