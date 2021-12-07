within FRP.RTUVAV;
record Performance_Stage2
    extends
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.PerformanceCurve(
    each capFunT={-1.8510377178572,0.171870003996834,-1.085121074288E-03,8.374816568125E-02,-7.813846159411E-04,
        -3.049558080189E-03},
    each capFunFF={0.822766923691327,0.218775801633375,-4.375220478842E-05,0},
    each EIRFunT={0.79058808346861,-1.208378376274E-03,-3.677232245117E-04,-1.472393065541E-02,7.882658009442E-04,
        -8.877595746150E-05},
    each EIRFunFF={1.59632163645242,-0.666084154294835,1.331893852016E-04,0},
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
end Performance_Stage2;
