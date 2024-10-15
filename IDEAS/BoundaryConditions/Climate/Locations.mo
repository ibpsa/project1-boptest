within IDEAS.BoundaryConditions.Climate;
package Locations

extends Modelica.Icons.Package;

  model BesTest "IEA Annex 21, Bestest"
    extends IDEAS.BoundaryConditions.Climate.Locations.Location(
      lat=39.8/180*Modelica.Constants.pi,
      lon=-104.9/180*Modelica.Constants.pi,
      Tdes=265.15,
      TdesGround=283.15,
      timZonSta=-7*3600,
      DST=false,
      yr=2010,
      locNam="BesTest");
  end BesTest;

  model Holzkirchen "IEA Annex 58, Holzkirchen"
    extends IDEAS.BoundaryConditions.Climate.Locations.Location(
      lat=47.874/180*Modelica.Constants.pi,
      lon=11.728/180*Modelica.Constants.pi,
      Tdes=265.15,
      TdesGround=283.15,
      timZonSta=3600,
      DST=false,
      yr=2013,
      locNam="Holzkirchen");
  end Holzkirchen;

  model Uccle "Uccle, Belgium"
    extends IDEAS.BoundaryConditions.Climate.Locations.Location(
      lat=50.800/180*Modelica.Constants.pi,
      lon=4.317/180*Modelica.Constants.pi,
      Tdes=265.15,
      TdesGround=284.15,
      timZonSta=3600,
      DST=true,
      yr=2010,
      locNam="climate");
  end Uccle;

  model Location "Geogrphical location"

    parameter Modelica.SIunits.Angle lat(displayUnit="degree")
      "latitude of the locatioin";
    parameter Modelica.SIunits.Angle lon(displayUnit="degree")
      "longitude of the locatioin";
    parameter Modelica.SIunits.Temperature Tdes "Design outdoor temperature";
    parameter Modelica.SIunits.Temperature TdesGround "Design ground temperature";
    parameter Modelica.SIunits.Time timZonSta "Standard (winter) time zone";
    parameter Boolean DST "Take into account daylight saving time or not";
    parameter Integer yr "Ddepcited year for DST only";
    parameter String locNam;

  end Location;
end Locations;
