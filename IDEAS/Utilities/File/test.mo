within IDEAS.Utilities.File;
model test
  import IDEAS;
  parameter String name = "example.mo";
  parameter String savePath=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/BorefieldData/");
  parameter String sha1=IDEAS.Utilities.File.sha1(savePath + name);
initial algorithm
  Modelica.Utilities.Streams.print(sha1,"E:/work/modelica/SimulationResults/test_sha2.txt");
end test;
