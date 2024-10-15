within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer;
model ZoneLwDistributionViewFactor
  "Internal longwave radiative heat exchange using view factors"

  parameter Integer nSurf(min=1) "number of surfaces in contact with the zone";

  parameter Modelica.SIunits.Angle incCeiling = IDEAS.Types.Tilt.Ceiling;
  parameter Modelica.SIunits.Angle incFloor = IDEAS.Types.Tilt.Floor;
  parameter Modelica.SIunits.Angle incWall = IDEAS.Types.Tilt.Wall;
  parameter Modelica.SIunits.Angle aziSouth = IDEAS.Types.Azimuth.S;
  final parameter Integer numAzi = 4;

  parameter Modelica.SIunits.Length hZone "Distance between floor and ceiling";
  parameter Boolean linearise = true "Linearise radiative heat exchange"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.Temperature Tzone_nom = 295.15
    "Nominal temperature of environment, used for linearisation"
    annotation(Dialog(group="Linearisation", enable=linearise));
  parameter Modelica.SIunits.TemperatureDifference dT_nom = -2
    "Nominal temperature difference between solid and air, used for linearisation"
    annotation(Dialog(group="Linearisation", enable=linearise));

  parameter Real[nSurf,nSurf] vieFac(each fixed=false)
    "Emissivity weighted viewfactor from surface to surface"
    annotation(Dialog(tab="Advanced"));
  final parameter Real[nSurf,nSurf] Umat(each fixed=false);
  Modelica.Blocks.Interfaces.RealInput[nSurf] inc "Surface inclination angles"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,40})));
  Modelica.Blocks.Interfaces.RealInput[nSurf] azi "Surface azimuth angles"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-40})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nSurf] port_a
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Interfaces.RealInput[nSurf] A "surface areas" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,100})));
  Modelica.Blocks.Interfaces.RealInput[nSurf] epsLw
    "longwave surface emissivities" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealOutput[nSurf] floorArea
    "Amount of floor area for each surface" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-104})));


protected
  parameter Modelica.SIunits.ThermalConductance coeffLin = 1*(2*Tzone_nom+dT_nom)*(Tzone_nom^2+(Tzone_nom+dT_nom)^2)
    "Coefficient allowing less overhead for evaluation functions. This implementation is an approximation of the real linearization f(u)_lin = df/du|(u=u_bar) * (u-u_bar) + f|u_bar. The accuracy of it has been checked.";
  parameter Real[2+numAzi] Atot(each fixed=false)
    "Total surface area per orientation";

  parameter Real[2+numAzi,2+numAzi] vieFacTot(each fixed=false)
    "Emissivity weighted viewfactor from total of surfaces to each other"
    annotation(Dialog(tab="Advanced"));
  parameter Real lWall(fixed = false);

  parameter Integer index1(fixed=false);
  parameter Integer index2(fixed=false);
  parameter Modelica.SIunits.Area[nSurf] Afloor(each fixed = false);
