within OU44Emulator.Models.Data;
record AhuFan
  "Fan based on NK08 from NK Industri A/S (power slightly calibtrated based on measurements)"
  extends Buildings.Fluid.Movers.Data.Generic(
      use_powerCharacteristic=true,
      speed_rpm_nominal=600,
      pressure(V_flow={4,6,9}, dp={380,340,80}),
      power(V_flow={4,6,9}, P={3,5,7}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AhuFan;
