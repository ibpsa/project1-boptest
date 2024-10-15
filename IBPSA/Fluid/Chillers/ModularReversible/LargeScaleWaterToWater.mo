within IBPSA.Fluid.Chillers.ModularReversible;
model LargeScaleWaterToWater "Large scale water to water chiller"
  extends Modular(
    dpEva_nominal=datTab.dpEva_nominal*scaFac^2,
    dpCon_nominal=datTab.dpCon_nominal*scaFac^2,
    final dTEva_nominal=-QCoo_flow_nominal/cpEva/mEva_flow_nominal,
    final dTCon_nominal=(PEle_nominal - QCoo_flow_nominal)/cpCon/mCon_flow_nominal,
    redeclare replaceable package MediumCon = IBPSA.Media.Water,
    redeclare replaceable package MediumEva = IBPSA.Media.Water,
    final GEvaIns=0,
    final GEvaOut=0,
    final CEva=0,
    final use_evaCap=false,
    final GConIns=0,
    final GConOut=0,
    final CCon=0,
    final TConHea_nominal=0,
    final TEvaHea_nominal=0,
    final use_conCap=false,
        redeclare replaceable
    IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021 safCtrPar
      constrainedby
      IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Generic(
      final tabUppHea=datTab.tabLowBou,
      final tabLowCoo=datTab.tabLowBou,
      final use_TEvaOutCoo=datTab.use_TEvaOutForOpeEnv,
      final use_TConOutCoo=datTab.use_TConOutForOpeEnv),
    redeclare model RefrigerantCycleInertia =
        IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Inertias.NoInertia,
    redeclare model RefrigerantCycleChillerHeating =
        IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.NoHeating,
    redeclare model RefrigerantCycleChillerCooling =
        IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.TableData2D (
        redeclare
          IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.NoFrosting
          iceFacCal, datTab=datTab),
    final use_rev=false,
    final QHea_flow_nominal=0,
    final mCon_flow_nominal=autCalMasCon_flow,
    final mEva_flow_nominal=autCalMasEva_flow,
    final tauCon=autCalVCon*rhoCon/autCalMasCon_flow,
    final tauEva=autCalVEva*rhoEva/autCalMasEva_flow);
  final parameter Real scaFac=refCyc.refCycChiCoo.scaFac "Scaling factor of chiller";

  extends IBPSA.Fluid.HeatPumps.ModularReversible.BaseClasses.LargeScaleWaterToWaterDeclarations(
    final autCalMasCon_flow=max(5E-5*abs(QCoo_flow_nominal) + 0.3161, autCalMMin_flow),
    final autCalMasEva_flow=max(5E-5*abs(QCoo_flow_nominal) - 0.5662, autCalMMin_flow),
    final autCalVCon=max(2E-7*abs(QCoo_flow_nominal) - 84E-4, autCalVMin),
    final autCalVEva=max(1E-7*abs(QCoo_flow_nominal) - 66E-4, autCalVMin));
  replaceable parameter
    IBPSA.Fluid.Chillers.ModularReversible.Data.TableData2D.Generic
    datTab constrainedby Data.TableData2D.Generic "Data Table of Chiller"
    annotation (choicesAllMatching=true,
    Placement(transformation(extent={{42,12},{58,28}})));

  annotation (Documentation(info="<html>
<p>
  Large scale water-to-water chiller,
  using the
  <a href=\"modelica://IBPSA.Fluid.Chillers.ModularReversible.Modular\">
  IBPSA.Fluid.Chillers.ModularReversible.Modular</a> approach.
</p>
<p>
  Contrary to the standard sizing approach for the <a href=\"modelica://IBPSA.Fluid.Chillers.ModularReversible.Modular\">
  IBPSA.Fluid.Chillers.ModularReversible.Modular</a> models,
  the parameters are based on an automatic estimation as described in
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.ModularReversible.BaseClasses.LargeScaleWaterToWaterDeclarations\">
  IBPSA.Fluid.HeatPumps.ModularReversible.BaseClasses.LargeScaleWaterToWaterDeclarations</a>.
</p>
<p>
  For more information on the approach, see
  <a href=\"modelica://IBPSA.Fluid.HeatPumps.ModularReversible.UsersGuide\">
  UsersGuide</a>.
</p>
<p>
  The documentation of the model for cooling is at
  <a href=\"modelica://IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.TableData2D\">
  IBPSA.Fluid.Chillers.ModularReversible.RefrigerantCycle.TableData2D</a>.
</p>
<h4>Assumptions</h4>
<ul>
<li>
  As heat losses are implicitly included in measured
  data in manufacturer dataseheets, heat losses are disabled.
</li>
<li>
  Pressure losses are not provided in datasheets. As typical
  values are unknown, the pressure loss is set to <i>0</i> to enable
  easier usage. However, the parameter is not final and should be
  replaced if pump electrical power consumption is of interest for your simulation aim.
</li>
</ul>
</html>", revisions="<html><ul>
  <li>
    <i>Novemeber 11, 2022</i> by Fabian Wuellhorst:<br/>
    Implemented <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
  </li>
</ul>
</html>"));
end LargeScaleWaterToWater;
