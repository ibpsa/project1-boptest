within IDEAS.BoundaryConditions.Occupants.Components;
model Schedule "Single schedule with look-ahead"

  outer IDEAS.BoundaryConditions.SimInfoManager sim;
  extends Modelica.Icons.ObsoleteModel;

  parameter Real occupancy[:]=3600*{7,19}
    "Occupancy table, each entry switching occupancy on or off";
  parameter Boolean firstEntryOccupied=true
    "Set to true if first entry in occupancy denotes a changed from unoccupied to occupied";
  parameter Modelica.SIunits.Time startTime=0 "Start time of periodicity";
  parameter Modelica.SIunits.Time endTime=86400 "End time of periodicity";

  Modelica.Blocks.Interfaces.RealOutput tNexNonOcc
    "Time until next non-occupancy"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput tNexOcc "Time until next occupancy"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput occupied
    "Outputs true if occupied at current time"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

protected
  final parameter Modelica.SIunits.Time period=endTime - startTime;
  final parameter Integer nRow=size(occupancy, 1);

  output Integer nexStaInd "Next index when occupancy starts";
  output Integer nexStoInd "Next index when occupancy stops";

  output Integer iPerSta
    "Counter for the period in which the next occupancy starts";
  output Integer iPerSto
    "Counter for the period in which the next occupancy stops";
  output Modelica.SIunits.Time schTim
    "Time in schedule (not exceeding max. schedule time)";
  output Modelica.SIunits.Time tMax "Maximum time in schedule";
  output Modelica.SIunits.Time tOcc "Time when next occupancy starts";
  output Modelica.SIunits.Time tNonOcc "Time when next non-occupancy starts";

initial algorithm
  tOcc := if firstEntryOccupied then occupancy[1] else  time;
  tNonOcc := if firstEntryOccupied then  time else occupancy[1];

  iPerSta := 0;
  iPerSto := 0;
  nexStaInd := if firstEntryOccupied then 1 else 2;
  nexStoInd := if firstEntryOccupied then 2 else 1;
  occupied := not firstEntryOccupied;
  tOcc := occupancy[nexStaInd];
  tNonOcc := occupancy[nexStoInd];

algorithm
  tMax := endTime;
  schTim := startTime + mod( time - startTime, period);

  // Changed the index that computes the time until the next occupancy
  when time >= occupancy[nexStaInd] + iPerSta*period then
    nexStaInd := nexStaInd + 2;
    occupied := not occupied;
    // Wrap index around
    if nexStaInd > nRow then
      nexStaInd := if firstEntryOccupied then 1 else 2;
      iPerSta := iPerSta + 1;
    end if;
    tOcc := occupancy[nexStaInd] + iPerSta*(period);
  end when;

  // Changed the index that computes the time until the next non-occupancy
  when time >= occupancy[nexStoInd] + iPerSto*period then
    nexStoInd := nexStoInd + 2;
    occupied := not occupied;
    // Wrap index around
    if nexStoInd > nRow then
      nexStoInd := if firstEntryOccupied then 2 else 1;
      iPerSto := iPerSto + 1;
    end if;
    tNonOcc := occupancy[nexStoInd] + iPerSto*(period);
  end when;

  tNexOcc := tOcc -  time;
  tNexNonOcc := tNonOcc -  time;

  annotation (Icon(graphics={Ellipse(
          extent={{-70,70},{70,-70}},
          lineColor={127,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={127,0,0}),Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{2,0},{2,58},{14,56},{24,52},{32,48},{42,40},{48,32},{54,22},
            {58,10},{58,-4},{56,-16},{50,-28},{44,-38},{42,-40},{2,0}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-4,50},{2,-2}},
          lineColor={127,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),Polygon(
          points={{2,0},{18,-16},{14,-20},{-4,-2},{2,0}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html>
<ul>
<li>
Revised implementation since timLoc was removed from the SimInfoManger.
Moreover, this seems to be the wrong variable to use, since this
relative time is a function of the building position, 
which should not be the case.
</li>
</ul>
</html>", info="<html>
<p>
This block implements a schedule. 
The Modelica built-in variable 'time' is used to compute the hour, 
assuming that time=0 corresponds to midnight on the first of january.
</p>
<p>
It may be removed in the future since its implementation is not very efficient.
</p>
</html>"));
end Schedule;
