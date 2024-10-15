within IDEAS.Experimental.Electric.Photovoltaics;
package UsersGuide "User's Guide"
extends Modelica.Icons.Information;


annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
<p>
The Photovoltaic Package implements everything that has to do with a distributed PV system itself.
</p>
<p>
The possibility exists to let the PV output be calculated during simulation using 
<a href=\"modelica://IDEAS.Electric.Photovoltaic.PVSystemGeneral\">PVSystemGeneral</a>, 
or to use an input file with the output of one PV panel for one year when using PVFromFile.
</p>
<p>
In<a href=\"modelica://IDEAS.Electric.Photovoltaic.Components\">Components</a> 
several submodels can be found.
</p>
<p>
The PV array itself is modeled, this exists of:
</p>
<ol>
<li>Reflection calculations</li>
<li>Absorption calculations</li>
<li>5 parameter model of a PV panel, which can be found in 
<a href=\"modelica://IDEAS.Electric.Photovoltaic.Components.Elements.PV5.mo\">Components.Elements.PV5</a></li>
</ol>
<p>
The inverter is modeled in <a href=\"modelica://IDEAS.Electric.Photovoltaic.Components.SimpleInverter\">SimpleInverter</a>.
</p>
<p>The model <a href=\"modelica://IDEAS.Electric.Photovoltaic.Components.PvVoltageToPower\">PvVoltageToPower</a> 
calculates the powers based on the output of the inverter.
</p>
<p>
To control if the power output of the PV panel is put on the grid, based on a maximum grid voltage, 
the model <a href=\"modelica://IDEAS.Electric.Photovoltaic.Components.PvVoltageCtrlGeneral\">PvVoltageCtrlGeneral</a> is used.
</p>
</html>"));
end UsersGuide;
