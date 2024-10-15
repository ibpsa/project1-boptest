within IDEAS.Experimental.Electric.Photovoltaics.Components.ForInputFiles;
class SimpleDCAC_effP

  //  Real eff;
  Modelica.SIunits.ApparentPower S;
  final parameter Real cosphi=1;
  //For now

  parameter Real PNom "Nominal power, in Wp";
  parameter Real P_dc_max=230;
  //MPP for one panel.
  parameter Real eff=0.95;
  //For now

  Modelica.Blocks.Interfaces.RealInput P_dc annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent=
           {{-108,-10},{-88,10}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
  Modelica.Blocks.Interfaces.RealOutput Q
    annotation (Placement(transformation(extent={{94,10},{114,30}})));
algorithm

  P := eff*P_dc;
  S := P/cosphi;
  Q := 0;
  //  Q := sqrt(S^2-P^2);

  //
  //   // Define efficiency as a function of P_dc (production) against the mpp for the system
  //   if noEvent(P_dc < (P_dc_max) * 0.05) then      //<5%
  //     eff = (0.945 * (P_dc/(P_dc_max))) / 0.05;
  //   elseif noEvent(P_dc < (P_dc_max) * 0.30) then  //5%-30%
  //     eff = 2.9333 * ((P_dc/(P_dc_max))^3) - 2.16 * ((P_dc/(P_dc_max*NPanelen))^2) + 0.5327*(P_dc/(P_dc_max*NPanelen)) + 0.9234;
  //   else                                         //>30%
  //     eff = 0.968 + (0.01*((P_dc/(P_dc_max*NPanelen))-0.3) / 0.7);
  //   end if;

  annotation (Icon(graphics={Text(
          extent={{-90,20},{-50,0}},
          lineColor={0,0,127},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          textString="DC"),Text(
          extent={{50,20},{90,0}},
          lineColor={0,0,127},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          textString="AC"),Line(
          points={{10,0},{-30,60},{-30,-60},{10,0}},
          color={0,0,127},
          smooth=Smooth.None),Line(
          points={{-100,0},{-30,0}},
          color={0,0,127},
          smooth=Smooth.None),Ellipse(extent={{10,10},{30,-10}}, lineColor={0,0,
          127}),Line(
          points={{30,0},{100,0}},
          color={0,0,127},
          smooth=Smooth.None),Line(
          points={{100,-80},{100,80}},
          color={0,0,127},
          smooth=Smooth.None)}), Diagram(graphics));
end SimpleDCAC_effP;
