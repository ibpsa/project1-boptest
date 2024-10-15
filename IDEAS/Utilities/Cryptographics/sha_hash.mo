within IDEAS.Utilities.Cryptographics;
function sha_hash
  "Return unique string containing the digits from the real number of baseClasses.sha. This is necessary as the Modelica function \"String\" cannot return 60 digits"
   extends Modelica.Icons.Function;
    input String argv=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Constants/package.mo");
    output String hash "string make of the digits of the sha-number";
protected
  Real hash_numb "Real number for sha-function";
  Integer hash_el "Part of the sha-number";
algorithm
  hash_numb := IDEAS.Utilities.Cryptographics.BaseClasses.sha(argv);
  hash :="";
  for i in 1:19 loop
    hash_el :=integer(hash_numb/10^(57 - 3*i));
    hash_numb :=hash_numb - hash_el*10^(57 - 3*i);
    hash :=hash + String(hash_el);
  end for;
end sha_hash;
