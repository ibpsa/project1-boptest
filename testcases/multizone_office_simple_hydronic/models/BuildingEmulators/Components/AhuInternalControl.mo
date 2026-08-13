within BuildingEmulators.Components;
model AhuInternalControl


    .IDEAS.Controls.Continuous.LimPID pidAhuHea(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=600,                                                      reset = IDEAS.Types.Reset.Parameter) annotation(Placement(transformation(extent = {{-45.340067323178786,-33.11784510095655},{-31.993266010154557,-19.77104378793232}},origin = {0.0,0.0},rotation = 0.0)));
    .IDEAS.Controls.Continuous.LimPID pidAhuCoo(
    k=0.1,
    Ti=900,                                                      reverseActing = false,reset = IDEAS.Types.Reset.Parameter,
    controllerType=Modelica.Blocks.Types.SimpleController.PI)                                                                                                                          annotation(Placement(transformation(extent = {{-44.433269153984476,-62.433269153984476},{-31.566730846015524,-49.566730846015524}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TSupAhu annotation(Placement(transformation(extent = {{-111.39778880753413,-91.50889991864526},{-89.93554452579922,-70.04665563691034}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput valPosAhuHea annotation(Placement(transformation(extent = {{99.33333333333333,-36.444444444444436},{119.33333333333333,-16.444444444444436}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealOutput valPosAhuCoo annotation(Placement(transformation(extent = {{99.33333333333333,-66.7777777777778},{119.33333333333333,-46.77777777777779}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TSupAhuSet annotation(Placement(transformation(extent = {{-111.39778880753413,-27.508899918645234},{-89.93554452579922,-6.046655636910323}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.BooleanOutput valPosRec annotation(Placement(transformation(extent = {{100.0,70.0},{120.0,90.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TRetAhu annotation(Placement(transformation(extent = {{-110.73112214086746,29.268877859132544},{-89.26887785913254,50.731122140867456}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput TInAhu annotation(Placement(transformation(extent = {{-111.26445547420079,69.51332230357698},{-89.80221119246588,90.9755665853119}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Greater greaterSet annotation(Placement(transformation(extent = {{-43.95589380078418,52.04410619921582},{-28.04410619921582,67.95589380078418}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Less lessSet annotation(Placement(transformation(extent = {{-44.06850924225885,-2.0685092422588482},{-27.93149075774115,14.068509242258848}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.And andRecCoo annotation(Placement(transformation(extent = {{-7.059244146799895,64.9407558532001},{7.059244146799895,79.0592441467999}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.And andRecHea annotation(Placement(transformation(extent = {{-7.0592441467998945,10.940755853200102},{7.0592441467998945,25.059244146799898}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Nor byPass annotation(Placement(transformation(extent = {{28,36},{48,56}},origin = {0,0},rotation = 0)));
    .Modelica.Blocks.Logical.Hysteresis hystCoo(uLow=-0.25, uHigh=0.75)   annotation(Placement(transformation(extent = {{-18.998648648600845,-80.99864864860085},{-5.001351351399155,-67.00135135139915}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent = {{-89.04635911183502,-38.95364088816498},{-74.95364088816498,-53.04635911183502}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Hysteresis hystHea(uHigh = 0.5, uLow=-0.5)   annotation(Placement(transformation(extent = {{-18.998648648600845,-52.99864864860085},{-5.001351351399155,-39.00135135139915}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Product proCoo annotation(Placement(transformation(extent = {{43.63704934105082,-76.36295065894917},{56.36295065894918,-63.637049341050826}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.BooleanToReal booToReaCoo annotation(Placement(transformation(extent = {{8.299371056482087,-79.70062894351791},{19.700628943517913,-68.29937105648209}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Not not1 annotation(Placement(transformation(extent = {{5.671880037107968,-50.32811996289203},{14.328119962892032,-41.67188003710797}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.Product proHea annotation(Placement(transformation(extent = {{61.63704934105081,-44.362950658949174},{74.36295065894919,-31.637049341050826}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Math.BooleanToReal booToReaHea annotation(Placement(transformation(extent = {{22.299371056482087,-51.70062894351791},{33.70062894351791,-40.29937105648209}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.RealInput prfAhu annotation(Placement(transformation(extent = {{-110.73112214086746,-46.731122140867456},{-89.26887785913254,-25.268877859132544}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 0.01)  annotation(Placement(transformation(extent = {{-70.89653022759906,-40.89653022759906},{-61.10346977240094,-31.103469772400945}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Or orOveWrite annotation(Placement(transformation(extent = {{60.0,44.0},{80.0,64.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Interfaces.BooleanInput oveByPass annotation(Placement(transformation(extent = {{-13.189503928312071,-13.189503928312064},{13.189503928312071,13.189503928312064}},origin = {50.0,100.0},rotation = -90.0)));
    .Modelica.Blocks.Math.Feedback feedbackBypass annotation(Placement(transformation(extent = {{-65.04635911183502,39.04635911183502},{-50.95364088816498,24.953640888164983}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Hysteresis hystBypassHea(uHigh = -0.5,uLow = -2) annotation(Placement(transformation(extent = {{-42.99864864860085,25.00135135139915},{-29.00135135139915,38.99864864860085}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Not not2 annotation(Placement(transformation(extent = {{-24.328119962892032,29.671880037107968},{-15.671880037107968,38.32811996289203}},origin = {0.0,0.0},rotation = 0.0)));
    .Modelica.Blocks.Logical.Hysteresis hystBypassCoo(uLow = 0.5,uHigh = 2) annotation(Placement(transformation(extent = {{-42.99864864860085,83.00135135139915},{-29.00135135139915,96.99864864860085}},origin = {0.0,0.0},rotation = 0.0)));
equation
    connect(pidAhuHea.u_s,TSupAhuSet) annotation(Line(points = {{-46.67474745448122,-26.44444444444445},{-73.67070706057396,-26.44444444444445},{-73.67070706057396,-16.77777777777778},{-100.66666666666669,-16.77777777777778}},color = {0,0,127}));
    connect(pidAhuCoo.u_s,TSupAhuSet) annotation(Line(points = {{-45.71992298478137,-56},{-73.52662815905737,-56},{-73.52662815905737,-16.77777777777778},{-100.66666666666669,-16.77777777777778}},color = {0,0,127}));
    connect(pidAhuHea.u_m,TSupAhu) annotation(Line(points = {{-38.666666666666686,-34.452525232258985},{-38.666666666666686,-42.777777777777786},{-60.666666666666686,-42.777777777777786},{-60.666666666666686,-80.77777777777779},{-100.66666666666669,-80.77777777777779}},color = {0,0,127}));
    connect(pidAhuCoo.u_m,TSupAhu) annotation(Line(points = {{-38,-63.71992298478137},{-38,-80.77777777777779},{-100.66666666666669,-80.77777777777779}},color = {0,0,127}));
    connect(TSupAhuSet,greaterSet.u2) annotation(Line(points = {{-100.66666666666667,-16.77777777777778},{-82,-16.77777777777778},{-82,53.635284959372655},{-45.54707256094102,53.635284959372655}},color = {0,0,127}));
    connect(greaterSet.u1,TInAhu) annotation(Line(points = {{-45.54707256094102,60},{-74,60},{-74,80.24444444444444},{-100.53333333333333,80.24444444444444}},color = {0,0,127}));
    connect(TInAhu,lessSet.u1) annotation(Line(points = {{-100.53333333333333,80.24444444444444},{-74,80.24444444444444},{-74,6},{-45.68221109071062,6}},color = {0,0,127}));
    connect(TSupAhuSet,lessSet.u2) annotation(Line(points = {{-100.66666666666667,-16.77777777777778},{-82,-16.77777777777778},{-82,-0.45480739380707824},{-45.68221109071062,-0.45480739380707824}},color = {0,0,127}));
    connect(greaterSet.y,andRecCoo.u2) annotation(Line(points = {{-27.2485168191374,60},{-18,60},{-18,66.35260468256008},{-8.471092976159875,66.35260468256008}},color = {255,0,255}));
    connect(lessSet.y,andRecHea.u2) annotation(Line(points = {{-27.124639833515268,6},{-17.79786640483757,6},{-17.79786640483757,12.35260468256008},{-8.471092976159873,12.35260468256008}},color = {255,0,255}));
    connect(andRecCoo.y,byPass.u1) annotation(Line(points = {{7.765168561479886,72},{16.88258428073994,72},{16.88258428073994,46},{26,46}},color = {255,0,255}));
    connect(andRecHea.y,byPass.u2) annotation(Line(points = {{7.765168561479884,18},{18,18},{18,38},{26,38}},color = {255,0,255}));
    connect(TSupAhuSet,feedback.u2) annotation(Line(points = {{-100.66666666666667,-16.77777777777778},{-82,-16.77777777777778},{-82,-40.36291271053199}},color = {0,0,127}));
    connect(feedback.u1,TSupAhu) annotation(Line(points = {{-87.63708728946801,-46},{-94.15187697806735,-46},{-94.15187697806735,-80.7777777777778},{-100.66666666666667,-80.7777777777778}},color = {0,0,127}));
    connect(feedback.y,hystCoo.u) annotation(Line(points = {{-75.65827679934849,-46},{-75.65827679934849,-74},{-20.398378378321013,-74}},color = {0,0,127}));
    connect(proCoo.u1,pidAhuCoo.y) annotation(Line(points = {{42.364459209260986,-66.18222960463049},{28,-66.18222960463049},{28,-56},{-30.923403930617077,-56}},color = {0,0,127}));
    connect(booToReaCoo.u,hystCoo.y) annotation(Line(points = {{7.1592452677785055,-74},{-4.30148648653907,-74}},color = {255,0,255}));
    connect(booToReaCoo.y,proCoo.u2) annotation(Line(points = {{20.270691837869705,-74},{31.317575523565345,-74},{31.317575523565345,-73.81777039536951},{42.364459209260986,-73.81777039536951}},color = {0,0,127}));
    connect(proCoo.y,valPosAhuCoo) annotation(Line(points = {{56.9992457248441,-70},{83.16628952908871,-70},{83.16628952908871,-56.7777777777778},{109.33333333333333,-56.7777777777778}},color = {0,0,127}));
    connect(not1.u,hystHea.y) annotation(Line(points = {{4.806256044529562,-46},{-4.30148648653907,-46}},color = {255,0,255}));
    connect(booToReaHea.y,proHea.u2) annotation(Line(points = {{34.270691837869705,-46},{47.317575523565345,-46},{47.317575523565345,-41.81777039536951},{60.36445920926097,-41.81777039536951}},color = {0,0,127}));
    connect(valPosAhuHea,proHea.y) annotation(Line(points = {{109.33333333333333,-26.444444444444436},{90.16628952908871,-26.444444444444436},{90.16628952908871,-38},{74.99924572484412,-38}},color = {0,0,127}));
    connect(booToReaHea.u,not1.y) annotation(Line(points = {{21.159245267778505,-46},{14.760931959181235,-46}},color = {255,0,255}));
    connect(proHea.u1,pidAhuHea.y) annotation(Line(points = {{60.36445920926097,-34.18222960463049},{14.519266632378812,-34.18222960463049},{14.519266632378812,-26.444444444444436},{-31.325925944503346,-26.444444444444436}},color = {0,0,127}));
    connect(hystHea.u,feedback.y) annotation(Line(points = {{-20.398378378321013,-46},{-75.65827679934849,-46}},color = {0,0,127}));
    connect(greaterThreshold.u,prfAhu) annotation(Line(points = {{-71.87583627311886,-36},{-100,-36}},color = {0,0,127}));
    connect(orOveWrite.y,valPosRec) annotation(Line(points = {{81,54},{95.5,54},{95.5,80},{110,80}},color = {255,0,255}));
    connect(orOveWrite.u2,byPass.y) annotation(Line(points = {{58,46},{49,46}},color = {255,0,255}));
    connect(orOveWrite.u1,oveByPass) annotation(Line(points = {{58,54},{50,54},{50,100}},color = {255,0,255}));
    connect(TInAhu,feedbackBypass.u1) annotation(Line(points = {{-100.53333333333333,80.24444444444444},{-86,80.24444444444444},{-86,32},{-63.63708728946801,32}},color = {0,0,127}));
    connect(TRetAhu,feedbackBypass.u2) annotation(Line(points = {{-100,40},{-58,40},{-58,37.63708728946801}},color = {0,0,127}));
    connect(not2.u,hystBypassHea.y) annotation(Line(points = {{-25.19374395547044,34},{-28.301486486539062,34},{-28.301486486539062,32}},color = {255,0,255}));
    connect(andRecHea.u1,not2.y) annotation(Line(points = {{-8.471092976159873,18},{-11.85508050848932,18},{-11.85508050848932,34},{-15.239068040818765,34}},color = {255,0,255}));
    connect(feedbackBypass.y,hystBypassHea.u) annotation(Line(points = {{-51.658276799348485,32},{-44.39837837832102,32}},color = {0,0,127}));
    connect(hystBypassCoo.y,andRecCoo.u1) annotation(Line(points = {{-28.301486486539066,90},{-18.38628973134947,90},{-18.38628973134947,72},{-8.471092976159873,72}},color = {255,0,255}));
    connect(feedbackBypass.y,hystBypassCoo.u) annotation(Line(points = {{-51.658276799348485,32},{-51.658276799348485,90},{-44.39837837832102,90}},color = {0,0,127}));
  connect(not1.y, pidAhuHea.trigger) annotation (Line(points={{14.7609,-46},{18,
          -46},{18,-36},{-28,-36},{-28,-38},{-44.0054,-38},{-44.0054,-34.4525}},
        color={255,0,255}));
  connect(hystCoo.y, pidAhuCoo.trigger) annotation (Line(points={{-4.30149,-74},
          {-4,-74},{-4,-84},{-42,-84},{-42,-68},{-43.1466,-68},{-43.1466,
          -63.7199}}, color={255,0,255}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics={Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="%name"),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString="",origin={214,2}),Ellipse(origin={-56,86},extent={{-10,10},{10,-10}}),Ellipse(origin={-16,16},extent={{-10,10},{10,-10}}),Ellipse(origin={24,66},extent={{-10,10},{10,-10}}),Ellipse(origin={64,-14},extent={{-10,10},{10,-10}}),Line(origin={-56,-2},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Line(origin={-16,-2},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Line(origin={24,-2},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Line(origin={64,0},points={{0.00012126970964487782,90.08584540026541},{-0.00012126970964487782,-90.08584540026541}}),Rectangle(extent={{-100,100},{100,-100}})}), uses(
        Modelica(version="4.0.0")));
end AhuInternalControl;
