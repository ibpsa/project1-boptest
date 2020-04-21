within DetachedHouse_ENGIE_IBPSAP1.Construction.Equipements.Stockage;
model LatentHeatStorage "Latent heat storage"

    replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  // ==========
  // Parameters
  // ==========
  parameter Modelica.SIunits.Temperature T_amb = 273.15+20
    "Ambient air temperature";

    // Storage volume characteristics
  parameter Modelica.SIunits.Volume V = 2 "Storage volume"    annotation(Dialog(group="Storage volume characteristics"));
  parameter Modelica.SIunits.Length L = 2.98 "Tank length"    annotation(Dialog(group="Storage volume characteristics"));
  parameter Modelica.SIunits.VolumeFraction f = 0.45
    "Volume fraction of the storage filled by the HTF"    annotation(Dialog(group="Storage volume characteristics"));
  parameter Modelica.SIunits.Length d_w = 0.035
    "Tank wall (with insulation) thickness"    annotation(Dialog(group="Storage volume characteristics"));
  parameter Modelica.SIunits.ThermalConductivity k_w = 0.02
    "Insulation thermal conductivity"    annotation(Dialog(group="Storage volume characteristics"));

  // Phase-change material properties
  parameter Modelica.SIunits.Temperature T_sat = 273.15+0
    "PCM phase-change temperature"    annotation(Dialog(group="PCM properties"));
  parameter Modelica.SIunits.SpecificEnthalpy h_sat = 190420
    "PCM latent heat"                                                         annotation(Dialog(group="PCM properties"));
  parameter Modelica.SIunits.SpecificHeatCapacity CpS_pcm = 2754
    "PCM solid specific heat capacity"
                                      annotation(Dialog(group="PCM properties"));
  parameter Modelica.SIunits.SpecificHeatCapacity CpL_pcm = 4328
    "PCM liquid specific heat capacity"
                                       annotation(Dialog(group="PCM properties"));
  parameter Modelica.SIunits.Density rho_pcm = 915 "PCM density"
                                                                annotation(Dialog(group="PCM properties"));
  parameter Modelica.SIunits.Length D_pcm = 0.098 "PCM nodule diameter"
                                                                       annotation(Dialog(group="PCM properties"));

  // Heat transfer fluid properties
  parameter Modelica.SIunits.SpecificHeatCapacity Cp_htf = 3790
    "HTF specific heat capacity" annotation(Dialog(group="HTF properties"));
  parameter Modelica.SIunits.Density rho_htf = 1084 "HTF density" annotation(Dialog(group="HTF properties"));
  parameter Modelica.SIunits.ThermalConductivity k_htf = 0.435
    "HTF thermal conductivity" annotation(Dialog(group="HTF properties"));
  parameter Modelica.SIunits.KinematicViscosity v_htf = 7.7e-6
    "HTF kinematic viscosity" annotation(Dialog(group="HTF properties"));

  // Simulation conditions
  parameter Modelica.SIunits.Temperature T_0 = 273.15+6
    "Initial PCM and HTF temperature" annotation(Dialog(group="Simulation specifications"));
  parameter Real xL_pcm_0 = 0.5
    "Initial PCM liquid fraction, used only if T_0=T_sat" annotation(Dialog(group="Simulation specifications"));
  parameter Modelica.SIunits.Temperature T_qzero = 273.15+6
    "Reference temperature for which there is no heat stored" annotation(Dialog(group="Simulation specifications"));
  parameter Modelica.SIunits.Temperature T_hzero = 273.15
    "Reference temperature for a zero enthalpy" annotation(Dialog(group="Simulation specifications"));
  parameter Integer n = 5 "Number of elements for meshing tank length" annotation(Dialog(group="Simulation specifications"));

protected
  constant Real pi = Modelica.Constants.pi;

  // =========
  // Variables
  // =========
  // Variables retrieved from/transmitted to connectors
