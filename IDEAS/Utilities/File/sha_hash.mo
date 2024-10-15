within IDEAS.Utilities.File;
function sha_hash
   extends Modelica.Icons.Function;
    input String argv="E:/work/modelica/SimulationResults/test.txt";
    output String hash;
    output Real hash_numb;
//    output Real hash_save[20];
//    output Integer hash_el_save[20];

protected
  Integer hash_el;
algorithm
  hash_numb :=IDEAS.Utilities.File.sha2(argv);
  hash :="";
  for i in 1:19 loop
//    hash_save[i] :=hash_numb;
    hash_el :=integer(hash_numb/10^(57 - 3*i));
//    hash_el_save[i] :=hash_el;
    hash_numb :=hash_numb - hash_el*10^(57 - 3*i);
    hash :=hash + String(hash_el);
  end for;

end sha_hash;
