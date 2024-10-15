within IDEAS.BoundaryConditions.Climate.Time.BaseClasses;
block TimeZone

  extends Modelica.Blocks.Interfaces.BlockIcon;

  parameter Modelica.SIunits.Time timZonSta "standard time zone";
  parameter Boolean DST=true;
  parameter Integer yr "depcited year";

  Modelica.Blocks.Interfaces.RealInput timCal "time zone"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput timZon "calendar time"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  parameter Modelica.SIunits.Time DSTstart=86400*(31 + 28 + 31 - rem(5*yr/4 + 4,
      7)) + 2*3600;
  parameter Modelica.SIunits.Time DSTend=86400*(31 + 28 + 31 + 30 + 31 + 30 +
      31 + 31 + 30 + 31 - rem(5*yr/4 + 1, 7)) + 2*3600;
  // Source : http://www.webexhibits.org/daylightsaving/i.html

  Modelica.Blocks.Interfaces.BooleanOutput summer annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,100})));

equation
  if timCal >= DSTstart and timCal <= DSTend then
    if DST then
      timZon = timZonSta + 3600;
      summer = true;
    else
      timZon = timZonSta;
      summer = true;
    end if;
  else
    timZon = timZonSta;
    summer = false;
  end if;

end TimeZone;
