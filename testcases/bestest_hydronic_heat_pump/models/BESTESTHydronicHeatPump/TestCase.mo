within BESTESTHydronicHeatPump;
model TestCase "This model just extends the test case model from IDEAS library"
  extends IDEAS.Examples.IBPSA.SingleZoneResidentialHydronicHeatPump(
    ovePum(CAT=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForActuatorTravel.Pump, actuator
        ="pump1"),
    oveHeaPumY(CAT=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForActuatorTravel.HVACEquipment, actuator
        ="heatpump1"),
    oveFan(CAT=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForActuatorTravel.Fan, actuator
        ="fan1"));

end TestCase;
