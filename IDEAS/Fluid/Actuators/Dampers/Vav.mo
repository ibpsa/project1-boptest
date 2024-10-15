within IDEAS.Fluid.Actuators.Dampers;
model Vav
  "Variable air volume with control signal in [0, 1] that corresponds to mass flow rates [fraMin, fraMax]*m_flow_nominal"
  extends IDEAS.Fluid.Actuators.Dampers.PressureIndependent(phi = l + (fraMin + (fraMax -
        fraMin)*y_internal)*(1 - l));
  parameter Real fraMax = 1
    "m_flow_set = fraMax*m_flow_nominal at y = y_nominal";
  parameter Real fraMin = 0
    "m_flow_set = fraMin*m_flow_nominal at y = 0";

initial equation
  assert(fraMin<=fraMax, "In " + getInstanceName() + ": fraMin="+String(fraMin)+
  " should be smaller than fraMax="+String(fraMax));

    annotation (Line(points={{-17,40},{0,40},{0,12}},   color={0,0,127}),
                Dialog(enable = not use_massFlowRate),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    Documentation(revisions="<html>
<ul>
<li>
April 12, 2021 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This VAV model is an extension of 
<a href=\"modelica://IDEAS.Fluid.Actuators.Dampers.PressureIndependent\">IDEAS.Fluid.Actuators.Dampers.PressureIndependent</a> 
and adds the parameters <code>fraMin</code> and <code>fraMax</code>.
</p>
</html>"));
end Vav;
