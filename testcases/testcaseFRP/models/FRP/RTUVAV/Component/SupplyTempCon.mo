within FRP.RTUVAV.Component;
model SupplyTempCon "Supply Ari Temperature Control"
  Buildings.Controls.Continuous.LimPID conDX(
    yMax=1,
    Td=60,
    k=0.1,
    Ti=120,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reverseActing=false)
                        "Controller for cooling (acts on damper)"
    annotation (Placement(transformation(extent={{50,-30},{80,0}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite
                                              oveTSup(description=
        "Supply air temperature setpoint", u(
      min=285.15,
      max=313.15,
      unit="K")) "Overwrite for supply air temperature signal"
    annotation (Placement(transformation(extent={{-76,-34},{-38,4}})));
  Modelica.Blocks.Sources.RealExpression SupAirTemSP(y=273.15 + 12.78)
    "Supply air temperature setpoint [K]"
    annotation (Placement(transformation(extent={{-188,-50},{-118,20}})));
  Modelica.Blocks.Interfaces.RealOutput y1
               "Connector of actuator output signal"
    annotation (Placement(transformation(extent={{160,-26},{180,-6}})));
  Modelica.Blocks.Interfaces.RealInput u_m1
                "Connector of measurement input signal" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={66,-88})));
equation
  connect(SupAirTemSP.y, oveTSup.u)
    annotation (Line(points={{-114.5,-15},{-79.8,-15}}, color={0,0,127}));
  connect(conDX.y, y1) annotation (Line(points={{81.5,-15},{170,-15},{170,-16}},
        color={0,0,127}));
  connect(conDX.u_m, u_m1)
    annotation (Line(points={{65,-33},{65,-88},{66,-88}}, color={0,0,127}));
  connect(oveTSup.y, conDX.u_s)
    annotation (Line(points={{-36.1,-15},{47,-15}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -80},{160,60}}), graphics={Rectangle(
          extent={{-200,60},{160,-78}},
          lineColor={28,108,200},
          fillColor={60,26,86},
          fillPattern=FillPattern.Solid), Text(
          extent={{-94,26},{46,-42}},
          lineColor={255,255,255},
          fillColor={102,44,145},
          fillPattern=FillPattern.None,
          textString="TSup",
          textStyle={TextStyle.Bold})}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-200,-80},{160,60}})));
end SupplyTempCon;
