within FRP.RTUVAV;
record Performance_Stage1
    extends
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.PerformanceCurve(
    each capFunT={-1.16750309302959,0.222072522422488,-5.681938180743E-03,1.986329192660E-02,-6.310595249328E-04,
        1.287885973229E-04},
    each capFunFF={0.401828117151334,0.72020365874059,-1.440212452288E-04,0},
    each EIRFunT={1.55014981024184,-7.084448275861E-02,2.120617253599E-03,-1.833288612269E-02,1.130514176805E-03,
        -1.120925426559E-03},
    each EIRFunFF={1.75801546305953,-0.872842049686309,1.745426229894E-04},
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
end Performance_Stage1;
