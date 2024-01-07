within FRP.BaseClasses;
record DoubleClearAir16Clear =
    Buildings.HeatTransfer.Data.GlazingSystems.Generic (
    final glass={Buildings.HeatTransfer.Data.Glasses.ID103(
                               x=0.006), Buildings.HeatTransfer.Data.Glasses.ID103(
                                                       x=0.006)},
    final gas={Buildings.HeatTransfer.Data.Gases.Air(
                         x=0.016)},
    UFra=1.4) "Double pane, clear glass 6mm, air 16, clear glass 6mm"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datGlaSys");
