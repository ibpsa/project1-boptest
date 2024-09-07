within FRP.RTUVAV;
record Performance_Stage2_New
    extends
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.PerformanceCurve(
    each capFunT={0.658706382748155,3.40786736020809E-02,-2.85273081924584E-04,-2.78446033810142E-03,-7.72431729518854E-05,
        -3.33550065019515E-05},
    each capFunFF={1,0,0,0},
    each EIRFunT={0.6609961,-0.0173045,0.0003871,0.0121825,0.000343,
        -0.0004676},
    each EIRFunFF={1,0,0,0},
    TConInMin=273.15+15.56,
    TConInMax=273.15+46.11,
    TEvaInMin=273.15+12.22,
    TEvaInMax=273.15+26.67,
    ffMin=0.4,
    ffMax=1.6);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Performance_Stage2_New;
