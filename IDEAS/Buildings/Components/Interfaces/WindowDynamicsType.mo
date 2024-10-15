within IDEAS.Buildings.Components.Interfaces;
type WindowDynamicsType = enumeration(
    Two "One state for the glazing and one for the frame",
    Normal "States in each glass sheet and one state for the frame") "Type of dynamics that are used for window models" annotation (
    Documentation(revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>", info="<html>
<p>
Type variable for defining how many states should be used to represent the window dynamics.
Zero, one or two states may be used to represent the dynamics of the frame and glazing of a window.
Fewer states are used than for opaque surfaces since the time constants of glazing are relatively fast,
which may slow down simulations. 
Therefore the dynamics are lumped into one or two states.
</p>
</html>"));
