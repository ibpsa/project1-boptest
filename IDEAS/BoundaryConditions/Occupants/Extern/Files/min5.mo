within IDEAS.BoundaryConditions.Occupants.Extern.Files;
model min5 "5-minute data"
  extends IDEAS.BoundaryConditions.Occupants.Extern.Detail(
    filNam="..\\Inputs\\" + locNam + "_5.txt",
    timestep=300,
    ending="_5.text");
end min5;
