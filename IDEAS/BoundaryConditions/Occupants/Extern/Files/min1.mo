within IDEAS.BoundaryConditions.Occupants.Extern.Files;
model min1 "1-minute data"
  extends IDEAS.BoundaryConditions.Occupants.Extern.Detail(
    filNam="..\\Inputs\\" + locNam + "_1.txt",
    timestep=60,
    ending="_1.text");
end min1;
