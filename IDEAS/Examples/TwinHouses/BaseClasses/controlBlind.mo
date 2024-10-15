within IDEAS.Examples.TwinHouses.BaseClasses;
model controlBlind
  parameter Integer exp = 1 "Parameter to select correct experiment (default =1)";
  parameter Integer bui = 1  "Parameter to select the building case. 1: N2 , 2:O5 (default=1)";
  final parameter Integer[4] Schedule= if exp == 1 then {20044800,20800000,22119000,22637400} else {8467200,10198800,11494800,12013200};
  Modelica.Blocks.Interfaces.RealOutput[3] y "outputs 1: south oriented windows , 2: north zones, 3: other"
    annotation (Placement(transformation(extent={{92,-10},{112,10}})));

equation
  if exp==1 and bui==2 then
    if time <= Schedule[2] then
      y[1]=1;
    elseif time > Schedule[2] and time <= Schedule[3] then
      y[1]=0;
    elseif time > Schedule[3] and time <= Schedule[4] then
      y[1] = 1;
    elseif time > Schedule[4] then
      y[1] = 0;
    else
      y[1] = 0;
    end if;
    y[2]=0;
    y[3]=0;
  elseif exp==1 and bui==1 then
    y[1]=1;
    y[2]=0;
    y[3]=0;
  else
    y[1]=0;
    y[3]=0;
    y[2]=1;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end controlBlind;
