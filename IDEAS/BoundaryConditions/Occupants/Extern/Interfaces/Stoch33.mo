within IDEAS.BoundaryConditions.Occupants.Extern.Interfaces;
model Stoch33 "33 stochastic user behaviour profiles "
  extends IDEAS.BoundaryConditions.Occupants.Extern.Interfaces.Occ_Files(
    nOcc=33,
    filPres="User_Presence_15.txt",
    filQCon="User_QCon_15.txt",
    filQRad="User_QRad_15.txt",
    filP="User_P_15.txt",
    filQ="User_zeros.txt",
    filDHW="User_mDHW_15.txt");
end Stoch33;
