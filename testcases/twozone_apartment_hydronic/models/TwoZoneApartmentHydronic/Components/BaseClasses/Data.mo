within TwoZoneApartmentHydronic.Components.BaseClasses;
package Data "Records container"
  record WindowGlass = Buildings.HeatTransfer.Data.Glasses.Generic (
        x=0.003,
        k=1.04,
        tauSol={1.31},
        rhoSol_a={0.163},
        rhoSol_b={0.163},
        tauIR=0,
        absIR_a=0.84,
        absIR_b=0.84) "Thermal properties of window glass"
    annotation (
  defaultComponentPrefixes="parameter",
  defaultComponentName="datGla",
  Documentation(info="<html>
<p>
This record declares the glass properties for the BESTEST model.
</p>
</html>",
  revisions="<html>
<ul>
<li>
August 7, 2015, by Michael Wetter:<br/>
Reimplemented the record by extending its base class, rather
than newly redefining the record.
This was needed as the record definition changed when implementing
electrochromic windows.
</li>
<li>
October 6, 2011, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
  record Window24 =
      Buildings.HeatTransfer.Data.GlazingSystems.Generic (
      final glass={Buildings.ThermalZones.Detailed.Validation.BESTEST.Data.Glass600(),
                              Buildings.ThermalZones.Detailed.Validation.BESTEST.Data.Glass600()},
      final gas={Buildings.HeatTransfer.Data.Gases.Air(x=0.013)},
      UFra=1.4)
    "Double pane, clear glass 3.175mm, air 13mm, clear glass 3.175mm" annotation (
  defaultComponentPrefixes="parameter",
  defaultComponentName="datThePro",
  Documentation(info="<html>
<p>
This record declares the parameters for the window system
for the BESTEST.
</p>
</html>",   revisions="<html>
<ul>
<li>
March 13, 2015, by Michael Wetter:<br/>
Removed assignment of <code>nLay</code> which no longer exists.
</li>
<li>
October 6, 2011, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end Data;
