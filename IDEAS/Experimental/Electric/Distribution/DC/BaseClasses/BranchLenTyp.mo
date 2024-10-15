within IDEAS.Experimental.Electric.Distribution.DC.BaseClasses;
model BranchLenTyp
  "A cable between two nodes specified by its type of cable and its length in meters"
  extends Branch(R=typ.RCha*mulFac*len);
  parameter Real mulFac=1;
  parameter Data.Interfaces.DirectCurrent.Cable typ=
      Data.Cables.DirectCurrent.PvcAl35();
  parameter Modelica.SIunits.Length len=10;
end BranchLenTyp;