initial algorithm
  //initialise surface area to zero
  Atot :=zeros(2 + numAzi);

  // calculate total area for each direction + ceiling/floor
  for i in 1:nSurf loop
    if IDEAS.Utilities.Math.Functions.isAngle(inc[i], incCeiling) then
      // ceiling area: index 1
      Atot[1]:=Atot[1] + A[i];
    elseif IDEAS.Utilities.Math.Functions.isAngle(inc[i], incFloor) then
      // floor area: index 2
      Atot[2]:=Atot[2] + A[i];
    elseif IDEAS.Utilities.Math.Functions.isAngle(inc[i], incWall) or IDEAS.Utilities.Math.Functions.isAngle(inc[i], incWall+Modelica.Constants.pi) then
        for j in (0:numAzi-1) loop
          // numAzi wall areas: indices 3 through 6
          if IDEAS.Utilities.Math.Functions.isAngle(azi[i], aziSouth + j*Modelica.Constants.pi*2/numAzi) then
            Atot[3+j] :=Atot[3 + j] + A[i];
            //Modelica.Utilities.Streams.print(String(azi[i]) + " to " + String(j));
            break;
          end if;
        end for;
    else
      Modelica.Utilities.Streams.error("Could not find matching orientation for surface with index " + String(i) +
          ". Avoid this error by disabling explicit view factor calculation in the zone model");
    end if;
  end for;
  assert(Atot[1]>0, "Zone contains no ceiling surfaces. This needs to be fixed or explicit view factor calculation should be disabled.");
  assert(Atot[2]>0, "Zone contains no floor surfaces. This needs to be fixed or explicit view factor calculation should be disabled.");

  //view factor from ceiling/floor to floor/ceiling
  vieFacTot[1,1] :=0;
  vieFacTot[2,2] :=0;
  vieFacTot[1,2] :=
    IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.viewFactorRectRectPar(
    A=(Atot[1] + Atot[2])/2,
    d=hZone,
    l=(A[3] + A[5])/hZone/2);
  vieFacTot[2,1] := vieFacTot[1,2]*Atot[1]/Atot[2];

  for i in 3:numAzi+2 loop
    //estimate for total wall length
    lWall :=Atot[i]/hZone;

    //view factor for walls to ceiling and floor
    if lWall == 0 then
      for j in 1:numAzi+2 loop
        vieFacTot[j,i]:=0;
        vieFacTot[i,j]:=0;
      end for;
    else

    vieFacTot[1,i]:=
        IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.viewFactorRectRectPerp(
        lCommon=lWall,
        W1=hZone,
        W2=Atot[1]/lWall);
    vieFacTot[i,1]:=vieFacTot[1,i]*Atot[1]/Atot[i];
    vieFacTot[2,i]:=
        IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.viewFactorRectRectPerp(
        lCommon=lWall,
        W1=hZone,
        W2=Atot[2]/lWall);
    vieFacTot[i,2]:=vieFacTot[2,i]*Atot[2]/Atot[i];
    // walls to walls
        for j in i:numAzi+2 loop
          if i==j then
            //a wall does not interchange radiant heat with itself
             vieFacTot[i,i] := 0;
          elseif Atot[i]==0 or Atot[j]==0 then
            vieFacTot[i,j] := 0;
            vieFacTot[j,i] := 0;
          elseif abs(i-j)==1 or abs(i-j)==3 then
            //surfaces are perpendicular
            vieFacTot[i,j] :=
            IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.viewFactorRectRectPerp(
            lCommon=hZone,
            W1=Atot[j]/hZone,
            W2=Atot[i]/hZone);
            vieFacTot[j,i]:=vieFacTot[i,j]*Atot[i]/Atot[j];
          elseif abs(i-j) == 2 then
            //surfaces are parallel
            vieFacTot[i,j] :=
            IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.viewFactorRectRectPar(
            A=(Atot[i] + Atot[j])/2,
            d=Atot[integer((i + j)/2)]/hZone,
            l=hZone);
            vieFacTot[j,i]:=vieFacTot[i,j]*Atot[i]/Atot[j];
          else
            //fixme warning
          end if;
        end for;
    end if;
  end for;

  //view factors for real surfaces are calculated from the total surfaces
  for i in 1:nSurf loop
      //set floor area
      Afloor[i]:=0;

       //determine orientation of first plane
      if IDEAS.Utilities.Math.Functions.isAngle(inc[i], incCeiling) then
         index1:=1;
      elseif IDEAS.Utilities.Math.Functions.isAngle(inc[i], incFloor) then
         index1:=2;
         Afloor[i]:=A[i];
      elseif IDEAS.Utilities.Math.Functions.isAngle(inc[i], incWall) then
         for k in 0:numAzi-1 loop
           if IDEAS.Utilities.Math.Functions.isAngle(azi[i], aziSouth + k*Modelica.Constants.pi*2/numAzi) then
             index1:=2+k+1;
           break;
           end if;
           //warning
         end for;
      end if;

        for j in i:nSurf loop
          if i==j then
            vieFac[i,j]:=0;
          else

              //determine orientation of second plane
          if IDEAS.Utilities.Math.Functions.isAngle(inc[j], incCeiling) then
            index2:=1;
          elseif IDEAS.Utilities.Math.Functions.isAngle(inc[j], incFloor) then
            index2:=2;
          elseif IDEAS.Utilities.Math.Functions.isAngle(inc[j], incWall) then
            for k in 0:numAzi-1 loop
              if IDEAS.Utilities.Math.Functions.isAngle(azi[j], aziSouth + k*Modelica.Constants.pi*2/numAzi) then
                index2:=2+k+1;
                break;
              end if;
              //warning
            end for;
          end if;

          Umat[i,j] := if vieFacTot[index1, index2]  < Modelica.Constants.small then 0 else (if linearise then coeffLin else 1) * Modelica.Constants.sigma/(1/A[i]/(vieFacTot[index1, index2]*A[j]/Atot[index2])+(1-epsLw[i])/A[i]/epsLw[i]+(1-epsLw[j])/A[j]/epsLw[j]);
          Umat[j,i] := if vieFacTot[index2, index1]  < Modelica.Constants.small then 0 else (if linearise then coeffLin else 1) * Modelica.Constants.sigma/(1/A[j]/(vieFacTot[index2, index1]*A[i]/Atot[index1])+(1-epsLw[i])/A[i]/epsLw[i]+(1-epsLw[j])/A[j]/epsLw[j]);
          end if;

        end for;
