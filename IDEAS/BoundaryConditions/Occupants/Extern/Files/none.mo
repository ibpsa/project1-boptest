within IDEAS.BoundaryConditions.Occupants.Extern.Files;
model none "No data"
  extends IDEAS.BoundaryConditions.Occupants.Extern.Detail(
    filNam="..\\Inputs\\User_zeros.txt",
    timestep=60,
    ending="none",
    locNam="none");
end none;
