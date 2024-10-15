within IDEAS.Buildings.Components.ZoneAirModels;
model WellMixedAir "Zone air model assuming perfectly mixed air"
  // We assume an initial CO2 concentration of 400 ppm, if the medium contains CO2
  extends IDEAS.Buildings.Components.ZoneAirModels.BaseClasses.PartialAirModel(
    C_start=400*s*MMFraction/1e6,
    final nSeg=1,
    mSenFac(min=0)=5);

    parameter StateSelect stateSelectTVol = if sim.linearise then StateSelect.prefer else StateSelect.default
      "Set to .prefer to use temperature as a state in mixing volume";

    Real ACH(unit="1/h") = (sum(m_flow_pos)*3600/rho_default)/Vtot
      "Air change rate per hour";

protected
  final parameter Modelica.SIunits.MolarMass MM=
    Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
    "Molar mass of the trace substance";
  final parameter Modelica.SIunits.MolarMass MMBul=Medium.molarMass(
    Medium.setState_phX(
      p=Medium.p_default,
      h=Medium.h_default,
      X=Medium.X_default)) "Molar mass of bulk medium";
  final parameter Real MMFraction=MM/MMBul
    "Molar mass of CO2 divided by the molar mass of the medium";

  constant Modelica.SIunits.SpecificEnthalpy lambdaWater = IDEAS.Media.Air.enthalpyOfCondensingGas(T=273.15+35)
    "Latent heat of evaporation water";
  constant Boolean hasVap = Medium.nXi>0
    "Medium has water vapour";
  constant Boolean hasPpm = sum(s)>0
    "Medium has trace substance";
  MixingVolumeNominal       vol(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    allowFlowReversal=allowFlowReversal,
    V=Vtot,
    mSenFac=mSenFac,
    U_nominal=mSenFac*10*Vtot*1.2*1000,
    use_C_flow=true,
    nPorts=(2 + (if hasVap then 1 else 0) + (if hasPpm then 1 else 0))+nPorts,
    m_flow_nominal=0.1,
    T(stateSelect=stateSelectTVol))  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,0})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTem
    annotation (Placement(transformation(extent={{10,-50},{30,-70}})));
  Modelica.Blocks.Math.Gain gaiLat(k=lambdaWater)
    "Gain for computing latent heat flow rate based on water vapor mass flow rate"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,58})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloLat(final
      alpha=0)
    "Prescribed heat flow rate for latent heat gain corresponding to water vapor mass flow rate"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,22})));
protected
  constant Real s[:]= {
  if ( Modelica.Utilities.Strings.isEqual(string1=Medium.extraPropertiesNames[i],
                                            string2="CO2",
                                            caseSensitive=false))
  then 1 else 0 for i in 1:Medium.nC}
    "Vector with zero everywhere except where species is";

  Modelica.SIunits.MassFlowRate m_flow_pos[nPorts+2]
    "Truncated mass flow rate";
  IDEAS.Fluid.Sensors.RelativeHumidity senRelHum(
    redeclare package Medium = Medium,
    final warnAboutOnePortConnection=false) if hasVap
    "Relative humidity of the zone air"
    annotation (Placement(transformation(extent={{30,-30},{50,-50}})));
    model MixingVolumeNominal
      "To avoid warning when modifying parameters of protected submodel dynBal of MixingVolumeMoistAir"
      parameter Modelica.SIunits.Energy U_nominal = mSenFac*10*m_nominal*1000 "Nominal value of internal energy";
      parameter Modelica.SIunits.Mass m_nominal = V*1.2 "Nominal value of internal energy";
      parameter Real[Medium.nXi] mXi_nominal = m_nominal*Medium.X_default[1:Medium.nXi] "Nominal value of internal energy";
      parameter Real[Medium.nC] mC_nominal = m_nominal*0.0015*ones(Medium.nC) "Nominal value of internal energy";
      extends IDEAS.Fluid.MixingVolumes.MixingVolumeMoistAir(
        mSenFac(min=0),
        dynBal(
          U(nominal=U_nominal),
          mC(nominal=mC_nominal),
          mXi(nominal=mXi_nominal),
          m(nominal=m_nominal)));
    end MixingVolumeNominal;
  IDEAS.Fluid.Sensors.PPM senPPM(
    redeclare package Medium = Medium,
    final warnAboutOnePortConnection=false) if  hasPpm
    "CO2 sensor"
    annotation (Placement(transformation(extent={{50,-10},{70,-30}})));




