within IDEAS.Buildings.Data.Interfaces;
partial record Construction "Template record for surface structure: define/order layers from outer to inner"

  extends Modelica.Icons.MaterialProperty;

  final parameter Integer nLay(min=1)=size(mats,1)
    "Number of layers of the construction, including gaps";
  final parameter Integer nGain = size(locGain,1)
   "Number of gain heat ports";
  parameter Integer locGain[:](each min=1) = {1}
    "Location of possible embedded system: between layer locGain and layer locGain + 1";
  // where locGain=1 is the first layer
  parameter IDEAS.Buildings.Data.Interfaces.Material[:] mats
    "Array of materials. The last layer is connected to propsBus_a.";
  parameter Modelica.SIunits.Angle incLastLay = IDEAS.Types.Tilt.Other
    "Set to IDEAS.Types.Tilt.Floor if the last layer of mats is a floor, to .Ceiling if it is a ceiling and to .Other if other. For verification purposes.";

  annotation (Documentation(info="<html>
<p>
This record may be used to define the structure of constructions (walls).
</p>
<h4>Typical use and important parameters</h4>
<p>
Parameter <code>mats</code> should be used to define 
the type and thickness of each material layers.
</p>
<p>
Parameter <code>incLastLay</code> may be used
to define the intended inclination angle
of the last material layer.
This is to check if you correctly connect
models that used this construction since
otherwise the natural convection correlations
may be computed for instance assuming a floor
orientation instead of a ceiling orientation.
</p>
<h4>Assumption and limitations</h4>
<p>
Edge effects are neglected. 
A simple correlation for unventilated cavities
is used when modeling an air layer.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
November 14, 2016 by Filip Jorissen:<br/>
Removed insulationType and insulationThickness
as these parameters could lead to confusion.
See <a href=https://github.com/open-ideas/IDEAS/issues/583>issue 583</a>.
</li>
<li>
Augustus 1, 2016 by Filip Jorissen:<br/>
Set default <code>nLay(min=1)=size(mats,1)</code> 
and <code>nGain = size(locGain,1)</code>.
</li>
</ul>
</html>"));
end Construction;