public
  Modelica.SIunits.MassFlowRate m_htf "HTF mass flow rate";
  Modelica.SIunits.Pressure P_htf "HTF pressure";
  Modelica.SIunits.Temperature TI_htf "HTF inlet temperature";
  Modelica.SIunits.Temperature TO_htf "HTF outlet temperature";
  // Phase-change material variables
  Modelica.SIunits.Temperature[n] T_pcm(each start=T_0) "PCM temperature";
  Real[n] xL_pcm(each start=xL_pcm_0) "Liquid PCM fraction";
  Modelica.SIunits.SpecificEnthalpy[n] h_pcm "PCM specific enthalpy";
  Modelica.SIunits.SpecificEnthalpy hsatL_pcm
    "PCM specific enthalpy at liquid saturation";
  Modelica.SIunits.SpecificEnthalpy hsatS_pcm
    "PCM specific enthalpy at solid saturation";
  Modelica.SIunits.SpecificEnthalpy h_pcm_0
    "PCM specific enthalpy at t=0 for T_pcm=T_0";
  Modelica.SIunits.SpecificEnthalpy h_pcm_qzero
    "PCM specific enthalpy for T_pcm=T_qzero";
  // HTF variables
  Modelica.SIunits.Temperature[n] T_htf(each start=T_0) "HTF temperature";
  Modelica.SIunits.Velocity u "HTF velocity";
  Modelica.SIunits.DynamicViscosity mu "HTF dynamic viscosity";
  Modelica.SIunits.CoefficientOfHeatTransfer h_htf_pcm
    "Convective coefficient of heat transfer with PCM";
  Modelica.SIunits.CoefficientOfHeatTransfer h_htf_w
    "Convective coefficient of heat transfer qith tank wall";
  Modelica.SIunits.CoefficientOfHeatTransfer U_pcm
    "Overall heat transfer coefficient from HTF to PCM";
  Modelica.SIunits.CoefficientOfHeatTransfer U_air
    "Overall heat transfer coefficient from HTF to ambient aire";
  Modelica.SIunits.NusseltNumber Nu_pcm "Nusselt number for PCM";
  Modelica.SIunits.NusseltNumber Nu_w "Nusselt number for tank wall";
  Modelica.SIunits.ReynoldsNumber Re_pcm "Reynolds number for PCM";
  Modelica.SIunits.ReynoldsNumber Re_w "Reynolds number for tank wall";
  Modelica.SIunits.PrandtlNumber Pr "Prandlt number";
  // Geometry variables
  Modelica.SIunits.Volume V_nod "Volume of 1 PCM nodule";
  Modelica.SIunits.Area S_nod "Surface of 1 PCM nodule";
  Real N_nod "Number of PCM nodules";
  Modelica.SIunits.Volume V_pcm "Volume of all PCM nodules";
  Modelica.SIunits.Area S_pcm "Total PCM exchange area";
  Modelica.SIunits.Length D "Internal diameter of the tank";
  Modelica.SIunits.Area S_amb "Exchange surface with ambient air";
  // Elements variables
  Modelica.SIunits.Length Delta_x "Length of one element";
  Modelica.SIunits.Volume dV "Volume of one element";
  Modelica.SIunits.Volume dV_pcm "Volume of PCM in one element";
  Modelica.SIunits.Volume dV_htf "Volume of HTF in one element";
  Modelica.SIunits.Area dS_pcm "PCM exchange area in one element";
  Modelica.SIunits.Area dS_amb "Exchange surface with ambient air in one element";
  Modelica.SIunits.Area A_htf "HTF area of contact between two elements";
  Modelica.SIunits.Length D_htf "Diameter of HTF area of contact";
  Modelica.SIunits.Mass dm_pcm "Mass of PCM in one element";
  Modelica.SIunits.Mass dm_htf "Mass of HTF in one element";
  // Power and heat stored
  Modelica.SIunits.Heat[n] Q_htf(each start=0) "Heat gain by HTF";
  Modelica.SIunits.Heat[n] Q_pcm(each start=0) "Heat gain by PCM";
  Modelica.SIunits.Heat[n] Q_air(each start=0) "Heat losses";
  Modelica.SIunits.HeatFlowRate[n] W_cond
    "Heat change rate due to HTF conduction";
  Modelica.SIunits.HeatFlowRate[n] W_conv
    "Heat change rate due to HTF convection";
  Modelica.SIunits.Power[n] W_pcm "Power exchanged between HTF and PCM";
  Modelica.SIunits.Power[n] W_air
    "Power exchanged between HTF and ambiant air";
  Modelica.SIunits.Heat Q_htf_stored(start=0) "Total heat storef in HTF";
  Modelica.SIunits.Heat Q_pcm_stored(start=0) "Total heat stored in PCM";
  Modelica.SIunits.Heat Delta_Q_stored_ini
    "Total heat stored difference between T0 and Tqzero";
  Modelica.SIunits.Heat Q_stored "Total heat stored";
  Modelica.SIunits.Heat Q_perdu "Total heat lossed";
  Modelica.SIunits.Power P_charge "Charge or discharge rate";
  Real N_stock "Stock level";
  Real x_stock;

  Modelica.Fluid.Interfaces.FluidPort_a                port_a(redeclare package
      Medium =                                                                           Medium)
    annotation (Placement(transformation(extent={{-134,-24},{-86,24}})));

  Modelica.Fluid.Interfaces.FluidPort_b                port_b(redeclare package
      Medium =                                                                           Medium)
    annotation (Placement(transformation(extent={{86,-24},{134,24}})));

  Modelica.Blocks.Interfaces.BooleanInput charge annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,104})));
  Modelica.Blocks.Logical.Timer timer_N_stock0
    annotation (Placement(transformation(extent={{24,20},{44,40}})));
  Modelica.Blocks.Logical.Timer timer_N_stock1
    annotation (Placement(transformation(extent={{24,-8},{44,12}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=0.9)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1 - N_stock)
    annotation (Placement(transformation(extent={{-42,20},{-22,40}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1(threshold=0.9)
    annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=N_stock)
    annotation (Placement(transformation(extent={{-42,-8},{-22,12}})));
initial equation
  for i in 1:n loop
    if (T_0 < T_sat) then
      h_pcm[i]= CpS_pcm*(T_0-T_hzero);
    elseif (T_0 > T_sat) then
      h_pcm[i] = CpS_pcm*(T_sat-T_hzero) + h_sat + CpL_pcm*(T_0-T_sat);
    else
      h_pcm[i] = CpS_pcm*(T_sat-T_hzero) + h_sat*xL_pcm_0;
    end if;
  end for;

equation

  // *** Variables retrieved/transmitted form connectors *** ///
  0 = port_a.m_flow + port_b.m_flow;
  if charge == true then
    m_htf = abs(port_a.m_flow);
    port_a.h_outflow  = inStream(port_a.h_outflow);
    port_a.h_outflow = Medium.specificEnthalpy_pTX(P_htf,TI_htf,Medium.X_default);
    port_b.h_outflow = Medium.specificEnthalpy_pTX(P_htf,TO_htf,Medium.X_default);
  else
    m_htf = abs(port_b.m_flow);
    port_b.h_outflow  = inStream(port_b.h_outflow);
    port_a.h_outflow = Medium.specificEnthalpy_pTX(P_htf,TO_htf,Medium.X_default);
    port_b.h_outflow = Medium.specificEnthalpy_pTX(P_htf,TI_htf,Medium.X_default);
  end if;
  // Assumption : Pressure loss is neglected across the storage
  P_htf = port_a.p;
  port_b.p = P_htf;
  T_htf[n] =  TO_htf;

  // *** Geometry variables *** //
  // Total exchange area of PCM nodules
  V_nod = pi * D_pcm^3 / 6;
  S_nod = pi * D_pcm^2;
  N_nod = V_pcm/V_nod;
  V_pcm = (1-f)*V;
  S_pcm = V_pcm * S_nod / V_nod;
  // Exchange area with ambiant air
  /* Assumption : Tank geometry is considered to be cylindrical */
  V = pi * D^2 / 4 * L;
  S_amb = pi * D * L + 2 * pi * D^2 / 4;

  // *** Elements variables *** //
  // Mesh of the tank in n elements
  Delta_x = L/n;
  dV = V/n;
  dV_pcm = V_pcm/n;
  dV_htf = f * dV;
  dS_pcm = dV_pcm * S_nod / V_nod;
  dS_amb = S_amb/n;
  dm_pcm = dV_pcm * rho_pcm;
  dm_htf = dV_htf * rho_htf;
  // Contact between two elements i and i+1
  A_htf = dV_htf / Delta_x;
  D_htf = (4 * A_htf / pi)^(1/2);

  // *** HTF variables *** //
  // HTF velocity
  if charge == true then
    u = m_htf / (rho_htf * A_htf)/2;
  else
    u = m_htf / (rho_htf * A_htf)/2;
  end if;
  mu = v_htf * rho_htf;
  // Dimensionless variables
  Pr = Cp_htf * mu / k_htf;
  Re_pcm = rho_htf * u * D_pcm / mu;
  Re_w = rho_htf * u * D_htf / mu;
  Nu_pcm = 2.0 + 2.03 * Re_pcm^(1/2) * Pr^(1/3) + 0.049 * Re_pcm * Pr^(1/2);
  Nu_w = 3.657 + (0.19*(D_htf/L*Re_w*Pr)^(0.8))/(1+0.117*(D_htf/L*Re_w*Pr)^(0.467));
  // Convective and overall heat transfer coefficents
  h_htf_pcm = k_htf * Nu_pcm / D_pcm;
  h_htf_w = k_htf * Nu_w / D_htf;
  U_pcm = h_htf_pcm;
  U_air = h_htf_w / (1 + h_htf_w*d_w/k_w);

  // *** PCM variables *** //
  hsatL_pcm = CpS_pcm * (T_sat-T_hzero) + h_sat;
  hsatS_pcm = CpS_pcm * (T_sat-T_hzero);
  if (h_pcm_0 < hsatS_pcm) then
      h_pcm_0 = CpS_pcm*(T_0-T_hzero);
    elseif (h_pcm_0 > hsatL_pcm) then
      h_pcm_0 = CpS_pcm*(T_sat-T_hzero) + h_sat + CpL_pcm*(T_0-T_sat);
    else
      h_pcm_0 = CpS_pcm*(T_sat-T_hzero) + h_sat*xL_pcm_0;
  end if;
  if (h_pcm_qzero < hsatS_pcm) then
      h_pcm_qzero = CpS_pcm*(T_qzero-T_hzero);
    elseif (h_pcm_qzero > hsatL_pcm) then
      h_pcm_qzero = CpS_pcm*(T_sat-T_hzero) + h_sat + CpL_pcm*(T_qzero-T_sat);
    else
      h_pcm_qzero = CpS_pcm*(T_sat-T_hzero) + h_sat*xL_pcm_0;
  end if;

  // *** Conservation equations *** ///
  for i in 1 : n loop
    // PCM variables
    if (h_pcm[i] < hsatS_pcm) then
      W_pcm[i] = - dm_pcm * CpS_pcm * der(T_pcm[i]);
      h_pcm[i] = CpS_pcm*(T_pcm[i]-T_hzero);
      xL_pcm[i] = 0;
    elseif (h_pcm[i] > hsatL_pcm) then
      W_pcm[i] = - dm_pcm * CpL_pcm * der(T_pcm[i]);
      h_pcm[i] = CpS_pcm*(T_sat-T_hzero) + h_sat + CpL_pcm*(T_pcm[i]-T_sat);
      xL_pcm[i] = 1;
    else
      W_pcm[i] = - dm_pcm * h_sat * der(xL_pcm[i]);
      h_pcm[i] = CpS_pcm*(T_sat-T_hzero) + h_sat*xL_pcm[i];
      T_pcm[i] = T_sat;
    end if;
    // Heat stored
    /* Conditions limites
    T_htf[0] = TI_htf;
    T_htf[n+1] = TO_htf;*/
    if i == 1 then
      W_cond[i] = A_htf * k_htf * (T_htf[i+1]-2*T_htf[i]+TI_htf) / Delta_x;
      W_conv[i] = - dm_htf * Cp_htf * u * (T_htf[i]-TI_htf) / Delta_x;
    elseif i == n then
      W_cond[i] = A_htf * k_htf * (TO_htf-2*T_htf[i]+T_htf[i-1]) / Delta_x;
      W_conv[i] = - dm_htf * Cp_htf * u * (T_htf[i]-T_htf[i-1]) / Delta_x;
    else
      W_cond[i] = A_htf * k_htf * (T_htf[i+1]-2*T_htf[i]+T_htf[i-1]) / Delta_x;
      W_conv[i] = - dm_htf * Cp_htf * u * (T_htf[i]-T_htf[i-1]) / Delta_x;
    end if;
    W_pcm[i] = U_pcm * dS_pcm * (T_pcm[i] - T_htf[i]);
    W_air[i] = U_air * dS_amb * (T_htf[i] - T_amb);
    der(Q_htf[i]) = W_cond[i] + W_conv[i] + W_pcm[i] - W_air[i];
    der(Q_htf[i]) = dm_htf * Cp_htf * der(T_htf[i]);
    der(Q_pcm[i]) = -W_pcm[i];
    der(Q_air[i]) = W_air[i];
  end for;

  // *** Heat stored *** //
  Q_perdu = -sum(Q_air);
  Q_htf_stored = -sum(Q_htf);
  Q_pcm_stored = -sum(Q_pcm);
  Delta_Q_stored_ini = f * V * rho_htf * Cp_htf * (T_0-T_qzero) + V_pcm * rho_pcm * (h_pcm_0-h_pcm_qzero);
  Q_stored = Q_htf_stored + Q_pcm_stored + Delta_Q_stored_ini;
  P_charge = der(Q_stored);

  // *** Niveau de stockage *** //
  x_stock = sum(xL_pcm)/n;
  if abs(TI_htf-TO_htf)<2 then
    if charge == true then
      N_stock = 1-x_stock;
    else
      N_stock = 0;
    end if;
  else
    N_stock = 1-x_stock;
  end if;

  //  N_stock = (1-x_stock)*T_stock;
 // end if;

  connect(timer_N_stock0.u, realToBoolean.y)
    annotation (Line(points={{22,30},{22,30},{11,30}}, color={255,0,255}));
  connect(realExpression.y, realToBoolean.u)
    annotation (Line(points={{-21,30},{-12,30}}, color={0,0,127}));
  connect(realToBoolean1.y, timer_N_stock1.u)
    annotation (Line(points={{11,2},{16.5,2},{22,2}}, color={255,0,255}));
  connect(realExpression1.y, realToBoolean1.u)
    annotation (Line(points={{-21,2},{-16.5,2},{-12,2}}, color={0,0,127}));
    annotation(Dialog(group="Storage volume characteristics"));
end LatentHeatStorage;
