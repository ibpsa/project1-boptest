within IDEAS.Experimental.Electric.Connections;
model HouseConnector
  "Makes the connections from the in-home connection to the grid, standard 16mm2 Alu.Still needs testing!!"
  extends Modelica.Icons.UnderConstruction;

  parameter Boolean singlePhaseGrid=true
    "Is it a single phase equivalent grid, or 3 phase grid" annotation (choices(
      choice=true "Single Phase",
      choice=false "3 Phase",
      __Dymola_radioButtons=true));
  parameter Integer connectedPhase=1
    "indicates if the connection is truly single phase or it just simulates a symmetrical 3 phase connection / Can I make these conditional?"
    annotation (choices(
      choice=0 "Single phase equivalent",
      choice=1 "Single Phase connection to phase 1",
      choice=2 "Single Phase connection to phase 2",
      choice=3 "Single Phase connection to phase 3",
      choice=4 "3 Phase connection",
      __Dymola_radioButtons=true));

  replaceable parameter IDEAS.Experimental.Electric.Data.Interfaces.Cable typHouBran=
      Data.Cables.PvcAl16() "Cable type used for the connection to the house";

  parameter Modelica.SIunits.Length lenHouBran=10
    "Length of the cable of the connection to the house";

  /***This creates the branches. TODO:adjust mulfac to cope with single phase connections and single phase equivalent 3 phase connections,
for 3 phase connections it can stay at default(1)
Maybe also make sure unused cables have very high impedance so errors will show in results***/
  IDEAS.Experimental.Electric.Distribution.BaseClasses.BranchLenTyp[numBran] branch(
    each len=lenHouBran,
    each typ=typHouBran,
    each mulFac=mulFacZ);

  /**This creates the Nodes for the gridconnection and the houseconnection**/
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin[
    numPhaGriCon] griCon
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin[
    numPhaHouCon] houCon annotation (
    Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(
          extent={{90,-10},{110,10}})),
    Icon(graphics),
    Diagram(graphics));
  /**This should input a multiplication factor for the houseconnection.
  The multiplication factor should always be 1/3 in case of a single phase equivalent grid.
  Single phase equivalent connections are not allowed when not using a single phase equivalent grid!!
  A single phase connection with a 3 phase grid will give a multiplication factor of 1 on the connected phase and the Neutral (phase 4)
  and very large multiplication on the others
  A 3 phase connection to a 3 phase grid gives a multiplication factor of 1 on all phases**/

  /***The Losses in the houseconnection***/
  Modelica.SIunits.ActivePower PLosHouCon;

protected
  parameter Integer numPhaGriCon=if singlePhaseGrid then 1 else (if
      connectedPhase == 4 then 4 else 3);
  parameter Integer numPhaHouCon=if connectedPhase == 4 then 3 else 1;
  parameter Integer numBran=if connectedPhase == 4 then 4 else 1;
  parameter Real mulFacZ=if connectedPhase == 0 then 1/3 else (if
      connectedPhase == 4 then 1 else 2);

equation
  for p in 1:numPhaHouCon loop
    connect(branch[p].pin_p, griCon[p]);
    connect(branch[p].pin_n, houCon[p]);
  end for;

  PLosHouCon = sum(branch[:].Plos);

  annotation (Diagram(graphics), Icon(graphics={Bitmap(extent={{-100,100},{102,
              -100}}, fileName="modelica://IDEAS/Electric/HouseCon.jpg")}));
end HouseConnector;
