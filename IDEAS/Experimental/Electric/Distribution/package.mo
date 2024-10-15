within IDEAS.Experimental.Electric;
package Distribution "This gives an electrical distribution grid model for a district"


extends Modelica.Icons.Package;


annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                 graphics={Ellipse(extent={{-58,26},{-8,-24}},  lineColor={0,0,0}),
        Line(
          points={{22,0},{24,0},{52,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{52,80},{52,-80}},
          color={0,0,0},
          smooth=Smooth.None),
                           Ellipse(extent={{-28,26},{22,-24}},  lineColor={0,0,0})}));
end Distribution;
