within ;
package SingleZoneVAV
  "This package contains models for the SingleZoneVAV testcase in BOPTEST."
  model TestCaseSupervisory
    "Based on Buildings.Air.Systems.SingleZone.VAV.Examples.ChillerDXHeatingEconomizer."

    package MediumA = Buildings.Media.Air "Buildings library air media package";
    package MediumW = Buildings.Media.Water "Buildings library air media package";

    parameter Modelica.SIunits.Temperature TSupChi_nominal=279.15
      "Design value for chiller leaving water temperature";

    Buildings.Air.Systems.SingleZone.VAV.ChillerDXHeatingEconomizerController con(
      minOAFra=0.2,
      kFan=4,
      kEco=4,
      kHea=4,
      TSupChi_nominal=TSupChi_nominal,
      TSetSupAir=286.15) "Controller"
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
    Buildings.Air.Systems.SingleZone.VAV.ChillerDXHeatingEconomizer hvac(
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW,
      mAir_flow_nominal=0.75,
      etaHea_nominal=0.99,
      QHea_flow_nominal=7000,
      QCoo_flow_nominal=-7000,
      TSupChi_nominal=TSupChi_nominal)   "Single zone VAV system"
      annotation (Placement(transformation(extent={{-40,-20},{0,20}})));
    Buildings.Air.Systems.SingleZone.VAV.Examples.BaseClasses.Room zon(
        mAir_flow_nominal=0.75,
        lat=weaDat.lat) "Thermal envelope of single zone"
      annotation (Placement(transformation(extent={{40,-20},{80,20}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
        computeWetBulbTemperature=false, filNam=
          Modelica.Utilities.Files.loadResource(
          "Resources/weatherdata/DRYCOLD.mos"))
      annotation (Placement(transformation(extent={{-160,120},{-140,140}})));
    Modelica.Blocks.Continuous.Integrator EFan "Total fan energy"
      annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
    Modelica.Blocks.Continuous.Integrator EHea "Total heating energy"
      annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
    Modelica.Blocks.Continuous.Integrator ECoo "Total cooling energy"
      annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
    Modelica.Blocks.Math.MultiSum EHVAC(nu=4)  "Total HVAC energy"
      annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
    Modelica.Blocks.Continuous.Integrator EPum "Total pump energy"
      annotation (Placement(transformation(extent={{40,-140},{60,-120}})));

    Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
      annotation (Placement(transformation(extent={{-118,120},{-98,140}})));

    Modelica.Blocks.Sources.CombiTimeTable TSetRooHea(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,20 + 273.15; 8*3600,20 + 273.15; 18*3600,20 + 273.15; 24*3600,20
           + 273.15]) "Heating setpoint for room temperature"
      annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
    Modelica.Blocks.Sources.CombiTimeTable TSetRooCoo(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      table=[0,25 + 273.15; 8*3600,25 + 273.15; 18*3600,25 + 273.15; 24*3600,25
           + 273.15]) "Cooling setpoint for room temperature"
      annotation (Placement(transformation(extent={{-180,-20},{-160,0}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite
                             oveTSetRooHea(u(unit="K"))
      annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite
                             oveTSetRooCoo(u(unit="K"))
      annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
    IBPSA.Utilities.IO.SignalExchange.Read
                        PPum(y(unit="W"))
      annotation (Placement(transformation(extent={{120,70},{140,90}})));
    IBPSA.Utilities.IO.SignalExchange.Read
                        PCoo(y(unit="W"))
      annotation (Placement(transformation(extent={{140,90},{160,110}})));
    IBPSA.Utilities.IO.SignalExchange.Read
                        PHea(y(unit="W"))
      annotation (Placement(transformation(extent={{120,110},{140,130}})));
    IBPSA.Utilities.IO.SignalExchange.Read
                        PFan(y(unit="W"))
      annotation (Placement(transformation(extent={{140,130},{160,150}})));
    IBPSA.Utilities.IO.SignalExchange.Read TRooAir(KPIs="comfort",y(unit="K"))
      annotation (Placement(transformation(extent={{120,-10},{140,10}})));
    IBPSA.Utilities.IO.SignalExchange.Read
                        ETotFan(y(unit="J"))
      annotation (Placement(transformation(extent={{120,-50},{140,-30}})));
    IBPSA.Utilities.IO.SignalExchange.Read ETotHVAC(KPIs="energy",y(unit="J"))
      annotation (Placement(transformation(extent={{140,-70},{160,-50}})));
    IBPSA.Utilities.IO.SignalExchange.Read
                        ETotHea(y(unit="J"))
      annotation (Placement(transformation(extent={{120,-90},{140,-70}})));
    IBPSA.Utilities.IO.SignalExchange.Read
                        ETotCoo(y(unit="J"))
      annotation (Placement(transformation(extent={{140,-110},{160,-90}})));
    IBPSA.Utilities.IO.SignalExchange.Read
                        ETotPum(y(unit="J"))
      annotation (Placement(transformation(extent={{120,-130},{140,-110}})));
  equation
    connect(weaDat.weaBus, weaBus) annotation (Line(
        points={{-140,130},{-108,130}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));

    connect(con.yFan, hvac.uFan) annotation (Line(points={{-79,9},{-60,9},{-60,18},
            {-42,18}},               color={0,0,127}));
    connect(con.yHea, hvac.uHea) annotation (Line(points={{-79,6},{-40,6},{-56,6},
            {-56,12},{-42,12}},        color={0,0,127}));
    connect(con.yCooCoiVal, hvac.uCooVal) annotation (Line(points={{-79,0},{-54,0},
            {-54,5},{-42,5}},             color={0,0,127}));
    connect(con.yOutAirFra, hvac.uEco) annotation (Line(points={{-79,3},{-50,3},{
            -50,-2},{-42,-2}},             color={0,0,127}));
    connect(hvac.chiOn, con.chiOn) annotation (Line(points={{-42,-10},{-60,-10},{
            -60,-4},{-79,-4}},                                color={255,0,255}));
    connect(con.TSetSupChi, hvac.TSetChi) annotation (Line(points={{-79,-8},{-70,
            -8},{-70,-15},{-42,-15}},           color={0,0,127}));
    connect(con.TMix, hvac.TMixAir) annotation (Line(points={{-102,2},{-112,2},{
            -112,-40},{10,-40},{10,-4},{1,-4}},             color={0,0,127}));

    connect(hvac.supplyAir, zon.supplyAir) annotation (Line(points={{0,8},{10,8},
            {10,2},{40,2}},          color={0,127,255}));
    connect(hvac.returnAir, zon.returnAir) annotation (Line(points={{0,0},{6,0},{
            6,-2},{10,-2},{40,-2}},  color={0,127,255}));

    connect(con.TOut, weaBus.TDryBul) annotation (Line(points={{-102,-2},{-108,
            -2},{-108,130}},              color={0,0,127}));
    connect(hvac.weaBus, weaBus) annotation (Line(
        points={{-36,17.8},{-36,130},{-108,130}},
        color={255,204,51},
        thickness=0.5));
    connect(zon.weaBus, weaBus) annotation (Line(
        points={{46,18},{42,18},{42,130},{-108,130}},
        color={255,204,51},
        thickness=0.5));
    connect(con.TSup, hvac.TSup) annotation (Line(points={{-102,-9},{-108,-9},{
            -108,-32},{4,-32},{4,-7},{1,-7}},
          color={0,0,127}));
    connect(con.TRoo, zon.TRooAir) annotation (Line(points={{-102,-6},{-110,-6},{
            -110,-36},{6,-36},{6,-22},{90,-22},{90,0},{81,0}},      color={0,0,
            127}));

    connect(hvac.PFan, EFan.u) annotation (Line(points={{1,18},{24,18},{24,-40},{
            38,-40}},  color={0,0,127}));
    connect(hvac.QHea_flow, EHea.u) annotation (Line(points={{1,16},{22,16},{22,
            -70},{38,-70}},
                       color={0,0,127}));
    connect(hvac.PCoo, ECoo.u) annotation (Line(points={{1,14},{20,14},{20,-100},
            {38,-100}},color={0,0,127}));
    connect(hvac.PPum, EPum.u) annotation (Line(points={{1,12},{18,12},{18,-130},{
            38,-130}},   color={0,0,127}));

    connect(EFan.y, EHVAC.u[1]) annotation (Line(points={{61,-40},{70,-40},{70,-54.75},
            {80,-54.75}},         color={0,0,127}));
    connect(EHea.y, EHVAC.u[2])
      annotation (Line(points={{61,-70},{64,-70},{64,-60},{66,-60},{66,-60},{80,-60},
            {80,-58.25}},                                      color={0,0,127}));
    connect(ECoo.y, EHVAC.u[3]) annotation (Line(points={{61,-100},{70,-100},{70,-61.75},
            {80,-61.75}},         color={0,0,127}));
    connect(EPum.y, EHVAC.u[4]) annotation (Line(points={{61,-130},{74,-130},{74,-65.25},
            {80,-65.25}},         color={0,0,127}));
    connect(TSetRooHea.y[1], oveTSetRooHea.u)
      annotation (Line(points={{-159,30},{-142,30}}, color={0,0,127}));
    connect(oveTSetRooHea.y, con.TSetRooHea) annotation (Line(points={{-119,30},
            {-116,30},{-116,10},{-102,10}}, color={0,0,127}));
    connect(TSetRooCoo.y[1], oveTSetRooCoo.u)
      annotation (Line(points={{-159,-10},{-142,-10}}, color={0,0,127}));
    connect(oveTSetRooCoo.y, con.TSetRooCoo) annotation (Line(points={{-119,-10},
            {-116,-10},{-116,6},{-102,6}}, color={0,0,127}));
    connect(hvac.PPum, PPum.u) annotation (Line(points={{1,12},{18,12},{18,80},
            {118,80}}, color={0,0,127}));
    connect(hvac.PCoo, PCoo.u) annotation (Line(points={{1,14},{14,14},{14,100},
            {138,100}}, color={0,0,127}));
    connect(hvac.QHea_flow, PHea.u) annotation (Line(points={{1,16},{10,16},{10,
            120},{118,120}}, color={0,0,127}));
    connect(hvac.PFan, PFan.u) annotation (Line(points={{1,18},{6,18},{6,140},{
            138,140}}, color={0,0,127}));
    connect(zon.TRooAir, TRooAir.u)
      annotation (Line(points={{81,0},{118,0}}, color={0,0,127}));
    connect(EFan.y, ETotFan.u)
      annotation (Line(points={{61,-40},{118,-40}}, color={0,0,127}));
    connect(ETotHVAC.u, EHVAC.y)
      annotation (Line(points={{138,-60},{101.7,-60}}, color={0,0,127}));
    connect(EHea.y, ETotHea.u) annotation (Line(points={{61,-70},{64,-70},{64,
            -80},{118,-80}}, color={0,0,127}));
    connect(ECoo.y, ETotCoo.u)
      annotation (Line(points={{61,-100},{138,-100}}, color={0,0,127}));
    connect(EPum.y, ETotPum.u) annotation (Line(points={{61,-130},{90,-130},{90,
            -120},{118,-120}}, color={0,0,127}));
    annotation (
      experiment(
        StopTime=504800,
        Interval=3600,
        Tolerance=1e-06),
        __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Air/Systems/SingleZone/VAV/Examples/ChillerDXHeatingEconomizer.mos"
          "Simulate and plot"),
       Documentation(info="<html>
<p>
The thermal zone is based on the BESTEST Case 600 envelope, while the HVAC
system is based on a conventional VAV system with air cooled chiller and
economizer.  See documentation for the specific models for more information.
</p>
</html>",   revisions="<html>
<ul>
<li>
September 14, 2018, by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"),
      Diagram(coordinateSystem(extent={{-160,-160},{120,140}})),
      Icon(coordinateSystem(extent={{-160,-160},{120,140}}), graphics={
          Rectangle(
            extent={{-160,140},{120,-160}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points = {{-36,60},{64,0},{-36,-60},{-36,60}}),
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-116,-110},{84,90}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-52,50},{48,-10},{-52,-70},{-52,50}})}));
  end TestCaseSupervisory;

  annotation (uses(Modelica(version="3.2.2"), Buildings(version="6.0.0"),
      IBPSA(version="3.0.0")));
end SingleZoneVAV;
