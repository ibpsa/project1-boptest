within IDEAS.LIDEAS.Components;
model LinearisationInterface
  "Extend this interface if you want to linearise a model"
protected
  inner input IDEAS.Buildings.Components.Interfaces.WindowBus[sim.nWindow]
    winBusIn(each nLay=sim.nLayWin) if sim.linearise;
public
  input IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(
    outputAngles=sim.outputAngles,
    final numSolBus=sim.numIncAndAziInBus) if sim.linearise;
  output IDEAS.Buildings.Components.Interfaces.WindowBus[sim.nWindow]
     winBusOut(each nLay=sim.nLayWin) if sim.createOutputs
    "Dummy for getting outputs";
  output IDEAS.Buildings.Components.Interfaces.WeaBus weaBusOut(
    outputAngles=sim.outputAngles,
   final numSolBus=sim.numIncAndAziInBus) if sim.createOutputs;
public
  inner replaceable
        IDEAS.BoundaryConditions.SimInfoManager sim(lineariseDymola=true, createOutputs=false)
    constrainedby IDEAS.BoundaryConditions.SimInfoManager
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
equation
  connect(sim.weaBus, weaBusOut);
  connect(sim.winBusOut,winBusOut);
  connect(weaBus,sim.weaBus);
end LinearisationInterface;
