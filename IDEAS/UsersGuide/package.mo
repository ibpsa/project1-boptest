within IDEAS;
package UsersGuide "User's Guide"
extends Modelica.Icons.Information;






annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
<p>
<i><b>Integrated District Energy Assessment by Simulation</b></i> 
(<code>IDEAS</code>) is a Modelica library that allows integrated transient simulation of 
thermal and electrical processes at neighborhood level. 
The <code>IDEAS</code> tool differs from existing building physics and 
systems based and electrical energy system based models by integrating 
the dynamics of the hydronic, thermal as well as electrical energy networks 
at both the building and aggregated level within a single model and solver.
</p>
<h4>Content</h4>
<p>
Main packages are listed below.
</p>
<ul>
<li>
<a href=modelica://IDEAS.Buildings>Buildings</a> contains component models for modelling building envelopes. 
</li>
<li>
<a href=modelica://IDEAS.Fluid>Fluid</a> contains component models for modelling fluid systems. 
</li>
<li>
<a href=modelica://IDEAS.Experimental.Electric>Experimental.Electric</a> contains component models for modelling electric distribution grids. 
These models are not unit tested and are not actively maintained.
</li>
<li>
<a href=modelica://IDEAS.Examples>Examples</a> contains example models that demonstrate 
the use of <a href=modelica://IDEAS.Buildings>Buildings</a> and <a href=modelica://IDEAS.Fluid>Fluid</a>. 
</li>
</ul>
<h4>Feedback</h4>
<p>
<code>IDEAS</code> is developed at <a href=https://github.com/open-ideas/IDEAS>github</a>.
Feel free to create an <a href=https://github.com/open-ideas/IDEAS/issues>issue</a>
in case you have a problem or a suggestion.
</p>
<h4>Acknowledgements</h4>
<p>
The following people have contributed to the <code>IDEAS</code> code.
<ul>
<li>
<a href=https://be.linkedin.com/in/arnoutaertgeerts>Arnout Aertgeerts</a>
</li>
<li>
<a href=https://www.linkedin.com/in/rubenbaetens>Ruben Baetens</a>
</li>
<li>
<a href=https://www.linkedin.com/in/roel-de-coninck-3647596>Roel De Coninck</a>
</li>
<li>
<a href=https://be.linkedin.com/in/filip-jorissen-19a26437>Filip Jorissen</a>
</li>
<li>
<a href=https://be.linkedin.com/in/damien-picard-5ab507139>Damien Picard</a>
</li>
<li>
<a href=https://be.linkedin.com/in/glennreynders>Glenn Reynders</a>
</li>
<li>
<a href=https://be.linkedin.com/in/juanvanroy>Juan van Roy</a>
</li>
<li>
Bart Verbruggen
</li>
</ul>
<p>
Furthermore, a large part of the code was originally developed within
the <a href=http://www.iea-annex60.org>IEA EBC Annex 60 project</a>,
which is continued as <a href=https://ibpsa.github.io/project1/>IBPSA project 1</a>.
For models originating from this library
bug reports are preferable submitted on the 
<a href=https://github.com/iea-annex60/modelica-annex60>Annex 60</a> or 
<a href=https://github.com/ibpsa/project1>IBPSA project 1</a>
github pages.
</p>
<h4>Funding</h4>
<p>
The authors acknowledge the financial support by the Agency for
Innovation by Science and Technology in Flanders (IWT) and WTCB
in the frame of the IWT-VIS Traject SMART GEOTHERM focusing
on integration of thermal energy storage and thermal inertia
in geothermal concepts for smart heating and cooling of (medium) large buildings.
The authors also acknowledge the financial support by IWT for the PhD work of
F. Jorissen (contract number 131012).
</p>
</html>", revisions="<html>
<ul>
<li>
January 12, 2017 by Filip Jorissen:<br/>
Updated for IDEAS 1.0
</li>
</ul>
</html>"));
end UsersGuide;
