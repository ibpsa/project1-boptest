within IDEAS.BoundaryConditions.Occupants.Extern.Files;
model min10 "10-minute data"
  extends IDEAS.BoundaryConditions.Occupants.Extern.Detail(
    filNam="..\\Inputs\\" + locNam + "_10.txt",
    timestep=600,
    ending="_10.text");
end min10;