equation

  for i in 1:nPorts+2 loop
    m_flow_pos[i]= max(vol.ports[i].m_flow,0);
  end for;

  if hasVap then
    assert(vol.ports[1].Xi_outflow[1] <= 0.1,
           "The water content of the zone air model is very high. 
           Possibly you are simulating occupants (that generates a latent heat load), 
           but air is not being refreshed (for instance using ventilation or air leakage models)?",
           level=AssertionLevel.warning);
  else
    phi=0;
  end if;
  if not hasPpm then
    ppm=0;
  end if;

  E=vol.U;
  QGai=preHeaFloLat.Q_flow;
  for i in 1:nSurf loop
    connect(vol.heatPort, ports_surf[i]) annotation (Line(points={{10,
            -1.33227e-15},{10,-20},{-40,-20},{-40,0},{-100,0}},
                                               color={191,0,0}));
  end for;
  for i in 1:nSeg loop
    connect(ports_air[i], vol.heatPort) annotation (Line(points={{100,0},{20,0},
            {20,-20},{10,-20},{10,0}},
                                   color={191,0,0}));
  end for;
  connect(senTem.port, vol.heatPort) annotation (Line(points={{10,-60},{10,0}},
                              color={191,0,0}));
  connect(senTem.T,TAir)
    annotation (Line(points={{30,-60},{110,-60}},          color={0,0,127}));
  connect(vol.mWat_flow, mWat_flow) annotation (Line(points={{12,-8},{16,-8},{
          16,80},{108,80}},
                         color={0,0,127}));
  connect(vol.C_flow[1:Medium.nC], C_flow[1:Medium.nC]) annotation (Line(points={{12,6},{
          18,6},{18,40},{108,40}},
                color={0,0,127}));
  connect(gaiLat.y, preHeaFloLat.Q_flow)
    annotation (Line(points={{64,47},{64,32}}, color={0,0,127}));
  connect(gaiLat.u, mWat_flow)
    annotation (Line(points={{64,70},{64,80},{108,80}}, color={0,0,127}));
  connect(preHeaFloLat.port, vol.heatPort) annotation (Line(points={{64,12},{64,
          0},{20,0},{20,-20},{10,-20},{10,0}},
                                 color={191,0,0}));
  connect(senRelHum.phi, phi)
    annotation (Line(points={{51,-40},{110,-40}},          color={0,0,127}));
  connect(port_b, vol.ports[2]) annotation (Line(points={{-60,100},{-60,10},{
          1.33227e-15,10}},
                color={0,127,255}));
  connect(port_a, vol.ports[1]) annotation (Line(points={{60,100},{60,10},{8.88178e-16,
          10}}, color={0,127,255}));
  connect(senRelHum.port, vol.ports[nPorts+3]) annotation (Line(points={{40,-30},
          {40,10},{1.33227e-15,10}},
                          color={0,127,255}));
  connect(senPPM.port, vol.ports[nPorts+3+(if hasVap then 1 else 0)]) annotation (Line(points={{60,-10},
          {60,10},{1.33227e-15,10}},
                          color={0,127,255}));
  connect(ports[1:nPorts], vol.ports[3:nPorts+2]) annotation (Line(points={{0,100},
          {0,10},{1.33227e-15,10}},
                          color={0,127,255}));
  connect(senPPM.ppm, ppm)
    annotation (Line(points={{71,-20},{110,-20}}, color={0,0,127}));
   annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(revisions="<html>
<ul>
<li>
November 21, 2020 by Filip Jorissen:<br/>
Avoiding warnings for one port sensors.
</li>
<li>
December 13, 2019 by Filip Jorissen:<br/>
Directly referencing <code>IDEAS.Media.Air</code> instead of <code>Medium</code>
to avoid warnings in Dymola and errors in OpenModelica.
<a href=\"https://github.com/open-ideas/IDEAS/issues/1097\">#1097</a>.
</li>
<li>
March 29, 2019 by Filip Jorissen:<br/>
Added start value for CO2 concentration for
<a href=\"https://github.com/open-ideas/IDEAS/issues/1004\">#1004</a>.
</li>
<li>
February 14, 2019 by Filip Jorissen:<br/>
Changed default value of <code>stateSelectTVol</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/982\">#982</a>.
</li>
<li>
December 11, 2018 by Filip Jorissen:<br/>
Revised mixing volume connection order to avoid triggering flow reversal warnings.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/964\">#964</a>.
</li>
<li>
August 30, 2018 by Damien Picard:<br/>
Added constant StateSelectTVol to be able to select preferred state
of mixing volume.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/905\">#905</a>.
</li>
<li>
July 27, 2018 by Filip Jorissen:<br/>
Added nominal values for <code>m</code>, <code>mXi</code> and <code>mC</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/864\">#864</a>.
</li>
<li>
Added output for the CO2 concentration.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/868\">#868</a>.
</li>
<li>
April 27, 2018 by Filip Jorissen:<br/>
Created <code>MixingVolumeNominalU</code> such that 
<code>MixingVolume</code> can be used without generating a warning.
</li>
<li>
April 27, 2018 by Filip Jorissen:<br/>
Added nominal value for internal energy of mixing volume.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/797\">#797</a>.
</li>
<li>
Modified model for supporting new interzonal air flow models.
Air leakage model and its parameters have been removed.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/796\">#796</a>.
</li>
<li>
August 5, 2017 by Filip Jorissen:<br/>
Added support for dry air.
</li>
<li>
November 15, 2016 by Filip Jorissen:<br/>
Revised documentation.
</li>
<li>
August 26, 2016 by Filip Jorissen:<br/>
Added support for conservation of energy.
</li>
<li>
April 30, 2016, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Perfectly mixed air model.
</p>
<h4>Main equations</h4>
<p>
This model computes a single air temperature that is used to 
evaluate convective heat transfer of all surfaces,
components connected to gainCon (e.g. radiators), etc.
The air outlet temperature equals the well mixed air temperature.
</p>
<h4>Assumption and limitations</h4>
<p>
This model is not valid for buildings where stratification occurs, 
e.g. when using floor cooling
or ceiling heating.
</p>
<p>
When dry air is used, then the relative humidity output is set to zero.
</p>
<h4>Typical use and important parameters</h4>
<p>
The zone air volume <code>Vto</code> determines the thermal mass of the air.
This mass may be artificially increased using <code>mSenFac</code> if desired, 
e.g. to take into account the thermal mass of furniture.
</p>
<h4>Dynamics</h4>
This model only contains states to represent the energy and mass dynamics, 
typically using a temperature and pressure variable.
Parameters <code>energyDynamics</code> and <code>massDynamics</code>
may be used to change the model dynamics.
<h4>Validation</h4>
<p>
See BESTEST.
</p>
</html>"));
end WellMixedAir;
