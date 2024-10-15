within IDEAS.Experimental.Electric.Photovoltaics.Components.ForInputFiles;
model PVvoltagemeas
  parameter Integer PVPha=4;
protected
  parameter Integer numPVPha=(if PVPha == 4 then 3 else 1);

public
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin PVside[
    numPVPha] annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
    GridSide[3]
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
equation
  if PVPha == 4 then
    connect(PVside, GridSide) annotation (Line(
        points={{0,100},{0,-100}},
        color={0,0,255},
        smooth=Smooth.None));
  else
    for p in 1:3 loop
      if PVPha == p then
        connect(PVside[1], GridSide[p]);
      else
        GridSide[p].i = 0 + 0*Modelica.ComplexMath.j;
      end if;
    end for;
  end if;
  annotation (Diagram(graphics));
end PVvoltagemeas;
