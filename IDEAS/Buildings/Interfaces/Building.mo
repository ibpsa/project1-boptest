within IDEAS.Buildings.Interfaces;
partial model Building "Partial model for building models"

parameter Integer nZones(min=1)
    "Number of conditioned thermal zones in the building";
parameter Modelica.SIunits.Area ATrans
    "Transmission heat loss area of the residential unit";
parameter Modelica.SIunits.Volume[nZones] VZones
    "Conditioned volume of the building based on external dimensions";
final parameter Modelica.SIunits.Length C = sum(VZones)/ATrans
    "Building compactness";

  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data" annotation (Placement(transformation(extent={{130,-100},{150,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
    "Internal zone nodes for convective heat gains" annotation (Placement(transformation(extent={{140,10},{160,30}}),
        iconTransformation(extent={{140,10},{160,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nZones] heatPortRad
    "Internal zones node for radiative heat gains" annotation (Placement(transformation(extent={{140,-30},{160,-10}}),
        iconTransformation(extent={{140,-30},{160,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortEmb
    "Construction nodes for heat gains by embedded layers" annotation (Placement(transformation(extent={{140,50},{160,70}}),
        iconTransformation(extent={{140,50},{160,70}})));
  Modelica.Blocks.Interfaces.RealOutput[nZones] TSensor
    "Sensor temperature of the zones" annotation (Placement(transformation(extent={{146,-70},{166,-50}})));
  annotation(Icon(coordinateSystem(preserveAspectRatio=true, extent={{-150,-100},
            {150,100}}),
                  graphics={Line(
          points={{60,8},{0,60},{-60,10},{-60,-60},{60,-60}},
          color={127,0,0},
          smooth=Smooth.None), Polygon(
          points={{-24,30},{-30,26},{-58,50},{-110,8},{-110,-52},{2,-52},{2,-60},
              {-118,-60},{-118,10},{-58,60},{-24,30}},
          lineColor={95,95,95},
          smooth=Smooth.None), Polygon(
          points={{60,8},{56,4},{0,50},{-52,8},{-52,-52},{60,-52},{60,-60},{-60,
              -60},{-60,10},{0,60},{60,8}},
          lineColor={95,95,95},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),                         Diagram(
        coordinateSystem(preserveAspectRatio=true, extent={{-150,-100},{150,100}}),
        graphics));

end Building;
