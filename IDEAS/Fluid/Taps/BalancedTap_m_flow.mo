within IDEAS.Fluid.Taps;
model BalancedTap_m_flow "DHW consumption with input for flowrate at 60 degC"
  extends IDEAS.Fluid.Taps.Interfaces.BalancedTap(idealSource(m_flow_small=
          m_flow_nominal/1000));
  Modelica.Blocks.Interfaces.RealInput mDHW60C(unit="kg/s")
    "Mass flowrate of DHW at 60 degC in kg/s"
    annotation (Placement(transformation(extent={{-120,80},{-80,120}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,100})));

equation
  mDHW60C = mFlo60C
  annotation (Documentation(info="<html>
<h4>Description</h4>
<p>Model of a domestic hot water (DHW) system composed mainly of a thermostatic mixing valve. The DHW flow rate is passed as a realInput.</p>
<p>This model is an extension of the <a href=\"modelica://IDEAS.Thermal.Components.Domestic_Hot_Water.partial_DHW\">Partial_DHW</a> model, see there for the documentation.</p>
<h4>Examples</h4>
<p>An example of this model is given in <a href=\"modelica://IDEAS.Thermal.Components.Examples.StorageTank_DHW_HP\">IDEAS.Thermal.Components.Examples.StorageTank_DHW_HP</a>.</p>
</html>"));
end BalancedTap_m_flow;
