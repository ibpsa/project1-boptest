within ;
package TestcaseCMA "Model for the commercial multi-zone air-based test case"
  model OriginalModelFromBuildings
    "This just extends the original model from the Buildngs library"
    extends Buildings.Examples.VAVReheat.ASHRAE2006;
  end OriginalModelFromBuildings;

  model TestcaseCMA
    "Variable air volume flow system with terminal reheat and five thermal zones"
    extends Modelica.Icons.Example;
    extends PartialOpenLoop(
      heaCoi(show_T=true),
      cooCoi(show_T=true));
    parameter Real k_hea = 0.02 "Gain of the PI controller of the heating coil";
    parameter Real Ti_hea = 300 "Time constant of the PI controller of the heating coil";
    parameter Real k_coo = 0.1 "Gain of the PI controller of the heating coil";
    parameter Real Ti_coo = 600 "Time constant of the PI controller of the heating coil";

    Modelica.Blocks.Sources.Constant TSupSetHea(y(
        final quantity="ThermodynamicTemperature",
        final unit="K",
        displayUnit="degC",
        min=0), k=273.15 + 10) "Supply air temperature setpoint for heating"
      annotation (Placement(transformation(extent={{-212,-170},{-192,-150}})));
    Buildings.Examples.VAVReheat.Controls.FanVFD conFanSup(xSet_nominal(
          displayUnit="Pa") = 410, r_N_min=yFanMin) "Controller for fan"
      annotation (Placement(transformation(extent={{240,-10},{260,10}})));
    ModeSelector                                       modeSelector
      annotation (Placement(transformation(extent={{-200,-320},{-180,-300}})));
    Buildings.Examples.VAVReheat.Controls.ControlBus controlBus
      annotation (Placement(transformation(extent={{-250,-352},{-230,-332}})));

    Buildings.Examples.VAVReheat.Controls.Economizer conEco(
      dT=1,
      VOut_flow_min=0.3*m_flow_nominal/1.2,
      Ti=600,
      k=0.1) "Controller for economizer"
      annotation (Placement(transformation(extent={{-80,140},{-60,160}})));
    Buildings.Examples.VAVReheat.Controls.RoomTemperatureSetpoint TSetRoo(
      final THeaOn=THeaOn,
      final THeaOff=THeaOff,
      final TCooOn=TCooOn,
      final TCooOff=TCooOff)
      annotation (Placement(transformation(extent={{-300,-358},{-280,-338}})));
    Buildings.Examples.VAVReheat.Controls.DuctStaticPressureSetpoint pSetDuc(
      nin=5,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      pMin=50) "Duct static pressure setpoint"
      annotation (Placement(transformation(extent={{160,-16},{180,4}})));
    Buildings.Examples.VAVReheat.Controls.CoolingCoilTemperatureSetpoint TSetCoo
      "Setpoint for cooling coil"
      annotation (Placement(transformation(extent={{-170,-250},{-150,-230}})));
    RoomVAV                                       conVAVCor
      "Controller for terminal unit corridor"
      annotation (Placement(transformation(extent={{530,32},{550,52}})));
    RoomVAV                                       conVAVSou
      "Controller for terminal unit south"
      annotation (Placement(transformation(extent={{700,30},{720,50}})));
    RoomVAV                                       conVAVEas
      "Controller for terminal unit east"
      annotation (Placement(transformation(extent={{880,30},{900,50}})));
    RoomVAV                                       conVAVNor
      "Controller for terminal unit north"
      annotation (Placement(transformation(extent={{1040,30},{1060,50}})));
    RoomVAV                                       conVAVWes
      "Controller for terminal unit west"
      annotation (Placement(transformation(extent={{1240,28},{1260,48}})));
    Buildings.Controls.Continuous.LimPID heaCoiCon(
      yMax=1,
      yMin=0,
      Td=60,
      initType=Modelica.Blocks.Types.InitPID.InitialState,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=k_hea,
      Ti=Ti_hea)
             "Controller for heating coil"
      annotation (Placement(transformation(extent={{-80,-212},{-60,-192}})));
    Buildings.Controls.Continuous.LimPID cooCoiCon(
      reverseAction=true,
      Td=60,
      initType=Modelica.Blocks.Types.InitPID.InitialState,
      yMax=1,
      yMin=0,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=Ti_coo,
      k=k_coo)
             "Controller for cooling coil"
      annotation (Placement(transformation(extent={{-80,-250},{-60,-230}})));
    Buildings.Controls.OBC.CDL.Logical.Switch swiHeaCoi
      "Switch to switch off heating coil"
      annotation (Placement(transformation(extent={{60,-220},{80,-200}})));
    Buildings.Controls.OBC.CDL.Logical.Switch swiCooCoi
      "Switch to switch off cooling coil"
      annotation (Placement(transformation(extent={{60,-258},{80,-238}})));
    Buildings.Controls.OBC.CDL.Continuous.Sources.Constant coiOff(k=0)
      "Signal to switch water flow through coils off"
      annotation (Placement(transformation(extent={{-60,-172},{-40,-152}})));

    Buildings.Controls.OBC.CDL.Logical.Or or2
      annotation (Placement(transformation(extent={{0,-180},{20,-160}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveTSetHea(u(unit="K"),
        description="Heating set point")
      annotation (Placement(transformation(extent={{-148,-170},{-128,-150}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveTSetCoo(u(unit="K"),
        description="Cooling set point")
      annotation (Placement(transformation(extent={{-126,-274},{-106,-254}})));
    IBPSA.Utilities.IO.SignalExchange.Read senPowFan(
      y(unit="W"),
      description="Fan power",
      KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
      annotation (Placement(transformation(extent={{360,218},{380,238}})));
    Modelica.Blocks.Sources.RealExpression heaCoiPow(y=abs(heaCoi.Q1_flow))
      annotation (Placement(transformation(extent={{300,302},{320,322}})));
    IBPSA.Utilities.IO.SignalExchange.Read senPowHea(
      y(unit="W"),
      description="Thermal power exchanged",
      KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
      annotation (Placement(transformation(extent={{360,302},{380,322}})));
    Modelica.Blocks.Sources.RealExpression cooCoiPow(y=abs(cooCoi.port_a1.m_flow
          *(cooCoi.port_b1.h_outflow - cooCoi.port_a1.h_outflow)))
      "Assumes constant EER"
      annotation (Placement(transformation(extent={{300,268},{320,288}})));
    IBPSA.Utilities.IO.SignalExchange.Read senPowCoo(
      y(unit="W"),
      description="Thermal power exchanged by cooCoi",
      KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
      annotation (Placement(transformation(extent={{360,268},{380,288}})));
    Modelica.Blocks.Sources.RealExpression TRetCalculator(y=TRet.T)
      annotation (Placement(transformation(extent={{100,340},{120,360}})));
    IBPSA.Utilities.IO.SignalExchange.Read senTRet(
      y(unit="K"),
      description="Return mixed temperature from zones",
      KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
      annotation (Placement(transformation(extent={{160,340},{180,360}})));
    Modelica.Blocks.Sources.RealExpression TMixCalculator(y=TMix.T)
      annotation (Placement(transformation(extent={{100,300},{120,320}})));
    IBPSA.Utilities.IO.SignalExchange.Read senTMix(
      y(unit="K"),
      description=
          "Return temperature from zones mixed with outdoor temperature after economizer",
      KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
      annotation (Placement(transformation(extent={{160,300},{180,320}})));

    Modelica.Blocks.Sources.RealExpression TSupCalculator(y=TSup.T)
      annotation (Placement(transformation(extent={{100,260},{120,280}})));
    IBPSA.Utilities.IO.SignalExchange.Read senTSup(
      y(unit="K"),
      description="Supply temperature to terminal units of the zones",
      KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
      annotation (Placement(transformation(extent={{160,260},{180,280}})));
  equation
    connect(fanSup.port_b, dpDisSupFan.port_a) annotation (Line(
        points={{320,-40},{320,0},{320,-10},{320,-10}},
        color={0,0,0},
        smooth=Smooth.None,
        pattern=LinePattern.Dot));
    connect(controlBus, modeSelector.cb) annotation (Line(
        points={{-240,-342},{-152,-342},{-152,-303.182},{-196.818,-303.182}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(min.y, controlBus.TRooMin) annotation (Line(
        points={{1221,450},{1400,450},{1400,-342},{-240,-342}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(ave.y, controlBus.TRooAve) annotation (Line(
        points={{1221,420},{1400,420},{1400,-342},{-240,-342}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(TRet.T, conEco.TRet) annotation (Line(
        points={{100,151},{100,172},{-92,172},{-92,157.333},{-81.3333,157.333}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(TMix.T, conEco.TMix) annotation (Line(
        points={{40,-29},{40,168},{-90,168},{-90,153.333},{-81.3333,153.333}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(conEco.TSupHeaSet, TSupSetHea.y) annotation (Line(
        points={{-81.3333,145.333},{-168,145.333},{-168,-160},{-191,-160}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(TSetRoo.controlBus, controlBus) annotation (Line(
        points={{-288,-342},{-240,-342}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(dpDisSupFan.p_rel, conFanSup.u_m) annotation (Line(
        points={{311,4.44089e-16},{304,4.44089e-16},{304,-16},{250,-16},{250,-12}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));

    connect(pSetDuc.y, conFanSup.u) annotation (Line(
        points={{181,-6},{210,-6},{210,0},{238,0}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(TSetCoo.TSet, conEco.TSupCooSet) annotation (Line(
        points={{-149,-240},{-102,-240},{-102,-118},{-152,-118},{-152,141.333},
            {-81.3333,141.333}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(TSupSetHea.y, TSetCoo.TSetHea) annotation (Line(
        points={{-191,-160},{-180,-160},{-180,-240},{-172,-240}},
        color={0,0,0},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(modeSelector.cb, TSetCoo.controlBus) annotation (Line(
        points={{-196.818,-303.182},{-162,-303.182},{-162,-248},{-161.8,-248}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(conEco.VOut_flow, VOut1.V_flow) annotation (Line(
        points={{-81.3333,149.333},{-90,149.333},{-90,80},{-61,80},{-61,-20.9}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(conEco.yOA, eco.yOut) annotation (Line(
        points={{-59.3333,152},{-10,152},{-10,-34}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));

    connect(conVAVCor.TRoo, TRooAir.y5[1]) annotation (Line(
        points={{528.462,39.2727},{520,39.2727},{520,162},{511,162}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(conVAVSou.TRoo, TRooAir.y1[1]) annotation (Line(
        points={{698.462,37.2727},{690,37.2727},{690,36},{680,36},{680,178},{
            511,178}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TRooAir.y2[1], conVAVEas.TRoo) annotation (Line(
        points={{511,174},{868,174},{868,37.2727},{878.462,37.2727}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TRooAir.y3[1], conVAVNor.TRoo) annotation (Line(
        points={{511,170},{1028,170},{1028,37.2727},{1038.46,37.2727}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TRooAir.y4[1], conVAVWes.TRoo) annotation (Line(
        points={{511,166},{1220,166},{1220,35.2727},{1238.46,35.2727}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(conVAVCor.yDam, pSetDuc.u[1]) annotation (Line(points={{550.769,
            47.2727},{556,47.2727},{556,72},{120,72},{120,-7.6},{158,-7.6}},
                                                                color={0,0,127}));
    connect(conVAVSou.yDam, pSetDuc.u[2]) annotation (Line(points={{720.769,
            45.2727},{730,45.2727},{730,72},{120,72},{120,-6.8},{158,-6.8}},
                                                                color={0,0,127}));
    connect(pSetDuc.u[3], conVAVEas.yDam) annotation (Line(points={{158,-6},{
            120,-6},{120,72},{910,72},{910,45.2727},{900.769,45.2727}},
                                                          color={0,0,127}));
    connect(conVAVNor.yDam, pSetDuc.u[4]) annotation (Line(points={{1060.77,
            45.2727},{1072,45.2727},{1072,72},{122,72},{122,-6},{160,-6},{160,
            -5.2},{158,-5.2}},
          color={0,0,127}));
    connect(conVAVCor.TDis, TSupCor.T) annotation (Line(points={{528.462,
            35.6364},{522,35.6364},{522,34},{514,34},{514,92},{569,92}},
                                                  color={0,0,127}));
    connect(TSupSou.T, conVAVSou.TDis) annotation (Line(points={{749,92},{688,
            92},{688,33.6364},{698.462,33.6364}},
                                color={0,0,127}));
    connect(TSupEas.T, conVAVEas.TDis) annotation (Line(points={{929,90},{872,
            90},{872,33.6364},{878.462,33.6364}},
                                color={0,0,127}));
    connect(TSupNor.T, conVAVNor.TDis) annotation (Line(points={{1089,94},{1032,
            94},{1032,33.6364},{1038.46,33.6364}},
                                      color={0,0,127}));
    connect(TSupWes.T, conVAVWes.TDis) annotation (Line(points={{1289,90},{1228,
            90},{1228,31.6364},{1238.46,31.6364}},
                                      color={0,0,127}));
    connect(conVAVWes.yDam, pSetDuc.u[5]) annotation (Line(points={{1260.77,
            43.2727},{1270,43.2727},{1270,72},{120,72},{120,-4},{134,-4},{134,
            -4.4},{158,-4.4}},
          color={0,0,127}));
    connect(cor.yVAV, conVAVCor.yDam) annotation (Line(points={{566,50},{556,50},
            {556,47.2727},{550.769,47.2727}},
                                   color={0,0,127}));
    connect(cor.yVal, conVAVCor.yVal) annotation (Line(points={{566,34},{560,34},
            {560,38.9091},{550.769,38.9091}},
                               color={0,0,127}));
    connect(conVAVSou.yDam, sou.yVAV) annotation (Line(points={{720.769,45.2727},
            {730,45.2727},{730,48},{746,48}},
                                      color={0,0,127}));
    connect(conVAVSou.yVal, sou.yVal) annotation (Line(points={{720.769,36.9091},
            {732.5,36.9091},{732.5,32},{746,32}},
                                  color={0,0,127}));
    connect(conVAVEas.yVal, eas.yVal) annotation (Line(points={{900.769,36.9091},
            {912.5,36.9091},{912.5,32},{926,32}},
                                  color={0,0,127}));
    connect(conVAVEas.yDam, eas.yVAV) annotation (Line(points={{900.769,45.2727},
            {910,45.2727},{910,48},{926,48}},
                                      color={0,0,127}));
    connect(conVAVNor.yDam, nor.yVAV) annotation (Line(points={{1060.77,45.2727},
            {1072.5,45.2727},{1072.5,48},{1086,48}},
                                                 color={0,0,127}));
    connect(conVAVNor.yVal, nor.yVal) annotation (Line(points={{1060.77,36.9091},
            {1072.5,36.9091},{1072.5,32},{1086,32}},
                                        color={0,0,127}));
    connect(conVAVCor.TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{528.462,
            50.1818},{480,50.1818},{480,-342},{-240,-342}},
                                                       color={0,0,127}));
    connect(conVAVCor.TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{528.462,
            47.4545},{480,47.4545},{480,-342},{-240,-342}},
                                                       color={0,0,127}));
    connect(conVAVSou.TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{698.462,
            48.1818},{660,48.1818},{660,-342},{-240,-342}},
                                                       color={0,0,127}));
    connect(conVAVSou.TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{698.462,
            45.4545},{660,45.4545},{660,-342},{-240,-342}},
                                                       color={0,0,127}));
    connect(conVAVEas.TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{878.462,
            48.1818},{850,48.1818},{850,-342},{-240,-342}},
                                                       color={0,0,127}));
    connect(conVAVEas.TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{878.462,
            45.4545},{850,45.4545},{850,-342},{-240,-342}},
                                                       color={0,0,127}));
    connect(conVAVNor.TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{1038.46,
            48.1818},{1020,48.1818},{1020,-342},{-240,-342}},
                                                          color={0,0,127}));
    connect(conVAVNor.TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{1038.46,
            45.4545},{1020,45.4545},{1020,-342},{-240,-342}},
                                                          color={0,0,127}));
    connect(conVAVWes.TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{1238.46,
            46.1818},{1202,46.1818},{1202,-342},{-240,-342}},
                                                          color={0,0,127}));
    connect(conVAVWes.TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{1238.46,
            43.4545},{1202,43.4545},{1202,-342},{-240,-342}},
                                                          color={0,0,127}));

    connect(conVAVWes.yVal, wes.yVal) annotation (Line(points={{1260.77,34.9091},
            {1272.5,34.9091},{1272.5,32},{1286,32}},
                                        color={0,0,127}));
    connect(wes.yVAV, conVAVWes.yDam) annotation (Line(points={{1286,48},{1274,
            48},{1274,43.2727},{1260.77,43.2727}},
                                      color={0,0,127}));
    connect(occSch.tNexOcc, controlBus.dTNexOcc) annotation (Line(
        points={{-297,-204},{-240,-204},{-240,-342}},
        color={0,0,127},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(occSch.occupied, controlBus.occupied) annotation (Line(
        points={{-297,-216},{-240,-216},{-240,-342}},
        color={255,0,255},
        smooth=Smooth.None), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(pSetDuc.TOut, TOut.y) annotation (Line(points={{158,2},{32,2},{32,130},
            {-160,130},{-160,180},{-279,180}}, color={0,0,127}));
    connect(TOut.y, controlBus.TOut) annotation (Line(points={{-279,180},{-240,180},
            {-240,-342}},                            color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(conEco.controlBus, controlBus) annotation (Line(
        points={{-76,150.667},{-76,120},{-240,120},{-240,-342}},
        color={255,204,51},
        thickness=0.5));
    connect(modeSelector.yFan, conFanSup.uFan) annotation (Line(points={{
            -179.545,-310},{260,-310},{260,-30},{226,-30},{226,6},{238,6}},
                                                                   color={255,0,
            255}));
    connect(conFanSup.y, fanSup.y) annotation (Line(points={{261,0},{280,0},{280,
            -20},{310,-20},{310,-28}}, color={0,0,127}));
    connect(swiHeaCoi.u1, heaCoiCon.y)
      annotation (Line(points={{58,-202},{-59,-202}}, color={0,0,127}));
    connect(coiOff.y, swiCooCoi.u3) annotation (Line(points={{-39,-162},{-28,-162},
            {-28,-256},{58,-256}},
                                color={0,0,127}));
    connect(coiOff.y, swiHeaCoi.u3) annotation (Line(points={{-39,-162},{-28,-162},
            {-28,-218},{58,-218}},
                                color={0,0,127}));
    connect(TSup.T, cooCoiCon.u_m) annotation (Line(points={{340,-29},{340,-12},{
            372,-12},{372,-268},{-70,-268},{-70,-252}}, color={0,0,127}));
    connect(TSup.T, heaCoiCon.u_m) annotation (Line(points={{340,-29},{340,-12},{
            372,-12},{372,-268},{-88,-268},{-88,-222},{-70,-222},{-70,-214}},
          color={0,0,127}));
    connect(gaiHeaCoi.u, swiHeaCoi.y)
      annotation (Line(points={{98,-210},{81,-210},{81,-210}}, color={0,0,127}));
    connect(gaiCooCoi.u, swiCooCoi.y) annotation (Line(points={{98,-248},{88,-248},
            {88,-248},{81,-248}}, color={0,0,127}));
    connect(eco.yExh, conEco.yOA) annotation (Line(
        points={{-3,-34},{-2,-34},{-2,152},{-59.3333,152}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(eco.yRet, conEco.yRet) annotation (Line(
        points={{-16.8,-34},{-16.8,146.667},{-59.3333,146.667}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(freSta.y, or2.u1) annotation (Line(points={{21,-92},{21,-92},{40,-92},
            {40,-150},{-20,-150},{-20,-170},{-2,-170}},        color={255,0,255}));
    connect(or2.u2, modeSelector.yFan) annotation (Line(points={{-2,-178},{-20,
            -178},{-20,-310},{-179.545,-310}},
                                       color={255,0,255}));
    connect(or2.y, swiHeaCoi.u2) annotation (Line(points={{21,-170},{40,-170},{40,
            -190},{40,-190},{40,-210},{58,-210}}, color={255,0,255}));
    connect(TSupSetHea.y, oveTSetHea.u) annotation (Line(
        points={{-191,-160},{-150,-160}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(oveTSetHea.y, heaCoiCon.u_s) annotation (Line(
        points={{-127,-160},{-96,-160},{-96,-202},{-82,-202}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TSetCoo.TSet, oveTSetCoo.u) annotation (Line(
        points={{-149,-240},{-140,-240},{-140,-264},{-128,-264}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(oveTSetCoo.y, cooCoiCon.u_s) annotation (Line(
        points={{-105,-264},{-96,-264},{-96,-240},{-82,-240}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(fanSup.P, senPowFan.u) annotation (Line(points={{321,-31},{334,-31},
            {334,228},{358,228}}, color={0,0,127}));
    connect(heaCoiPow.y,senPowHea. u)
      annotation (Line(points={{321,312},{358,312}}, color={0,0,127}));
    connect(cooCoiPow.y, senPowCoo.u)
      annotation (Line(points={{321,278},{358,278}}, color={0,0,127}));
    connect(TRetCalculator.y, senTRet.u)
      annotation (Line(points={{121,350},{158,350}}, color={0,0,127}));
    connect(TMixCalculator.y, senTMix.u)
      annotation (Line(points={{121,310},{158,310}}, color={0,0,127}));
    connect(TSupCalculator.y, senTSup.u)
      annotation (Line(points={{121,270},{158,270}}, color={0,0,127}));
    connect(swiCooCoi.u2, modeSelector.yFan) annotation (Line(points={{58,-248},
            {-20,-248},{-20,-310},{-179.545,-310}}, color={255,0,255}));
    connect(cooCoiCon.y, swiCooCoi.u1)
      annotation (Line(points={{-59,-240},{58,-240}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-380,-400},{1440,
              580}})),
      Documentation(info="<html>
<p>
This model consist of an HVAC system, a building envelope model and a model
for air flow through building leakage and through open doors.
</p>
<p>
The HVAC system is a variable air volume (VAV) flow system with economizer
and a heating and cooling coil in the air handler unit. There is also a
reheat coil and an air damper in each of the five zone inlet branches.
The figure below shows the schematic diagram of the HVAC system
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavSchematics.png\" border=\"1\"/>
</p>
<p>
See the model
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoop\">
Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoop</a>
for a description of the HVAC system and the building envelope.
</p>
<p>
The control is an implementation of the control sequence
<i>VAV 2A2-21232</i> of the Sequences of Operation for
Common HVAC Systems (ASHRAE, 2006). In this control sequence, the
supply fan speed is regulated based on the duct static pressure.
The return fan controller tracks the supply fan air flow rate.
The duct static pressure is adjusted
so that at least one VAV damper is 90% open. The economizer dampers
are modulated to track the setpoint for the mixed air dry bulb temperature.
Priority is given to maintain a minimum outside air volume flow rate.
In each zone, the VAV damper is adjusted to meet the room temperature
setpoint for cooling, or fully opened during heating.
The room temperature setpoint for heating is tracked by varying
the water flow rate through the reheat coil. There is also a
finite state machine that transitions the mode of operation of
the HVAC system between the modes
<i>occupied</i>, <i>unoccupied off</i>, <i>unoccupied night set back</i>,
<i>unoccupied warm-up</i> and <i>unoccupied pre-cool</i>.
In the VAV model, all air flows are computed based on the
duct static pressure distribution and the performance curves of the fans.
Local loop control is implemented using proportional and proportional-integral
controllers, while the supervisory control is implemented
using a finite state machine.
</p>
<p>
A similar model but with a different control sequence can be found in
<a href=\"modelica://Buildings.Examples.VAVReheat.Guideline36\">
Buildings.Examples.VAVReheat.Guideline36</a>.
</p>
<h4>References</h4>
<p>
ASHRAE.
<i>Sequences of Operation for Common HVAC Systems</i>.
ASHRAE, Atlanta, GA, 2006.
</p>
</html>",   revisions="<html>
<ul>
<li>
May 19, 2016, by Michael Wetter:<br/>
Changed chilled water supply temperature to <i>6&circ;C</i>.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/509\">#509</a>.
</li>
<li>
April 26, 2016, by Michael Wetter:<br/>
Changed controller for freeze protection as the old implementation closed
the outdoor air damper during summer.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/511\">#511</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
September 24, 2015 by Michael Wetter:<br/>
Set default temperature for medium to avoid conflicting
start values for alias variables of the temperature
of the building and the ambient air.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
</li>
</ul>
</html>"),
      __Dymola_Commands(file=
            "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/ASHRAE2006.mos"
          "Simulate and plot"),
      experiment(StopTime=172800, Tolerance=1e-06));
  end TestcaseCMA;

  block RoomVAV "Controller for room VAV box BOPTEST ready"
    extends Modelica.Blocks.Icons.Block;

    Buildings.Controls.OBC.CDL.Interfaces.RealInput TRooHeaSet(
      final quantity="ThermodynamicTemperature",
      final unit = "K",
      displayUnit = "degC",
      min=0)
      "Setpoint temperature for room for heating"
      annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
          iconTransformation(extent={{-140,60},{-100,100}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealInput TRooCooSet(
      final quantity="ThermodynamicTemperature",
      final unit = "K",
      displayUnit = "degC",
      min=0)
      "Setpoint temperature for room for cooling"
      annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
          iconTransformation(extent={{-140,30},{-100,70}})));

    Modelica.Blocks.Interfaces.RealInput TRoo(
      final quantity="ThermodynamicTemperature",
      final unit = "K",
      displayUnit = "degC",
      min=0)
      "Measured room temperature"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
          iconTransformation(extent={{-140,-60},{-100,-20}})));

    Modelica.Blocks.Interfaces.RealInput TDis(
      final quantity="ThermodynamicTemperature",
      final unit = "K",
      displayUnit = "degC",
      min=0)
      "Measured supply air temperature after heating coil"
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
          iconTransformation(extent={{-140,-100},{-100,-60}})));

    Modelica.Blocks.Interfaces.RealOutput yVal "Signal for heating coil valve"
      annotation (Placement(transformation(extent={{160,-54},{180,-34}})));
    Modelica.Blocks.Interfaces.RealOutput yDam "Signal for VAV damper"
      annotation (Placement(transformation(extent={{160,38},{180,58}})));

    Buildings.Controls.OBC.CDL.Continuous.LimPID conHea(
      yMax=1,
      xi_start=0.1,
      Td=60,
      yMin=0,
      k=0.1,
      Ti=120,
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI)
              "Controller for heating"
      annotation (Placement(transformation(extent={{-20,70},{0,90}})));
    Buildings.Controls.Continuous.LimPID conCoo(
      yMax=1,
      Td=60,
      k=0.1,
      Ti=120,
      controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
      reverseAction=true)
      "Controller for cooling (acts on damper)"
      annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
    IBPSA.Utilities.IO.SignalExchange.Read senTRooAir(
      y(unit="K"),
      description="Air room temperature",
      KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature)
      annotation (Placement(transformation(extent={{140,-84},{160,-64}})));
    IBPSA.Utilities.IO.SignalExchange.Read senTSup(y(unit="K"), description=
          "Air supply temperature")
      annotation (Placement(transformation(extent={{140,-116},{160,-96}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveVal(u(unit="None"),
        description="Heating valve set point")
      annotation (Placement(transformation(extent={{104,-54},{124,-34}})));
    IBPSA.Utilities.IO.SignalExchange.Read senValSet(y(unit="None"),
        description="Heating valve set point")
      annotation (Placement(transformation(extent={{134,-54},{154,-34}})));
    IBPSA.Utilities.IO.SignalExchange.Read senDamSet(y(unit="None"),
        description="Damper set point")
      annotation (Placement(transformation(extent={{132,38},{152,58}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveDam(u(unit="None"),
        description="Damper set point")
      annotation (Placement(transformation(extent={{100,38},{120,58}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveTRooHeaSet(u(unit="K"),
        description="Room heating temperature set point")
      annotation (Placement(transformation(extent={{-94,70},{-74,90}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveTRooCooSet(u(unit="K"),
        description="Room cooling temperature set point")
      annotation (Placement(transformation(extent={{-94,40},{-74,60}})));
    IBPSA.Utilities.IO.SignalExchange.Read senTRooHeaSet(y(unit="K"),
        description="Room heating temperature set point")
      annotation (Placement(transformation(extent={{-66,70},{-46,90}})));
    IBPSA.Utilities.IO.SignalExchange.Read senTRooCooSet(y(unit="K"),
        description="Room cooling temperature set point")
      annotation (Placement(transformation(extent={{-66,40},{-46,60}})));
  protected
    parameter Real kDamHea = 0.5
      "Gain for VAV damper controller in heating mode";

    Buildings.Controls.OBC.CDL.Continuous.Max maxDam
      "Limitation of damper signal"
      annotation (Placement(transformation(extent={{12,-14},{32,6}})));
    Buildings.Controls.OBC.CDL.Continuous.Sources.Constant one(k=1)
      annotation (Placement(transformation(extent={{-74,-76},{-54,-56}})));
    Buildings.Controls.OBC.CDL.Continuous.Add add
      "Addition of cooling and heating signal (one of which being zero due to dual setpoint)"
      annotation (Placement(transformation(extent={{40,-20},{60,0}})));
    Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zero(k=0.1)
      annotation (Placement(transformation(extent={{-20,10},{0,30}})));
    Buildings.Controls.OBC.CDL.Continuous.Min minDam
      "Limitation of damper signal"
      annotation (Placement(transformation(extent={{70,-26},{90,-6}})));

    Buildings.Controls.OBC.CDL.Continuous.MultiSum mulSum(
      final k={1,kDamHea,-kDamHea},
      nin=3) annotation (Placement(transformation(extent={{-20,-20},{0,0}})));

  equation
    connect(conHea.u_m, TRoo) annotation (Line(
        points={{-10,68},{-10,36},{-80,36},{-80,-40},{-120,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(conCoo.u_m, TRoo) annotation (Line(
        points={{-10,-62},{-10,-90},{-80,-90},{-80,-40},{-120,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(conCoo.y, add.u2) annotation (Line(
        points={{1,-50},{20,-50},{20,-16},{38,-16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(zero.y, maxDam.u1)
      annotation (Line(points={{1,20},{6,20},{6,2},{10,2}}, color={0,0,127}));
    connect(maxDam.y, add.u1) annotation (Line(points={{33,-4},{38,-4}},
                      color={0,0,127}));
    connect(add.y, minDam.u1) annotation (Line(points={{61,-10},{68,-10}},
                       color={0,0,127}));
    connect(one.y, minDam.u2) annotation (Line(points={{-53,-66},{44,-66},{44,-22},
            {68,-22}},          color={0,0,127}));
    connect(one.y, mulSum.u[1]) annotation (Line(points={{-53,-66},{-30,-66},{-30,
            -8.66667},{-22,-8.66667}}, color={0,0,127}));
    connect(TDis, mulSum.u[2]) annotation (Line(points={{-120,-80},{-40,-80},{-40,
            -10},{-22,-10}}, color={0,0,127}));
    connect(TRoo, mulSum.u[3]) annotation (Line(points={{-120,-40},{-80,-40},{
            -80,-11.3333},{-22,-11.3333}},            color={0,0,127}));
    connect(maxDam.u2, mulSum.y)
      annotation (Line(points={{10,-10},{1,-10}},   color={0,0,127}));
    connect(senTRooAir.u, TRoo) annotation (Line(points={{138,-74},{-10,-74},{-10,
            -90},{-80,-90},{-80,-40},{-120,-40}}, color={0,0,127}));
    connect(TDis, senTSup.u) annotation (Line(points={{-120,-80},{-90,-80},{-90,
            -106},{138,-106}}, color={0,0,127}));
    connect(conHea.y, oveVal.u) annotation (Line(points={{1,80},{34,80},{34,-44},
            {102,-44}},color={0,0,127}));
    connect(oveVal.y, senValSet.u)
      annotation (Line(points={{125,-44},{132,-44}}, color={0,0,127}));
    connect(senValSet.y, yVal)
      annotation (Line(points={{155,-44},{170,-44}}, color={0,0,127}));
    connect(minDam.y, oveDam.u) annotation (Line(points={{91,-16},{94,-16},{94,48},
            {98,48}}, color={0,0,127}));
    connect(oveDam.y, senDamSet.u)
      annotation (Line(points={{121,48},{130,48}}, color={0,0,127}));
    connect(senDamSet.y, yDam)
      annotation (Line(points={{153,48},{170,48}}, color={0,0,127}));
    connect(oveTRooHeaSet.u, TRooHeaSet)
      annotation (Line(points={{-96,80},{-120,80}}, color={0,0,127}));
    connect(TRooCooSet, oveTRooCooSet.u)
      annotation (Line(points={{-120,50},{-96,50}}, color={0,0,127}));
    connect(conHea.u_s, senTRooHeaSet.y)
      annotation (Line(points={{-22,80},{-45,80}}, color={0,0,127}));
    connect(senTRooHeaSet.u, oveTRooHeaSet.y)
      annotation (Line(points={{-68,80},{-73,80}}, color={0,0,127}));
    connect(oveTRooCooSet.y, senTRooCooSet.u)
      annotation (Line(points={{-73,50},{-68,50}}, color={0,0,127}));
    connect(senTRooCooSet.y, conCoo.u_s) annotation (Line(points={{-45,50},{-42,
            50},{-42,-50},{-22,-50}}, color={0,0,127}));
    annotation ( Icon(coordinateSystem(extent={{-100,-120},{160,100}}),
                      graphics={
          Text(
            extent={{-92,-16},{-44,-40}},
            lineColor={0,0,127},
            textString="TRoo"),
          Text(
            extent={{-92,-72},{-44,-96}},
            lineColor={0,0,127},
            textString="TSup"),
          Text(
            extent={{44,-34},{92,-58}},
            lineColor={0,0,127},
            textString="yHea"),
          Text(
            extent={{42,64},{90,40}},
            lineColor={0,0,127},
            textString="yDam"),
          Text(
            extent={{-90,100},{-42,76}},
            lineColor={0,0,127},
            textString="TRooHeaSet"),
          Text(
            extent={{-90,42},{-42,18}},
            lineColor={0,0,127},
            textString="TRooCooSet")}),
                                  Documentation(info="<html>
<p>
Controller for terminal box of VAV system with reheat.
</p>
</html>",   revisions="<html>
<ul>
<li>
September 20, 2017, by Michael Wetter:<br/>
Removed blocks with blocks from CDL package.
</li>
</ul>
</html>"),
      Diagram(coordinateSystem(extent={{-100,-120},{160,100}})));
  end RoomVAV;

  model VAVBranch "Supply branch of a VAV system"
    extends Modelica.Blocks.Icons.Block;
    replaceable package MediumA = Modelica.Media.Interfaces.PartialMedium
      "Medium model for air" annotation (choicesAllMatching=true);
    replaceable package MediumW = Modelica.Media.Interfaces.PartialMedium
      "Medium model for water" annotation (choicesAllMatching=true);

    parameter Boolean allowFlowReversal=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal
      "Mass flow rate of this thermal zone";
    parameter Modelica.SIunits.Volume VRoo "Room volume";

    Buildings.Fluid.Actuators.Dampers.PressureIndependent vav(
      redeclare package Medium = MediumA,
      m_flow_nominal=m_flow_nominal,
      dp_nominal = 220 + 20,
      allowFlowReversal=allowFlowReversal) "VAV box for room" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-50,40})));
    Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU terHea(
      redeclare package Medium1 = MediumA,
      redeclare package Medium2 = MediumW,
      m1_flow_nominal=m_flow_nominal,
      m2_flow_nominal=m_flow_nominal*1000*(50 - 17)/4200/10,
      Q_flow_nominal=m_flow_nominal*1006*(50 - 16.7),
      configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
      dp1_nominal=0,
      from_dp2=true,
      dp2_nominal=0,
      allowFlowReversal1=allowFlowReversal,
      allowFlowReversal2=false,
      T_a1_nominal=289.85,
      T_a2_nominal=355.35) "Heat exchanger of terminal box" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-44,0})));
    Buildings.Fluid.Sources.FixedBoundary sinTer(
      redeclare package Medium = MediumW,
      p(displayUnit="Pa") = 3E5,
      nPorts=1) "Sink for terminal box " annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={40,-20})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(
      redeclare package Medium = MediumA)
      "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-60,-110},{-40,-90}}),
          iconTransformation(extent={{-60,-110},{-40,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_b(
      redeclare package Medium = MediumA)
      "Fluid connector b (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-60,90},{-40,110}}),
          iconTransformation(extent={{-60,90},{-40,110}})));
    Buildings.Fluid.Sensors.MassFlowRate senMasFlo(
      redeclare package Medium = MediumA,
      allowFlowReversal=allowFlowReversal)
      "Sensor for mass flow rate" annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-50,70})));
    Modelica.Blocks.Math.Gain fraMasFlo(k=1/m_flow_nominal)
      "Fraction of mass flow rate, relative to nominal flow"
      annotation (Placement(transformation(extent={{0,70},{20,90}})));
    Modelica.Blocks.Math.Gain ACH(k=1/VRoo/1.2*3600) "Air change per hour"
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Buildings.Fluid.Sources.MassFlowSource_T souTer(
      redeclare package Medium = MediumW,
      nPorts=1,
      use_m_flow_in=true,
      T=323.15) "Source for terminal box " annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={40,20})));
    Modelica.Blocks.Interfaces.RealInput yVAV
      "Actuator position for VAV damper (0: closed, 1: open)" annotation (
        Placement(transformation(extent={{-140,20},{-100,60}}),
          iconTransformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.RealInput yVal
      "Actuator position for reheat valve (0: closed, 1: open)" annotation (
        Placement(transformation(extent={{-140,-60},{-100,-20}}),
          iconTransformation(extent={{-140,-60},{-100,-20}})));
    Buildings.Controls.OBC.CDL.Continuous.Gain gaiM_flow(
      final k=m_flow_nominal*1000*15/4200/10) "Gain for mass flow rate"
      annotation (Placement(transformation(extent={{80,2},{60,22}})));
    IBPSA.Utilities.IO.SignalExchange.Read senACH(y(unit="None"),
      description="Air change per hour",
        KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None)
      annotation (Placement(transformation(extent={{40,40},{60,60}})));
    Modelica.Blocks.Sources.RealExpression heaCoiPow(y=abs(terHea.Q1_flow))
      annotation (Placement(transformation(extent={{-36,-80},{-16,-60}})));
    IBPSA.Utilities.IO.SignalExchange.Read senPowVAV(
      y(unit="W"),
      description="Thermal power exchanged",
      KPIs=IBPSA.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
      annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
    IBPSA.Utilities.IO.SignalExchange.Subcontroller subConHea(description=
          "Heating input to the zone", u(unit="W"))
      annotation (Placement(transformation(extent={{32,-64},{52,-44}})));
  equation
    connect(fraMasFlo.u, senMasFlo.m_flow) annotation (Line(
        points={{-2,80},{-24,80},{-24,70},{-39,70}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(vav.port_b, senMasFlo.port_a) annotation (Line(
        points={{-50,50},{-50,60}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(ACH.u, senMasFlo.m_flow) annotation (Line(
        points={{-2,50},{-24,50},{-24,70},{-39,70}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(souTer.ports[1], terHea.port_a2) annotation (Line(
        points={{30,20},{-38,20},{-38,10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(port_a, terHea.port_a1) annotation (Line(
        points={{-50,-100},{-50,-10}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(senMasFlo.port_b, port_b) annotation (Line(
        points={{-50,80},{-50,100}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(terHea.port_b1, vav.port_a) annotation (Line(
        points={{-50,10},{-50,30}},
        color={0,127,255},
        thickness=0.5));
    connect(vav.y, yVAV) annotation (Line(points={{-62,40},{-120,40}},
                  color={0,0,127}));
    connect(souTer.m_flow_in, gaiM_flow.y)
      annotation (Line(points={{52,12},{59,12}}, color={0,0,127}));
    connect(sinTer.ports[1], terHea.port_b2) annotation (Line(points={{30,-20},{
            -38,-20},{-38,-10}}, color={0,127,255}));
    connect(ACH.y, senACH.u)
      annotation (Line(points={{21,50},{38,50}}, color={0,0,127}));
    connect(heaCoiPow.y, senPowVAV.u)
      annotation (Line(points={{-15,-70},{78,-70}},color={0,0,127}));
    connect(heaCoiPow.y, subConHea.u_m) annotation (Line(points={{-15,-70},{-2,
            -70},{-2,-48},{30,-48}}, color={0,0,127}));
    connect(subConHea.u, yVal) annotation (Line(points={{30,-54},{8,-54},{8,-40},
            {-120,-40}}, color={0,0,127}));
    connect(subConHea.y, gaiM_flow.u) annotation (Line(points={{53,-54},{90,-54},
            {90,12},{82,12}}, color={0,0,127}));
    annotation (Icon(
      graphics={
          Rectangle(
            extent={{-108.07,-16.1286},{93.93,-20.1286}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255},
            origin={-68.1286,6.07},
            rotation=90),
          Rectangle(
            extent={{-68,-20},{-26,-60}},
            fillPattern=FillPattern.Solid,
            fillColor={175,175,175},
            pattern=LinePattern.None),
          Rectangle(
            extent={{100.8,-22},{128.8,-44}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192},
            origin={-82,-76.8},
            rotation=90),
          Rectangle(
            extent={{102.2,-11.6667},{130.2,-25.6667}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255},
            origin={-67.6667,-78.2},
            rotation=90),
          Polygon(
            points={{-62,32},{-34,48},{-34,46},{-62,30},{-62,32}},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Polygon(
            points={{-68,-28},{-34,-28},{-34,-30},{-68,-30},{-68,-28}},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Polygon(
            points={{-68,-52},{-34,-52},{-34,-54},{-68,-54},{-68,-52}},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Polygon(
            points={{-48,-34},{-34,-28},{-34,-30},{-48,-36},{-48,-34}},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Polygon(
            points={{-48,-34},{-34,-40},{-34,-42},{-48,-36},{-48,-34}},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Polygon(
            points={{-48,-46},{-34,-52},{-34,-54},{-48,-48},{-48,-46}},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Polygon(
            points={{-48,-46},{-34,-40},{-34,-42},{-48,-48},{-48,-46}},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0})}));
  end VAVBranch;

  partial model PartialOpenLoop
    "Partial model of variable air volume flow system with terminal reheat and five thermal zones"

    package MediumA = Buildings.Media.Air "Medium model for air";
    package MediumW = Buildings.Media.Water "Medium model for water";

    constant Integer numZon=5 "Total number of served VAV boxes";

    parameter Modelica.SIunits.Volume VRooCor=AFloCor*flo.hRoo
      "Room volume corridor";
    parameter Modelica.SIunits.Volume VRooSou=AFloSou*flo.hRoo
      "Room volume south";
    parameter Modelica.SIunits.Volume VRooNor=AFloNor*flo.hRoo
      "Room volume north";
    parameter Modelica.SIunits.Volume VRooEas=AFloEas*flo.hRoo "Room volume east";
    parameter Modelica.SIunits.Volume VRooWes=AFloWes*flo.hRoo "Room volume west";

    parameter Modelica.SIunits.Area AFloCor=flo.cor.AFlo "Floor area corridor";
    parameter Modelica.SIunits.Area AFloSou=flo.sou.AFlo "Floor area south";
    parameter Modelica.SIunits.Area AFloNor=flo.nor.AFlo "Floor area north";
    parameter Modelica.SIunits.Area AFloEas=flo.eas.AFlo "Floor area east";
    parameter Modelica.SIunits.Area AFloWes=flo.wes.AFlo "Floor area west";

    parameter Modelica.SIunits.Area AFlo[numZon]={flo.cor.AFlo,flo.sou.AFlo,flo.eas.AFlo,
        flo.nor.AFlo,flo.wes.AFlo} "Floor area of each zone";
    final parameter Modelica.SIunits.Area ATot=sum(AFlo) "Total floor area";

    constant Real conv=1.2/3600 "Conversion factor for nominal mass flow rate";
    parameter Modelica.SIunits.MassFlowRate mCor_flow_nominal=6*VRooCor*conv
      "Design mass flow rate core";
    parameter Modelica.SIunits.MassFlowRate mSou_flow_nominal=6*VRooSou*conv
      "Design mass flow rate perimeter 1";
    parameter Modelica.SIunits.MassFlowRate mEas_flow_nominal=9*VRooEas*conv
      "Design mass flow rate perimeter 2";
    parameter Modelica.SIunits.MassFlowRate mNor_flow_nominal=6*VRooNor*conv
      "Design mass flow rate perimeter 3";
    parameter Modelica.SIunits.MassFlowRate mWes_flow_nominal=7*VRooWes*conv
      "Design mass flow rate perimeter 4";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.7*(mCor_flow_nominal
         + mSou_flow_nominal + mEas_flow_nominal + mNor_flow_nominal +
        mWes_flow_nominal) "Nominal mass flow rate";
    parameter Modelica.SIunits.Angle lat=41.98*3.14159/180 "Latitude";

    parameter Modelica.SIunits.Temperature THeaOn=293.15
      "Heating setpoint during on";
    parameter Modelica.SIunits.Temperature THeaOff=285.15
      "Heating setpoint during off";
    parameter Modelica.SIunits.Temperature TCooOn=297.15
      "Cooling setpoint during on";
    parameter Modelica.SIunits.Temperature TCooOff=303.15
      "Cooling setpoint during off";
    parameter Modelica.SIunits.PressureDifference dpBuiStaSet(min=0) = 12
      "Building static pressure";
    parameter Real yFanMin = 0.1 "Minimum fan speed";

  //  parameter Modelica.SIunits.HeatFlowRate QHeaCoi_nominal= 2.5*yFanMin*m_flow_nominal*1000*(20 - 4)
  //    "Nominal capacity of heating coil";

    parameter Boolean allowFlowReversal=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal"
      annotation (Evaluate=true);

    parameter Boolean use_windPressure=true "Set to true to enable wind pressure";

    parameter Boolean sampleModel=true
      "Set to true to time-sample the model, which can give shorter simulation time if there is already time sampling in the system model"
      annotation (Evaluate=true, Dialog(tab=
            "Experimental (may be changed in future releases)"));

    Buildings.Fluid.Sources.Outside amb(redeclare package Medium = MediumA,
        nPorts=3) "Ambient conditions"
      annotation (Placement(transformation(extent={{-136,-56},{-114,-34}})));
  //  Buildings.Fluid.HeatExchangers.DryCoilCounterFlow heaCoi(
  //    redeclare package Medium1 = MediumW,
  //    redeclare package Medium2 = MediumA,
  //    UA_nominal = QHeaCoi_nominal/Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
  //      T_a1=45,
  //      T_b1=35,
  //      T_a2=3,
  //      T_b2=20),
  //    m2_flow_nominal=m_flow_nominal,
  //    allowFlowReversal1=false,
  //    allowFlowReversal2=allowFlowReversal,
  //    dp1_nominal=0,
  //    dp2_nominal=200 + 200 + 100 + 40,
  //    m1_flow_nominal=QHeaCoi_nominal/4200/10,
  //    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
  //    "Heating coil"
  //    annotation (Placement(transformation(extent={{118,-36},{98,-56}})));

    Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU heaCoi(
      redeclare package Medium1 = MediumW,
      redeclare package Medium2 = MediumA,
      m1_flow_nominal=m_flow_nominal*1000*(10 - (-20))/4200/10,
      m2_flow_nominal=m_flow_nominal,
      configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
      Q_flow_nominal=m_flow_nominal*1006*(16.7 - 8.5),
      dp1_nominal=0,
      dp2_nominal=200 + 200 + 100 + 40,
      allowFlowReversal1=false,
      allowFlowReversal2=allowFlowReversal,
      T_a1_nominal=318.15,
      T_a2_nominal=281.65) "Heating coil"
      annotation (Placement(transformation(extent={{118,-36},{98,-56}})));

    Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(
      UA_nominal=3*m_flow_nominal*1000*15/
          Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
          T_a1=26.2,
          T_b1=12.8,
          T_a2=6,
          T_b2=16),
      redeclare package Medium1 = MediumW,
      redeclare package Medium2 = MediumA,
      m1_flow_nominal=m_flow_nominal*1000*15/4200/10,
      m2_flow_nominal=m_flow_nominal,
      dp2_nominal=0,
      dp1_nominal=0,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      allowFlowReversal1=false,
      allowFlowReversal2=allowFlowReversal) "Cooling coil"
      annotation (Placement(transformation(extent={{210,-36},{190,-56}})));
    Buildings.Fluid.FixedResistances.PressureDrop dpRetDuc(
      m_flow_nominal=m_flow_nominal,
      redeclare package Medium = MediumA,
      allowFlowReversal=allowFlowReversal,
      dp_nominal=40) "Pressure drop for return duct"
      annotation (Placement(transformation(extent={{400,130},{380,150}})));
    Buildings.Fluid.Movers.SpeedControlled_y fanSup(
      redeclare package Medium = MediumA,
      per(pressure(V_flow={0,m_flow_nominal/1.2*2}, dp=2*{780 + 10 + dpBuiStaSet,
              0})),
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) "Supply air fan"
      annotation (Placement(transformation(extent={{300,-50},{320,-30}})));

    Buildings.Fluid.Sensors.VolumeFlowRate senSupFlo(redeclare package Medium =
          MediumA, m_flow_nominal=m_flow_nominal)
      "Sensor for supply fan flow rate"
      annotation (Placement(transformation(extent={{400,-50},{420,-30}})));

    Buildings.Fluid.Sensors.VolumeFlowRate senRetFlo(redeclare package Medium =
          MediumA, m_flow_nominal=m_flow_nominal)
      "Sensor for return fan flow rate"
      annotation (Placement(transformation(extent={{360,130},{340,150}})));

    Buildings.Fluid.Sources.FixedBoundary sinHea(
      redeclare package Medium = MediumW,
      p=300000,
      T=318.15,
      nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={80,-122})));
    Buildings.Fluid.Sources.FixedBoundary sinCoo(
      redeclare package Medium = MediumW,
      p=300000,
      T=285.15,
      nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={180,-120})));
    Modelica.Blocks.Routing.RealPassThrough TOut(y(
        final quantity="ThermodynamicTemperature",
        final unit="K",
        displayUnit="degC",
        min=0))
      annotation (Placement(transformation(extent={{-300,170},{-280,190}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TSup(
      redeclare package Medium = MediumA,
      m_flow_nominal=m_flow_nominal,
      allowFlowReversal=allowFlowReversal)
      annotation (Placement(transformation(extent={{330,-50},{350,-30}})));
    Buildings.Fluid.Sensors.RelativePressure dpDisSupFan(redeclare package
        Medium =
          MediumA) "Supply fan static discharge pressure" annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={320,0})));
    Buildings.Controls.SetPoints.OccupancySchedule occSch(occupancy=3600*{6,19})
      "Occupancy schedule"
      annotation (Placement(transformation(extent={{-318,-220},{-298,-200}})));
    Buildings.Utilities.Math.Min min(nin=5) "Computes lowest room temperature"
      annotation (Placement(transformation(extent={{1200,440},{1220,460}})));
    Buildings.Utilities.Math.Average ave(nin=5)
      "Compute average of room temperatures"
      annotation (Placement(transformation(extent={{1200,410},{1220,430}})));
    Buildings.Fluid.Sources.MassFlowSource_T souCoo(
      redeclare package Medium = MediumW,
      T=279.15,
      nPorts=1,
      use_m_flow_in=true) "Source for cooling coil" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={230,-120})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TRet(
      redeclare package Medium = MediumA,
      m_flow_nominal=m_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Return air temperature sensor"
      annotation (Placement(transformation(extent={{110,130},{90,150}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TMix(
      redeclare package Medium = MediumA,
      m_flow_nominal=m_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Mixed air temperature sensor"
      annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
    Buildings.Fluid.Sources.MassFlowSource_T souHea(
      redeclare package Medium = MediumW,
      T=318.15,
      use_m_flow_in=true,
      nPorts=1)           "Source for heating coil" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={132,-120})));
    Buildings.Fluid.Sensors.VolumeFlowRate VOut1(redeclare package Medium =
          MediumA, m_flow_nominal=m_flow_nominal) "Outside air volume flow rate"
      annotation (Placement(transformation(extent={{-72,-44},{-50,-22}})));

    VAVBranch                                           cor(
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW,
      m_flow_nominal=mCor_flow_nominal,
      VRoo=VRooCor,
      allowFlowReversal=allowFlowReversal)
      "Zone for core of buildings (azimuth will be neglected)"
      annotation (Placement(transformation(extent={{570,22},{610,62}})));
    VAVBranch                                           sou(
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW,
      m_flow_nominal=mSou_flow_nominal,
      VRoo=VRooSou,
      allowFlowReversal=allowFlowReversal) "South-facing thermal zone"
      annotation (Placement(transformation(extent={{750,20},{790,60}})));
    VAVBranch                                           eas(
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW,
      m_flow_nominal=mEas_flow_nominal,
      VRoo=VRooEas,
      allowFlowReversal=allowFlowReversal) "East-facing thermal zone"
      annotation (Placement(transformation(extent={{930,20},{970,60}})));
    VAVBranch                                           nor(
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW,
      m_flow_nominal=mNor_flow_nominal,
      VRoo=VRooNor,
      allowFlowReversal=allowFlowReversal) "North-facing thermal zone"
      annotation (Placement(transformation(extent={{1090,20},{1130,60}})));
    VAVBranch                                           wes(
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW,
      m_flow_nominal=mWes_flow_nominal,
      VRoo=VRooWes,
      allowFlowReversal=allowFlowReversal) "West-facing thermal zone"
      annotation (Placement(transformation(extent={{1290,20},{1330,60}})));
    Buildings.Fluid.FixedResistances.Junction splRetRoo1(
      redeclare package Medium = MediumA,
      m_flow_nominal={m_flow_nominal,m_flow_nominal - mCor_flow_nominal,
          mCor_flow_nominal},
      from_dp=false,
      linearized=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      dp_nominal(each displayUnit="Pa") = {0,0,0},
      portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering,
      portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering)
      "Splitter for room return"
      annotation (Placement(transformation(extent={{630,10},{650,-10}})));
    Buildings.Fluid.FixedResistances.Junction splRetSou(
      redeclare package Medium = MediumA,
      m_flow_nominal={mSou_flow_nominal + mEas_flow_nominal + mNor_flow_nominal
           + mWes_flow_nominal,mEas_flow_nominal + mNor_flow_nominal +
          mWes_flow_nominal,mSou_flow_nominal},
      from_dp=false,
      linearized=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      dp_nominal(each displayUnit="Pa") = {0,0,0},
      portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering,
      portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering)
      "Splitter for room return"
      annotation (Placement(transformation(extent={{812,10},{832,-10}})));
    Buildings.Fluid.FixedResistances.Junction splRetEas(
      redeclare package Medium = MediumA,
      m_flow_nominal={mEas_flow_nominal + mNor_flow_nominal + mWes_flow_nominal,
          mNor_flow_nominal + mWes_flow_nominal,mEas_flow_nominal},
      from_dp=false,
      linearized=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      dp_nominal(each displayUnit="Pa") = {0,0,0},
      portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering,
      portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering)
      "Splitter for room return"
      annotation (Placement(transformation(extent={{992,10},{1012,-10}})));
    Buildings.Fluid.FixedResistances.Junction splRetNor(
      redeclare package Medium = MediumA,
      m_flow_nominal={mNor_flow_nominal + mWes_flow_nominal,mWes_flow_nominal,
          mNor_flow_nominal},
      from_dp=false,
      linearized=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      dp_nominal(each displayUnit="Pa") = {0,0,0},
      portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering,
      portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering)
      "Splitter for room return"
      annotation (Placement(transformation(extent={{1142,10},{1162,-10}})));
    Buildings.Fluid.FixedResistances.Junction splSupRoo1(
      redeclare package Medium = MediumA,
      m_flow_nominal={m_flow_nominal,m_flow_nominal - mCor_flow_nominal,
          mCor_flow_nominal},
      from_dp=true,
      linearized=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      dp_nominal(each displayUnit="Pa") = {0,0,0},
      portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering,
      portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving)
      "Splitter for room supply"
      annotation (Placement(transformation(extent={{570,-30},{590,-50}})));
    Buildings.Fluid.FixedResistances.Junction splSupSou(
      redeclare package Medium = MediumA,
      m_flow_nominal={mSou_flow_nominal + mEas_flow_nominal + mNor_flow_nominal
           + mWes_flow_nominal,mEas_flow_nominal + mNor_flow_nominal +
          mWes_flow_nominal,mSou_flow_nominal},
      from_dp=true,
      linearized=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      dp_nominal(each displayUnit="Pa") = {0,0,0},
      portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering,
      portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving)
      "Splitter for room supply"
      annotation (Placement(transformation(extent={{750,-30},{770,-50}})));
    Buildings.Fluid.FixedResistances.Junction splSupEas(
      redeclare package Medium = MediumA,
      m_flow_nominal={mEas_flow_nominal + mNor_flow_nominal + mWes_flow_nominal,
          mNor_flow_nominal + mWes_flow_nominal,mEas_flow_nominal},
      from_dp=true,
      linearized=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      dp_nominal(each displayUnit="Pa") = {0,0,0},
      portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering,
      portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving)
      "Splitter for room supply"
      annotation (Placement(transformation(extent={{930,-30},{950,-50}})));
    Buildings.Fluid.FixedResistances.Junction splSupNor(
      redeclare package Medium = MediumA,
      m_flow_nominal={mNor_flow_nominal + mWes_flow_nominal,mWes_flow_nominal,
          mNor_flow_nominal},
      from_dp=true,
      linearized=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      dp_nominal(each displayUnit="Pa") = {0,0,0},
      portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Entering,
      portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
           else Modelica.Fluid.Types.PortFlowDirection.Leaving)
      "Splitter for room supply"
      annotation (Placement(transformation(extent={{1090,-30},{1110,-50}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          Modelica.Utilities.Files.loadResource(
          "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
      annotation (Placement(transformation(extent={{-360,170},{-340,190}})));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
      annotation (Placement(transformation(extent={{-330,170},{-310,190}}),
          iconTransformation(extent={{-360,170},{-340,190}})));
    Buildings.Examples.VAVReheat.ThermalZones.Floor flo(
      redeclare final package Medium = MediumA,
      final lat=lat,
      final use_windPressure=use_windPressure,
      final sampleModel=sampleModel)
      "Model of a floor of the building that is served by this VAV system"
      annotation (Placement(transformation(extent={{772,396},{1100,616}})));
    Modelica.Blocks.Routing.DeMultiplex5 TRooAir(u(each unit="K", each
          displayUnit="degC")) "Demultiplex for room air temperature"
      annotation (Placement(transformation(extent={{490,160},{510,180}})));

    Buildings.Fluid.Sensors.TemperatureTwoPort TSupCor(
      redeclare package Medium = MediumA,
      initType=Modelica.Blocks.Types.Init.InitialState,
      m_flow_nominal=mCor_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Discharge air temperature"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={580,92})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TSupSou(
      redeclare package Medium = MediumA,
      initType=Modelica.Blocks.Types.Init.InitialState,
      m_flow_nominal=mSou_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Discharge air temperature"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={760,92})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TSupEas(
      redeclare package Medium = MediumA,
      initType=Modelica.Blocks.Types.Init.InitialState,
      m_flow_nominal=mEas_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Discharge air temperature"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={940,90})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TSupNor(
      redeclare package Medium = MediumA,
      initType=Modelica.Blocks.Types.Init.InitialState,
      m_flow_nominal=mNor_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Discharge air temperature"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={1100,94})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TSupWes(
      redeclare package Medium = MediumA,
      initType=Modelica.Blocks.Types.Init.InitialState,
      m_flow_nominal=mWes_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Discharge air temperature"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={1300,90})));
    Buildings.Fluid.Sensors.VolumeFlowRate VSupCor_flow(
      redeclare package Medium = MediumA,
      initType=Modelica.Blocks.Types.Init.InitialState,
      m_flow_nominal=mCor_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Discharge air flow rate"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={580,130})));
    Buildings.Fluid.Sensors.VolumeFlowRate VSupSou_flow(
      redeclare package Medium = MediumA,
      initType=Modelica.Blocks.Types.Init.InitialState,
      m_flow_nominal=mSou_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Discharge air flow rate"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={760,130})));
    Buildings.Fluid.Sensors.VolumeFlowRate VSupEas_flow(
      redeclare package Medium = MediumA,
      initType=Modelica.Blocks.Types.Init.InitialState,
      m_flow_nominal=mEas_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Discharge air flow rate"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={940,128})));
    Buildings.Fluid.Sensors.VolumeFlowRate VSupNor_flow(
      redeclare package Medium = MediumA,
      initType=Modelica.Blocks.Types.Init.InitialState,
      m_flow_nominal=mNor_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Discharge air flow rate"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={1100,132})));
    Buildings.Fluid.Sensors.VolumeFlowRate VSupWes_flow(
      redeclare package Medium = MediumA,
      initType=Modelica.Blocks.Types.Init.InitialState,
      m_flow_nominal=mWes_flow_nominal,
      allowFlowReversal=allowFlowReversal) "Discharge air flow rate"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={1300,128})));
    Buildings.Examples.VAVReheat.BaseClasses.MixingBox eco(
      redeclare package Medium = MediumA,
      mOut_flow_nominal=m_flow_nominal,
      dpOut_nominal=10,
      mRec_flow_nominal=m_flow_nominal,
      dpRec_nominal=10,
      mExh_flow_nominal=m_flow_nominal,
      dpExh_nominal=10,
      from_dp=false) "Economizer" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-10,-46})));

    Results res(
      final A=ATot,
      PFan=fanSup.P + 0,
      PHea=heaCoi.Q2_flow + cor.terHea.Q1_flow + nor.terHea.Q1_flow + wes.terHea.Q1_flow
           + eas.terHea.Q1_flow + sou.terHea.Q1_flow,
      PCooSen=cooCoi.QSen2_flow,
      PCooLat=cooCoi.QLat2_flow) "Results of the simulation";
    /*fanRet*/

  protected
    model Results "Model to store the results of the simulation"
      parameter Modelica.SIunits.Area A "Floor area";
      input Modelica.SIunits.Power PFan "Fan energy";
      input Modelica.SIunits.Power PHea "Heating energy";
      input Modelica.SIunits.Power PCooSen "Sensible cooling energy";
      input Modelica.SIunits.Power PCooLat "Latent cooling energy";

      Real EFan(
        unit="J/m2",
        start=0,
        nominal=1E5,
        fixed=true) "Fan energy";
      Real EHea(
        unit="J/m2",
        start=0,
        nominal=1E5,
        fixed=true) "Heating energy";
      Real ECooSen(
        unit="J/m2",
        start=0,
        nominal=1E5,
        fixed=true) "Sensible cooling energy";
      Real ECooLat(
        unit="J/m2",
        start=0,
        nominal=1E5,
        fixed=true) "Latent cooling energy";
      Real ECoo(unit="J/m2") "Total cooling energy";
    equation

      A*der(EFan) = PFan;
      A*der(EHea) = PHea;
      A*der(ECooSen) = PCooSen;
      A*der(ECooLat) = PCooLat;
      ECoo = ECooSen + ECooLat;

    end Results;
  public
    Buildings.Controls.OBC.CDL.Continuous.Gain gaiHeaCoi(k=m_flow_nominal*1000*40
          /4200/10) "Gain for heating coil mass flow rate"
      annotation (Placement(transformation(extent={{100,-220},{120,-200}})));
    Buildings.Controls.OBC.CDL.Continuous.Gain gaiCooCoi(k=m_flow_nominal*1000*15
          /4200/10) "Gain for cooling coil mass flow rate"
      annotation (Placement(transformation(extent={{100,-258},{120,-238}})));
    Buildings.Controls.OBC.CDL.Logical.OnOffController freSta(bandwidth=1)
      "Freeze stat for heating coil"
      annotation (Placement(transformation(extent={{0,-102},{20,-82}})));
    Buildings.Controls.OBC.CDL.Continuous.Sources.Constant freStaTSetPoi(k=273.15
           + 3) "Freeze stat set point for heating coil"
      annotation (Placement(transformation(extent={{-40,-96},{-20,-76}})));
  equation
    connect(fanSup.port_b, dpDisSupFan.port_a) annotation (Line(
        points={{320,-40},{320,-10}},
        color={0,0,0},
        smooth=Smooth.None,
        pattern=LinePattern.Dot));
    connect(TSup.port_a, fanSup.port_b) annotation (Line(
        points={{330,-40},{320,-40}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(amb.ports[1], VOut1.port_a) annotation (Line(
        points={{-114,-42.0667},{-94,-42.0667},{-94,-33},{-72,-33}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splRetRoo1.port_1, dpRetDuc.port_a) annotation (Line(
        points={{630,0},{430,0},{430,140},{400,140}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splRetNor.port_1, splRetEas.port_2) annotation (Line(
        points={{1142,0},{1110,0},{1110,0},{1078,0},{1078,0},{1012,0}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splRetEas.port_1, splRetSou.port_2) annotation (Line(
        points={{992,0},{952,0},{952,0},{912,0},{912,0},{832,0}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splRetSou.port_1, splRetRoo1.port_2) annotation (Line(
        points={{812,0},{650,0}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splSupRoo1.port_3, cor.port_a) annotation (Line(
        points={{580,-30},{580,22}},
        color={0,127,255},
        thickness=0.5));
    connect(splSupRoo1.port_2, splSupSou.port_1) annotation (Line(
        points={{590,-40},{750,-40}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splSupSou.port_3, sou.port_a) annotation (Line(
        points={{760,-30},{760,20}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splSupSou.port_2, splSupEas.port_1) annotation (Line(
        points={{770,-40},{930,-40}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splSupEas.port_3, eas.port_a) annotation (Line(
        points={{940,-30},{940,20}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splSupEas.port_2, splSupNor.port_1) annotation (Line(
        points={{950,-40},{1090,-40}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splSupNor.port_3, nor.port_a) annotation (Line(
        points={{1100,-30},{1100,20}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(splSupNor.port_2, wes.port_a) annotation (Line(
        points={{1110,-40},{1300,-40},{1300,20}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(cooCoi.port_b1, sinCoo.ports[1]) annotation (Line(
        points={{190,-52},{180,-52},{180,-110}},
        color={28,108,200},
        thickness=0.5));
    connect(weaDat.weaBus, weaBus) annotation (Line(
        points={{-340,180},{-320,180}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(weaBus.TDryBul, TOut.u) annotation (Line(
        points={{-320,180},{-302,180}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(amb.weaBus, weaBus) annotation (Line(
        points={{-136,-44.78},{-320,-44.78},{-320,180}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(splRetRoo1.port_3, flo.portsCor[2]) annotation (Line(
        points={{640,10},{640,364},{874,364},{874,472},{898,472},{898,449.533},
            {924.286,449.533}},
        color={0,127,255},
        thickness=0.5));
    connect(splRetSou.port_3, flo.portsSou[2]) annotation (Line(
        points={{822,10},{822,350},{900,350},{900,420.2},{924.286,420.2}},
        color={0,127,255},
        thickness=0.5));
    connect(splRetEas.port_3, flo.portsEas[2]) annotation (Line(
        points={{1002,10},{1002,368},{1067.2,368},{1067.2,445.867}},
        color={0,127,255},
        thickness=0.5));
    connect(splRetNor.port_3, flo.portsNor[2]) annotation (Line(
        points={{1152,10},{1152,446},{924.286,446},{924.286,478.867}},
        color={0,127,255},
        thickness=0.5));
    connect(splRetNor.port_2, flo.portsWes[2]) annotation (Line(
        points={{1162,0},{1342,0},{1342,394},{854,394},{854,449.533}},
        color={0,127,255},
        thickness=0.5));
    connect(weaBus, flo.weaBus) annotation (Line(
        points={{-320,180},{-320,506},{988.714,506}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(flo.TRooAir, min.u) annotation (Line(
        points={{1094.14,491.333},{1164.7,491.333},{1164.7,450},{1198,450}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(flo.TRooAir, ave.u) annotation (Line(
        points={{1094.14,491.333},{1166,491.333},{1166,420},{1198,420}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(TRooAir.u, flo.TRooAir) annotation (Line(
        points={{488,170},{480,170},{480,538},{1164,538},{1164,491.333},{
            1094.14,491.333}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));

    connect(cooCoi.port_b2, fanSup.port_a) annotation (Line(
        points={{210,-40},{300,-40}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=0.5));
    connect(cor.port_b, TSupCor.port_a) annotation (Line(
        points={{580,62},{580,82}},
        color={0,127,255},
        thickness=0.5));

    connect(sou.port_b, TSupSou.port_a) annotation (Line(
        points={{760,60},{760,82}},
        color={0,127,255},
        thickness=0.5));
    connect(eas.port_b, TSupEas.port_a) annotation (Line(
        points={{940,60},{940,80}},
        color={0,127,255},
        thickness=0.5));
    connect(nor.port_b, TSupNor.port_a) annotation (Line(
        points={{1100,60},{1100,84}},
        color={0,127,255},
        thickness=0.5));
    connect(wes.port_b, TSupWes.port_a) annotation (Line(
        points={{1300,60},{1300,80}},
        color={0,127,255},
        thickness=0.5));

    connect(TSupCor.port_b, VSupCor_flow.port_a) annotation (Line(
        points={{580,102},{580,120}},
        color={0,127,255},
        thickness=0.5));
    connect(TSupSou.port_b, VSupSou_flow.port_a) annotation (Line(
        points={{760,102},{760,120}},
        color={0,127,255},
        thickness=0.5));
    connect(TSupEas.port_b, VSupEas_flow.port_a) annotation (Line(
        points={{940,100},{940,100},{940,118}},
        color={0,127,255},
        thickness=0.5));
    connect(TSupNor.port_b, VSupNor_flow.port_a) annotation (Line(
        points={{1100,104},{1100,122}},
        color={0,127,255},
        thickness=0.5));
    connect(TSupWes.port_b, VSupWes_flow.port_a) annotation (Line(
        points={{1300,100},{1300,118}},
        color={0,127,255},
        thickness=0.5));
    connect(VSupCor_flow.port_b, flo.portsCor[1]) annotation (Line(
        points={{580,140},{580,372},{866,372},{866,480},{912.571,480},{912.571,
            449.533}},
        color={0,127,255},
        thickness=0.5));

    connect(VSupSou_flow.port_b, flo.portsSou[1]) annotation (Line(
        points={{760,140},{760,356},{912.571,356},{912.571,420.2}},
        color={0,127,255},
        thickness=0.5));
    connect(VSupEas_flow.port_b, flo.portsEas[1]) annotation (Line(
        points={{940,138},{940,376},{1055.49,376},{1055.49,445.867}},
        color={0,127,255},
        thickness=0.5));
    connect(VSupNor_flow.port_b, flo.portsNor[1]) annotation (Line(
        points={{1100,142},{1100,498},{912.571,498},{912.571,478.867}},
        color={0,127,255},
        thickness=0.5));
    connect(VSupWes_flow.port_b, flo.portsWes[1]) annotation (Line(
        points={{1300,138},{1300,384},{842.286,384},{842.286,449.533}},
        color={0,127,255},
        thickness=0.5));
    connect(VOut1.port_b, eco.port_Out) annotation (Line(
        points={{-50,-33},{-42,-33},{-42,-40},{-20,-40}},
        color={0,127,255},
        thickness=0.5));
    connect(eco.port_Sup, TMix.port_a) annotation (Line(
        points={{0,-40},{30,-40}},
        color={0,127,255},
        thickness=0.5));
    connect(eco.port_Exh, amb.ports[2]) annotation (Line(
        points={{-20,-52},{-96,-52},{-96,-45},{-114,-45}},
        color={0,127,255},
        thickness=0.5));
    connect(eco.port_Ret, TRet.port_b) annotation (Line(
        points={{0,-52},{10,-52},{10,140},{90,140}},
        color={0,127,255},
        thickness=0.5));
    connect(senRetFlo.port_a, dpRetDuc.port_b)
      annotation (Line(points={{360,140},{380,140}}, color={0,127,255}));
    connect(TSup.port_b, senSupFlo.port_a)
      annotation (Line(points={{350,-40},{400,-40}}, color={0,127,255}));
    connect(senSupFlo.port_b, splSupRoo1.port_1)
      annotation (Line(points={{420,-40},{570,-40}}, color={0,127,255}));
    connect(cooCoi.port_a1, souCoo.ports[1]) annotation (Line(
        points={{210,-52},{230,-52},{230,-110}},
        color={28,108,200},
        thickness=0.5));
    connect(gaiHeaCoi.y, souHea.m_flow_in) annotation (Line(points={{121,-210},
            {124,-210},{124,-132}},color={0,0,127}));
    connect(gaiCooCoi.y, souCoo.m_flow_in) annotation (Line(points={{121,-248},
            {222,-248},{222,-132}},color={0,0,127}));
    connect(dpDisSupFan.port_b, amb.ports[3]) annotation (Line(
        points={{320,10},{320,14},{-88,14},{-88,-47.9333},{-114,-47.9333}},
        color={0,0,0},
        pattern=LinePattern.Dot));
    connect(senRetFlo.port_b, TRet.port_a) annotation (Line(points={{340,140},{
            226,140},{110,140}}, color={0,127,255}));
    connect(freStaTSetPoi.y, freSta.reference)
      annotation (Line(points={{-19,-86},{-2,-86}}, color={0,0,127}));
    connect(freSta.u, TMix.T) annotation (Line(points={{-2,-98},{-10,-98},{-10,-70},
            {20,-70},{20,-20},{40,-20},{40,-29}}, color={0,0,127}));
    connect(TMix.port_b, heaCoi.port_a2) annotation (Line(
        points={{50,-40},{98,-40}},
        color={0,127,255},
        thickness=0.5));
    connect(heaCoi.port_b2, cooCoi.port_a2) annotation (Line(
        points={{118,-40},{190,-40}},
        color={0,127,255},
        thickness=0.5));
    connect(souHea.ports[1], heaCoi.port_a1) annotation (Line(
        points={{132,-110},{132,-52},{118,-52}},
        color={28,108,200},
        thickness=0.5));
    connect(heaCoi.port_b1, sinHea.ports[1]) annotation (Line(
        points={{98,-52},{80,-52},{80,-112}},
        color={28,108,200},
        thickness=0.5));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-380,
              -400},{1420,600}})), Documentation(info="<html>
<p>
This model consist of an HVAC system, a building envelope model and a model
for air flow through building leakage and through open doors.
</p>
<p>
The HVAC system is a variable air volume (VAV) flow system with economizer
and a heating and cooling coil in the air handler unit. There is also a
reheat coil and an air damper in each of the five zone inlet branches.
The figure below shows the schematic diagram of the HVAC system
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavSchematics.png\" border=\"1\"/>
</p>
<p>
Most of the HVAC control in this model is open loop.
Two models that extend this model, namely
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>
and
<a href=\"modelica://Buildings.Examples.VAVReheat.Guideline36\">
Buildings.Examples.VAVReheat.Guideline36</a>
add closed loop control. See these models for a description of
the control sequence.
</p>
<p>
To model the heat transfer through the building envelope,
a model of five interconnected rooms is used.
The five room model is representative of one floor of the
new construction medium office building for Chicago, IL,
as described in the set of DOE Commercial Building Benchmarks
(Deru et al, 2009). There are four perimeter zones and one core zone.
The envelope thermal properties meet ASHRAE Standard 90.1-2004.
The thermal room model computes transient heat conduction through
walls, floors and ceilings and long-wave radiative heat exchange between
surfaces. The convective heat transfer coefficient is computed based
on the temperature difference between the surface and the room air.
There is also a layer-by-layer short-wave radiation,
long-wave radiation, convection and conduction heat transfer model for the
windows. The model is similar to the
Window 5 model and described in TARCOG 2006.
</p>
<p>
Each thermal zone can have air flow from the HVAC system, through leakages of the building envelope (except for the core zone) and through bi-directional air exchange through open doors that connect adjacent zones. The bi-directional air exchange is modeled based on the differences in static pressure between adjacent rooms at a reference height plus the difference in static pressure across the door height as a function of the difference in air density.
Infiltration is a function of the
flow imbalance of the HVAC system.
</p>
<h4>References</h4>
<p>
Deru M., K. Field, D. Studer, K. Benne, B. Griffith, P. Torcellini,
 M. Halverson, D. Winiarski, B. Liu, M. Rosenberg, J. Huang, M. Yazdanian, and D. Crawley.
<i>DOE commercial building research benchmarks for commercial buildings</i>.
Technical report, U.S. Department of Energy, Energy Efficiency and
Renewable Energy, Office of Building Technologies, Washington, DC, 2009.
</p>
<p>
TARCOG 2006: Carli, Inc., TARCOG: Mathematical models for calculation
of thermal performance of glazing systems with our without
shading devices, Technical Report, Oct. 17, 2006.
</p>
</html>",   revisions="<html>
<ul>
<li>
September 26, 2017, by Michael Wetter:<br/>
Separated physical model from control to facilitate implementation of alternate control
sequences.
</li>
<li>
May 19, 2016, by Michael Wetter:<br/>
Changed chilled water supply temperature to <i>6&circ;C</i>.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/509\">#509</a>.
</li>
<li>
April 26, 2016, by Michael Wetter:<br/>
Changed controller for freeze protection as the old implementation closed
the outdoor air damper during summer.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/511\">#511</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
September 24, 2015 by Michael Wetter:<br/>
Set default temperature for medium to avoid conflicting
start values for alias variables of the temperature
of the building and the ambient air.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
</li>
</ul>
</html>"));
  end PartialOpenLoop;

  model ModeSelector "Finite State Machine for the operational modes"
    Modelica.StateGraph.InitialStep initialStep
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.StateGraph.Transition start "Starts the system"
      annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
    Buildings.Examples.VAVReheat.Controls.State unOccOff(
      mode=Buildings.Examples.VAVReheat.Controls.OperationModes.unoccupiedOff,
      nIn=3,
      nOut=4) "Unoccupied off mode, no coil protection"
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Buildings.Examples.VAVReheat.Controls.State unOccNigSetBac(
      nOut=2,
      mode=Buildings.Examples.VAVReheat.Controls.OperationModes.unoccupiedNightSetBack,
      nIn=1) "Unoccupied night set back"
      annotation (Placement(transformation(extent={{80,20},{100,40}})));

    Modelica.StateGraph.Transition t2(
      enableTimer=true,
      waitTime=60,
      condition=TRooMinErrHea.y > delTRooOnOff/2)
      annotation (Placement(transformation(extent={{28,20},{48,40}})));
    parameter Modelica.SIunits.TemperatureDifference delTRooOnOff(min=0.1)=1
      "Deadband in room temperature between occupied on and occupied off";
    parameter Modelica.SIunits.Temperature TRooSetHeaOcc=293.15
      "Set point for room air temperature during heating mode";
    parameter Modelica.SIunits.Temperature TRooSetCooOcc=299.15
      "Set point for room air temperature during cooling mode";
    parameter Modelica.SIunits.Temperature TSetHeaCoiOut=303.15
      "Set point for air outlet temperature at central heating coil";
    Modelica.StateGraph.Transition t1(condition=delTRooOnOff/2 < -TRooMinErrHea.y,
      enableTimer=true,
      waitTime=30*60)
      annotation (Placement(transformation(extent={{50,70},{30,90}})));
    inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
      annotation (Placement(transformation(extent={{160,160},{180,180}})));
    Buildings.Examples.VAVReheat.Controls.ControlBus cb annotation (Placement(
          transformation(extent={{-168,130},{-148,150}}), iconTransformation(
            extent={{-176,124},{-124,176}})));
    Modelica.Blocks.Routing.RealPassThrough TRooSetHea
      "Current heating setpoint temperature"
      annotation (Placement(transformation(extent={{-80,170},{-60,190}})));
    Buildings.Examples.VAVReheat.Controls.State morWarUp(
      mode=Buildings.Examples.VAVReheat.Controls.OperationModes.unoccupiedWarmUp,
      nIn=2,
      nOut=1) "Morning warm up"
      annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));

    Modelica.StateGraph.TransitionWithSignal t6(enableTimer=true, waitTime=60)
      annotation (Placement(transformation(extent={{-76,-100},{-56,-80}})));
    Modelica.Blocks.Logical.LessEqualThreshold occThrSho(threshold=1800)
      "Signal to allow transition into morning warmup"
      annotation (Placement(transformation(extent={{-140,-190},{-120,-170}})));
    Modelica.StateGraph.TransitionWithSignal t5
      annotation (Placement(transformation(extent={{118,20},{138,40}})));
    Buildings.Examples.VAVReheat.Controls.State occ(mode=Buildings.Examples.VAVReheat.Controls.OperationModes.occupied,
        nIn=3) "Occupied mode"
      annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
    Modelica.Blocks.Routing.RealPassThrough TRooMin
      annotation (Placement(transformation(extent={{-80,140},{-60,160}})));
    Modelica.Blocks.Math.Feedback TRooMinErrHea "Room control error for heating"
      annotation (Placement(transformation(extent={{-40,170},{-20,190}})));
    Modelica.StateGraph.Transition t3(condition=TRooMin.y + delTRooOnOff/2 >
          TRooSetHeaOcc or occupied.y)
      annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
    Modelica.Blocks.Routing.BooleanPassThrough occupied
      "outputs true if building is occupied"
      annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
    Modelica.StateGraph.TransitionWithSignal t4(enableTimer=false)
      annotation (Placement(transformation(extent={{118,120},{98,140}})));
    Buildings.Examples.VAVReheat.Controls.State morPreCoo(
      nIn=2,
      mode=Buildings.Examples.VAVReheat.Controls.OperationModes.unoccupiedPreCool,
      nOut=1) "Pre-cooling mode"
      annotation (Placement(transformation(extent={{-40,-140},{-20,-120}})));

    Modelica.StateGraph.Transition t7(condition=TRooMin.y - delTRooOnOff/2 <
          TRooSetCooOcc or occupied.y)
      annotation (Placement(transformation(extent={{10,-140},{30,-120}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{-100,-200},{-80,-180}})));
    Modelica.Blocks.Routing.RealPassThrough TRooAve "Average room temperature"
      annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=TRooAve.y <
          TRooSetCooOcc)
      annotation (Placement(transformation(extent={{-198,-224},{-122,-200}})));
    Buildings.Examples.VAVReheat.Controls.PreCoolingStarter preCooSta(
        TRooSetCooOcc=TRooSetCooOcc) "Model to start pre-cooling"
      annotation (Placement(transformation(extent={{-140,-160},{-120,-140}})));
    Modelica.StateGraph.TransitionWithSignal t9
      annotation (Placement(transformation(extent={{-90,-140},{-70,-120}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-48,-180},{-28,-160}})));
    Modelica.Blocks.Logical.And and2
      annotation (Placement(transformation(extent={{80,100},{100,120}})));
    Modelica.Blocks.Logical.Not not2
      annotation (Placement(transformation(extent={{0,100},{20,120}})));
    Modelica.StateGraph.TransitionWithSignal t8
      "changes to occupied in case precooling is deactivated"
      annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
    Modelica.Blocks.MathInteger.Sum sum(nu=5)
      annotation (Placement(transformation(extent={{-186,134},{-174,146}})));
    Modelica.Blocks.Interfaces.BooleanOutput yFan
      "True if the fans are to be switched on"
      annotation (Placement(transformation(extent={{220,-10},{240,10}})));
    Modelica.Blocks.MathBoolean.Or or1(nu=5)
      annotation (Placement(transformation(extent={{184,-6},{196,6}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
      annotation (Placement(transformation(extent={{194,56},{214,76}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveFanMod(u(unit="None"),
        description="Overwrite the fan mode")
      annotation (Placement(transformation(extent={{164,56},{184,76}})));
    Modelica.Blocks.Sources.Constant const(k=1)
      annotation (Placement(transformation(extent={{172,112},{192,132}})));
    IBPSA.Utilities.IO.SignalExchange.Overwrite oveConMod(u(unit="None"),
        description="Overwrite the control mode")
      annotation (Placement(transformation(extent={{-160,190},{-140,210}})));
    Modelica.Blocks.Math.RealToInteger realToInteger
      annotation (Placement(transformation(extent={{-140,160},{-160,180}})));
    Modelica.Blocks.Math.IntegerToReal integerToReal
      annotation (Placement(transformation(extent={{-200,190},{-180,210}})));
  equation
    connect(start.outPort, unOccOff.inPort[1]) annotation (Line(
        points={{-38.5,30},{-29.75,30},{-29.75,30.6667},{-21,30.6667}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(initialStep.outPort[1], start.inPort) annotation (Line(
        points={{-59.5,30},{-44,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(unOccOff.outPort[1], t2.inPort)         annotation (Line(
        points={{0.5,30.375},{8.25,30.375},{8.25,30},{34,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(t2.outPort, unOccNigSetBac.inPort[1])  annotation (Line(
        points={{39.5,30},{79,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(unOccNigSetBac.outPort[1], t1.inPort)   annotation (Line(
        points={{100.5,30.25},{112,30.25},{112,80},{44,80}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(t1.outPort, unOccOff.inPort[2])          annotation (Line(
        points={{38.5,80},{-30,80},{-30,30},{-21,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(cb.dTNexOcc, occThrSho.u)             annotation (Line(
        points={{-158,140},{-150,140},{-150,-180},{-142,-180}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(t6.outPort, morWarUp.inPort[1]) annotation (Line(
        points={{-64.5,-90},{-41,-90},{-41,-89.5}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(t5.outPort, morWarUp.inPort[2]) annotation (Line(
        points={{129.5,30},{140,30},{140,-60},{-48,-60},{-48,-90.5},{-41,-90.5}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(unOccNigSetBac.outPort[2], t5.inPort)
                                           annotation (Line(
        points={{100.5,29.75},{113.25,29.75},{113.25,30},{124,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(cb.TRooMin, TRooMin.u) annotation (Line(
        points={{-158,140},{-92,140},{-92,150},{-82,150}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(TRooSetHea.y, TRooMinErrHea.u1)
                                      annotation (Line(
        points={{-59,180},{-38,180}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(TRooMin.y, TRooMinErrHea.u2)
                                      annotation (Line(
        points={{-59,150},{-30,150},{-30,172}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(unOccOff.outPort[2], t6.inPort) annotation (Line(
        points={{0.5,30.125},{12,30.125},{12,-48},{-80,-48},{-80,-90},{-70,-90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(morWarUp.outPort[1], t3.inPort) annotation (Line(
        points={{-19.5,-90},{16,-90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(cb.occupied, occupied.u) annotation (Line(
        points={{-158,140},{-120,140},{-120,90},{-82,90}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(occ.outPort[1], t4.inPort) annotation (Line(
        points={{80.5,-90},{150,-90},{150,130},{112,130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(t4.outPort, unOccOff.inPort[3]) annotation (Line(
        points={{106.5,130},{-30,130},{-30,29.3333},{-21,29.3333}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(occThrSho.y, and1.u1) annotation (Line(
        points={{-119,-180},{-110,-180},{-110,-190},{-102,-190}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and1.y, t6.condition) annotation (Line(
        points={{-79,-190},{-66,-190},{-66,-102}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and1.y, t5.condition) annotation (Line(
        points={{-79,-190},{128,-190},{128,18}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(cb.TRooAve, TRooAve.u) annotation (Line(
        points={{-158,140},{-100,140},{-100,120},{-82,120}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(booleanExpression.y, and1.u2) annotation (Line(
        points={{-118.2,-212},{-110.1,-212},{-110.1,-198},{-102,-198}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(preCooSta.y, t9.condition) annotation (Line(
        points={{-119,-150},{-80,-150},{-80,-142}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(t9.outPort, morPreCoo.inPort[1]) annotation (Line(
        points={{-78.5,-130},{-59.75,-130},{-59.75,-129.5},{-41,-129.5}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(unOccOff.outPort[3], t9.inPort) annotation (Line(
        points={{0.5,29.875},{12,29.875},{12,0},{-100,0},{-100,-130},{-84,-130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(cb, preCooSta.controlBus) annotation (Line(
        points={{-158,140},{-150,140},{-150,-144},{-136.2,-144}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(morPreCoo.outPort[1], t7.inPort) annotation (Line(
        points={{-19.5,-130},{16,-130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(t7.outPort, occ.inPort[2]) annotation (Line(
        points={{21.5,-130},{30,-130},{30,-128},{46,-128},{46,-90},{59,-90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(t3.outPort, occ.inPort[1]) annotation (Line(
        points={{21.5,-90},{42,-90},{42,-89.3333},{59,-89.3333}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(occThrSho.y, not1.u) annotation (Line(
        points={{-119,-180},{-110,-180},{-110,-170},{-50,-170}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not1.y, and2.u2) annotation (Line(
        points={{-27,-170},{144,-170},{144,84},{66,84},{66,102},{78,102}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and2.y, t4.condition) annotation (Line(
        points={{101,110},{108,110},{108,118}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(occupied.y, not2.u) annotation (Line(
        points={{-59,90},{-20,90},{-20,110},{-2,110}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not2.y, and2.u1) annotation (Line(
        points={{21,110},{78,110}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(cb.TRooSetHea, TRooSetHea.u) annotation (Line(
        points={{-158,140},{-92,140},{-92,180},{-82,180}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(t8.outPort, occ.inPort[3]) annotation (Line(
        points={{41.5,-20},{52,-20},{52,-90.6667},{59,-90.6667}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(unOccOff.outPort[4], t8.inPort) annotation (Line(
        points={{0.5,29.625},{12,29.625},{12,-20},{36,-20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(occupied.y, t8.condition) annotation (Line(
        points={{-59,90},{-50,90},{-50,-40},{40,-40},{40,-32}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(morPreCoo.y, sum.u[1]) annotation (Line(
        points={{-19,-136},{-8,-136},{-8,-68},{-192,-68},{-192,143.36},{-186,
            143.36}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(morWarUp.y, sum.u[2]) annotation (Line(
        points={{-19,-96},{-8,-96},{-8,-68},{-192,-68},{-192,141.68},{-186,141.68}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(occ.y, sum.u[3]) annotation (Line(
        points={{81,-96},{100,-96},{100,-108},{-192,-108},{-192,140},{-186,140}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(unOccOff.y, sum.u[4]) annotation (Line(
        points={{1,24},{6,24},{6,8},{-192,8},{-192,138.32},{-186,138.32}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(unOccNigSetBac.y, sum.u[5]) annotation (Line(
        points={{101,24},{112,24},{112,8},{-192,8},{-192,136.64},{-186,136.64}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(yFan, or1.y)
      annotation (Line(points={{230,0},{196.9,0}}, color={255,0,255}));
    connect(unOccNigSetBac.active, or1.u[1]) annotation (Line(points={{90,19},{90,
            3.36},{184,3.36}}, color={255,0,255}));
    connect(occ.active, or1.u[2]) annotation (Line(points={{70,-101},{70,-104},{168,
            -104},{168,1.68},{184,1.68}},     color={255,0,255}));
    connect(morWarUp.active, or1.u[3]) annotation (Line(points={{-30,-101},{-30,-112},
            {170,-112},{170,0},{184,0}},               color={255,0,255}));
    connect(morPreCoo.active, or1.u[4]) annotation (Line(points={{-30,-141},{-30,-150},
            {174,-150},{174,-1.68},{184,-1.68}},       color={255,0,255}));
    connect(oveFanMod.y, greaterThreshold.u)
      annotation (Line(points={{185,66},{192,66}}, color={0,0,127}));
    connect(greaterThreshold.y, or1.u[5]) annotation (Line(points={{215,66},{218,66},
            {218,20},{184,20},{184,-3.36}}, color={255,0,255}));
    connect(const.y, oveFanMod.u) annotation (Line(points={{193,122},{210,122},{
            210,88},{156,88},{156,66},{162,66}}, color={0,0,127}));
    connect(realToInteger.y, cb.controlMode) annotation (Line(points={{-161,170},
            {-166,170},{-166,140},{-158,140}}, color={255,127,0}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(oveConMod.y, realToInteger.u) annotation (Line(points={{-139,200},{
            -130,200},{-130,170},{-138,170}}, color={0,0,127}));
    connect(sum.y, integerToReal.u) annotation (Line(points={{-173.1,140},{-170,
            140},{-170,160},{-208,160},{-208,200},{-202,200}}, color={255,127,0}));
    connect(integerToReal.y, oveConMod.u)
      annotation (Line(points={{-179,200},{-162,200}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-220,
              -220},{220,220}})), Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-220,-220},{220,220}}), graphics={
            Rectangle(
            extent={{-200,200},{200,-200}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={215,215,215}), Text(
            extent={{-176,80},{192,-84}},
            lineColor={0,0,255},
            textString="%name")}));
  end ModeSelector;
  annotation (uses(Buildings(version="6.0.0"), Modelica(version="3.2.2"),
      IBPSA(version="3.0.0")));
end TestcaseCMA;
