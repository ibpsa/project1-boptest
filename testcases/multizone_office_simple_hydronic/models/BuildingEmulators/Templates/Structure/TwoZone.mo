within BuildingEmulators.Templates.Structure;
model TwoZone "Example three-zone building structure model"
  parameter Modelica.Units.SI.Length l = 40 "Length of the building, defined from north to south";
  parameter Modelica.Units.SI.Length w = 25 "Width of the building, defined from east to west";
  parameter Modelica.Units.SI.Height h(min = hFlo) = 15 "Total height of the building";
  parameter Modelica.Units.SI.Height hFlo = 3 "per-floor height of the building";
  parameter Real fraWin(min = 0, max = 1) = 0.5 "Window-to-wall ratio";
  parameter Real nFlo(min = 1) = floor(h / hFlo) "Number of internal floors in the building, always rounding down";
  final parameter Modelica.Units.SI.HeatFlowRate Q_design_tot = sum(Q_design) "Design heat flow of the spaces";
  final parameter Modelica.Units.SI.MassFlowRate m_flow_air_nominal[nZones] = {nZ.m_flow_nominal, sZ.m_flow_nominal};

  extends BuildingEmulators.Templates.Interfaces.BaseClasses.Structure(
    T_start = 273.15 + 23,
    nZones = 2,
    nEmb = 0,
    ATrans = 2 * l * h + 2 * w * h + l * w,
    VZones = {nZ.V, sZ.V},
    AZones = {nZ.A, sZ.A}*nFlo,
    Q_design = {nZ.Q_design, sZ.Q_design});
    //sim.filNam = "/home/iago/Documents/DeltaQ/DQ_DevEnv/Repositories/IDEAS/IDEAS/Resources/weatherdata/BEL_VLG_Uccle.064470_TMYx.2007-2021.mos");
  IDEAS.Buildings.Components.RectangularZoneTemplate nZ(
    redeclare package Medium=Medium,
    redeclare IDEAS.Buildings.Components.Occupants.Input occNum,
    redeclare IDEAS.Buildings.Components.RoomType.Office rooTyp,
    redeclare IDEAS.Buildings.Components.LightingType.LED ligTyp,
    redeclare IDEAS.Buildings.Components.LightingControl.OccupancyBased ligCtr,
    hasWinA=true,
    hasWinB=true,
    hasWinD=true,
    A_winA = nZ.h*nZ.l*fraWin,
    A_winB = nZ.h*nZ.w * fraWin,
    A_winD = nZ.h*nZ.w * fraWin,
    aziOpt = 3,
    bouTypA = IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypB = IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypC = IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    bouTypCei = IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypD = IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypFlo = IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    h = h,
    hasInt = true,
    l = w,
    lInt = (nFlo - 1) * nZ.l * nZ.w / nZ.h,
    w = l / 2,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall conTypA,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall conTypB,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall conTypD,
    redeclare BuildingEmulators.Data.Roof conTypCei,
    redeclare IDEAS.Buildings.Data.Constructions.InsulatedFloorHeating conTypFlo,
    redeclare BuildingEmulators.Data.ConcreteInternalFloor conTypInt,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingA,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingB,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingD,
    redeclare IDEAS.Buildings.Data.Frames.AluminumInsulated fraTypA,
    redeclare IDEAS.Buildings.Data.Frames.AluminumInsulated fraTypB,
    redeclare IDEAS.Buildings.Data.Frames.AluminumInsulated fraTypD,redeclare replaceable .IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow,T_start = T_start,
    mSenFac = 3)                                                                                                                                                                                                         annotation (
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  IDEAS.Buildings.Components.RectangularZoneTemplate sZ(
    redeclare package Medium=Medium,
    redeclare IDEAS.Buildings.Components.Occupants.Input occNum,
    redeclare IDEAS.Buildings.Components.RoomType.Office rooTyp,
    redeclare IDEAS.Buildings.Components.LightingType.LED ligTyp,
    redeclare IDEAS.Buildings.Components.LightingControl.OccupancyBased ligCtr,
    hasWinB=true,
    hasWinC=true,
    hasWinD=true,
    A_winB = sZ.h*sZ.w * fraWin,
    A_winC = sZ.h*sZ.l * fraWin,
    A_winD = sZ.h*sZ.w * fraWin,
    aziOpt = 3,
    bouTypA = IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    bouTypB = IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypC = IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypCei = IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypD = IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypFlo = IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    h = h,
    hasInt = true,
    l = w,
    lInt = (nFlo - 1) * sZ.w * sZ.l / sZ.h,
    w = l / 2,
    redeclare BuildingEmulators.Data.InteriorWall7 conTypA,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall conTypB,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall conTypC,
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall conTypD,
    redeclare BuildingEmulators.Data.Roof conTypCei,
    redeclare IDEAS.Buildings.Data.Constructions.InsulatedFloorHeating conTypFlo,
    redeclare BuildingEmulators.Data.ConcreteInternalFloor conTypInt,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingB,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingC,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingD,
    redeclare IDEAS.Buildings.Data.Frames.AluminumInsulated fraTypB,
    redeclare IDEAS.Buildings.Data.Frames.AluminumInsulated fraTypC,
    redeclare IDEAS.Buildings.Data.Frames.AluminumInsulated fraTypD,
    hasCavityA=true,redeclare replaceable .IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow,T_start = T_start,
    mSenFac = 3)                                                                                                                                                                                                         annotation (
    Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

    .Modelica.Blocks.Interfaces.RealOutput[nZones, Medium.nX] humAir(each min = 0) "Humidity in the air" annotation(Placement(transformation(extent = {{146.0,-84.0},{166.0,-64.0}},rotation = 0.0,origin = {0.0,0.0})));


equation

  humAir[1, :] = {nZ.port_b.Xi_outflow[1], 1-nZ.port_b.Xi_outflow[1]};
  humAir[2, :] = {sZ.port_b.Xi_outflow[1], 1-sZ.port_b.Xi_outflow[1]};

  connect(sZ.proBusA[1], nZ.proBusC[1]) annotation (Line(
      points={{-6,-21},{-6,0},{6.8,0},{6.8,30.2}},
      color={255,204,51},
      thickness=0.5));
  connect(nZ.TSensor, TSensor[1]) annotation (Line(points={{11,42},{120,42},{120,
          -60},{150,-60},{150,-62.5},{156,-62.5}}, color={0,0,127}));
  connect(sZ.TSensor, TSensor[2]) annotation (Line(points={{11,-28},{120,-28},{120,
          -57.5},{156,-57.5}}, color={0,0,127}));
  connect(nZ.gainCon, heatPortCon[1]) annotation (Line(points={{10,37},{10,38},{
          136,38},{136,17.5},{150,17.5}}, color={191,0,0}));
  connect(sZ.gainCon, heatPortCon[2]) annotation (Line(points={{10,-33},{136,-33},
          {136,22.5},{150,22.5}}, color={191,0,0}));
  connect(heatPortRad[1], nZ.gainRad) annotation (Line(points={{150,-22.5},{100,
          -22.5},{100,34},{10,34}}, color={191,0,0}));
  connect(sZ.gainRad, heatPortRad[2]) annotation (Line(points={{10,-36},{100,-36},
          {100,-17.5},{150,-17.5}}, color={191,0,0}));
  connect(port_a[1], nZ.ports[1]) annotation (Line(points={{20,97.5},{20,56},{0,
          56},{0,50}}, color={0,127,255}));
  connect(port_b[1], nZ.ports[2]) annotation (Line(points={{-20,97.5},{-20,56},{
          0,56},{0,50}}, color={0,127,255}));
  connect(port_a[2], sZ.ports[1]) annotation (Line(points={{20,102.5},{20,-14},{
          0,-14},{0,-20}}, color={0,127,255}));
  connect(port_b[2], sZ.ports[2]) annotation (Line(points={{-20,102.5},{-20,-14},
          {0,-14},{0,-20}}, color={0,127,255}));
  connect(nOcc[1], nZ.yOcc) annotation (Line(points={{-110,-103},{-110,70},{56,
          70},{56,44},{12,44}}, color={0,0,127}));
  connect(nOcc[2], sZ.yOcc) annotation (Line(points={{-110,-97},{-110,-4},{54,
          -4},{54,-26},{12,-26}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-150, -100}, {150, 100}})),
    Documentation(revisions = "<html>
<ul>
<li>
March 17, 2020 by Filip Jorissen:<br/>
Revised fluid port connections to use <code>ports</code> instead
of <code>port_a</code> and <code>port_b</code>.
This is for
<a href=https://github.com/open-ideas/IDEAS/issues/1029>#1029</a>.
</li>
</ul>
</html>"));
end TwoZone;
