within IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer;
model MonoLayer "single material layer"

  parameter Modelica.SIunits.Area A "Layer surface area";
  parameter IDEAS.Buildings.Data.Interfaces.Material mat
    "Layer material properties";
  parameter Modelica.SIunits.Angle inc
    "Inclinination angle of the layer at port_a";
  parameter Modelica.SIunits.Emissivity epsLw_a
    "Longwave emissivity of material connected at port_a";
  parameter Modelica.SIunits.Emissivity epsLw_b
    "Longwave emissivity on material connected at port_b";

  parameter Boolean linIntCon=false
    "Linearise interior convection inside air layers / cavities in walls";
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=if mat.glass then Modelica.Fluid.Types.Dynamics.SteadyState else Modelica.Fluid.Types.Dynamics.FixedInitial
    "Static (steady state) or transient (dynamic) thermal conduction model"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.SIunits.Temperature T_start=293.15
    "Start temperature for each of the states";
  parameter Boolean checkCoating = false
    "Throw if an air cavity does not have a coating";
  final parameter Modelica.SIunits.ThermalInsulance R = mat.R
    "Total specific thermal resistance";
  final parameter Boolean isDynamic = dynamicLayer and realLayer and not airLayer;

  Modelica.SIunits.Energy E = E_internal;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    "Port for connections between layers"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    "Port for connections between layers"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_gain
    "Port for heat gains in layers"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MonoLayerDynamic
    monLayDyn(
    A=A,
    mat=mat,
    T_start=T_start,
    energyDynamics=energyDynamics) if isDynamic
    "Dynamic monolayer for solid"
    annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));

  IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.MonoLayerAir
    monLayAir(
    A=A,
    inc=inc,
    d=mat.d,
    k=mat.k,
    epsLw_a=epsLw_a,
    epsLw_b=epsLw_b,
    linearise=linIntCon,
    dT_nominal=dT_nom_air,
    checkCoating=checkCoating) if                 realLayer and airLayer
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MonoLayerStatic
    monLaySta(R=R/A) if
       realLayer and not dynamicLayer and not airLayer
    annotation (Placement(transformation(extent={{0,70},{20,90}})));

protected
  Modelica.Blocks.Interfaces.RealInput E_internal;
  final parameter Boolean dynamicLayer= not energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState
    "True when modelling thermal dynamics"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  final parameter Boolean realLayer = mat.d > Modelica.Constants.small
    "True when the layer has a non-zero thickness";

  final parameter Boolean airLayer = mat.gas
    "True when a convection + radiation equation should be used to model the layer instead of conduction";

public
  parameter SI.TemperatureDifference dT_nom_air=1
    "Nominal temperature difference for air layers, used for linearising Rayleigh number";
equation
  connect(E_internal, monLayDyn.E);
  if not realLayer or airLayer or not dynamicLayer then
    E_internal=0;
  end if;

  // Connections for fictive layers
  if not realLayer then
    connect(port_a, port_b) annotation (Line(
      points={{-100,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  end if;

  // Connections for dynamic layers
  connect(port_a, monLayDyn.port_a) annotation (Line(
      points={{-100,0},{-100,-32},{-10,-32}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(monLayDyn.port_b, port_b) annotation (Line(
      points={{10,-32},{100,-32},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));

  // Connections for air layers
  connect(monLayAir.port_a, port_a) annotation (Line(points={{-20,40},{-100,40},
          {-100,0}},         color={191,0,0}));
  connect(monLayAir.port_b, port_b) annotation (Line(points={{0,40},{100,40},{100,
          0}},            color={191,0,0}));

  // Connections for static layers
  connect(port_a, monLaySta.port_a) annotation (Line(points={{-100,0},{-100,0},{
          -100,78},{-100,80},{0,80}},   color={191,0,0}));
  connect(monLaySta.port_b, port_b) annotation (Line(points={{20,80},{20,80},{100,
          80},{100,0}}, color={191,0,0}));

  // For static monolayers or air monolayer, connect port_gain in the middle of the layer.
  connect(monLayAir.port_emb, port_gain)
    annotation (Line(points={{-10,50},{-10,50},{-10,100},{0,100}},
                                     color={191,0,0}));
  connect(port_gain, monLaySta.port_gain)
    annotation (Line(points={{0,100},{8,100},{10,100},{10,90}},
                                              color={191,0,0}));
  // For dynamic monolayers or fictive monolayers, connect port_gain at port_b of the layer.
  if not realLayer or realLayer and dynamicLayer and not airLayer then
    connect(port_a, port_gain) annotation (Line(points={{-100,0},{-100,0},{-100,
            100},{0,100}},
                    color={191,0,0}));
  end if;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(graphics={Rectangle(
          extent={{-90,80},{90,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),Text(
          extent={{-150,113},{150,73}},
          textString="%name",
          lineColor={0,0,255}),Ellipse(
          extent={{-40,-42},{40,38}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-39,40},{39,-40}},
          lineColor={127,0,0},
          fontName="Calibri",
          origin={0,-1},
          rotation=90,
          textString="S")}),
    Documentation(info="<html>
</html>", revisions="<html>
<ul>
<li>
September 9, 2019, by Kristoff Six:<br/>
Updated with <code>checkCoating</code> for issue
<a href=\"https://github.com/open-ideas/IDEAS/issues/1038\">#1038</a>.
</li>
<li>
January 25, 2019, by Filip Jorissen:<br/>
Revised initial equation implementation.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/971>#971</a>.
</li>
<li>
March 8, 2016, by Filip Jorissen:<br/>
Fixed bug in connection of internal gains. 
Now connecting to port_a instead of port_b.
</li>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation: now only one MonoLayer component exists.
</li>
</ul>
</html>"));
end MonoLayer;
