within IDEAS.BoundaryConditions.Occupants.StROBe.Interfaces;
model Occ_Files "Dummy file reader for occupant model"
  parameter Integer nOcc=1 "Number of occupant data sets to be read"
    annotation (Dialog(group="Building occupants"));
  parameter String filPres="User_zeros.txt" "Filename for occupancy presence"
    annotation (Dialog(group="Building occupants"));
  parameter String filQCon="User_zeros.txt"
    "Filename for occupancy-driven convective gains"
    annotation (Dialog(group="Building occupants"));
  parameter String filQRad="User_zeros.txt"
    "Filename for occupancy-driven radiative gains"
    annotation (Dialog(group="Building occupants"));
  parameter String filP="User_zeros.txt"
    "Filename for occupancy-driven active power load"
    annotation (Dialog(group="Building occupants"));
  parameter String filQ="User_zeros.txt"
    "Filename for occupancy-driven reactive power load"
    annotation (Dialog(group="Building occupants"));
  parameter String filDHW="User_zeros.txt"
    "Filename for occupancy-driven domestic hot water redrawal"
    annotation (Dialog(group="Building occupants"));
end Occ_Files;
