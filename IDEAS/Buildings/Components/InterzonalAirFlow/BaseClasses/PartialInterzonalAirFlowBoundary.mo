within IDEAS.Buildings.Components.InterzonalAirFlow.BaseClasses;
partial model PartialInterzonalAirFlowBoundary
  "Partial interzonal air flow model that includes a boundary"
  extends
    IDEAS.Buildings.Components.InterzonalAirFlow.BaseClasses.PartialInterzonalAirFlow;
  outer BoundaryConditions.SimInfoManager sim "Simulation information manager"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  IDEAS.Fluid.Sources.OutsideAir bou(
    redeclare package Medium = Medium,
    azi=0)
    "Boundary model" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,10})));
protected
  final parameter Real s_co2[max(Medium.nC,1)] = {if Modelica.Utilities.Strings.isEqual(string1=if Medium.nC>0 then Medium.extraPropertiesNames[i] else "",
                                             string2="CO2",
                                             caseSensitive=false)
                                             then 1 else 0 for i in 1:max(Medium.nC,1)};
  IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(numSolBus=sim.numIncAndAziInBus, outputAngles=sim.outputAngles)
    annotation (Placement(transformation(extent={{-78,80},{-58,100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo(final
      alpha=0) if                                                                 sim.computeConservationOfEnergy
    "Prescribed heat flow rate for conservation of energy check" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-90,66})));
  Modelica.Blocks.Sources.RealExpression QGai(y=-actualStream(bou.ports.h_outflow)
        *bou.ports.m_flow) "Net heat gain through n50 air leakage "
    annotation (Placement(transformation(extent={{-22,30},{-82,50}})));

equation
  connect( sim.weaBus,weaBus);
  connect(port_a_interior, port_b_exterior) annotation (Line(points={{-60,-100},
          {-60,0},{-60,0},{-60,100}}, color={0,127,255}));
  connect(port_a_exterior, port_b_interior) annotation (Line(points={{60,100},{
          60,0},{60,0},{60,-100}},
                                color={0,127,255}));
  connect(preHeaFlo.port, sim.Qgai)
    annotation (Line(points={{-90,76},{-90,80}}, color={191,0,0}));
  connect(QGai.y, preHeaFlo.Q_flow)
    annotation (Line(points={{-85,40},{-90,40},{-90,56}}, color={0,0,127}));


  if Medium.nX == 2 then
  end if;
  if Medium.nC > 0 then
  end if;


  annotation (Documentation(revisions="<html>
<ul>
<li>
March 17, 2020, Filip Jorissen:<br/>
Added support for vector fluidport.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1029\">#1029</a>.
</li>
<li>
September 21, 2019 by Filip Jorissen:<br/>
Using OutsideAir.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1052\">#1052</a>.
</li>
<li>
September 24, 2018 by Filip Jorissen:<br/>
Fix for supporting multiple trace substances.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/920\">#920</a>.
</li>
<li>
August 24, 2018 by Damien Picard:<br/>
Use weaDatBus.Te instead of sim.Te such that the variable is correctly 
used when linearizing with LIDEAS.
</li>
<li>
June 11, 2018 by Filip Jorissen:<br/>
Using <code>Xi_in</code> instead of <code>X_in</code> since this
requires fewer inputs and it avoids an input variable consistency check.
</li>
<li>
April 27, 2018 by Filip Jorissen:<br/>
First version.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/796\">#796</a>.
</li>
</ul>
</html>"));
end PartialInterzonalAirFlowBoundary;
