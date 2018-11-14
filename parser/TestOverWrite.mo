within ;
package TestOverWrite "Test package for overwrite block"
  block Overwrite "Block that allows a signal to be overwritten"
    extends Modelica.Blocks.Interfaces.SISO;

    Modelica.Blocks.Logical.Switch swi
      "Switch between external signal and direct feedthrough signal"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.RealExpression uExt "External input signal"
      annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
    Modelica.Blocks.Sources.BooleanExpression activate
      "Block to activate use of external signal"
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  protected
    parameter Boolean is_overwrite = true "Protected parameter indicating signal overwrite block";
  equation
    connect(activate.y, swi.u2)
      annotation (Line(points={{-39,0},{-12,0}}, color={255,0,255}));
    connect(swi.u3, u) annotation (Line(points={{-12,-8},{-80,-8},{-80,0},{-120,
            0}}, color={0,0,127}));
    connect(uExt.y, swi.u1) annotation (Line(points={{-39,20},{-26,20},{-26,8},
            {-12,8}}, color={0,0,127}));
    connect(swi.y, y)
      annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
    annotation (Icon(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={255,170,170},
            fillPattern=FillPattern.Solid)}));
  end Overwrite;

  model OriginalModel "Original model"

    Modelica.Blocks.Sources.Constant TSet(k=1) "Set point"
      annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
    Modelica.Blocks.Continuous.LimPID conPI(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=10) "Controller"
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Blocks.Continuous.FirstOrder firOrd(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput)
      "First order element"
      annotation (Placement(transformation(extent={{50,20},{70,40}})));
    Overwrite oveWriSet "Overwrite block for setpoint"
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Overwrite oveWriAct "Overwrite block for actuator signal"
      annotation (Placement(transformation(extent={{20,20},{40,40}})));
    Read rea "Measured state variable"
      annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
  equation
    connect(TSet.y, oveWriSet.u)
      annotation (Line(points={{-49,30},{-42,30}}, color={0,0,127}));
    connect(oveWriSet.y, conPI.u_s)
      annotation (Line(points={{-19,30},{-12,30}}, color={0,0,127}));
    connect(conPI.y, oveWriAct.u)
      annotation (Line(points={{11,30},{18,30}}, color={0,0,127}));
    connect(oveWriAct.y, firOrd.u)
      annotation (Line(points={{41,30},{48,30}}, color={0,0,127}));
    connect(firOrd.y, rea.u) annotation (Line(points={{71,30},{80,30},{80,-20},{52,
            -20}}, color={0,0,127}));
    connect(rea.y, conPI.u_m)
      annotation (Line(points={{29,-20},{0,-20},{0,18}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end OriginalModel;

  model ExportedModel "Model to be exported as an FMU"

    Modelica.Blocks.Interfaces.RealInput oveWriSet_u "Signal for overwrite block for set point"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.BooleanInput oveWriSet_activate "Activation for overwrite block for set point"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
    Modelica.Blocks.Interfaces.RealInput oveWriAct_u "Signal for overwrite block for actuator signal"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.BooleanInput oveWriAct_activate "Activation for overwrite block for actuator signal"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

    Modelica.Blocks.Interfaces.RealOutput rea = mod.rea.y
      "Measured state variable"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    OriginalModel mod(
       oveWriSet(
         uExt(
           y = oveWriSet_u),
         activate(
           y = oveWriSet_activate)),
       oveWriAct(
         uExt(
           y = oveWriAct_u),
         activate(
           y = oveWriAct_activate)))
       "Original model"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  end ExportedModel;

  model Read "Model that allows a signal to be read as an FMU output"
    extends Modelica.Blocks.Routing.RealPassThrough;
  protected
    parameter Boolean is_read = true "Protected parameter indicating signal read block";
    annotation (Icon(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid)}));
  end Read;

  model OriginalModelStacked "Original model with lower level model"

    Modelica.Blocks.Sources.Constant TSet(k=1) "Set point"
      annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
    Modelica.Blocks.Continuous.LimPID conPI(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=10) "Controller"
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Blocks.Continuous.FirstOrder firOrd(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput)
      "First order element"
      annotation (Placement(transformation(extent={{50,20},{70,40}})));
    Overwrite oveWriSet "Overwrite block for setpoint"
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Overwrite oveWriAct "Overwrite block for actuator signal"
      annotation (Placement(transformation(extent={{20,20},{40,40}})));
    Read rea "Measured state variable"
      annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
    OriginalModel lowLevMod
      annotation (Placement(transformation(extent={{-62,-46},{-42,-26}})));
  equation
    connect(TSet.y, oveWriSet.u)
      annotation (Line(points={{-49,30},{-42,30}}, color={0,0,127}));
    connect(oveWriSet.y, conPI.u_s)
      annotation (Line(points={{-19,30},{-12,30}}, color={0,0,127}));
    connect(conPI.y, oveWriAct.u)
      annotation (Line(points={{11,30},{18,30}}, color={0,0,127}));
    connect(oveWriAct.y, firOrd.u)
      annotation (Line(points={{41,30},{48,30}}, color={0,0,127}));
    connect(firOrd.y, rea.u) annotation (Line(points={{71,30},{80,30},{80,-20},{52,
            -20}}, color={0,0,127}));
    connect(rea.y, conPI.u_m)
      annotation (Line(points={{29,-20},{0,-20},{0,18}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end OriginalModelStacked;
  annotation (uses(Modelica(version="3.2.2")));
end TestOverWrite;
