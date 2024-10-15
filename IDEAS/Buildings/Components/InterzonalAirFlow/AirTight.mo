within IDEAS.Buildings.Components.InterzonalAirFlow;
model AirTight
  "Airtight: Air tight zone without air infiltration"
  extends IDEAS.Buildings.Components.InterzonalAirFlow.BaseClasses.PartialInterzonalAirFlow(
    n50_int=0,
    nPorts=nPortsExt,
    prescribesPressure=false);
equation
  connect(port_a_interior, port_b_exterior) annotation (Line(points={{-60,-100},
          {-60,0},{-60,0},{-60,100}}, color={0,127,255}));
  connect(port_a_exterior, port_b_interior) annotation (Line(points={{60,100},{60,
          0},{60,0},{60,-100}}, color={0,127,255}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
March 17, 2020, Filip Jorissen:<br/>
Added support for vector fluidport.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1029\">#1029</a>.
</li>
<li>
January 25, 2019, Filip Jorissen:<br/>
Added constant <code>prescribesPressure</code> that indicates
whether this model prescribes the zone air pressure or not.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/971\">#971</a>.
</li>
<li>
April 27, 2018 by Filip Jorissen:<br/>
First version.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/796\">#796</a>.
</li>
</ul>
</html>", info="<html>
<p>
This model represents an air tight zone. 
I.e. the zone only exchanges mass through its 
fluid ports and not through air infiltration. 
</p>
</html>"), Icon(graphics={
        Rectangle(
          extent={{-70,40},{-100,0}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None)}));
end AirTight;
