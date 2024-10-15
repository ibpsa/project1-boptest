within IDEAS.Templates.Interfaces.BaseClasses;
partial model HeatingSystem "Partial heating/cooling system"
  extends IDEAS.Templates.Interfaces.BaseClasses.PartialSystem;
  replaceable package Medium=IDEAS.Media.Water;

  // *********** Building characteristics and  interface ***********
  //parameter Boolean isHea=true "=true, if system is able to heat";
  //parameter Boolean isCoo=false "=true, if system is able to cool";
  parameter Boolean isDH=false "=true, if the system is connected to a DH grid";
  //parameter Boolean InInterface = false;
  parameter Modelica.SIunits.Power[nZones] Q_design
    "Total design heat load for heating system based on heat losses" annotation(Dialog(enable=InInterface));

  // --- Ports
  parameter Integer nConvPorts(min=0) = nZones
    "Number of ports in building for convective heating/cooling"
    annotation(Dialog(tab="Advanced"));
  parameter Integer nRadPorts(min=0) = nZones
    "Number of ports in building for radiative heating/cooling"
    annotation(Dialog(tab="Advanced"));
  parameter Integer nEmbPorts(min=0) = nZones
    "Number of ports in building for embedded systems"
    annotation(Dialog(tab="Advanced"));

  // --- Sensor
  parameter Integer nTemSen(min=0) = nZones
    "number of temperature inputs for the system";

  // *********** Outputs ***********
  // --- Thermal
  Modelica.SIunits.Power QHeaSys=
    sum({max(0,-heatPortCon[i].Q_flow) for i in 1:nConvPorts})
    +sum({max(0,-heatPortRad[i].Q_flow) for i in 1:nRadPorts})
    +sum({max(0,-heatPortEmb[i].Q_flow) for i in 1:nEmbPorts})
    "Total thermal power use for space heating";
  Modelica.SIunits.Power QCooTotal=
    sum({max(0,heatPortCon[i].Q_flow) for i in 1:nConvPorts})
    +sum({max(0,heatPortRad[i].Q_flow) for i in 1:nRadPorts})
    +sum({max(0,heatPortEmb[i].Q_flow) for i in 1:nEmbPorts})
    "Total thermal power use for cooling";

  // *********** Interface ***********
  // --- thermal
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nConvPorts] heatPortCon
    "Nodes for convective heat gains"
    annotation (Placement(transformation(extent={{-210,10},{-190,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nRadPorts] heatPortRad
    "Nodes for radiative heat gains"
    annotation (Placement(transformation(extent={{-210,-30},{-190,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nEmbPorts] heatPortEmb
    "Construction nodes for heat gains by embedded layers"
    annotation (Placement(transformation(extent={{-210,50},{-190,70}})));

  // --- Sensor
  Modelica.Blocks.Interfaces.RealInput[nTemSen] TSensor(
    final quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC",
    min=0) "Sensor temperature" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-204,-60})));

  Modelica.Blocks.Interfaces.RealInput[nZones] TSet(
    final quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC",
    min=0) "Setpoint temperature for the zones" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-104}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-102})));

  // --- fluid
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = Medium) if
       isDH
    "Supply water connection to the DH grid"
    annotation (Placement(transformation(extent={{110,-110},{130,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium) if
       isDH
    "Return water connection to the DH grid"
    annotation (Placement(transformation(extent={{150,-110},{170,-90}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,
            100}}), graphics={
        Rectangle(
          extent={{-200,100},{200,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={191,0,0}),
        Line(
          points={{50,-20},{30,0}},
          color={0,0,127}),
        Line(
          points={{30,0},{0,-30}},
          color={0,0,127},
          pattern=LinePattern.Dash),
        Line(
          points={{30,0},{-8,0}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{200,100},{200,-100}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(
          points={{-28,-20},{-128,-20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-28,20},{-128,20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-8,0},{-28,-20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-8,0},{-28,20}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{-128,0},{-128,40},{-158,20},{-128,0}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-128,-40},{-128,0},{-158,-20},{-128,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-158,40},{-178,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{200,0},{30,0}},
          color={85,170,255},
          smooth=Smooth.None),
        Line(points={{30,70},{30,40}}),
        Line(points={{52.9,32.8},{70.2,57.3}}),
        Line(points={{7.1,32.8},{-10.2,57.3}}),
        Line(points={{67.6,13.7},{95.8,23.9}}),
        Ellipse(
          lineColor={64,64,64},
          fillColor={215,215,215},
          extent={{18,-12},{42,12}},
          fillPattern=FillPattern.Solid),
        Polygon(
          origin={30,0},
          rotation=-17.5,
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
        Ellipse(
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{23,-7},{37,7}}),
        Line(
          points={{60,-30},{50,-20}},
          color={0,0,127},
          pattern=LinePattern.Dash),
        Line(
          points={{0,-100},{0,-30}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{60,-100},{60,-30}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
            200,100}})),
    Documentation(info="<html>
<p><b>Description</b> </p>
<p>Interface model for a complete multi-zone heating system (with our without domestic hot water and solar system).</p>
<p>This model defines the ports used to link a heating system with a building, and the basic parameters that most heating systems will need to have. The model is modular as a function of the number of zones <i>nZones. </i></p>
<p>Two sets of heatPorts are defined:</p>
<ol>
<li><i>heatPortCon[nZones]</i> and <i>heatPortRad[nZones]</i> for convective respectively radiative heat transfer to the building. </li>
<li><i>heatPortEmb[nZones]</i> for heat transfer to TABS elements in the building. </li>
</ol>
<p>The model also defines <i>TSensor[nZones]</i> and <i>TSet[nZones]</i> for the control, and a nominal power <i>QNom[nZones].</i></p>
<p>There is also an input for the DHW flow rate, <i>mDHW60C</i>, but this can be unconnected if the system only includes heating and no DHW.</p>
<h4>Assumptions and limitations </h4>
<ol>
<li>See the different extensions of this model in <a href=\"modelica://IDEAS.Thermal.HeatingSystems\">IDEAS.Thermal.HeatingSystems</a></li>
</ol>
<h4>Model use</h4>
<ol>
<li>Connect the heating system to the corresponding heatPorts of a <a href=\"modelica://IDEAS.Templates.Interfaces.BaseClasses.Structure\">structure</a>. </li>
<li>Connect <i>TSet</i> and <i>TSensor</i> and <i>plugLoad. </i></li>
<li>Connect <i>plugLoad </i> to an inhome grid.  A<a href=\"modelica://IDEAS.Templates.Interfaces.BaseClasses.CausalInhomeFeeder\"> dummy inhome grid like this</a> has to be used if no inhome grid is to be modelled. </li>
<li>Set all parameters that are required, depending on which implementation of this interface is used. </li>
</ol>
<h4>Validation </h4>
<p>No validation performed.</p>
<h4>Example </h4>
<p>See the <a href=\"modelica://IDEAS.Thermal.HeatingSystems.Examples\">heating system examples</a>. </p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"));
end HeatingSystem;
