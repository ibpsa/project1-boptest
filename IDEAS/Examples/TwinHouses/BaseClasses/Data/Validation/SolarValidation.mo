within IDEAS.Examples.TwinHouses.BaseClasses.Data.Validation;
model SolarValidation
  extends Modelica.Icons.Example;
  ValidationDataN2Exp1 validationDataN2Exp1
    "Measurement data for validation purposes"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  IDEAS.Examples.TwinHouses.BaseClasses.TwinHouseInfoManager sim(
    exp=1,
    bui=1,
    radSol(each rho=0.23))
           "Sim info manager"
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Buildings.Components.Interfaces.WeaBus weaBus1(numSolBus=6)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Math.Add3 HGloHor
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Math.Add3 HGloS
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Blocks.Math.Add3 HGloW
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Math.Add3 HGloN
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Math.Add3 HGloE
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Sources.RealExpression errHEast(y=abs(HGloE.y - sim.radCon.HEast))
    "Error on HEast computation"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Sources.RealExpression errHSouth(y=abs(HGloS.y - sim.radCon.HSouth))
    "Error on HSouth computation"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Blocks.Sources.RealExpression errHWest(y=abs(HGloW.y - sim.radCon.HWest))
    "Error on HWest computation"
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Blocks.Continuous.Integrator errTot(k=1) "Total error"
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
equation
  connect(sim.weaBus, weaBus1) annotation (Line(
      points={{-61,93},{-40,93},{-40,92},{-40,10},{-30,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HGloHor.u1, weaBus1.solBus[1].HDirTil) annotation (Line(points={{-2,58},
          {-29.95,58},{-29.95,10.05}},color={0,0,127}));
  connect(HGloHor.u2, weaBus1.solBus[1].HSkyDifTil) annotation (Line(points={{-2,50},
          {-29.95,50},{-29.95,10.05}},color={0,0,127}));
  connect(HGloHor.u3, weaBus1.solBus[1].HGroDifTil) annotation (Line(points={{-2,42},
          {-29.95,42},{-29.95,10.05}},color={0,0,127}));
  connect(HGloS.u1, weaBus1.solBus[2].HDirTil) annotation (Line(points={{-2,38},
          {-29.95,38},{-29.95,10.05}},color={0,0,127}));
  connect(HGloS.u2, weaBus1.solBus[2].HSkyDifTil) annotation (Line(points={{-2,30},
          {-29.95,30},{-29.95,10.05}},color={0,0,127}));
  connect(HGloS.u3, weaBus1.solBus[2].HGroDifTil) annotation (Line(points={{-2,22},
          {-29.95,22},{-29.95,10.05}},color={0,0,127}));
  connect(HGloW.u1, weaBus1.solBus[3].HDirTil) annotation (Line(points={{-2,18},
          {-29.95,18},{-29.95,10.05}},color={0,0,127}));
  connect(HGloW.u2, weaBus1.solBus[3].HSkyDifTil) annotation (Line(points={{-2,10},
          {-29.95,10},{-29.95,10.05}},color={0,0,127}));
  connect(HGloW.u3, weaBus1.solBus[3].HGroDifTil) annotation (Line(points={{-2,2},{
          -29.95,2},{-29.95,10.05}},  color={0,0,127}));
  connect(HGloN.u1, weaBus1.solBus[4].HDirTil) annotation (Line(points={{-2,-2},
          {-29.95,-2},{-29.95,10.05}},color={0,0,127}));
  connect(HGloN.u2, weaBus1.solBus[4].HSkyDifTil) annotation (Line(points={{-2,-10},
          {-29.95,-10},{-29.95,10.05}},
                                      color={0,0,127}));
  connect(HGloN.u3, weaBus1.solBus[4].HGroDifTil) annotation (Line(points={{-2,-18},
          {-29.95,-18},{-29.95,10.05}},
                                      color={0,0,127}));
  connect(HGloE.u1, weaBus1.solBus[5].HDirTil) annotation (Line(points={{-2,-22},
          {-29.95,-22},{-29.95,10.05}},
                                      color={0,0,127}));
  connect(HGloE.u2, weaBus1.solBus[5].HSkyDifTil) annotation (Line(points={{-2,-30},
          {-29.95,-30},{-29.95,10.05}},
                                      color={0,0,127}));
  connect(HGloE.u3, weaBus1.solBus[5].HGroDifTil) annotation (Line(points={{-2,-38},
          {-29.95,-38},{-29.95,10.05}},
                                      color={0,0,127}));


  connect(errHWest.y, add3_1.u3)
    annotation (Line(points={{1,-90},{18,-90},{18,-78}}, color={0,0,127}));
  connect(errHSouth.y, add3_1.u2)
    annotation (Line(points={{1,-70},{18,-70}}, color={0,0,127}));
  connect(add3_1.u1, errHEast.y)
    annotation (Line(points={{18,-62},{18,-50},{1,-50}}, color={0,0,127}));
  connect(errTot.u, add3_1.y)
    annotation (Line(points={{58,-70},{41,-70}}, color={0,0,127}));
    annotation (experiment(
      StartTime=20000000,
      StopTime=23587200,
      Interval=600,
      Tolerance=1e-06),
                     __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Examples/TwinHouses/BaseClasses/Data/Validation/SolarValidation.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
October 10, 2019, by Filip Jorissen:<br/>
Extended implementation such that it computes total errors.
</li>
</ul>
</html>"));
end SolarValidation;
