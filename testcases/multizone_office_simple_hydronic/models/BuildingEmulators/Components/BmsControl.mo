within BuildingEmulators.Components;
model BmsControl

    parameter Integer nZones = 2;
    parameter Integer nVen = nZones;

      outer IDEAS.Utilities.Time.CalendarTime calTim
    annotation (Placement(transformation(extent={{-92.0,142.0},{-72.0,162.0}},rotation = 0.0,origin = {0.0,0.0})));

    .Modelica.Blocks.Interfaces.RealOutput TSetProHea annotation(Placement(transformation(extent = {{100.3076923076923,110.74358974358975},{120.3076923076923,130.74358974358975}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.Constant[nVen] TSetAhu(each k = 273.15 + 21) annotation(Placement(transformation(extent = {{-75.8614366211,74.57446081479745},{-63.52317876351539,86.91271867238206}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput TSetProCoo annotation(Placement(transformation(extent = {{100.3076923076923,90.74358974358975},{120.3076923076923,110.74358974358975}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Controls.Continuous.LimPID[nVen] pidAhuHea(each k = 0.2,Ti = {30,30},Ni = {1,1},y_start = {1,1},reverseActing = {true,true},each controllerType = Modelica.Blocks.Types.SimpleController.PI) annotation(Placement(transformation(extent = {{-32.673400656512115,2.4932660101545494},{-19.326599343487885,15.84006732317878}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Controls.Continuous.LimPID[nVen] pidAhuCoo(each controllerType = Modelica.Blocks.Types.SimpleController.PI,each k = 0.2,Ti = {30,30},reverseActing = {false,false},Ni = {1,1},y_start = {1,1}) annotation(Placement(transformation(extent = {{-32.433269153984476,-37.26660248731781},{-19.566730846015524,-24.40006417934886}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput[nVen] TSupAhuHea annotation(Placement(transformation(extent = {{-110.73112214086746,-14.731122140867452},{-89.26887785913254,6.731122140867452}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] valPosAhuHea annotation(Placement(transformation(extent = {{100.0,0.3333333333333357},{120.0,20.333333333333336}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] valPosAhuCoo annotation(Placement(transformation(extent = {{100.0,-39.666666666666664},{120.0,-19.666666666666664}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.IntegerOutput[nVen] prfAhuHea annotation(Placement(transformation(extent = {{100.0,-17.666666666666664},{120.0,2.333333333333334}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.IntegerOutput[nVen] prfAhuCoo annotation(Placement(transformation(extent = {{100.0,-57.666666666666664},{120.0,-37.666666666666664}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.BooleanToReal[nVen] boolToRealAhuHea annotation(Placement(transformation(extent = {{24.960210682066574,-12.706455984600089},{35.039789317933426,-2.6268773487332435}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.BooleanToReal[nVen] boolToRealAhuCoo annotation(Placement(transformation(extent = {{24.960210682066574,-52.70645598460009},{35.039789317933426,-42.62687734873324}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] prfAhuSup annotation(Placement(transformation(extent = {{100.0,19.999999999999996},{120.0,40.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput[nZones] nOcc annotation(Placement(transformation(extent = {{-111.38569444853543,18.94763888479791},{-88.61430555146457,41.71902778186876}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.GreaterThreshold[nVen] greaterOcc(threshold = {0.1,0.1}) annotation(Placement(transformation(extent = {{-43.031481687780726,25.30185164555261},{-32.968518312219274,35.36481502111406}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.BooleanToReal[nVen] boolToReaOcc annotation(Placement(transformation(extent = {{36.960210682066574,24.960210682066574},{47.039789317933426,35.039789317933426}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] TSupAhuSet annotation(Placement(transformation(extent = {{100.3076923076923,70.74358974358975},{120.3076923076923,90.74358974358975}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput[nVen] TSupAhuCoo annotation(Placement(transformation(extent = {{-110.73112214086746,-54.731122140867456},{-89.26887785913254,-33.268877859132544}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Controls.Continuous.LimPID[nVen] pidEmiHea(y_start = {1,1},Ni = {1,1},Ti = {30,30},each controllerType = .Modelica.Blocks.Types.SimpleController.PI,each k = 0.2) annotation(Placement(transformation(extent = {{-32.673400656512115,-75.84006732317879},{-19.326599343487885,-62.49326601015456}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Controls.Continuous.LimPID[nVen] pidEmiCoo(y_start = {1,1},Ni = {1,1},reverseActing = {false,false},Ti = {30,30},each k = 0.2,each controllerType = .Modelica.Blocks.Types.SimpleController.PI) annotation(Placement(transformation(extent = {{-32.433269153984476,-115.59993582065114},{-19.566730846015524,-102.7333975126822}},origin = {0.0,0.0},rotation = 0.0)));

    .Modelica.Blocks.Interfaces.RealInput[nZones] TSupEmiCoo annotation(Placement(transformation(extent = {{-110.73112214086746,-138.73112214086746},{-89.26887785913254,-117.26887785913254}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput[nZones] TSupEmiHea annotation(Placement(transformation(extent = {{-110.73112214086746,-98.73112214086746},{-89.26887785913254,-77.26887785913254}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nZones] valPosEmiHea annotation(Placement(transformation(extent = {{100.0,-78.0},{120.0,-58.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nZones] valPosEmiCoo annotation(Placement(transformation(extent = {{100.0,-118.0},{120.0,-98.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.Constant[nZones] TZonSet(k = {273.15 + 23,273.15 + 23}) annotation(Placement(transformation(extent = {{-76.1691289287923,-148.1691289287923},{-63.830871071207696,-135.8308710712077}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.Constant[nZones] dTSet(k = {2,2}) annotation(Placement(transformation(extent = {{-76.1691289287923,-166.1691289287923},{-63.830871071207696,-153.8308710712077}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.Constant[nZones] nightSetback(k = {5,5}) annotation(Placement(transformation(extent = {{-76.1691289287923,-184.1691289287923},{-63.830871071207696,-171.8308710712077}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.BooleanToReal[nZones] boolToReaSetbackSetpoint(realTrue = {0,0},realFalse = {1,1}) annotation(Placement(transformation(extent = {{-9.657149190680986,-132.342850809319},{-18.342850809319014,-123.657149190681}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Product[nZones] proSetpoint annotation(Placement(transformation(extent = {{-39.17420066897361,-179.1742006689736},{-28.82579933102639,-168.8257993310264}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Add[nZones] add annotation(Placement(transformation(extent = {{-16.695675489247563,-164.69567548924755},{-7.304324510752437,-155.30432451075245}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.IntegerOutput[nVen] prfEmiCoo annotation(Placement(transformation(extent = {{100.0,-136.0},{120.0,-116.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.IntegerOutput[nVen] prfEmiHea annotation(Placement(transformation(extent = {{100.0,-96.0},{120.0,-76.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput[nZones] TZon annotation(Placement(transformation(extent = {{-111.38569444853543,54.614305551464575},{-88.61430555146457,77.38569444853542}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.BooleanToReal[nZones] boolToRealEmiHea annotation(Placement(transformation(extent = {{58.960210682066574,-91.03978931793343},{69.03978931793343,-80.96021068206657}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Add[nZones] minusEmiHea(k2 = {-1,-1}) annotation(Placement(transformation(extent = {{5.304324510752437,-124.69567548924755},{14.695675489247563,-115.30432451075245}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.BooleanToReal[nZones] boolToRealEmiCoo annotation(Placement(transformation(extent = {{58.960210682066574,-131.0397893179334},{69.03978931793343,-120.96021068206659}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Add[nZones] addEmiCoo annotation(Placement(transformation(extent = {{7.304324510752437,-154.69567548924755},{16.695675489247563,-145.30432451075245}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nZones] TZonSetMax annotation(Placement(transformation(extent = {{100.0,-171.0},{120.0,-151.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nZones] TZonSetMin annotation(Placement(transformation(extent = {{100.0,-153.0},{120.0,-133.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nZones] TSet annotation(Placement(transformation(extent = {{100.0,-188.0},{120.0,-168.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Add[nZones] TSetMeas(k1 = {0.5,0.5},k2 = {0.5,0.5}) annotation(Placement(transformation(extent = {{79.30432451075244,-182.69567548924755},{88.69567548924756,-173.30432451075245}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.IntegerOutput prfProHea annotation(Placement(transformation(extent = {{100.3076923076923,148.74358974358975},{120.3076923076923,168.74358974358975}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.IntegerOutput prfProCoo annotation(Placement(transformation(extent = {{100.3076923076923,128.74358974358975},{120.3076923076923,148.74358974358975}},origin = {0.0,0.0},rotation = 0.0)));
            .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTProHea(description = "Heating production system supply temperature setpoint", u(min=273.15+20, max=273.15+80, unit="K")) annotation(Placement(transformation(extent = {{42.991794822775006,115.42769225867247},{53.62358979260961,126.05948722850704}},origin = {0.0,0.0},rotation = 0.0)));
            .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTProCoo(description = "Cooling production system supply temperature setpoint", u(min=273.15+0, max=273.15+20, unit="K")) annotation(Placement(transformation(extent = {{42.991794822775006,95.42769225867247},{53.62358979260961,106.05948722850704}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.RealExpression maxPrfProHea(y = if sum(prfAhuHea) + sum(prfEmiHea) > 1 then 1 else 0) annotation(Placement(transformation(extent = {{-36.28010648187601,151.719893518124},{-19.71989351812399,168.280106481876}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.RealExpression maxPrfProCoo(y = if sum(prfAhuCoo) + sum(prfEmiCoo) > 1 then 1 else 0) annotation(Placement(transformation(extent = {{-36.562783472371926,129.43721652762807},{-19.437216527628074,146.56278347237193}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput[nVen] prfAhuRet annotation(Placement(transformation(extent = {{100.0,38.0},{120.0,58.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.BooleanOutput[nVen] oveByPass annotation(Placement(transformation(extent = {{100.0,56.0},{120.0,76.0}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfProCoo(description = "Cooling production system pump activation setpoint", u(min=0, max=1, unit="1")) annotation(Placement(transformation(extent = {{-1.3158974849173006,132.6841025150827},{9.3158974849173,143.3158974849173}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfProHea(description = "Heating production system supply temperature setpoint", u(min=0, max=1, unit="1")) annotation(Placement(transformation(extent = {{-1.3158974849173006,154.6841025150827},{9.3158974849173,165.3158974849173}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.RealToInteger realToIntPrfProHea annotation(Placement(transformation(extent = {{29.259458112116533,155.25945811211653},{38.74054188788347,164.74054188788347}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.RealToInteger realToIntPrfProCoo annotation(Placement(transformation(extent = {{29.259458112116533,133.25945811211653},{38.74054188788347,142.74054188788347}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSupAhuNz(description = "North zone AHU air supply temperature setpoint", u(min=273.15+16, max=273.15+25, unit="K")) annotation(Placement(transformation(extent = {{0.7964094858412487,76.7964094858413},{11.203590514158751,87.2035905141587}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSupAhuSz(description = "South zone AHU air supply temperature setpoint", u(min=273.15+16, max=273.15+25, unit="K")) annotation(Placement(transformation(extent = {{0.7964094858412487,76.7964094858413},{11.203590514158751,87.2035905141587}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSupAhuHeaNz(description = "North zone AHU heating water supply temperature setpoint", u(min=273.15+20, max=273.15+80, unit="K")) annotation(Placement(transformation(extent = {{-53.3158974849173,4.684102515082714},{-42.6841025150827,15.315897484917286}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSupAhuHeaSz(description = "South zone AHU heating water supply temperature setpoint", u(min=273.15+20, max=273.15+80, unit="K")) annotation(Placement(transformation(extent = {{-53.3158974849173,4.684102515082714},{-42.6841025150827,15.315897484917286}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSupAhuCooNz(description = "North zone AHU cooling water supply temperature setpoint", u(min=273.15+0, max=273.15+20, unit="K")) annotation(Placement(transformation(extent = {{-53.3158974849173,-35.315897484917286},{-42.6841025150827,-24.684102515082714}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSupAhuCooSz(description = "South zone AHU cooling water supply temperature setpoint", u(min=273.15+0, max=273.15+20, unit="K")) annotation(Placement(transformation(extent = {{-53.3158974849173,-35.315897484917286},{-42.6841025150827,-24.684102515082714}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveValPosAhuHeaNz(description = "North zone AHU heating circuit mixing valve position setpoint", u(min=0, max=1, unit="1")) annotation(Placement(transformation(extent = {{30.6841025150827,4.684102515082714},{41.3158974849173,15.315897484917286}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveValPosAhuHeaSz(description = "South zone AHU heating circuit mixing valve position setpoint", u(min=0, max=1, unit="1")) annotation(Placement(transformation(extent = {{30.6841025150827,4.684102515082714},{41.3158974849173,15.315897484917286}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveValPosAhuCooNz(description = "North zone AHU cooling circuit mixing valve position setpoint", u(min=0, max=1, unit="1")) annotation(Placement(transformation(extent = {{30.6841025150827,-35.315897484917286},{41.3158974849173,-24.684102515082714}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveValPosAhuCooSz(description = "South zone AHU cooling circuit mixing valve position setpoint", u(min=0, max=1, unit="1")) annotation(Placement(transformation(extent = {{30.6841025150827,-35.315897484917286},{41.3158974849173,-24.684102515082714}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSupEmiHeaNz(description = "North zone heating emission circuit supply temperature setpoint", u(min=273.15+20, max=273.15+80, unit="K")) annotation(Placement(transformation(extent = {{-53.3158974849173,-73.31589748491729},{-42.6841025150827,-62.684102515082714}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSupEmiHeaSz(description = "South zone heating emission circuit supply temperature setpoint", u(min=273.15+20, max=273.15+80, unit="K")) annotation(Placement(transformation(extent = {{-53.3158974849173,-73.31589748491729},{-42.6841025150827,-62.684102515082714}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSupEmiCooNz(description = "North zone cooling emission circuit supply temperature setpoint", u(min=273.15+0, max=273.15+20, unit="K")) annotation(Placement(transformation(extent = {{-53.3158974849173,-113.31589748491729},{-42.6841025150827,-102.68410251508271}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSupEmiCooSz(description = "Southh zone cooling emission circuit supply temperature setpoint", u(min=273.15+0, max=273.15+20, unit="K")) annotation(Placement(transformation(extent = {{-53.3158974849173,-113.31589748491729},{-42.6841025150827,-102.68410251508271}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveValPosEmiHeaNz(description = "North zone heating emission circuit mixing valve position setpoint", u(min=0, max=1, unit="1")) annotation(Placement(transformation(extent = {{30.6841025150827,-73.31589748491729},{41.3158974849173,-62.684102515082714}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveValPosEmiHeaSz(description = "South zone heating emission circuit supply mixing valve position setpoint", u(min=0, max=1, unit="1")) annotation(Placement(transformation(extent = {{30.6841025150827,-73.31589748491729},{41.3158974849173,-62.684102515082714}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveValPosEmiCooNz(description = "North zone cooling emission circuit mixing valve position setpoint", u(min=0, max=1, unit="1")) annotation(Placement(transformation(extent = {{56.6841025150827,-113.31589748491729},{67.3158974849173,-102.68410251508271}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveValPosEmiCooSz(description = "South zone cooling emission circuit mixing valve position setpoint", u(min=0, max=1, unit="1")) annotation(Placement(transformation(extent = {{56.6841025150827,-113.31589748491729},{67.3158974849173,-102.68410251508271}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTZonSetMinNz(description = "North zone minimum (heating) zone temperature setpoint", u(min=273.15+15, max=273.15+30, unit="K")) annotation(Placement(transformation(extent = {{70.68410251508271,-149.3158974849173},{81.31589748491729,-138.6841025150827}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTZonSetMinSz(description = "South zone minimum (heating) zone temperature setpoint", u(min=273.15+10, max=273.15+30, unit="K")) annotation(Placement(transformation(extent = {{70.68410251508271,-149.3158974849173},{81.31589748491729,-138.6841025150827}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTZonSetMaxNz(description = "North zone maximum (cooling) zone temperature setpoint", u(min=273.15+15, max=273.15+30, unit="K")) annotation(Placement(transformation(extent = {{70.68410251508271,-165.3158974849173},{81.31589748491729,-154.6841025150827}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveTZonSetMaxSz(description = "South zone maximum (cooling) zone temperature setpoint", u(min=273.15+15, max=273.15+30, unit="K")) annotation(Placement(transformation(extent = {{70.68410251508271,-165.3158974849173},{81.31589748491729,-154.6841025150827}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.Constant[nVen] nightVen(k = {0,0}) annotation(Placement(transformation(extent = {{-26.169128928792304,59.830871071207696},{-13.830871071207696,72.1691289287923}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveByPassNz(u(min = 0,max = 1, unit="1"),description = "North zone AHU setpoint to override the recovery bypass (for night free cooling purposes)") annotation(Placement(transformation(extent = {{24.6841025150827,60.684102515082714},{35.3158974849173,71.31589748491729}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite oveByPassSz(u(min = 0,max = 1, unit="1"),description = "South zone AHU setpoint to override the recovery bypass (for night free cooling purposes)") annotation(Placement(transformation(extent = {{24.6841025150827,60.684102515082714},{35.3158974849173,71.31589748491729}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.RealToBoolean[nVen] realToBoolByPass annotation(Placement(transformation(extent = {{51.351672695830956,61.351672695830956},{60.648327304169044,70.64832730416904}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfAhuSupNz(description = "North zone AHU supply fan setpoint",u(min = 0,max = 1, unit="1")) annotation(Placement(transformation(extent = {{60.6841025150827,24.684102515082714},{71.3158974849173,35.315897484917286}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfAhuRetNz(u(min = 0,max = 1, unit="1"),description = "North zone AHU return fan setpoint") annotation(Placement(transformation(extent = {{60.6841025150827,42.684102515082714},{71.3158974849173,53.315897484917286}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfAhuSupSz(description = "South zone AHU supply fan setpoint",u(min = 0,max = 1, unit="1")) annotation(Placement(transformation(extent = {{60.6841025150827,24.684102515082714},{71.3158974849173,35.315897484917286}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfAhuRetSz(u(min = 0,max = 1, unit="1"),description = "South zone AHU return fan setpoint") annotation(Placement(transformation(extent = {{60.6841025150827,42.684102515082714},{71.3158974849173,53.315897484917286}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfAhuHeaNz(u(min = 0,max = 1, unit="1"),description = "North zone AHU heating circuit activation setpoint") annotation(Placement(transformation(extent = {{54.6841025150827,-13.315897484917286},{65.3158974849173,-2.6841025150827136}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfAhuCooNz(description = "North zone AHU cooling circuit activation setpoint",u(min = 0,max = 1, unit="1")) annotation(Placement(transformation(extent = {{54.6841025150827,-53.315897484917286},{65.3158974849173,-42.684102515082714}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfAhuHeaSz(u(min = 0,max = 1, unit="1"),description = "South zone AHU heating circuit activation setpoint") annotation(Placement(transformation(extent = {{54.6841025150827,-13.315897484917286},{65.3158974849173,-2.6841025150827136}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfAhuCooSz(description = "South zone AHU cooling circuit activation setpoint",u(min = 0,max = 1, unit="1")) annotation(Placement(transformation(extent = {{54.6841025150827,-53.315897484917286},{65.3158974849173,-42.684102515082714}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.RealToInteger[nVen] realToIntPrfAhuHea annotation(Placement(transformation(extent = {{83.25945811211653,-12.740541887883467},{92.74054188788347,-3.2594581121165334}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.RealToInteger[nVen] realToIntPrfAhuCoo annotation(Placement(transformation(extent = {{83.25945811211653,-52.74054188788347},{92.74054188788347,-43.25945811211653}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.RealToInteger[nZones] realToIntPrfEmiHea annotation(Placement(transformation(extent = {{87.25945811211653,-90.74054188788347},{96.74054188788347,-81.25945811211653}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.RealToInteger[nZones] realToIntPrfEmiCoo annotation(Placement(transformation(extent = {{87.25945811211653,-130.74054188788347},{96.74054188788347,-121.25945811211653}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfEmiCooNz(u(min = 0,max = 1, unit="1"),description = "North zone emission cooling circuit activation setpoint") annotation(Placement(transformation(extent = {{72.68410251508271,-131.3158974849173},{83.31589748491729,-120.68410251508271}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfEmiHeaNz(description = "North zone emission heating circuit activation setpoint",u(min = 0,max = 1, unit="1")) annotation(Placement(transformation(extent = {{72.43172280599326,-91.56827719400674},{83.56827719400674,-80.43172280599326}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfEmiCooSz(u(min = 0,max = 1, unit="1"),description = "South zone emission cooling circuit activation setpoint") annotation(Placement(transformation(extent = {{72.68410251508271,-131.3158974849173},{83.31589748491729,-120.68410251508271}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Utilities.IO.SignalExchange.Overwrite ovePrfEmiHeaSz(description = "South zone emission heating circuit activation setpoint",u(min = 0,max = 1, unit="1")) annotation(Placement(transformation(extent = {{72.43172280599326,-91.56827719400674},{83.56827719400674,-80.43172280599326}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Tables.CombiTable1Ds[nZones] heaCur(each table = [273.15 - 10, 273.15 + 70; 273.15 + 20, 273.15 + 40]) annotation(Placement(transformation(extent = {{-75.38187521415755,-73.38187521415755},{-64.61812478584245,-62.618124785842454}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput Te annotation(Placement(transformation(extent = {{-111.38569444853543,78.61430555146458},{-88.61430555146457,101.38569444853542}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Tables.CombiTable1Ds[nZones] cooCur(each table = [273.15 + 15, 273.15 + 12; 273.15 + 35, 273.15 + 7]) annotation(Placement(transformation(extent = {{-75.38187521415755,-113.38187521415755},{-64.61812478584245,-102.61812478584245}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.Constant[nVen] TSetAhuHea(k = {273.15 + 50,273.15 + 50}) annotation(Placement(transformation(extent = {{-76.1691289287923,3.830871071207696},{-63.830871071207696,16.169128928792304}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.Constant[nVen] TSetAhuCoo(k = {273.15 + 9,273.15 + 9}) annotation(Placement(transformation(extent = {{-76.1691289287923,-36.169128928792304},{-63.830871071207696,-23.830871071207696}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Utilities.Math.Max TSupProHea(nin = nVen + nZones) annotation(Placement(transformation(extent = {{-33.00368646072283,114.99631353927717},{-22.996313539277168,125.00368646072283}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Utilities.Math.Min TSupProCoo(nin = nVen + nZones) annotation(Placement(transformation(extent = {{-3.0036864607228324,94.99631353927717},{7.003686460722832,105.00368646072283}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.MathBoolean.And[nZones] andPrfEmiHea(each nu=2) annotation(Placement(transformation(extent = {{40.329291946639664,-89.67070805336034},{47.670708053360336,-82.32929194663966}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.MathBoolean.And[nZones] andPrfEmiCoo(each nu=2) annotation(Placement(transformation(extent = {{40.329291946639664,-129.67070805336033},{47.670708053360336,-122.32929194663967}},origin = {0.0,0.0},rotation = 0.0)));

    .Modelica.Blocks.Sources.BooleanExpression weekday(y = if (((calTim.hour >= 4) and (calTim.hour < 19)) and calTim.weekDay == 1) or (((calTim.hour >= 6) and (calTim.hour < 19)) and (calTim.weekDay >= 2 and calTim.weekDay <= 5)) then true else false) annotation(Placement(transformation(extent = {{11.405034699958179,-84.59496530004182},{20.59496530004182,-75.40503469995818}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Sources.BooleanExpression holidays(y = if
        (calTim.month == 1 and calTim.day == 1)
        or (calTim.month == 4 and calTim.day == 17)
        or (calTim.month == 4 and calTim.day == 18)
        or (calTim.month == 5 and calTim.day == 1)
        or (calTim.month == 5 and calTim.day == 26)
        or (calTim.month == 6 and calTim.day == 5)
        or (calTim.month == 6 and calTim.day == 6)
        or (calTim.month == 7 and calTim.day == 21)
        or (calTim.month == 8 and calTim.day == 15)
        or (calTim.month == 11 and calTim.day == 1)
        or (calTim.month == 11 and calTim.day == 11)
        or (calTim.month == 12 and calTim.day == 25) then false else true) annotation(Placement(transformation(extent = {{11.405034699958179,-96.59496530004182},{20.59496530004182,-87.40503469995818}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.MathBoolean.And[nZones] andSetpoint(each nu = 2) annotation(Placement(transformation(extent = {{13.670708053360336,-105.67070805336034},{6.329291946639664,-98.32929194663966}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Product[nZones] proComfort annotation(Placement(transformation(extent = {{-9.174200668973612,-187.1742006689736},{1.1742006689736115,-176.8257993310264}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.BooleanToReal[nZones] boolToReaSetbackComfort(realFalse = {1,1},realTrue = {0,0}) annotation(Placement(transformation(extent = {{-10.054704658907312,-151.94529534109267},{-17.945295341092688,-144.05470465890733}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Add[nZones] addComfort annotation(Placement(transformation(extent = {{9.304324510752437,-180.69567548924755},{18.695675489247563,-171.30432451075245}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Add[nZones] TZonMin(k2 = {-1,-1}) annotation(Placement(transformation(extent = {{29.304324510752437,-166.69567548924755},{38.69567548924756,-157.30432451075245}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Add[nZones] TZonMax annotation(Placement(transformation(extent = {{29.304324510752437,-190.69567548924755},{38.69567548924756,-181.30432451075245}},origin = {0.0,0.0},rotation = 0.0)));

equation

    connect(holidays.y, andPrfEmiHea[1].u[1]);
    connect(weekday.y, andPrfEmiHea[1].u[2]);

    connect(holidays.y,  andPrfEmiHea[2].u[1]);
    connect(weekday.y, andPrfEmiHea[2].u[2]);

    connect(holidays.y, andPrfEmiCoo[1].u[1]);
    connect(weekday.y, andPrfEmiCoo[1].u[2]);

    connect(holidays.y,  andPrfEmiCoo[2].u[1]);
    connect(weekday.y, andPrfEmiCoo[2].u[2]);

    connect(holidays.y, andSetpoint[1].u[1]);
    connect(weekday.y, andSetpoint[1].u[2]);

    connect(holidays.y,  andSetpoint[2].u[1]);
    connect(weekday.y, andSetpoint[2].u[2]);

    connect(greaterOcc.u,nOcc) annotation(Line(points = {{-44.03777802533687,30.333333333333336},{-100,30.333333333333336}},color = {0,0,127}));
    connect(pidAhuHea.u_m,TSupAhuHea) annotation(Line(points = {{-26,1.1585858788521275},{-26,-4},{-100,-4}},color = {0,0,127}));
    connect(pidAhuCoo.u_m,TSupAhuCoo) annotation(Line(points = {{-26,-38.553256318114705},{-26,-44},{-100,-44}},color = {0,0,127}));
    connect(pidEmiHea.u_m,TSupEmiHea) annotation(Line(points = {{-26,-77.1747474544812},{-26,-88},{-100,-88}},color = {0,0,127}));
    connect(pidEmiCoo.u_m,TSupEmiCoo) annotation(Line(points = {{-26,-116.88658965144803},{-26,-128},{-100,-128}},color = {0,0,127}));
    connect(dTSet.y,add.u1) annotation(Line(points = {{-63.21395817832847,-160},{-40.42438438271277,-160},{-40.42438438271277,-157.18259470645148},{-17.634810587097075,-157.18259470645148}},color = {0,0,127}));
    connect(add.y,minusEmiHea.u2) annotation(Line(points = {{-6.834756961827681,-160},{0,-160},{0,-122.81740529354853},{4.365189412902924,-122.81740529354853}},color = {0,0,127}));
    connect(TZonSet.y,minusEmiHea.u1) annotation(Line(points = {{-63.21395817832847,-142},{-2,-142},{-2,-117.18259470645147},{4.365189412902924,-117.18259470645147}},color = {0,0,127}));
    connect(add.y,addEmiCoo.u2) annotation(Line(points = {{-6.834756961827681,-160},{0,-160},{0,-152.81740529354852},{6.365189412902924,-152.81740529354852}},color = {0,0,127}));
    connect(TZonSet.y,addEmiCoo.u1) annotation(Line(points = {{-63.21395817832847,-142},{-2,-142},{-2,-147.18259470645148},{6.365189412902924,-147.18259470645148}},color = {0,0,127}));
    connect(TSetMeas.y,TSet) annotation(Line(points = {{89.16524303817232,-178},{110,-178}},color = {0,0,127}));
    connect(oveTProHea.y,TSetProHea) annotation(Line(points = {{54.15517954110133,120.74358974358975},{110.3076923076923,120.74358974358975}},color = {0,0,127}));
    connect(oveTProCoo.y,TSetProCoo) annotation(Line(points = {{54.15517954110134,100.74358974358975},{110.3076923076923,100.74358974358975}},color = {0,0,127}));
    connect(maxPrfProHea.y,ovePrfProHea.u) annotation(Line(points = {{-18.89188286993639,160},{-2.379076981900761,160}},color = {0,0,127}));
    connect(maxPrfProCoo.y,ovePrfProCoo.u) annotation(Line(points = {{-18.58093818039088,138},{-2.379076981900761,138}},color = {0,0,127}));
    connect(ovePrfProHea.y,realToIntPrfProHea.u) annotation(Line(points = {{9.84748723340903,160},{28.31134973453984,160}},color = {0,0,127}));
    connect(realToIntPrfProHea.y,prfProHea) annotation(Line(points = {{39.21459607667181,160},{100,160},{100,158.74358974358975},{110.3076923076923,158.74358974358975}},color = {255,127,0}));
    connect(realToIntPrfProCoo.u,ovePrfProCoo.y) annotation(Line(points = {{28.31134973453984,138},{9.84748723340903,138}},color = {0,0,127}));
    connect(realToIntPrfProCoo.y,prfProCoo) annotation(Line(points = {{39.21459607667181,138},{100,138},{100,138.74358974358975},{110.3076923076923,138.74358974358975}},color = {255,127,0}));
    connect(TSetAhu[1].y,oveTSupAhuNz.u) annotation(Line(points = {{-62.90626587063616,80.74358974358975},{-0.24430861699050155,80.74358974358975},{-0.24430861699050155,82}},color = {0,0,127}));
    connect(oveTSupAhuNz.y,TSupAhuSet[1]) annotation(Line(points = {{11.723949565574626,82},{58.07758977055067,82},{58.07758977055067,80.74358974358975},{110.3076923076923,80.74358974358975}},color = {0,0,127}));
    connect(TSetAhu[2].y,oveTSupAhuSz.u) annotation(Line(points = {{-62.90626587063616,80.74358974358975},{-0.24430861699050155,80.74358974358975},{-0.24430861699050155,82}},color = {0,0,127}));
    connect(oveTSupAhuSz.y,TSupAhuSet[2]) annotation(Line(points = {{11.723949565574626,82},{58.07758977055067,82},{58.07758977055067,80.74358974358975},{110.3076923076923,80.74358974358975}},color = {0,0,127}));
    connect(oveTSupAhuHeaNz.y,pidAhuHea[1].u_s) annotation(Line(points = {{-42.15251276659097,10},{-38.08029677720275,10},{-38.08029677720275,9.166666666666664},{-34.008080787814535,9.166666666666664}},color = {0,0,127}));
    connect(oveTSupAhuHeaSz.y,pidAhuHea[2].u_s) annotation(Line(points = {{-42.15251276659097,10},{-38.08029677720275,10},{-38.08029677720275,9.166666666666664},{-34.008080787814535,9.166666666666664}},color = {0,0,127}));
    connect(oveTSupAhuCooNz.y,pidAhuCoo[1].u_s) annotation(Line(points = {{-42.15251276659097,-30},{-37.93621787568617,-30},{-37.93621787568617,-30.833333333333336},{-33.71992298478137,-30.833333333333336}},color = {0,0,127}));
    connect(oveTSupAhuCooSz.y,pidAhuCoo[2].u_s) annotation(Line(points = {{-42.15251276659097,-30},{-37.93621787568617,-30},{-37.93621787568617,-30.833333333333336},{-33.71992298478137,-30.833333333333336}},color = {0,0,127}));
    connect(oveValPosAhuHeaNz.y,valPosAhuHea[1]) annotation(Line(points = {{41.84748723340903,10},{76.92374361670451,10},{76.92374361670451,10.333333333333336},{110,10.333333333333336}},color = {0,0,127}));
    connect(oveValPosAhuHeaNz.u,pidAhuHea[1].y) annotation(Line(points = {{29.62092301809924,10},{6.480831870131283,10},{6.480831870131283,9.166666666666664},{-18.659259277836675,9.166666666666664}},color = {0,0,127}));
    connect(oveValPosAhuHeaSz.y,valPosAhuHea[2]) annotation(Line(points = {{41.84748723340903,10},{76.92374361670451,10},{76.92374361670451,10.333333333333336},{110,10.333333333333336}},color = {0,0,127}));
    connect(oveValPosAhuHeaSz.u,pidAhuHea[2].y) annotation(Line(points = {{29.62092301809924,10},{6.480831870131283,10},{6.480831870131283,9.166666666666664},{-18.659259277836675,9.166666666666664}},color = {0,0,127}));
    connect(oveValPosAhuCooNz.u,pidAhuCoo[1].y) annotation(Line(points = {{29.62092301809924,-30},{5.348759543741082,-30},{5.348759543741082,-30.833333333333336},{-18.923403930617077,-30.833333333333336}},color = {0,0,127}));
    connect(oveValPosAhuCooNz.y,valPosAhuCoo[1]) annotation(Line(points = {{41.84748723340903,-30},{75.92374361670451,-30},{75.92374361670451,-29.666666666666664},{110,-29.666666666666664}},color = {0,0,127}));
    connect(oveValPosAhuCooSz.u,pidAhuCoo[2].y) annotation(Line(points = {{29.62092301809924,-30},{5.348759543741082,-30},{5.348759543741082,-30.833333333333336},{-18.923403930617077,-30.833333333333336}},color = {0,0,127}));
    connect(oveValPosAhuCooSz.y,valPosAhuCoo[2]) annotation(Line(points = {{41.84748723340903,-30},{75.92374361670451,-30},{75.92374361670451,-29.666666666666664},{110,-29.666666666666664}},color = {0,0,127}));
    connect(oveTSupEmiHeaNz.y,pidEmiHea[1].u_s) annotation(Line(points = {{-42.15251276659097,-68},{-38.08029677720275,-68},{-38.08029677720275,-69.16666666666667},{-34.008080787814535,-69.16666666666667}},color = {0,0,127}));
    connect(oveTSupEmiHeaSz.y,pidEmiHea[2].u_s) annotation(Line(points = {{-42.15251276659097,-68},{-38.08029677720275,-68},{-38.08029677720275,-69.16666666666667},{-34.008080787814535,-69.16666666666667}},color = {0,0,127}));
    connect(oveTSupEmiCooNz.y,pidEmiCoo[1].u_s) annotation(Line(points = {{-42.15251276659097,-108},{-37.93621787568617,-108},{-37.93621787568617,-109.16666666666667},{-33.71992298478137,-109.16666666666667}},color = {0,0,127}));
    connect(oveTSupEmiCooSz.y,pidEmiCoo[2].u_s) annotation(Line(points = {{-42.15251276659097,-108},{-37.93621787568617,-108},{-37.93621787568617,-109.16666666666667},{-33.71992298478137,-109.16666666666667}},color = {0,0,127}));
    connect(oveValPosEmiHeaNz.u,pidEmiHea[1].y) annotation(Line(points = {{29.62092301809924,-68},{5.480831870131283,-68},{5.480831870131283,-69.16666666666667},{-18.659259277836675,-69.16666666666667}},color = {0,0,127}));
    connect(oveValPosEmiHeaNz.y,valPosEmiHea[1]) annotation(Line(points = {{41.84748723340903,-68},{110,-68}},color = {0,0,127}));
    connect(oveValPosEmiHeaSz.u,pidEmiHea[2].y) annotation(Line(points = {{29.62092301809924,-68},{5.480831870131283,-68},{5.480831870131283,-69.16666666666667},{-18.659259277836675,-69.16666666666667}},color = {0,0,127}));
    connect(oveValPosEmiHeaSz.y,valPosEmiHea[2]) annotation(Line(points = {{41.84748723340903,-68},{110,-68}},color = {0,0,127}));
    connect(oveValPosEmiCooNz.y,valPosEmiCoo[1]) annotation(Line(points = {{67.84748723340903,-108},{110,-108}},color = {0,0,127}));
    connect(oveValPosEmiCooNz.u,pidEmiCoo[1].y) annotation(Line(points = {{55.62092301809924,-108},{18.34875954374108,-108},{18.34875954374108,-109.16666666666667},{-18.923403930617077,-109.16666666666667}},color = {0,0,127}));
    connect(oveValPosEmiCooSz.y,valPosEmiCoo[2]) annotation(Line(points = {{67.84748723340903,-108},{110,-108}},color = {0,0,127}));
    connect(oveValPosEmiCooSz.u,pidEmiCoo[2].y) annotation(Line(points = {{55.62092301809924,-108},{18.34875954374108,-108},{18.34875954374108,-109.16666666666667},{-18.923403930617077,-109.16666666666667}},color = {0,0,127}));
    connect(oveTZonSetMinNz.y,TZonSetMin[1]) annotation(Line(points = {{81.84748723340901,-144},{99.92374361670451,-144},{99.92374361670451,-143},{110,-143}},color = {0,0,127}));
    connect(oveTZonSetMinNz.u,minusEmiHea[1].y) annotation(Line(points = {{69.62092301809926,-144},{15.165243038172319,-144},{15.165243038172319,-120}},color = {0,0,127}));
    connect(oveTZonSetMinSz.y,TZonSetMin[2]) annotation(Line(points = {{81.84748723340901,-144},{99.92374361670451,-144},{99.92374361670451,-143},{110,-143}},color = {0,0,127}));
    connect(oveTZonSetMinSz.u,minusEmiHea[2].y) annotation(Line(points = {{69.62092301809926,-144},{15.165243038172319,-144},{15.165243038172319,-120}},color = {0,0,127}));
    connect(oveTZonSetMaxNz.y,TZonSetMax[1]) annotation(Line(points = {{81.84748723340901,-160},{95.92374361670451,-160},{95.92374361670451,-161},{110,-161}},color = {0,0,127}));
    connect(oveTZonSetMaxNz.u,addEmiCoo[1].y) annotation(Line(points = {{69.62092301809926,-160},{42,-160},{42,-150},{17.16524303817232,-150}},color = {0,0,127}));
    connect(oveTZonSetMaxSz.y,TZonSetMax[2]) annotation(Line(points = {{81.84748723340901,-160},{95.92374361670451,-160},{95.92374361670451,-161},{110,-161}},color = {0,0,127}));
    connect(oveTZonSetMaxSz.u,addEmiCoo[2].y) annotation(Line(points = {{69.62092301809926,-160},{42,-160},{42,-150},{17.16524303817232,-150}},color = {0,0,127}));
    connect(oveTZonSetMinNz.y,TSetMeas[1].u1) annotation(Line(points = {{81.84748723340901,-144},{86,-144},{86,-168},{78.36518941290292,-168},{78.36518941290292,-175.18259470645148}},color = {0,0,127}));
    connect(oveTZonSetMaxNz.y,TSetMeas[1].u2) annotation(Line(points = {{81.84748723340901,-160},{86,-160},{86,-168},{72,-168},{72,-180.81740529354852},{78.36518941290292,-180.81740529354852}},color = {0,0,127}));
    connect(oveTZonSetMinSz.y,TSetMeas[2].u1) annotation(Line(points = {{81.84748723340901,-144},{86,-144},{86,-168},{78.36518941290292,-168},{78.36518941290292,-175.18259470645148}},color = {0,0,127}));
    connect(oveTZonSetMaxSz.y,TSetMeas[2].u2) annotation(Line(points = {{81.84748723340901,-160},{86,-160},{86,-168},{72,-168},{72,-180.81740529354852},{78.36518941290292,-180.81740529354852}},color = {0,0,127}));
    connect(boolToReaOcc.u,greaterOcc.y) annotation(Line(points = {{35.95225281847989,30},{1.7434413375193465,30},{1.7434413375193465,30.333333333333336},{-32.4653701434412,30.333333333333336}},color = {255,0,255}));
    connect(nightVen[1].y,oveByPassNz.u) annotation(Line(points = {{-13.213958178328465,66},{23.62092301809924,66}},color = {0,0,127}));
    connect(realToBoolByPass.y,oveByPass) annotation(Line(points = {{61.113160034585945,66},{110,66}},color = {255,0,255}));
    connect(oveByPassNz.y,realToBoolByPass[1].u) annotation(Line(points = {{35.84748723340903,66},{50.422007234997146,66}},color = {0,0,127}));
    connect(nightVen[2].y,oveByPassSz.u) annotation(Line(points = {{-13.213958178328465,66},{23.62092301809924,66}},color = {0,0,127}));
    connect(oveByPassSz.y,realToBoolByPass[2].u) annotation(Line(points = {{35.84748723340903,66},{50.422007234997146,66}},color = {0,0,127}));
    connect(boolToReaOcc[1].y,ovePrfAhuRetNz.u) annotation(Line(points = {{47.54376824972677,30},{53.58234563391301,30},{53.58234563391301,48},{59.62092301809924,48}},color = {0,0,127}));
    connect(boolToReaOcc[1].y,ovePrfAhuSupNz.u) annotation(Line(points = {{47.54376824972677,30},{59.62092301809924,30}},color = {0,0,127}));
    connect(ovePrfAhuRetNz.y,prfAhuRet[1]) annotation(Line(points = {{71.84748723340903,48},{110,48}},color = {0,0,127}));
    connect(ovePrfAhuSupNz.y,prfAhuSup[1]) annotation(Line(points = {{71.84748723340903,30},{110,30}},color = {0,0,127}));
    connect(boolToReaOcc[2].y,ovePrfAhuRetSz.u) annotation(Line(points = {{47.54376824972677,30},{53.58234563391301,30},{53.58234563391301,48},{59.62092301809924,48}},color = {0,0,127}));
    connect(boolToReaOcc[2].y,ovePrfAhuSupSz.u) annotation(Line(points = {{47.54376824972677,30},{59.62092301809924,30}},color = {0,0,127}));
    connect(ovePrfAhuRetSz.y,prfAhuRet[2]) annotation(Line(points = {{71.84748723340903,48},{110,48}},color = {0,0,127}));
    connect(ovePrfAhuSupSz.y,prfAhuSup[2]) annotation(Line(points = {{71.84748723340903,30},{110,30}},color = {0,0,127}));
    connect(greaterOcc.y,boolToRealAhuHea.u) annotation(Line(points = {{-32.4653701434412,30.333333333333336},{-4.256558662480655,30.333333333333336},{-4.256558662480655,-7.666666666666666},{23.952252818479888,-7.666666666666666}},color = {255,0,255}));
    connect(boolToRealAhuHea[1].y,ovePrfAhuHeaNz.u) annotation(Line(points = {{35.54376824972677,-7.666666666666666},{39.58234563391301,-7.666666666666666},{39.58234563391301,-8},{53.62092301809924,-8}},color = {0,0,127}));
    connect(greaterOcc.y,boolToRealAhuCoo.u) annotation(Line(points = {{-32.4653701434412,30.333333333333336},{-4.256558662480655,30.333333333333336},{-4.256558662480655,-47.666666666666664},{23.952252818479888,-47.666666666666664}},color = {255,0,255}));
    connect(boolToRealAhuCoo[1].y,ovePrfAhuCooNz.u) annotation(Line(points = {{35.54376824972677,-47.666666666666664},{39.58234563391301,-47.666666666666664},{39.58234563391301,-48},{53.62092301809924,-48}},color = {0,0,127}));
    connect(boolToRealAhuHea[2].y,ovePrfAhuHeaSz.u) annotation(Line(points = {{35.54376824972677,-7.666666666666666},{39.58234563391301,-7.666666666666666},{39.58234563391301,-8},{53.62092301809924,-8}},color = {0,0,127}));
    connect(boolToRealAhuCoo[2].y,ovePrfAhuCooSz.u) annotation(Line(points = {{35.54376824972677,-47.666666666666664},{39.58234563391301,-47.666666666666664},{39.58234563391301,-48},{53.62092301809924,-48}},color = {0,0,127}));
    connect(realToIntPrfAhuHea.y,prfAhuHea) annotation(Line(points = {{93.21459607667181,-8},{101.6072980383359,-8},{101.6072980383359,-7.666666666666664},{110,-7.666666666666664}},color = {255,127,0}));
    connect(realToIntPrfAhuCoo.y,prfAhuCoo) annotation(Line(points = {{93.21459607667181,-48},{101.6072980383359,-48},{101.6072980383359,-47.666666666666664},{110,-47.666666666666664}},color = {255,127,0}));
    connect(ovePrfAhuHeaNz.y,realToIntPrfAhuHea[1].u) annotation(Line(points = {{65.84748723340903,-8},{82.31134973453985,-8}},color = {0,0,127}));
    connect(ovePrfAhuCooNz.y,realToIntPrfAhuCoo[1].u) annotation(Line(points = {{65.84748723340903,-48},{82.31134973453985,-48}},color = {0,0,127}));
    connect(ovePrfAhuHeaSz.y,realToIntPrfAhuHea[2].u) annotation(Line(points = {{65.84748723340903,-8},{82.31134973453985,-8}},color = {0,0,127}));
    connect(ovePrfAhuCooSz.y,realToIntPrfAhuCoo[2].u) annotation(Line(points = {{65.84748723340903,-48},{82.31134973453985,-48}},color = {0,0,127}));
    connect(realToIntPrfEmiCoo.y,prfEmiCoo) annotation(Line(points = {{97.21459607667181,-126},{110,-126}},color = {255,127,0}));
    connect(realToIntPrfEmiHea.y,prfEmiHea) annotation(Line(points = {{97.21459607667181,-86},{110,-86}},color = {255,127,0}));
    connect(ovePrfEmiHeaNz.u,boolToRealEmiHea[1].y) annotation(Line(points = {{71.31806736719192,-86},{69.54376824972677,-86}},color = {0,0,127}));
    connect(ovePrfEmiHeaNz.y,realToIntPrfEmiHea[1].u) annotation(Line(points = {{84.12510491340741,-86},{86.31134973453985,-86}},color = {0,0,127}));
    connect(ovePrfEmiHeaSz.u,boolToRealEmiHea[2].y) annotation(Line(points = {{71.31806736719192,-86},{69.54376824972677,-86}},color = {0,0,127}));
    connect(ovePrfEmiHeaSz.y,realToIntPrfEmiHea[2].u) annotation(Line(points = {{84.12510491340741,-86},{86.31134973453985,-86}},color = {0,0,127}));
    connect(ovePrfEmiCooNz.y,realToIntPrfEmiCoo[1].u) annotation(Line(points = {{83.84748723340901,-126},{86.31134973453985,-126}},color = {0,0,127}));
    connect(ovePrfEmiCooSz.y,realToIntPrfEmiCoo[2].u) annotation(Line(points = {{83.84748723340901,-126},{86.31134973453985,-126}},color = {0,0,127}));
    connect(heaCur[1].u,Te) annotation(Line(points = {{-76.45825025698906,-68},{-80,-68},{-80,90},{-100,90}},color = {0,0,127}));
    connect(heaCur[2].u,Te) annotation(Line(points = {{-76.45825025698906,-68},{-80,-68},{-80,90},{-100,90}},color = {0,0,127}));
    connect(cooCur[1].u,Te) annotation(Line(points = {{-76.45825025698906,-108},{-80,-108},{-80,90},{-100,90}},color = {0,0,127}));
    connect(cooCur[2].u,Te) annotation(Line(points = {{-76.45825025698906,-108},{-80,-108},{-80,90},{-100,90}},color = {0,0,127}));
    connect(heaCur[1].y[1],oveTSupEmiHeaNz.u) annotation(Line(points = {{-64.0799372644267,-68},{-54.37907698190076,-68}},color = {0,0,127}));
    connect(cooCur[1].y[1],oveTSupEmiCooNz.u) annotation(Line(points = {{-64.0799372644267,-108},{-54.37907698190076,-108}},color = {0,0,127}));
    connect(heaCur[2].y[1],oveTSupEmiHeaSz.u) annotation(Line(points = {{-64.0799372644267,-68},{-54.37907698190076,-68}},color = {0,0,127}));
    connect(cooCur[2].y[1],oveTSupEmiCooSz.u) annotation(Line(points = {{-64.0799372644267,-108},{-54.37907698190076,-108}},color = {0,0,127}));
    connect(TSetAhuHea[1].y,oveTSupAhuHeaNz.u) annotation(Line(points = {{-63.21395817832847,10},{-54.37907698190076,10}},color = {0,0,127}));
    connect(TSetAhuCoo[1].y,oveTSupAhuCooNz.u) annotation(Line(points = {{-63.21395817832847,-30},{-54.37907698190076,-30}},color = {0,0,127}));
    connect(TSetAhuHea[2].y,oveTSupAhuHeaSz.u) annotation(Line(points = {{-63.21395817832847,10},{-54.37907698190076,10}},color = {0,0,127}));
    connect(TSetAhuCoo[2].y,oveTSupAhuCooSz.u) annotation(Line(points = {{-63.21395817832847,-30},{-54.37907698190076,-30}},color = {0,0,127}));
    connect(TSupProHea.y,oveTProHea.u) annotation(Line(points = {{-22.495944893204886,120},{41.92861532579155,120},{41.92861532579155,120.74358974358975}},color = {0,0,127}));
    connect(oveTSupAhuHeaNz.y,TSupProHea.u[1]) annotation(Line(points = {{-42.15251276659097,10},{-38,10},{-38,20},{-30,20},{-30,94},{-42,94},{-42,120},{-34.004423752867396,120}},color = {0,0,127}));
    connect(oveTSupEmiHeaNz.y,TSupProHea.u[3]) annotation(Line(points = {{-42.15251276659097,-68},{-38,-68},{-38,20},{-30,20},{-30,94},{-42,94},{-42,120},{-34.004423752867396,120}},color = {0,0,127}));
    connect(oveTSupAhuHeaSz.y,TSupProHea.u[2]) annotation(Line(points = {{-42.15251276659097,10},{-38,10},{-38,20},{-30,20},{-30,94},{-42,94},{-42,120},{-34.004423752867396,120}},color = {0,0,127}));
    connect(oveTSupEmiHeaSz.y,TSupProHea.u[4]) annotation(Line(points = {{-42.15251276659097,-68},{-38,-68},{-38,20},{-30,20},{-30,94},{-42,94},{-42,120},{-34.004423752867396,120}},color = {0,0,127}));
    connect(oveTSupAhuCooNz.y,TSupProCoo.u[1]) annotation(Line(points = {{-42.15251276659097,-30},{-36,-30},{-36,-18},{-12,-18},{-12,100},{-4.004423752867399,100}},color = {0,0,127}));
    connect(oveTProCoo.u,TSupProCoo.y) annotation(Line(points = {{41.92861532579155,100.74358974358975},{41.92861532579155,100},{7.504055106795116,100}},color = {0,0,127}));
    connect(oveTSupEmiCooNz.y,TSupProCoo.u[3]) annotation(Line(points = {{-42.15251276659097,-108},{-36,-108},{-36,-98},{-12,-98},{-12,100},{-4.004423752867399,100}},color = {0,0,127}));
    connect(oveTSupAhuCooSz.y,TSupProCoo.u[2]) annotation(Line(points = {{-42.15251276659097,-30},{-36,-30},{-36,-18},{-12,-18},{-12,100},{-4.004423752867399,100}},color = {0,0,127}));
    connect(oveTSupEmiCooSz.y,TSupProCoo.u[4]) annotation(Line(points = {{-42.15251276659097,-108},{-36,-108},{-36,-98},{-12,-98},{-12,100},{-4.004423752867399,100}},color = {0,0,127}));
    connect(andPrfEmiHea.y,boolToRealEmiHea.u) annotation(Line(points = {{48.221314261364384,-86},{57.95225281847989,-86}},color = {255,0,255}));
    connect(andPrfEmiCoo.y,boolToRealEmiCoo.u) annotation(Line(points = {{48.221314261364384,-126},{57.95225281847989,-126}},color = {255,0,255}));
    connect(ovePrfEmiCooNz.u,boolToRealEmiCoo[1].y) annotation(Line(points = {{71.62092301809926,-126},{69.54376824972677,-126}},color = {0,0,127}));
    connect(ovePrfEmiCooSz.u,boolToRealEmiCoo[2].y) annotation(Line(points = {{71.62092301809926,-126},{69.54376824972677,-126}},color = {0,0,127}));
    connect(nightSetback.y,proSetpoint.u2) annotation(Line(points = {{-63.21395817832847,-178},{-51.711499490548405,-178},{-51.711499490548405,-177.10452040138418},{-40.209040802768335,-177.10452040138418}},color = {0,0,127}));
    connect(proSetpoint.y,add.u2) annotation(Line(points = {{-28.308379264129027,-174},{-22.97159492561305,-174},{-22.97159492561305,-162.81740529354852},{-17.634810587097075,-162.81740529354852}},color = {0,0,127}));
    connect(andSetpoint.y,boolToReaSetbackSetpoint.u) annotation(Line(points = {{5.778685738635614,-102},{-4,-102},{-4,-128},{-8.788579028817182,-128}},color = {255,0,255}));
    connect(proSetpoint.u1,boolToReaSetbackSetpoint.y) annotation(Line(points = {{-40.209040802768335,-170.89547959861582},{-46.209040802768335,-170.89547959861582},{-46.209040802768335,-128},{-18.777135890250918,-128}},color = {0,0,127}));
    connect(boolToReaSetbackComfort.y,proComfort.u1) annotation(Line(points = {{-18.339824875201955,-148},{-24.339824875201955,-148},{-24.339824875201955,-178.89547959861582},{-10.209040802768333,-178.89547959861582}},color = {0,0,127}));
    connect(nightSetback.y,proComfort.u2) annotation(Line(points = {{-63.21395817832847,-178},{-52,-178},{-52,-185.10452040138418},{-10.209040802768333,-185.10452040138418}},color = {0,0,127}));
    connect(greaterOcc.y,boolToReaSetbackComfort.u) annotation(Line(points = {{-32.4653701434412,30.333333333333336},{-4,30.333333333333336},{-4,-148},{-9.265645590688774,-148}},color = {255,0,255}));
    connect(proComfort.y,addComfort.u2) annotation(Line(points = {{1.6916207358709725,-182},{5.028405074386949,-182},{5.028405074386949,-178.81740529354852},{8.365189412902925,-178.81740529354852}},color = {0,0,127}));
    connect(dTSet.y,addComfort.u1) annotation(Line(points = {{-63.21395817832847,-160},{-20,-160},{-20,-173.18259470645148},{8.365189412902925,-173.18259470645148}},color = {0,0,127}));
    connect(addComfort.y,TZonMin.u2) annotation(Line(points = {{19.16524303817232,-176},{23.76521622553762,-176},{23.76521622553762,-164.81740529354852},{28.365189412902925,-164.81740529354852}},color = {0,0,127}));
    connect(addComfort.y,TZonMax.u2) annotation(Line(points = {{19.16524303817232,-176},{23.76521622553762,-176},{23.76521622553762,-188.81740529354852},{28.365189412902925,-188.81740529354852}},color = {0,0,127}));
    connect(TZonSet.y,TZonMin.u1) annotation(Line(points = {{-63.21395817832847,-142},{2,-142},{2,-159.18259470645148},{28.365189412902925,-159.18259470645148}},color = {0,0,127}));
    connect(TZonMax.u1,TZonMin.u1) annotation(Line(points = {{28.365189412902925,-183.18259470645148},{22,-183.18259470645148},{22,-159.18259470645148},{28.365189412902925,-159.18259470645148}},color = {0,0,127}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100, -100},{100, 100}}),graphics={Text(origin = {-2, 104}, lineColor = {0, 0, 255}, extent = {{-152, 21}, {152, -21}}, textString = "%name"),Rectangle(origin={0,-19},extent={{-100,169},{100,-169}}),Ellipse(origin={-60,70},extent={{-10,10},{10,-10}}),Ellipse(origin={-20,-100},extent={{-10,10},{10,-10}}),Ellipse(origin={20,24},extent={{-10,10},{10,-10}}),Ellipse(origin={60,-30},extent={{-10,10},{10,-10}}),Line(origin = {-60.0352, -37.2642}, points = {{0.00892857, 108.246}, {-0.00892857, -108.246}}),Line(origin = {-19.9999, -34.6794}, points = {{7.22622e-12, 106.765}, {-7.22977e-12, -106.765}}),Line(origin = {20.0782, -35.9134}, points = {{-0.0780582, 107.999}, {0.0780582, -107.999}}),Line(origin = {60.1671, -34.1563}, points = {{-0.166984, 108.242}, {0.166984, -108.242}})}), uses(
        Modelica(version="4.0.0")));
end BmsControl;
