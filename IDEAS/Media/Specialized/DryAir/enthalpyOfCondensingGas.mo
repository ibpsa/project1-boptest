within IDEAS.Media.Specialized.DryAir;
function enthalpyOfCondensingGas
  "Enthalpy of steam per unit mass of steam"
  extends Modelica.Icons.Function;
  input Temperature T "temperature";
  output SpecificEnthalpy h "steam enthalpy";
algorithm
  h := 0;
  annotation(smoothOrder=5,
  Inline=true);
end enthalpyOfCondensingGas;
