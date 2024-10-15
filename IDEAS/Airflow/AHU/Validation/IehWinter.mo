within IDEAS.Airflow.AHU.Validation;
model IehWinter
  "Validation of indirect evaporative heat exchanger using summer data set"
  extends IDEAS.Airflow.AHU.Validation.IehSummer(
    iehOn(k=false),
    TSup(k=273.15 - 12),
    RhSup(k=0.9),
    RhRet(k=0.39),
    TRet(k=273.15 + 22.4),
    datasheet_RhRetOut(k=1),
    datasheet_RhSupOut(k=0.13),
    datasheet_TRetOut(k=273.15 + 1.2),
    datasheet_TSupOut(k=273.15 + 15.1),
    V_flowRet(k=14200/3600*1.195),
    V_flowSup(k=12460*1.35/3600),
    IEH(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial));
  annotation (experiment(StopTime=500, Tolerance=1e-06),
                                       __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Airflow/AHU/Validation/IehWinter.mos"
        "Simulate and plot"));
end IehWinter;
