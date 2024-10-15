within IDEAS.Utilities.File;
function sha2
  extends Modelica.Icons.Function;
  input String argv="E:/work/modelica/SimulationResults/test.txt";
  output Real sha2;

external"C" sha2 = sha2(argv); ////sha1 = sha1(filePath);  //md5_file(filePath, "1234567891234567")
  annotation (Include="#include <sha2.c>", IncludeDirectory="modelica://IDEAS/Resources/C-Sources");
end sha2;
