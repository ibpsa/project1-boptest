within IDEAS.Media.Specialized.BaseClasses;
partial package PartialSimpleMedium "Medium model with linear dependency of u, h from temperature. All other quantities are constant, including density."

  extends Modelica.Media.Interfaces.PartialPureSubstance(final ThermoStates=
        Modelica.Media.Interfaces.Choices.IndependentVariables.pT, final
      singleState=true);

  constant SpecificHeatCapacity cp_const
    "Constant specific heat capacity at constant pressure";
  constant SpecificHeatCapacity cv_const
    "Constant specific heat capacity at constant volume";
  constant Density d_const "Constant density";
  constant DynamicViscosity eta_const "Constant dynamic viscosity";
  constant ThermalConductivity lambda_const "Constant thermal conductivity";
  constant VelocityOfSound a_const "Constant velocity of sound";
  constant Temperature T_min "Minimum temperature valid for medium model";
  constant Temperature T_max "Maximum temperature valid for medium model";
  constant Temperature T0=reference_T "Zero enthalpy temperature";
  constant MolarMass MM_const "Molar mass";

  constant FluidConstants[nS] fluidConstants "Fluid constants";

  redeclare record extends ThermodynamicState "Thermodynamic state"
    AbsolutePressure p "Absolute pressure of medium";
    Temperature T "Temperature of medium";
  end ThermodynamicState;

  redeclare replaceable model extends BaseProperties(T(stateSelect=if
          preferredMediumStates then StateSelect.prefer else StateSelect.default),
      p(stateSelect=if preferredMediumStates then StateSelect.prefer else
          StateSelect.default)) "Base properties"
  equation
    assert(T >= T_min and T <= T_max, "
Temperature T (= "
                 + String(T) + " K) is not
in the allowed range ("
                      + String(T_min) + " K <= T <= " + String(T_max) + " K)
required from medium model \""
                             + mediumName + "\".
");

    // h = cp_const*(T-T0);
    h = specificEnthalpy_pTX(
            p,
            T,
            X);
    T=T0 + u/cv_const;
    //u = cv_const*(T - T0);
    d = d_const;
    R = 0;
    MM = MM_const;
    state.T = T;
    state.p = p;
    annotation (Documentation(info="<html>
<p>
This is the most simple incompressible medium model, where
specific enthalpy h and specific internal energy u are only
a function of temperature T and all other provided medium
quantities are assumed to be constant.
Note that the (small) influence of the pressure term p/d is neglected.
</p>
</html>"));
  end BaseProperties;

  redeclare function setState_pTX
    "Return thermodynamic state from p, T, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input MassFraction X[:]=reference_X "Mass fractions";
    output ThermodynamicState state "Thermodynamic state record";
  algorithm
    state := ThermodynamicState(p=p, T=T);
  end setState_pTX;

  redeclare function setState_phX
    "Return thermodynamic state from p, h, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input MassFraction X[:]=reference_X "Mass fractions";
    output ThermodynamicState state "Thermodynamic state record";
  algorithm
    state := ThermodynamicState(p=p, T=T0 + h/cp_const);
  end setState_phX;

  redeclare replaceable function setState_psX
    "Return thermodynamic state from p, s, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input MassFraction X[:]=reference_X "Mass fractions";
    output ThermodynamicState state "Thermodynamic state record";
  algorithm
    state := ThermodynamicState(p=p, T=Modelica.Math.exp(s/cp_const +
      Modelica.Math.log(reference_T)))
      "Here the incompressible limit is used, with cp as heat capacity";
  end setState_psX;

  redeclare function setState_dTX
    "Return thermodynamic state from d, T, and X or Xi"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input MassFraction X[:]=reference_X "Mass fractions";
    output ThermodynamicState state "Thermodynamic state record";
  algorithm
    assert(false,
      "Pressure can not be computed from temperature and density for an incompressible fluid!");
  end setState_dTX;

  redeclare function extends setSmoothState
    "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
  algorithm
    state := ThermodynamicState(p=Modelica.Media.Common.smoothStep(
        x,
        state_a.p,
        state_b.p,
        x_small), T=Modelica.Media.Common.smoothStep(
        x,
        state_a.T,
        state_b.T,
        x_small));
  end setSmoothState;

  redeclare function extends dynamicViscosity "Return dynamic viscosity"

  algorithm
    eta := eta_const;
  end dynamicViscosity;

  redeclare function extends thermalConductivity
    "Return thermal conductivity"

  algorithm
    lambda := lambda_const;
  end thermalConductivity;

  redeclare function extends pressure "Return pressure"

  algorithm
    p := state.p;
  end pressure;

  redeclare function extends temperature "Return temperature"

  algorithm
    T := state.T;
  end temperature;

  redeclare function extends density "Return density"

  algorithm
    d := d_const;
  end density;

  redeclare function extends specificEnthalpy "Return specific enthalpy"

  algorithm
    h := cp_const*(state.T - T0);
  end specificEnthalpy;

  redeclare function extends specificHeatCapacityCp
    "Return specific heat capacity at constant pressure"

  algorithm
    cp := cp_const;
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "Return specific heat capacity at constant volume"

  algorithm
    cv := cv_const;
  end specificHeatCapacityCv;

  redeclare function extends isentropicExponent "Return isentropic exponent"

  algorithm
    gamma := cp_const/cv_const;
  end isentropicExponent;

  redeclare function extends velocityOfSound "Return velocity of sound"

  algorithm
    a := a_const;
  end velocityOfSound;

  redeclare function specificEnthalpy_pTX
    "Return specific enthalpy from p, T, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input MassFraction X[nX] "Mass fractions";
    output SpecificEnthalpy h "Specific enthalpy";
  algorithm
    h := cp_const*(T - T0);
    annotation (Documentation(info="<html>
<p>
This function computes the specific enthalpy of the fluid, but neglects the (small) influence of the pressure term p/d.
</p>
</html>"));
  end specificEnthalpy_pTX;

  redeclare function temperature_phX
    "Return temperature from p, h, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input MassFraction X[nX] "Mass fractions";
    output Temperature T "Temperature";
  algorithm
    T := T0 + h/cp_const;
  end temperature_phX;

  redeclare function density_phX "Return density from p, h, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input MassFraction X[nX] "Mass fractions";
    output Density d "Density";
  algorithm
    d := density(setState_phX(
            p,
            h,
            X));
  end density_phX;

  redeclare function extends specificInternalEnergy
    "Return specific internal energy"
    extends Modelica.Icons.Function;
  algorithm
    //  u := cv_const*(state.T - T0) - reference_p/d_const;
    u := cv_const*(state.T - T0);
    annotation (Documentation(info="<html>
<p>
This function computes the specific internal energy of the fluid, but neglects the (small) influence of the pressure term p/d.
</p>
</html>"));
  end specificInternalEnergy;

  redeclare function extends specificEntropy "Return specific entropy"
    extends Modelica.Icons.Function;
  algorithm
    s := cv_const*Modelica.Math.log(state.T/T0);
  end specificEntropy;

  redeclare function extends specificGibbsEnergy
    "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
  algorithm
    g := specificEnthalpy(state) - state.T*specificEntropy(state);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
    "Return specific Helmholtz energy"
    extends Modelica.Icons.Function;
  algorithm
    f := specificInternalEnergy(state) - state.T*specificEntropy(state);
  end specificHelmholtzEnergy;

  redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
  algorithm
    h_is := cp_const*(temperature(refState) - T0);
  end isentropicEnthalpy;

  redeclare function extends isobaricExpansionCoefficient
    "Returns overall the isobaric expansion coefficient beta"
  algorithm
    beta := 0.0;
  end isobaricExpansionCoefficient;

  redeclare function extends isothermalCompressibility
    "Returns overall the isothermal compressibility factor"
  algorithm
    kappa := 0;
  end isothermalCompressibility;

  redeclare function extends density_derp_T
    "Returns the partial derivative of density with respect to pressure at constant temperature"
  algorithm
    ddpT := 0;
  end density_derp_T;

  redeclare function extends density_derT_p
    "Returns the partial derivative of density with respect to temperature at constant pressure"
  algorithm
    ddTp := 0;
  end density_derT_p;

  redeclare function extends density_derX
    "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
  algorithm
    dddX := fill(0, nX);
  end density_derX;

  redeclare function extends molarMass "Return the molar mass of the medium"
  algorithm
    MM := MM_const;
  end molarMass;

  annotation (Documentation(info="<html>
<p>
Partial medium that contains an explicit expression 
for the computation T=T0+u/cv instead of using implicit function of u=cv*(T-T0).
This Medium generates fewer algebraic loops in JModelica.
</p>
</html>", revisions="<html>
<ul>
<li>
February 17, 2020, by Filip Jorissen:<br/>
Bugfix in <code>cv_const</code>. 
See <a href=https://github.com/open-ideas/IDEAS/issues/1107>#1107</a>.
</li>
<li>
May 23, 2018, by Filip Jorissen:<br/>
First implementation based on IBPSA library models.
</li>
</ul>
</html>"));
end PartialSimpleMedium;
