within IDEAS.Buildings.Validation;
model BESTEST
  extends Modelica.Icons.Example;

  //conversion factors for convertion Joule/Watt into MWh/kW
  constant Real MWh = 1/3600000000.0;
  constant Real kW = 1/1000;

  //variables for annual heating/cooling load (energy)
  Modelica.SIunits.Energy EAnnHea600[6];
  Modelica.SIunits.Energy EAnnCoo600[6];
  Modelica.SIunits.Energy EAnnHea900[6];
  Modelica.SIunits.Energy EAnnCoo900[6];

  //intermediate variables for computing average hourly cooling/heating load (power)
  Modelica.SIunits.Energy EHouHea600[6];
  Modelica.SIunits.Energy EHouCoo600[6];
  Modelica.SIunits.Energy EHouHea900[6];
  Modelica.SIunits.Energy EHouCoo900[6];

  //variables for storing peak hourly cooling/heating load (power)
  discrete Modelica.SIunits.Power QPeaHea600[6];
  discrete Modelica.SIunits.Power QPeaCoo600[6];
  discrete Modelica.SIunits.Power QPeaHea900[6];
  discrete Modelica.SIunits.Power QPeaCoo900[6];

  Real TAnnAvg[4];
  Real THouAvg[4];

  //variables for storing peak temperatures in free floating cases
  discrete Modelica.SIunits.Temperature Tmax[4];
  discrete Modelica.SIunits.Temperature Tmin[4];

  // BESTEST cases
  IDEAS.Buildings.Validation.Cases.Case600 Case600
    annotation (Placement(transformation(extent={{-76,44},{-64,56}})));
  IDEAS.Buildings.Validation.Cases.Case600FF Case600FF
    annotation (Placement(transformation(extent={{-56,44},{-44,56}})));
  IDEAS.Buildings.Validation.Cases.Case610 Case610
    annotation (Placement(transformation(extent={{-36,44},{-24,56}})));
  IDEAS.Buildings.Validation.Cases.Case620 Case620
    annotation (Placement(transformation(extent={{-16,44},{-4,56}})));
  IDEAS.Buildings.Validation.Cases.Case630 Case630
    annotation (Placement(transformation(extent={{4,44},{16,56}})));
  IDEAS.Buildings.Validation.Cases.Case640 Case640
    annotation (Placement(transformation(extent={{24,44},{36,56}})));
  IDEAS.Buildings.Validation.Cases.Case650 Case650
    annotation (Placement(transformation(extent={{44,44},{56,56}})));
  IDEAS.Buildings.Validation.Cases.Case650FF Case650FF
    annotation (Placement(transformation(extent={{64,44},{76,56}})));
  IDEAS.Buildings.Validation.Cases.Case900 Case900
    annotation (Placement(transformation(extent={{-76,4},{-64,16}})));
  IDEAS.Buildings.Validation.Cases.Case900FF Case900FF
    annotation (Placement(transformation(extent={{-56,4},{-44,16}})));
  IDEAS.Buildings.Validation.Cases.Case910 Case910
    annotation (Placement(transformation(extent={{-36,4},{-24,16}})));
  IDEAS.Buildings.Validation.Cases.Case920 Case920
    annotation (Placement(transformation(extent={{-16,4},{-4,16}})));
  IDEAS.Buildings.Validation.Cases.Case930 Case930
    annotation (Placement(transformation(extent={{4,4},{16,16}})));
  IDEAS.Buildings.Validation.Cases.Case940 Case940
    annotation (Placement(transformation(extent={{24,4},{36,16}})));
  IDEAS.Buildings.Validation.Cases.Case950 Case950
    annotation (Placement(transformation(extent={{44,4},{56,16}})));
  IDEAS.Buildings.Validation.Cases.Case950FF Case950FF
    annotation (Placement(transformation(extent={{64,4},{76,16}})));


  inner BaseClasses.SimInfoManagerBestest sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
initial equation
  EAnnHea600 =  zeros(6);
  EAnnCoo600 =  zeros(6);
  EAnnHea900 =  zeros(6);
  EAnnCoo900 =  zeros(6);
  EHouHea600 =  zeros(6);
  EHouCoo600 =  zeros(6);
  EHouHea900 =  zeros(6);
  EHouCoo900 =  zeros(6);
  QPeaHea600 =  zeros(6);
  QPeaCoo600 =  zeros(6);
  QPeaHea900 =  zeros(6);
  QPeaCoo900 =  zeros(6);

  Tmax=fill(21,4);
  Tmax=fill(21,4);

