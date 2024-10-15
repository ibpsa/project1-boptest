within IDEAS.UsersGuide;
class RevisionHistory "Revision History"
  extends Modelica.Icons.ReleaseNotes;

  annotation (Documentation(info="<html>
<h4>Version 0.1.0, December 11th, 2011</h4>
<p>
This is the first version integrated in the IDEAS tool and made available for the public. 
</p>
<h4>Version 0.2.0, January 26th, 2015</h4>
<p>
Major changes compared to v0.1 are: 
</p>
<ul>
<li>*.TMY3 is used as default climate file and its reader is adopted from the LBNL Buildings library.</li>
<li>The IDEAS/Buildings/. package is updated so that the building components only require a single connector to be connected with the zone.</li>
<li>All hydronic components in IDEAS/Fluid/. are defined and updated based on the IEA EBC Annex60 models.</li>
</ul>
<h4>Version 0.3.0, September, 2016</h4>
<p>
Major changes compared to v0.2 are: 
</p>
<ul>
<li>Added code for checking conservation of energy</li>
<li>Added options for linear / non-linear radiative heat exchange and convection for exterior and interior faces of walls and floors/ceilings. Respective correlations have been changed.</li>
<li>Overall improvements resulting in more efficient code and less warnings.</li>
<li>The emissivity of window coatings must now be specified as a property of the solid (glass sheet) and not as a property of the gas between the glass sheets. This is only relevant if you create your own glazing.</li>
<li>Merged Annex 60 library up to commit d7749e3</li>
<li>Expanded unit tests</li>
<li>More correct implementation of Koschenz's model for TABS. Also added the option for discretising TABS sections.</li>
<li>Added new building shade components.</li>
<li>Removed inefficient code that would lead to numerical Jacobians in grid.</li>
<li>Added new AC and DC electrical models.</li>
</ul>
<h4>Version 1.0.0, January 12, 2017</h4>
<p>
Major changes compared to v0.3 are: 
</p>
<ul>
<li>IDEAS 1.0 is based on Annex 60 version 1.0.</li>
<li>The IDEAS packages have been restructured to be more in line with the Annex 60 package structure.<br/>
IDEAS.Constants has been replaced by IDEAS.Types<br/>
The SimInfoManager has been moved to IDEAS.BoundaryConditions<br/>
Interfaces such as HeatingSystem and BaseCircuits have been moved to IDEAS.Templates 
</li>
<li>Setting up new Construction records has been simplifiedParameter values of nLay and nGain are now inferred from the other parameters.</li>
<li>Optional parameter incLastLay has been added to Construction recordsUsers may use this to double-check if InternalWalls are connected as intended.</li>
<li>The way how internal gains may be connected to surfaces has been changed.</li>
<li>Convection and thermal radiation equations have been tuned to be more accurate and faster.</li>
<li>Added an option to the zone model for evaluating thermal comfort.</li>
<li>Added an option to the zone model for computing the sensible and latent heat gains from occupants.</li>
<li>The zone air model is now replaceable such that custom models may be created.</li>
<li>A zone template has been added that allows to add a rectangular zone, including 4 walls, 4 optional windows, a floor and a ceiling.</li>
<li>Some variables have been renamedA conversion script is provided for converting the user's models to accomodate these changes.<br/>
TStar has been renamed into TRad in the zone model.<br/>
flowPort_Out and flowPort_In have been renamed in the zone model, heating system, ventilaiton system and structure models.<br/>
Some Annex 60 models were renamed.
</li>
<li>Added example model of a terraced house in IDEAS.Examples.PPD12</li>
<li>Added twin house validation models in IDEAS.Examples.TwinHouse</li>
<li>Added solar irradiation model for window frames.</li>
<li>Added optional thermal bridge model for windows.</li>
<li>Extended implementation of building shade model.</li>
<li>Fixed bug in view factor implementation.</li>
<li>Updated documentation for many models in IDEAS.Buildings</li>
<li>Added thermostatic valve model: IDEAS.Fluid.Actuators.Valves.TwoWayTRV</li>
<li>Removed insulationType and insulationThickness parametersThese should now be defined in the Construction records.</li>
<li>Harmonised implementation of Perez solar irradiation model with Annex 60 implementation.</li>
<li>Cleaned up implementation of BESTEST models.</li>
<li>Added new, specialised window types.</li>
<li>Added options for model linearisation.</li>
</ul>
</html>", revisions=""));
end RevisionHistory;
