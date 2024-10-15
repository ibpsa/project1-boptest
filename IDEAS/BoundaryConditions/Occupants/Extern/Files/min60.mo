within IDEAS.BoundaryConditions.Occupants.Extern.Files;
model min60 "60-minute data"
  extends IDEAS.BoundaryConditions.Occupants.Extern.Detail(
    filNam="..\\Inputs\\" + locNam + "_60.txt",
    timestep=3600,
    ending="_60.text");
end min60;
