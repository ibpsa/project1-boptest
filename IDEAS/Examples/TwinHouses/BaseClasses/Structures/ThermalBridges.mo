within IDEAS.Examples.TwinHouses.BaseClasses.Structures;
model ThermalBridges
  "Thermal bridges for twinhouses based on psi-values of model specification (obtained for inner dimensions)"

  Modelica.Blocks.Interfaces.RealInput Te
    annotation (Placement(transformation(extent={{-126,40},{-86,80}})));
  Modelica.Blocks.Interfaces.RealInput Tatt
    annotation (Placement(transformation(extent={{-124,-6},{-84,34}})));
  Modelica.Blocks.Interfaces.RealInput Tbas
    annotation (Placement(transformation(extent={{-124,-54},{-84,-14}})));
  Modelica.Blocks.Interfaces.RealInput[7] Tzone
    annotation (Placement(transformation(extent={{-124,-96},{-84,-56}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[7] heatPortRad
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[7] prescribedHeatFlow
    annotation (Placement(transformation(extent={{40,-8},{60,12}})));
equation
  prescribedHeatFlow[1].Q_flow = (1.113+0.981+0.366+0.091*3.28)*(Te-Tzone[1])+(0.436+(1.136+0.83+1.034+1.163+0.167)/2)*(Tatt-Tzone[1])+(0.583+(1.136+0.167                               +0.83+1.034+1.163)/2)*(Tbas-Tzone[1]);
  prescribedHeatFlow[2].Q_flow = (0.359+1.034+0.606+0.359)/2*(Tatt+Tbas-2*Tzone[2]);
  prescribedHeatFlow[3].Q_flow = (0.623)*(Te-Tzone[3]) + (0.511+0.606+0.511)/2*(Tatt+Tbas-2*Tzone[3]);
  prescribedHeatFlow[4].Q_flow = (0.685+0.841)*(Te-Tzone[4])+ (0.436+(0.359+0.511+1.163)/2)*(Tatt-Tzone[4])+(0.583+(0.359+0.511+1.163)/2)*(Tbas-Tzone[4]);
  prescribedHeatFlow[5].Q_flow = (0.644+0.616)*(Te-Tzone[5])+ (0.436+(0.665+1.139)/2)*(Tatt-Tzone[5])+(0.583+(0.665+1.139)/2)*(Tbas-Tzone[5]);
  prescribedHeatFlow[6].Q_flow = (0.469)*(Te-Tzone[6]) + (0.665+1.136+0.83)/2*(Tatt+Tbas-2*Tzone[6]);
  prescribedHeatFlow[7].Q_flow = (0.841+742)*(Te-Tzone[7])+ (0.436+(1.136+0.359+0.511+0.167)/2)*(Tatt-Tzone[7])+(0.583+(1.136+0.359+0.511+0.167)/2)*(Tbas-Tzone[7])
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
  connect(heatPortRad, prescribedHeatFlow.port) annotation (Line(points={{100,0},
          {80,0},{80,2},{60,2}},                  color={191,0,0}));
end ThermalBridges;
