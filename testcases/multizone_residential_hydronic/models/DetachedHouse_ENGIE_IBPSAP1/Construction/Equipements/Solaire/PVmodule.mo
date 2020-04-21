within DetachedHouse_ENGIE_IBPSAP1.Construction.Equipements.Solaire;
model PVmodule

parameter Integer Ns = 100 "Nombre de modules en série";
parameter Integer Np = 100 "Nombre de modules en parallèle";
parameter Modelica.SIunits.Area S = 2*1 "Surface d'un module";
parameter Modelica.SIunits.Area S_ref = 1 "Surface d'un module";
parameter Real gamma(unit="1/K") = 0.004 "Coefficient de correction de température";

// Paramètres en conditions standard de test (STC)
parameter Modelica.SIunits.Power P_STC = 245 "Puissance crête du module"
annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(group="Standard Tests Conditions"));
parameter Modelica.SIunits.Irradiance E_STC = 1000 "Irradiation solaire"
annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(group="Standard Tests Conditions"));
 parameter Modelica.SIunits.Temperature Tcell_STC = 25+273.15 "Température des PV"
annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(group="Standard Tests Conditions"));

// Paramètres en conditions de température des PV nominale (NOCT)
parameter Modelica.SIunits.Irradiance E_NOCT = 800 "Irradiation solaire"
 annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(group="Nominal Cell Temperature Conditions"));
parameter Modelica.SIunits.Temperature Tcell_NOCT = 46+273.15 "Température des PV"
annotation(Evaluate=true,choices(__Dymola_checkBox=true), Dialog(group="Nominal Cell Temperature Conditions"));
parameter Modelica.SIunits.Temperature Tamb_NOCT = 20+273.15 "Température ambiante"
annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(group="Nominal Cell Temperature Conditions"));

Modelica.SIunits.Temperature Tamb_moyen;

   Modelica.Blocks.Interfaces.RealInput Tamb "Température ambiante"
   annotation (Placement(transformation(extent={{-123,10},{-77,56}}),
        iconTransformation(extent={{-140,26},{-100,66}})));
   Modelica.Blocks.Interfaces.RealInput E "Irradiation solaire"
   annotation (Placement(transformation(extent={{-124,-44},{-76,4}}),
        iconTransformation(extent={{-140,-72},{-100,-32}})));
   Modelica.Blocks.Interfaces.RealOutput Pmpp "Point de puissance maximale"
     annotation (Placement(transformation(extent={{100,6},{158,64}}),
        iconTransformation(extent={{100,20},{158,78}})));
  Modelica.Blocks.Interfaces.RealOutput Tcell "Température des PV"
   annotation (
     Placement(transformation(extent={{100,-64},{160,-4}}), iconTransformation(
          extent={{100,-78},{158,-20}})));

equation
  Tamb_moyen = Tamb;
  Tcell = Tamb_moyen +(E/E_NOCT)*(Tcell_NOCT-Tamb_NOCT);
  Pmpp = (P_STC*E/E_STC)*Ns*Np*S/S_ref*(1-gamma*(Tcell-Tcell_STC));

annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true), Dialog(group="Standard Tests Conditions"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end PVmodule;
