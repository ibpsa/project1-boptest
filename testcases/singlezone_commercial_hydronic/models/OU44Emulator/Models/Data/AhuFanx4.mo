within OU44Emulator.Models.Data;
record AhuFanx4
  "Oversized fan to be used in AHU representing 4 actual AHUs"
  extends Buildings.Fluid.Movers.Data.Generic(
      use_powerCharacteristic=true,
      speed_rpm_nominal=600,
      pressure(V_flow={16,25,35}, dp={800,680,100}),
      power(V_flow={16,25,35}, P={18000,25000,30000}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AhuFanx4;
