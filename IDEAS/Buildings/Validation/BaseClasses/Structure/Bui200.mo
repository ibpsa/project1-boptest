within IDEAS.Buildings.Validation.BaseClasses.Structure;
model Bui200 "BESTEST Building model case 195"

  extends IDEAS.Templates.Interfaces.BaseClasses.Structure(
    final nZones=1,
    ATrans=1,
    VZones={gF.V});

  IDEAS.Buildings.Components.Zone gF(
    V=129.6,
    n50=0,
    mSenFac=0.822,
    nSurf=8,
    T_start=293.15,
    redeclare package Medium = Medium)
                annotation (Placement(transformation(extent={{40,0},{80,40}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{120,-70},{140,-50}})));
  IDEAS.Buildings.Components.OuterWall[4] wall(
    redeclare final parameter Data.Constructions.LightWall_195 constructionType,
    final azi={IDEAS.Types.Azimuth.N,IDEAS.Types.Azimuth.E,IDEAS.Types.Azimuth.S,
        IDEAS.Types.Azimuth.W},
    final inc={IDEAS.Types.Tilt.Wall,IDEAS.Types.Tilt.Wall,IDEAS.Types.Tilt.Wall,
        IDEAS.Types.Tilt.Wall},
    final A={21.6,16.2,21.6,16.2}) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-49,-14})));

  IDEAS.Buildings.Components.BoundaryWall floor(
    redeclare final parameter Data.Constructions.LightFloor constructionType,
    final A=48,
    final inc=IDEAS.Types.Tilt.Floor,
    final azi=IDEAS.Types.Azimuth.S) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-19,-14})));
  IDEAS.Buildings.Components.OuterWall roof(
    redeclare final parameter Data.Constructions.LightRoof_195 constructionType,
    final A=48,
    final inc=IDEAS.Types.Tilt.Ceiling,
    final azi=IDEAS.Types.Azimuth.S) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-79,-14})));

  //fixme: is the implementation of win correct?
  Components.OuterWall[2] win(
    final A={6,6},
    redeclare final parameter Data.Constructions.HighConductance
      constructionType,
    final inc={IDEAS.Types.Tilt.Wall,IDEAS.Types.Tilt.Wall},
    final azi={IDEAS.Types.Azimuth.S,IDEAS.Types.Azimuth.S}) annotation (
      Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={11,-14})));
equation
  connect(gF.gainCon, temperatureSensor.port) annotation (Line(
      points={{80,14},{100,14},{100,-60},{120,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(gF.gainCon, heatPortCon[1]) annotation (Line(
      points={{80,14},{120,14},{120,20},{150,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(gF.gainRad, heatPortRad[1]) annotation (Line(
      points={{80,8},{120,8},{120,-20},{150,-20}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(roof.propsBus_a, gF.propsBus[1]) annotation (Line(
      points={{-81,-9.83333},{-81,31.5},{40,31.5}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wall.propsBus_a, gF.propsBus[2:5]) annotation (Line(
      points={{-51,-9.83333},{-51,27.5},{40,27.5}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(floor.propsBus_a, gF.propsBus[6]) annotation (Line(
      points={{-21,-9.83333},{-21,26.5},{40,26.5}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(temperatureSensor.T, TSensor[1]) annotation (Line(
      points={{140,-60},{156,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(win.propsBus_a, gF.propsBus[7:8]) annotation (Line(
      points={{9,-9.83333},{9,24.5},{40,24.5}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  connect(port_b[1], gF.port_b) annotation (Line(
      points={{-20,100},{-20,60},{56,60},{56,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(port_a[1], gF.port_a) annotation (Line(
      points={{20,100},{20,62},{64,62},{64,40}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,
            -100},{150,100}}), graphics));
end Bui200;