end for;
      Umat := Umat-identity(nSurf).*(Umat*ones(nSurf,nSurf));

equation
  if linearise then
    port_a.Q_flow=-Umat*port_a.T;
  else
    port_a.Q_flow=-Umat*port_a.T.^4;
  end if;
  floorArea=Afloor;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics),
    Icon(graphics={
        Rectangle(
          extent={{-90,80},{90,-80}},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward,
          lineColor={0,0,0}),
        Rectangle(
          extent={{68,60},{-68,-60}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(points={{-42,0},{40,0}},     color={191,0,0}),
        Line(points={{30,-6},{40,0}},    color={191,0,0}),
        Line(points={{30,6},{40,0}},    color={191,0,0}),
        Line(points={{-58,6},{-14,50}}, color={191,0,0}),
        Line(points={{-14,38},{-14,50}},
                                       color={191,0,0}),
        Line(points={{-26,50},{-14,50}},
                                       color={191,0,0}),
        Line(
          points={{-68,60},{68,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{68,60},{68,-60},{-68,-60},{-68,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(points={{-32,6},{-42,0}},  color={191,0,0}),
        Line(points={{-32,-6},{-42,0}},  color={191,0,0}),
        Line(points={{-58,18},{-58,6}},color={191,0,0}),
        Line(points={{-46,6},{-58,6}}, color={191,0,0}),
        Line(points={{14,-52},{58,-8}}, color={191,0,0}),
        Line(points={{26,-52},{14,-52}},
                                       color={191,0,0}),
        Line(points={{14,-40},{14,-52}},
                                       color={191,0,0}),
        Line(points={{46,-8},{58,-8}}, color={191,0,0}),
        Line(points={{58,-20},{58,-8}},color={191,0,0}),
        Line(points={{-22,-22},{22,22}},color={191,0,0},
          origin={36,28},
          rotation=90),
        Line(points={{14,50},{26,50}}, color={191,0,0}),
        Line(points={{14,38},{14,50}}, color={191,0,0}),
        Line(points={{46,6},{58,6}},   color={191,0,0}),
        Line(points={{58,6},{58,18}},  color={191,0,0}),
        Line(points={{-14,-52},{-14,-40}},
                                       color={191,0,0}),
        Line(points={{-22,-22},{22,22}},color={191,0,0},
          origin={-36,-30},
          rotation=90),
        Line(points={{-58,-20},{-58,-8}},
                                       color={191,0,0}),
        Line(points={{-58,-8},{-46,-8}},
                                       color={191,0,0}),
        Line(points={{-26,-52},{-14,-52}},
                                       color={191,0,0}),
        Line(points={{-41,0},{41,0}},     color={191,0,0},
          origin={-1,0},
          rotation=90),
        Line(points={{-5,3},{5,-3}},    color={191,0,0},
          origin={-5,35},
          rotation=90),
        Line(points={{-5,-3},{5,3}},     color={191,0,0},
          origin={3,35},
          rotation=90),
        Line(points={{-5,-3},{5,3}},     color={191,0,0},
          origin={-5,-35},
          rotation=90),
        Line(points={{-5,3},{5,-3}},    color={191,0,0},
          origin={3,-35},
          rotation=90)}),
    Documentation(info="<html>
<p>
Computation of longwave radiative heat exchange based on view factors. 
</p>
<h4>Assumption and limitations</h4>
<p>
This implementation is only valid for rectangular geometries.
</p>
<h4>Verification</h4>
<p>
Verification test in IDEAS.Buildings.Validation.Tests.ViewFactorVerification.
</p>
</html>", revisions="<html>
<ul>
<li>
January 19, 2017 by Filip Jorissen:<br/>
Updated icon for issue
<a href=https://github.com/open-ideas/IDEAS/issues/641>#641
</a>.
</li>
<li>
January 19, 2017 by Filip Jorissen:<br/>
Added options for properly linearising heat exchange.
</li>
<li>
December 8, 2016 by Filip Jorissen:<br/>
Fixed indexing bug in algorithm.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
December 8, 2016 by Filip Jorissen:<br/>
Fixed indexing bug in algorithm.
</li>
</ul>
</html>"));
end ZoneLwDistributionViewFactor;
