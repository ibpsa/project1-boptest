within MultiZoneOfficeSimpleAir.BaseClasses;
model RoomLeakage "Room leakage model with CO2"
  extends Buildings.Examples.VAVReheat.BaseClasses.RoomLeakage(amb(use_C_in=
          true));
  Modelica.Blocks.Sources.Constant conCO2Out(k=400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
        /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM)
    "Outside air CO2 concentration"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
equation
  connect(conCO2Out.y, amb.C_in[1]) annotation (Line(points={{-79,-50},{-70,-50},
          {-70,-8},{-62,-8}}, color={0,0,127}));
end RoomLeakage;
