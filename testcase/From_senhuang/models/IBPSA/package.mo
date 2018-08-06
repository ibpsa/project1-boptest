within ;
package IBPSA "Library with models for building energy and control systems"
  extends Modelica.Icons.Package;


package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;
  class Conventions "Conventions"
    extends Modelica.Icons.Information;
    annotation (preferredView="info",
    Documentation(info="<html>
<p>
This library follows the conventions of the
<a href=\"modelica://Modelica.UsersGuide.Conventions\">Modelica Standard Library</a>, which are as follows:
</p>

<p>
Note, in the html documentation of any Modelica library,
the headings \"h1, h2, h3\" should not be used,
because they are utilized from the automatically generated documentation/headings.
Additional headings in the html documentation should start with \"h4\".
</p>

<p>
In the Modelica package the following conventions are used:
</p>

<ol>
<li> Class and instance names are written in upper and lower case
  letters, e.g., \"ElectricCurrent\", and may contain numbers.
  An underscore is only used
  at the end of a name to characterize a lower or upper index,
  e.g., \"pin_a\".</li>

<li> <b>Class names</b> start always with an upper case letter.</li>

<li> <b>Instance names</b>, i.e., names of component instances and
  of variables (with the exception of constants),
  start usually with a lower case letter with only
  a few exceptions if this is common sense
  (such as \"T\" for a temperature variable).</li>

<li> <b>Constant names</b>, i.e., names of variables declared with the
  \"constant\" prefix, follow the usual naming conventions
  (= upper and lower case letters) and start usually with an
  upper case letter, e.g. UniformGravity, SteadyState,
  with only few exceptions such as \"pi\" and \"h_fg\".</li>
<li> The two connectors of a domain that have identical declarations
  and different icons are usually distinguished by \"_a\", \"_b\"
  or \"_p\", \"_n\", e.g., Flange_a/Flange_b, HeatPort_a, HeatPort_b.</li>

<li> The <b>instance name</b> of a component is always displayed in its icon
  (= text string \"%name\") in <b>blue color</b>. A connector class has the instance
  name definition in the diagram layer and not in the icon layer.
  If displayed, <b>parameter</b> values, e.g., resistance, mass, gear ratio, are displayed
  in the icon in <b>black color</b> in a smaller font size as the instance name.
 </li>

<li>Packages have usually the following subpackages:
  <ul>
  <li><b>UsersGuide</b> containing an overall description of the library
   and how to use it.</li>
  <li><b>Examples</b> containing models demonstrating the
   usage of the library.</li>
  <li><b>Interfaces</b> containing connectors and partial
   models.</li>
  <li><b>Types</b> containing type, enumeration and choice
   definitions.</li>
  </ul>
  </li>
</ol>

<p>
The <code>IBPSA</code> library uses the following conventions
in addition to the ones of the Modelica Standard Library:
</p>

<ol>
<li>
  The nomenclature used in the package
  <a href=\"modelica://IBPSA.Utilities.Psychrometrics\">
  IBPSA.Utilities.Psychrometrics</a>
   is as follows,
  <ul>
    <li>
      Uppercase <code>X</code> denotes mass fraction per total mass.
    </li>
    <li>
      Lowercase <code>x</code> denotes mass fraction per mass of dry air.
    </li>
    <li>
      The notation <code>z_xy</code> denotes that the function or block has output
      <code>z</code> and inputs <code>x</code> and <code>y</code>.
      </li>
    <li>
      The symbol <code>pW</code> denotes water vapor pressure, <code>TDewPoi</code>
      denotes dew point temperature, <code>TWetBul</code> denotes wet bulb temperature,
      and <code>TDryBul</code> (or simply <code>T</code>) denotes dry bulb temperature.
    </li>
  </ul>
</li>
<li>
  Names of models, blocks and packages should start with an upper-case letter and be a
  noun or a noun with a combination of adjectives and nouns.
  Use camel-case notation to combine multiple words, such as <code>HeatTransfer</code>.
</li>
<li>
  Parameter and variables names are usually a character, such as <code>T</code>
  for temperature and <code>p</code> for pressure, or a combination of the first three
  characters of a word, such as <code>higPreSetPoi</code> for high pressure set point.
</li>
<li>
  Comments should be added to each class (package, model, function etc.).
  The first character should be upper case.
  For one-line comments of parameters, variables and classes, no period should be used at the end of the comment.
</li>
<li>
All variables that have a physical correspondence, including physical ratios, must have a unit.
Use (derived) SI units.
Non-SI units are to be kept at an absolute minimum, and they must be declared as <code>protected</code>.
</li>
<li>
  To indicate that a class (i.e., a package, model, block etc.) has not been extensively tested or validated,
  its class name ends with the string <code>Beta</code>.
</li>
</ol>
</html>"));
  end Conventions;

  package ReleaseNotes "Release notes"
    extends Modelica.Icons.ReleaseNotes;

  class Version_2_0_0 "Version 2.0.0"
    extends Modelica.Icons.ReleaseNotes;
      annotation (preferredView="info", Documentation(info="<html>
<p>
Second release of the IBPSA library.
</p>
</html>"));
  end Version_2_0_0;

  class Version_1_0_0 "Version 1.0.0"
    extends Modelica.Icons.ReleaseNotes;
      annotation (preferredView="info", Documentation(info="<html>
<p>
First official release of the IBPSA library.
</p>
</html>"));
  end Version_1_0_0;


    annotation (preferredView="info",
    Documentation(info="<html>
<p>
This section summarizes the releases of the <code>IBPSA</code> library.
</p>
<ul>
<li>
<a href=\"modelica://IBPSA.UsersGuide.ReleaseNotes.Version_2_0_0\">Version 2.0.0</a>(June 14, 2018)
</li>
<li>
<a href=\"modelica://IBPSA.UsersGuide.ReleaseNotes.Version_1_0_0\">Version 1.0.0</a>(January 17, 2017)
</li>
</ul>

</html>"));
  end ReleaseNotes;

  class Contact "Contact"
    extends Modelica.Icons.Contact;
    annotation (preferredView="info",
    Documentation(info="<html>
<h4><font color=\"#008000\" size=\"5\">Contact</font></h4>
<p>
The development of the IBPSA library is organized through the
<a href=\"https://ibpsa.github.io/project1\">IBPSA Project 1</a>
of the International Building Performance Simulation Association (IBPSA).
From 2012 to 2017, the development was organized through the
<a href=\"http://www.iea-annex60.org\">Annex 60 project</a>
of the Energy in Buildings and Communities Programme of the International Energy Agency (IEA EBC).
</p>
<p>
Library point of contact<br/>
<a href=\"http://simulationresearch.lbl.gov/wetter\">Michael Wetter</a><br/>
    Lawrence Berkeley National Laboratory (LBNL)<br/>
    One Cyclotron Road<br/>
    Bldg. 90-3147<br/>
    Berkeley, CA 94720<br/>
    USA<br/>
    email: <a href=\"mailto:MWetter@lbl.gov\">MWetter@lbl.gov</a><br/>
</p>
</html>"));
  end Contact;

  class Acknowledgements "Acknowledgements"
    extends Modelica.Icons.Information;
    annotation (preferredView="info",
    Documentation(info="<html>
<h4><font color=\"#008000\" size=\"5\">Acknowledgements</font></h4>
<p>
The following grants supported the development of the <code>IBPSA</code> library:
</p>
<ul>
<li>
LBNL
was supported for the development of this library
by the Assistant Secretary for
Energy Efficiency and Renewable Energy, Office of Building
Technologies of the U.S. Department of Energy, under
contract No. DE-AC02-05CH11231.
</li>
<li>
The authors acknowledge the financial support by the Agency for
Innovation by Science and Technology in Flanders (IWT) and WTCB
in the frame of the IWT-VIS Traject SMART GEOTHERM focusing
on integration of thermal energy storage and thermal inertia
in geothermal concepts for smart heating and cooling of (medium) large buildings.
The authors also acknowledge the financial support by IWT for the PhD work of
F. Jorissen (contract number 131012).
The work of Bram van der Heijde is funded through the
project \"Towards a Sustainable Energy Supply in Cities\" by the European Union,
the European Regional Development Fund ERDF, Flanders Innovation &amp; Entrepreneurship
and the Province of Limburg.
</li>
<li>
 RWTH Aachen University
 was supported for the development of this library
 by the German Federal Ministry for Economic Affairs and Energy (BMWi),
 promotional reference no. 03ET1177A, 03ET1211B.
</li>
<li>
 UdK Berlin
 was supported for the development of this library
 by the German Federal Ministry for Economic Affairs and Energy (BMWi),
 promotional reference no. 03ET1177D, 03ESP409C.
</li>
<li>
 Aalborg University
 was supported for the development of this library
 by the Danish Energy Agency, under the Energy Technology Development and
 Demonstration Program (EUDP), journal no. 64013-0566.
</li>
</ul>


<p>
The following people have directly contributed to the implementation of
the <code>IBPSA</code> library
(many others have contributed by other means than model implementation):
</p>
<ul>
<li>
David Blum, Lawrence Berkeley National Laboratory, Berkeley, CA, USA
</li>
<li>
Massimo Cimmino, Polytechnique Montreal, Canada
</li>
<li>
Jianjun Hu, Lawrence Berkeley National Laboratory, Berkeley, CA, USA
</li>
<li>
Marcus Fuchs, RWTH Aachen University, Germany
</li>
<li>
Filip Jorissen, KU Leuven, Belgium
</li>
<li>
Moritz Lauster, RWTH Aachen University, Germany
</li>
<li>
Alessandro Maccarini, Aalborg University, Denmark
</li>
<li>
Philipp Mehrfeld, RWTH Aachen University, Germany
</li>
<li>
Jens Moeckel, UdK Berlin, Germany
</li>
<li>
Thierry S. Nouidui, Lawrence Berkeley National Laboratory, Berkeley, CA, USA
</li>
<li>
Christoph Nytsch-Geusen, UdK Berlin, Germany
</li>
<li>
Damien Picard, KU Leuven, Belgium
</li>
<li>
Matthis Thorade, UdK Berlin, Germany
</li>
<li>
Carles Ribas Tugores, UdK Berlin, Germany
</li>
<li>
Bram van der Heijde, KU Leuven, Belgium
</li>
<li>
Michael Wetter, Lawrence Berkeley National Laboratory, Berkeley, CA, USA
</li>
</ul>
</html>"));
  end Acknowledgements;

  class License "License"
    extends Modelica.Icons.Information;
    annotation (preferredView="info",
    Documentation(info="<html>
<h4>License</h4>
<p>
Modelica IBPSA Library. Copyright (c) 1998-2018
Modelica Association,
International Building Performance Simulation Association (IBPSA) and
contributors.
All rights reserved.
</p>
<p>
Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
</p>
<ol>
<li>
Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.
</li>
<li>
Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.
</li>
<li>
Neither the name of the copyright holder nor the names of its contributors may be used
to endorse or promote products derived from this software
without specific prior written permission.
</li>
</ol>
<p>
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
</p>
<p>
You are under no obligation whatsoever to provide any bug fixes, patches,
or upgrades to the features, functionality or performance of the source code
(\"Enhancements\") to anyone; however, if you choose to make your Enhancements
available either publicly, or directly to its copyright holders,
without imposing a separate written license agreement for such
Enhancements, then you hereby grant the following license: a non-exclusive,
royalty-free perpetual license to install, use, modify, prepare derivative
works, incorporate into other computer software, distribute, and sublicense
such enhancements or derivative works thereof, in binary and source code form.
</p>
<p>
Note: The license is a revised 3 clause BSD license with an ADDED paragraph
at the end that makes it easy to accept improvements.
</p>
</html>"));
  end License;

  annotation (preferredView="info",
  Documentation(info="<html>
<p>
The Modelica <code>IBPSA</code> library is a free open-source library
with classes (models, functions, etc.) that
codify and demonstrate best practices for the implementation of models for
building and community energy and control systems.
</p>
<p>
The development of the IBPSA library is organized through the
<a href=\"https://ibpsa.github.io/project1\">IBPSA Project 1</a>
of the International Building Performance Simulation Association (IBPSA).
From 2012 to 2017, the development was organized through the
<a href=\"http://www.iea-annex60.org\">Annex 60 project</a>
of the Energy in Buildings and Communities Programme of the International Energy Agency (IEA EBC).
</p>
<p>
Many models are based on models from the package
<a href=\"modelica://Modelica.Fluid\">Modelica.Fluid</a> and use
the same ports to ensure compatibility with models from that library.
However, a design change is that models from the <code>IBPSA</code>
library do not require the use of
<a href=\"modelica://Modelica.Fluid.System\">Modelica.Fluid.System</a>
as applications in buildings often have multiple fluids with largely varying
flow rates, and therefore a global declaration is impractical.
</p>
<p>
The development page for this library is
<a href=\"https://github.com/ibpsa/modelica\">
https://github.com/ibpsa/modelica</a>.
We welcome contributions from different users to further advance this library,
whether it is through collaborative model development, through model use and testing
or through requirements definition or by providing feedback regarding the model applicability
to solve specific problems.
</p>
<p>
The library has the following <i>User's Guides</i>:
</p>
<table summary=\"summary\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td valign=\"top\"><a href=\"modelica://IBPSA.Fluid.UsersGuide\">Fluid</a>
   </td>
   <td valign=\"top\">Package for one-dimensional fluid in piping networks with heat exchangers, valves, etc.</td>
</tr>
<tr><td valign=\"top\"><a href=\"modelica://IBPSA.Fluid.Actuators.UsersGuide\">Fluid.Actuators</a>
   </td>
   <td valign=\"top\">Package with valves and air dampers.</td>
</tr>
<tr><td valign=\"top\"><a href=\"modelica://IBPSA.Fluid.Movers.UsersGuide\">Fluid.Movers</a>
   </td>
   <td valign=\"top\">Package with fans and pumps.</td>
</tr>
<tr><td valign=\"top\"><a href=\"modelica://IBPSA.Fluid.Sensors.UsersGuide\">Fluid.Sensors</a>
   </td>
   <td valign=\"top\">Package with sensors.</td>
</tr>
<tr><td valign=\"top\"><a href=\"modelica://IBPSA.Fluid.Interfaces.UsersGuide\">Fluid.Interfaces</a>
   </td>
   <td valign=\"top\">Base models that can be used by developers to implement new models.</td>
</tr>
</table>
</html>"));
end UsersGuide;


annotation (
version="2.0.0",
versionDate="2018-06-14",
dateModified = "2018-06-14",
uses(Modelica(version="3.2.2")),
preferredView="info",
Documentation(info="<html>
<p>
<img
align=\"right\"
alt=\"Logo of IBPSA\"
src=\"modelica://IBPSA/Resources/Images/IBPSA-logo-text.png\" border=\"1\"/>
The <code>IBPSA</code> library is a free library
that provides more than 300 classes (models, functions, etc.) for the development of
Modelica libraries for building and community energy and control systems.
The library is compatible with models from the Modelica Standard Library,
in particular with models from
<a href=\"modelica://Modelica.Fluid\">Modelica.Fluid</a>
and
<a href=\"modelica://Modelica.Media\">Modelica.Media</a>.
</p>
<p>
The development of the IBPSA library is organized through the
<a href=\"https://ibpsa.github.io/project1\">IBPSA Project 1</a>
of the International Building Performance Simulation Association (IBPSA).
From 2012 to 2017, the development was organized through the
<a href=\"http://www.iea-annex60.org\">Annex 60 project</a>
of the Energy in Buildings and Communities Programme of the International Energy Agency (IEA EBC).
</p>
<p>
The intent of the library is that it will be extended by
implementations of Modelica libraries that are targeted to end-users.
Major goals are
</p>
<ul>
<li>to codify best practice and to provide a solid foundation onto which
other libraries for building and community energy systems can be built, and
</li>
<li>
to avoid a fragmentation of libraries that serve similar purpose but
that cannot share models among each others, thereby duplicating efforts
for model development and validation.
</li>
</ul>
<p>
Hence, this library is typically not used directly by end-users,
but rather by developers of libraries that will be distributed to end-users.
Libraries that are using the <code>IBPSA</code> library as their core, or
that are working on using the <code>IBPSA</code> as their core, include, in
alphabetic order:
</p>
<ul>
<li>
The <code>AixLib</code> library from RWTH Aachen, Germany, available at
<a href=\"https://github.com/RWTH-EBC/AixLib\">https://github.com/RWTH-EBC/AixLib</a>
</li>
<li>
The <code>Buildings</code> library from Lawrence Berkeley National Laboratory, Berkeley, CA, available at
<a href=\"http://simulationresearch.lbl.gov/modelica\">http://simulationresearch.lbl.gov/modelica/</a>.
</li>
<li>
The <code>BuildingSystems</code> library from
Universit&auml;t der K&uuml;nste Berlin, Germany,
available at
<a href=\"http://www.modelica-buildingsystems.de/\">http://www.modelica-buildingsystems.de/</a>.
</li>
<li>
The <code>IDEAS</code> library from KU Leuven, Belgium, available at
<a href=\"https://github.com/open-ideas/IDEAS\">https://github.com/open-ideas/IDEAS</a>.
</li>
</ul>
<p>
The library also contains more than 300 example and validation models. For Dymola,
each of these example and validation models contains a script that simulates it and
plots certain variables of interest.
</p>
<p>
The web page for this library is
<a href=\"https://github.com/ibpsa/modelica\">https://github.com/ibpsa/modelica</a>.
Contributions to further advance the library are welcomed.
Contributions may not only be in the form of model development, but also
through model use, model testing and validation,
requirements definition or providing feedback regarding the model applicability
to solve specific problems.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Bitmap(extent={{-90,-90},{90,90}},
        fileName="modelica://IBPSA/Resources/Images/IBPSA-logo.png")}));
end IBPSA;
