within IDEAS.Buildings.Components.Examples.BaseClasses;
model Window
  "Window with pre-filled in parameters"
  extends .IDEAS.Buildings.Components.Window(
    redeclare IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazing,
    A=12,
    frac=0,
    redeclare IDEAS.Buildings.Components.Shading.None shaType,
    redeclare IDEAS.Buildings.Data.Frames.None fraType);
end Window;
