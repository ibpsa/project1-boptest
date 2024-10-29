model TestCase "This model just extends the test case model from IDEAS library"
  extends IDEAS.Examples.IBPSA.SingleZoneResidentialHydronicHeatPump(
    ovePum(CAT=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForActuatorTravel.Pump),
    oveHeaPumY(CAT=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForActuatorTravel.HVACEquipment),
    oveFan(CAT=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForActuatorTravel.Fan));

end TestCase;
