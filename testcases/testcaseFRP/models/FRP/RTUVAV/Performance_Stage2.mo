within FRP.RTUVAV;
record Performance_Stage2
    extends
    Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.Data.Generic.BaseClasses.PerformanceCurve(
    each capFunT={1.67520968845010,-0.00692156475161,0.00005483806171,-0.05867190028641,0.00020850406343,
        0.00193809110078},
    each capFunFF={0.79304534799510,0.23420981003442,-0.00005206109583,0},
    each EIRFunT={-0.63985907614556,0.01345071384090,0.00234046419466,0.10159333338045,0.00028254517424,
        -0.00499337303048},
    each EIRFunFF={1.20706248250042,-0.12447347640041,0.00002768264599,0},
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
