within IDEAS.Experimental.Electric.Data.Interfaces.DirectCurrent;
record GridImp "Describe a grid by matrices of layout and impedances"
extends Modelica.Icons.MaterialProperty;

parameter Integer nNodes( min=1);
//parameter Integer nodeMatrix[size(nodeMatrix,1),:];
parameter Integer nodeMatrix[nNodes,nNodes];
parameter Modelica.SIunits.Resistance R[nNodes];

protected
parameter Modelica.SIunits.ComplexImpedance Z[nNodes](re=R,each im=0);

end GridImp;
