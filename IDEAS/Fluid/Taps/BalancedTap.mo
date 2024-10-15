within IDEAS.Fluid.Taps;
model BalancedTap
  "DHW consumption with profile reader.  RealInput mDHW60C is not used."
  extends IDEAS.Fluid.Taps.Interfaces.BalancedTap;

  parameter Modelica.SIunits.Volume VDayAvg "Average daily water consumption";
  parameter Integer profileType=1 "Type of the DHW tap profile";

  Modelica.Blocks.Tables.CombiTable1Ds table(
    tableOnFile=true,
    tableName="data",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    columns=2:4,
    fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Inputs/")
         + "DHWProfile_2d.txt")
    "ratio between the actual DHW mass flow rate (per second) and its average daily mass flow rate (per day)"
                                                                                                        annotation (Placement(visible=
          true, transformation(
        origin={79.5,89.75},
        extent={{6.5,6.25},{-6.5,-6.25}},
        rotation=0)));

  Modelica.Blocks.Math.Product mDHW60C
    annotation (Placement(transformation(extent={{54,74},{34,94}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=time)
    annotation (Placement(transformation(extent={{118,80},{98,100}})));
  Modelica.Blocks.Sources.RealExpression mFloDayAvg(y=VDayAvg*Medium.density(
        Medium.setState_phX(
        port_hot.p,
        inStream(port_hot.h_outflow),
        inStream(port_hot.Xi_outflow))))
    "Average daily hot water consumption, at 60 degC"
    annotation (Placement(transformation(extent={{126,54},{78,76}})));
equation
  mDHW60C.y = mFlo60C;
  connect(realExpression1.y, table.u) annotation (Line(
      points={{97,90},{92,90},{92,89.75},{87.3,89.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mFloDayAvg.y, mDHW60C.u2) annotation (Line(
      points={{75.6,65},{66,65},{66,78},{56,78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(table.y[profileType], mDHW60C.u1) annotation (Line(
      points={{72.35,89.75},{68,89.75},{68,90},{56,90}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Documentation(info="<html>
<h4>Description</h4>
<p>Model of a domestic hot water (DHW) system composed mainly of a thermostatic mixing valve and a table for reading the DHW flow rate. </p>
<p>This model is an extension of the <a href=\"modelica://IDEAS.Thermal.Components.Domestic_Hot_Water.partial_DHW\">Partial_DHW</a> model, see there for the documentation.</p>
<h4>Examples</h4>
<p>An example of this model is given in <a href=\"modelica://IDEAS.Thermal.Components.Examples.StorageTank_DHW_HP\">IDEAS.Thermal.Components.Examples.StorageTank_DHW_HP</a>.</p>
</html>", revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
</ul>
</html>"));
end BalancedTap;
