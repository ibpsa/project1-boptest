within IDEAS.Buildings.Components.InternalGains;
model Occupants "Constant sensible, latent and CO2 heat production per person"
  extends BaseClasses.PartialOccupancyGains;
  parameter Modelica.SIunits.Power QlatPp = occupancyType.QlatPp
    "Latent heat production per person, default from Ashrae Fundamentals: 'Seated, very light work'";
  parameter Modelica.SIunits.Power QsenPp = occupancyType.QsenPp
    "Sensible heat production per person, default from Ashrae Fundamentals: 'Seated, very light work'";
  parameter Real radFra(min=0,max=1) = occupancyType.radFra
    "Radiant fraction of sensible heat exchange, default based on Ashrae fundamentals chap 18.4 for low air velocity";
protected
  constant Modelica.SIunits.SpecificEnthalpy lambdaWater = if (Medium.nX) > 1 then Medium.enthalpyOfCondensingGas(T=273.15+35) else 2566120
    "Latent heat of evaporation of water at 35 degrees Celsius";
  constant Modelica.SIunits.SpecificEnthalpy E_glu = 16e6
    "Calorific value of glucose";
  constant Real MM_glu = 180
    "Molar mass of glucose";
  constant Real MM_CO2 = 44
    "Molar mass of CO2";
  parameter Real m_flow_co2_pp = (QlatPp+QsenPp)/(E_glu*MM_glu/6/MM_CO2)
    "CO2 production per person, based on oxidation of suger with calorific value of 16 kJ/g";
  final parameter Modelica.SIunits.MassFlowRate m_flow_h2o_pp = QlatPp/lambdaWater
    "Vapor production per person";
  final parameter Real s_co2[max(Medium.nC,1)] = {if Modelica.Utilities.Strings.isEqual(string1=if Medium.nC>0 then Medium.extraPropertiesNames[i] else "",
                                             string2="CO2",
                                             caseSensitive=false)
                                             then 1 else 0 for i in 1:max(Medium.nC,1)};
  Modelica.Blocks.Math.Gain gaiHea(k=QsenPp)
                "Gain for computing heat flow rate"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Math.Gain[max(Medium.nC,1)] gaiCO2(k=m_flow_co2_pp*s_co2)
    "Gain for computing CO2 mass flow rate"
    annotation (Placement(transformation(extent={{-8,10},{12,30}})));
  Modelica.Blocks.Math.Gain gaiWat(k=m_flow_h2o_pp)
    "Gain for computing water mass flow rate"
    annotation (Placement(transformation(extent={{-8,50},{12,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloCon(final
      alpha=0) "Prescribed heat flow rate for convective sensible heat"
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
public
  Modelica.Blocks.Math.Gain gain(final k=radFra)
    annotation (Placement(transformation(extent={{-8,-70},{12,-50}})));
  Modelica.Blocks.Math.Gain gainCon(final k=1 - radFra)
    annotation (Placement(transformation(extent={{-8,-30},{12,-10}})));
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloRad(final
      alpha=0) "Prescribed heat flow rate for radiative sensible heat"
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
equation
  connect(gaiWat.y, mWat_flow)
    annotation (Line(points={{13,60},{106,60},{106,60}}, color={0,0,127}));
  connect(gaiCO2.y, C_flow)
    annotation (Line(points={{13,20},{60,20},{106,20}}, color={0,0,127}));
  connect(preHeaFloCon.port, portCon)
    annotation (Line(points={{60,-20},{82,-20},{100,-20}}, color={191,0,0}));
  connect(gaiHea.u, nOcc)
    annotation (Line(points={{-62,-40},{-110,-40},{-110,0}}, color={0,0,127}));
  for i in 1:max(Medium.nC,1) loop
    connect(gaiCO2[i].u, nOcc)
      annotation (Line(points={{-10,20},{-60,20},{-60,0},{-110,0}},
                                                  color={0,0,127}));
  end for;
  connect(gaiWat.u, nOcc)
    annotation (Line(points={{-10,60},{-110,60},{-110,0}}, color={0,0,127}));
  connect(preHeaFloRad.port, portRad)
    annotation (Line(points={{60,-60},{100,-60},{100,-60}}, color={191,0,0}));
  connect(gain.y, preHeaFloRad.Q_flow)
    annotation (Line(points={{13,-60},{40,-60}},          color={0,0,127}));
  connect(gainCon.y, preHeaFloCon.Q_flow) annotation (Line(points={{13,-20},{26,
          -20},{40,-20}},          color={0,0,127}));
  connect(gainCon.u, gaiHea.y)
    annotation (Line(points={{-10,-20},{-39,-20},{-39,-40}}, color={0,0,127}));
  connect(gain.u, gaiHea.y)
    annotation (Line(points={{-10,-60},{-39,-60},{-39,-40}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This occupancy model assumes a constant latent and sensible load per person. 
We assume this heat gain is caused by the metabolic combustion of suger, 
resulting into a corresponding CO2 production. 
The CO2 mass flow rate is added only if the Medium contains CO2. 
Latent heat is only added if the Medium is a moist air medium. 
Sensible heat is emitted both as convective and radiant heat using a fixed weighing factor.
</p>
</html>",
        revisions="<html>
<ul>
<li>
June 3, 2020 by Iago Cupeiro:<br/>
Changed latent heat of evaporation of water.
This is for issue
<a href=https://github.com/open-ideas/IDEAS/issues/1141>#1141</a>.
</li>
<li>
July 26, 2018 by Filip Jorissen:<br/>
Revised implementation to add support for
<a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
<li>
January 18, 2017 by Filip Jorissen:<br/>
Changed latent heat of evaporation of water.
This is for issue
<a href=https://github.com/open-ideas/IDEAS/issues/635>#635</a>.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
end Occupants;
