within IDEAS.Experimental.Electric.Data.Interfaces;
record GridImp "Describe a grid by matrices of layout and impedances"
  extends Modelica.Icons.MaterialProperty;
  //extends IDEAS.Experimental.Electric.Data.Interfaces.GridLayout;
  //parameter Integer n(min=1);
  //parameter Integer T_matrix[nNodes,nNodes];

  parameter Integer nNodes( min=1);
 // parameter Integer nodeMatrix[size(nodeMatrix, 1), :];
  parameter Integer nodeMatrix[nNodes, nNodes];
  parameter Modelica.SIunits.Resistance R[nNodes];
  parameter Modelica.SIunits.Reactance X[nNodes];
  parameter Modelica.SIunits.ComplexImpedance Z[nNodes](re=R, im=X);

end GridImp;