equation
  der(EAnnHea600[1]) = max(0,-Case600.PHea)*MWh;
  der(EAnnHea600[2]) = max(0,-Case610.PHea)*MWh;
  der(EAnnHea600[3]) = max(0,-Case620.PHea)*MWh;
  der(EAnnHea600[4]) = max(0,-Case630.PHea)*MWh;
  der(EAnnHea600[5]) = max(0,-Case640.PHea)*MWh;
  der(EAnnHea600[6]) = max(0,-Case650.PHea)*MWh;
  der(EHouHea600[1]) = max(0,-Case600.PHea);
  der(EHouHea600[2]) = max(0,-Case610.PHea);
  der(EHouHea600[3]) = max(0,-Case620.PHea);
  der(EHouHea600[4]) = max(0,-Case630.PHea);
  der(EHouHea600[5]) = max(0,-Case640.PHea);
  der(EHouHea600[6]) = max(0,-Case650.PHea);
  der(EAnnCoo600[1]) = max(0,Case600.PCoo)*MWh;
  der(EAnnCoo600[2]) = max(0,Case610.PCoo)*MWh;
  der(EAnnCoo600[3]) = max(0,Case620.PCoo)*MWh;
  der(EAnnCoo600[4]) = max(0,Case630.PCoo)*MWh;
  der(EAnnCoo600[5]) = max(0,Case640.PCoo)*MWh;
  der(EAnnCoo600[6]) = max(0,Case650.PCoo)*MWh;
  der(EHouCoo600[1]) = max(0,Case600.PCoo);
  der(EHouCoo600[2]) = max(0,Case610.PCoo);
  der(EHouCoo600[3]) = max(0,Case620.PCoo);
  der(EHouCoo600[4]) = max(0,Case630.PCoo);
  der(EHouCoo600[5]) = max(0,Case640.PCoo);
  der(EHouCoo600[6]) = max(0,Case650.PCoo);
  der(EAnnHea900[1]) = max(0,-Case900.PHea)*MWh;
  der(EAnnHea900[2]) = max(0,-Case910.PHea)*MWh;
  der(EAnnHea900[3]) = max(0,-Case920.PHea)*MWh;
  der(EAnnHea900[4]) = max(0,-Case930.PHea)*MWh;
  der(EAnnHea900[5]) = max(0,-Case940.PHea)*MWh;
  der(EAnnHea900[6]) = max(0,-Case950.PHea)*MWh;
  der(EHouHea900[1]) = max(0,-Case900.PHea);
  der(EHouHea900[2]) = max(0,-Case910.PHea);
  der(EHouHea900[3]) = max(0,-Case920.PHea);
  der(EHouHea900[4]) = max(0,-Case930.PHea);
  der(EHouHea900[5]) = max(0,-Case940.PHea);
  der(EHouHea900[6]) = max(0,-Case950.PHea);
  der(EAnnCoo900[1]) = max(0,Case900.PCoo)*MWh;
  der(EAnnCoo900[2]) = max(0,Case910.PCoo)*MWh;
  der(EAnnCoo900[3]) = max(0,Case920.PCoo)*MWh;
  der(EAnnCoo900[4]) = max(0,Case930.PCoo)*MWh;
  der(EAnnCoo900[5]) = max(0,Case940.PCoo)*MWh;
  der(EAnnCoo900[6]) = max(0,Case950.PCoo)*MWh;
  der(EHouCoo900[1]) = max(0,Case900.PCoo);
  der(EHouCoo900[2]) = max(0,Case910.PCoo);
  der(EHouCoo900[3]) = max(0,Case920.PCoo);
  der(EHouCoo900[4]) = max(0,Case930.PCoo);
  der(EHouCoo900[5]) = max(0,Case940.PCoo);
  der(EHouCoo900[6]) = max(0,Case950.PCoo);

  der(THouAvg) = {Case600FF.TAir, Case650FF.TAir, Case900FF.TAir, Case950FF.TAir};
  der(TAnnAvg) = {Case600FF.TAir/3600/24/365, Case650FF.TAir/3600/24/365, Case900FF.TAir/3600/24/365, Case950FF.TAir/3600/24/365};

  when sample(3600,3600) then
    // reinitialise integrators that are used for computing mean hourly cooling/heating/temperature
    reinit(EHouHea600,zeros(6));
    reinit(EHouCoo600,zeros(6));
    reinit(EHouHea900,zeros(6));
    reinit(EHouCoo900,zeros(6));
    reinit(THouAvg,zeros(4));

    // store peak cooling and heating loads when previous maximum was exceeded
    QPeaHea600[1] = max(pre(QPeaHea600[1]),pre(EHouHea600[1])/3600*kW);
    QPeaHea600[2] = max(pre(QPeaHea600[2]),pre(EHouHea600[2])/3600*kW);
    QPeaHea600[3] = max(pre(QPeaHea600[3]),pre(EHouHea600[3])/3600*kW);
    QPeaHea600[4] = max(pre(QPeaHea600[4]),pre(EHouHea600[4])/3600*kW);
    QPeaHea600[5] = max(pre(QPeaHea600[5]),pre(EHouHea600[5])/3600*kW);
    QPeaHea600[6] = max(pre(QPeaHea600[6]),pre(EHouHea600[6])/3600*kW);
    QPeaCoo600[1] = max(pre(QPeaCoo600[1]),pre(EHouCoo600[1])/3600*kW);
    QPeaCoo600[2] = max(pre(QPeaCoo600[2]),pre(EHouCoo600[2])/3600*kW);
    QPeaCoo600[3] = max(pre(QPeaCoo600[3]),pre(EHouCoo600[3])/3600*kW);
    QPeaCoo600[4] = max(pre(QPeaCoo600[4]),pre(EHouCoo600[4])/3600*kW);
    QPeaCoo600[5] = max(pre(QPeaCoo600[5]),pre(EHouCoo600[5])/3600*kW);
    QPeaCoo600[6] = max(pre(QPeaCoo600[6]),pre(EHouCoo600[6])/3600*kW);
    QPeaHea900[1] = max(pre(QPeaHea900[1]),pre(EHouHea900[1])/3600*kW);
    QPeaHea900[2] = max(pre(QPeaHea900[2]),pre(EHouHea900[2])/3600*kW);
    QPeaHea900[3] = max(pre(QPeaHea900[3]),pre(EHouHea900[3])/3600*kW);
    QPeaHea900[4] = max(pre(QPeaHea900[4]),pre(EHouHea900[4])/3600*kW);
    QPeaHea900[5] = max(pre(QPeaHea900[5]),pre(EHouHea900[5])/3600*kW);
    QPeaHea900[6] = max(pre(QPeaHea900[6]),pre(EHouHea900[6])/3600*kW);
    QPeaCoo900[1] = max(pre(QPeaCoo900[1]),pre(EHouCoo900[1])/3600*kW);
    QPeaCoo900[2] = max(pre(QPeaCoo900[2]),pre(EHouCoo900[2])/3600*kW);
    QPeaCoo900[3] = max(pre(QPeaCoo900[3]),pre(EHouCoo900[3])/3600*kW);
    QPeaCoo900[4] = max(pre(QPeaCoo900[4]),pre(EHouCoo900[4])/3600*kW);
    QPeaCoo900[5] = max(pre(QPeaCoo900[5]),pre(EHouCoo900[5])/3600*kW);
    QPeaCoo900[6] = max(pre(QPeaCoo900[6]),pre(EHouCoo900[6])/3600*kW);


    // store peak temperatures when previous maximum was exceeded
    Tmax[1]=max(pre(Tmax[1]), THouAvg[1]/3600);
    Tmax[2]=max(pre(Tmax[2]), THouAvg[2]/3600);
    Tmax[3]=max(pre(Tmax[3]), THouAvg[3]/3600);
    Tmax[4]=max(pre(Tmax[4]), THouAvg[4]/3600);

    Tmin[1]=min(pre(Tmin[1]), THouAvg[1]/3600);
    Tmin[2]=min(pre(Tmin[2]), THouAvg[2]/3600);
    Tmin[3]=min(pre(Tmin[3]), THouAvg[3]/3600);
    Tmin[4]=min(pre(Tmin[4]), THouAvg[4]/3600);
  end when;

  annotation (
    experiment(
      StopTime=3.1536e+07,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput(events=false),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-78,68},{-40,60}},
          lineColor={85,0,0},
          fontName="Calibri",
          textStyle={TextStyle.Bold},
          textString="BESTEST 600 Series"),Text(
          extent={{-78,28},{-40,20}},
          lineColor={85,0,0},
          fontName="Calibri",
          textStyle={TextStyle.Bold},
          textString="BESTEST 900 Series")}),
    Documentation(info="<html>
<p>
BESTEST implementation of IDEAS. 
This model generates the results in the figures below, which has last been updated on December 16, 2019 for IDEAS 2.1. 
Reference results are from the 
<a href=https://energyplus.net/sites/all/modules/custom/nrel_custom/eplus_files/current_testing_reports/ASHRAE140-Envelope-8.3.0-b45b06b780.pdf>
EnergyPlus website</a>.
</p>
<p>
Series 600, series 900 and free float normalised results:<br/>
<img alt=\"results\" src=\"modelica://IDEAS/Resources/Images/BESTEST/bestest.png\"/>
</p>
<p>
E<sub>H</sub> and E<sub>C</sub> indicate normalised total yearly energy use for heating and cooling. 
P<sub>H</sub> and P<sub>C</sub> indicate normalised peak average hourly energy use for heating and cooling.
For free float cases, normalised minimum, average and maximum temperatures are reported.
</p>
</html>", revisions="<html>
<ul>
<li>
December 16, 2019 by Filip Jorissen:<br/>
Updated results after having updated convection implementation
<a href=\"https://github.com/open-ideas/IDEAS/issues/1099\">#1099</a>.
</li>
<li>
June 7, 2018 by Filip Jorissen:<br/>
Revised implementation using dedicated SimInfoManger for 
<a href=\"https://github.com/open-ideas/IDEAS/issues/838\">#838</a>.
</li>
<li>
March 30, 2017 by Filip Jorissen:<br/>
Revised figure and documentation.
</li>
<li>
July 25, 2016 by Filip Jorissen:<br/>
Revised implementation.
</li>
</ul>
</html>"));
end BESTEST;
