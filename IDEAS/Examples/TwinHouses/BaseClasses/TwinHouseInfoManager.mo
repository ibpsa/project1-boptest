within IDEAS.Examples.TwinHouses.BaseClasses;
model TwinHouseInfoManager
  extends IDEAS.BoundaryConditions.SimInfoManager(
    weaDat(
      pAtmSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
      ceiHeiSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
      ceiHei=7,
      HSou=IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor,
      totSkyCovSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
      opaSkyCovSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
      calTSky=IDEAS.BoundaryConditions.Types.SkyTemperatureCalculation.TemperaturesAndSkyCover,
      totSkyCov=0.6,
      opaSkyCov=0.6),
    linIntRad=false,
    linExtRad=false,
    radSol(each rho=0.23),
    lat=0.83555892609977,
    lon=0.20469221467389,
    final filNam=filPat);
  parameter Integer exp = 1 "Experiment number: 1 or 2";
  parameter Integer bui = 1 "Building number 1 (N2), 2 (O5)";
  final parameter String filNam3 = (if exp == 1 and bui == 1 then "validationdataN2Exp1.txt" elseif exp==2 and bui == 1 then "validationdataExp2.txt" else "validationdataO5Exp1.txt");
  final parameter String dirPath = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/")    annotation(Evaluate=true);

  Modelica.Blocks.Sources.CombiTimeTable inputSolTTH(
    tableOnFile=true,
    tableName="data",
    smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    final fileName=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/measurements/")+filNam3,
    columns= (if exp== 1 then 37:42 else {55,56,58,59,60,61}))
    "input for solGloHor and solDifHor measured at TTH"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  IDEAS.BoundaryConditions.SolarIrradiation.RadiationConvertor radCon(final lat=lat, final lon=lon,
    rho={radSol[1].rho,radSol[1].rho,radSol[1].rho})
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
protected
  final parameter String filNam2 = (if exp == 1  then "WeatherTwinHouseExp1.txt" else "WeatherTwinHouseExp2.txt")
    annotation(Evaluate=true);
  final parameter String filPat = dirPath+filNam2
    annotation(Evaluate=true);

equation
  connect(weaDat.HDirNor_in, radCon.HDirNor);
  connect(weaDat.HDifHor_in, radCon.HDifHor);

  connect(inputSolTTH.y[4], radCon.HEast) annotation (Line(points={{-79,-30},{
          -36,-30},{-36,-61},{-22,-61}},
                                       color={0,0,127}));
  connect(inputSolTTH.y[5], radCon.HSouth) annotation (Line(points={{-79,-30},{
          -38,-30},{-38,-65},{-22,-65}},   color={0,0,127}));
  connect(inputSolTTH.y[6], radCon.HWest) annotation (Line(points={{-79,-30},{
          -40,-30},{-40,-69},{-22,-69}},
                                       color={0,0,127}));
  connect(radCon.decAng, solDec.y) annotation (Line(points={{-22,-74},{-42,-74},
          {-42,56},{-77.6,56}}, color={0,0,127}));
  connect(radCon.solHouAng, solHouAng.y) annotation (Line(points={{-22,-78},{
          -44,-78},{-44,70},{-77.6,70}},    color={0,0,127}));
  annotation (
      defaultComponentName="sim",
    defaultComponentPrefixes="inner",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
October 10, 2019, by Filip Jorissen:<br/>
Revised implementation by using new <code>RadiationConverter</code>.
</li>
<li>
January 17, 2017, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This block extends the normal SimInfoManager and adds 
computations that are specific to the TwinHouse validation models.
</p>
</html>"));
end TwinHouseInfoManager;
