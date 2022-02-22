within FRP.RTUVAV;
record Performance_Stage0
    extends
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.PerformanceCurve(
    each capFunT={0.15774293983227,0.04372374074736,0.00072920770462,0.03188358869040,-0.00054110762699,
        -0.00118166008309},
    each capFunFF={1,0,0},
    each EIRFunT={1.54543818055558,-0.02701572205069,-0.00034608894725,-0.04034348882262,0.00131449522747,
        0.00016963840381},
    each EIRFunFF={1,0,0},
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
end Performance_Stage0;
