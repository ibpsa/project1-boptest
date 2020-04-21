#include <moutil.c>
PreNonAliasDef(6)
PreNonAliasDef(7)
PreNonAliasDef(8)
PreNonAliasDef(9)
PreNonAliasDef(10)
StartNonAlias(5)
DeclareAlias2("case900Template.outC.radSolData.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 1028)
DeclareVariable("case900Template.outC.radSolData.weaBus.Tdes", "Design temperature? [K|degC]",\
 265.15, 0.0,1E+100,300.0,0,2569)
DeclareVariable("case900Template.outC.radSolData.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,2569)
DeclareAlias2("case900Template.outC.radSolData.weaBus.hConExt", "Exterior convective heat transfer coefficient [W/(m2.K)]",\
 "sim.hCon", 1, 5, 35, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.X_wEnv", "Environment air water mass fraction",\
 "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1, 5, 649, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.CEnv", "Environment air trace substance mass fraction",\
 "sim.weaBus.CEnv", 1, 5, 76, 1028)
DeclareVariable("case900Template.outC.radSolData.weaBus.dummy", "Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outC.radSolData.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.F1", "", "sim.weaBus.F1", 1,\
 5, 80, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.F2", "", "sim.weaBus.F2", 1,\
 5, 81, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 1028)
DeclareAlias2("case900Template.outC.radSolData.weaBus.phi", "", "weaBus.relHum", 1,\
 3, 20, 1028)
DeclareAlias2("case900Template.outC.radSolData.HDirTil", "Direct solar irradiation on a tilted surface",\
 "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 1024)
DeclareAlias2("case900Template.outC.radSolData.HGroDifTil", "Diffuse sky solar irradiance on a tilted surface",\
 "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 1024)
DeclareAlias2("case900Template.outC.radSolData.HSkyDifTil", "Diffuse sky solar irradiance on a tilted surface",\
 "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 1024)
DeclareAlias2("case900Template.outC.radSolData.angInc", "", "sim.radSol[4].incAng.incAng", 1,\
 5, 204, 1024)
DeclareAlias2("case900Template.outC.radSolData.angZen", "", "weaBus.solZen", 1, 3,\
 25, 1024)
DeclareAlias2("case900Template.outC.radSolData.angAzi", "", "sim.radSol[4].relAzi.y", 1,\
 5, 225, 1024)
DeclareAlias2("case900Template.outC.radSolData.angHou", "Hour angle", \
"weaBus.solHouAng", 1, 3, 23, 1024)
DeclareAlias2("case900Template.outC.radSolData.Tenv", "Environment temperature",\
 "sim.weaBus.solBus[4].Tenv", 1, 5, 63, 1024)
DeclareVariable("case900Template.outC.radSolData.numMatches", "[:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.radSolData.solDataInBus", "True if the {inc,azi} combination is found in incAndAziInBus [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outC.radSolData.solDataIndex", "Index of the {inc,azi} combination in incAndAziInBus [:#(type=Integer)]",\
 4, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.radSolData.solBusDummy.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outC.radSolData.solBusDummy.HDirTil", "[W/(m2)]",\
 "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 1028)
DeclareAlias2("case900Template.outC.radSolData.solBusDummy.HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 1028)
DeclareAlias2("case900Template.outC.radSolData.solBusDummy.HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 1028)
DeclareAlias2("case900Template.outC.radSolData.solBusDummy.angInc", "[rad|deg]",\
 "sim.radSol[4].incAng.incAng", 1, 5, 204, 1028)
DeclareAlias2("case900Template.outC.radSolData.solBusDummy.angZen", "[rad|deg]",\
 "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outC.radSolData.solBusDummy.angAzi", "[rad|deg]",\
 "sim.radSol[4].relAzi.y", 1, 5, 225, 1028)
DeclareAlias2("case900Template.outC.radSolData.solBusDummy.Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 1028)
DeclareVariable("case900Template.outC.Tdes.u", "Connector of Real input signal",\
 265.15, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.Tdes.y", "Connector of Real output signal",\
 265.15, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outC.solDif.u1", "Connector of Real input signal 1",\
 "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 1024)
DeclareAlias2("case900Template.outC.solDif.u2", "Connector of Real input signal 2",\
 "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 1024)
DeclareAlias2("case900Template.outC.solDif.y", "Connector of Real output signal",\
 "case900Template.outC.solAbs.solDif", 1, 5, 5232, 1024)
DeclareVariable("case900Template.outC.solDif.k1", "Gain of upper input", 1, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.solDif.k2", "Gain of lower input", 1, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.nLay", "Number of layers of the construction, including gaps [:#(type=Integer)]",\
 3, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outD.constructionType.nGain", "Number of gain heat ports [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.constructionType.locGain[1]", \
"Location of possible embedded system: between layer locGain and layer locGain + 1 [:#(type=Integer)]",\
 1, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outD.constructionType.mats[1].k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].c", \
"Specific thermal capacity [J/(kg.K)]", 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].rho", \
"Density [kg/m3|g/cm3]", 530.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].d", \
"Layer thickness [m]", 0.009, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.constructionType.mats[1].glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.constructionType.mats[1].mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].R", "[m2.K/W]", \
0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].alpha", \
"Thermal diffusivity [m2/s]", 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.constructionType.mats[1].piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 16.612602789104763, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[1].nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outD.constructionType.mats[2].k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].c", \
"Specific thermal capacity [J/(kg.K)]", 1400.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].rho", \
"Density [kg/m3|g/cm3]", 10.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].d", \
"Layer thickness [m]", 0.0615, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.constructionType.mats[2].glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.constructionType.mats[2].mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].R", "[m2.K/W]", \
1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].alpha", \
"Thermal diffusivity [m2/s]", 2.8571428571428573E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.constructionType.mats[2].piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 36.38389066606264, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[2].nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outD.constructionType.mats[3].k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].c", \
"Specific thermal capacity [J/(kg.K)]", 1000.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].rho", \
"Density [kg/m3|g/cm3]", 1400.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].d", \
"Layer thickness [m]", 0.1, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.constructionType.mats[3].glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.constructionType.mats[3].mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].R", "[m2.K/W]", \
0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].alpha", \
"Thermal diffusivity [m2/s]", 3.642857142857143E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.constructionType.mats[3].piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 165.68337391590282, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.constructionType.mats[3].nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 3, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outD.constructionType.incLastLay", \
"Set to IDEAS.Types.Tilt.Floor if the last layer of mats is a floor, to .Ceiling if it is a ceiling and to .Other if other. For verification purposes. [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.inc", "Inclination (tilt) angle of the wall, see IDEAS.Types.Tilt [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.azi", "Azimuth angle of the wall, i.e. see IDEAS.Types.Azimuth, set IDEAS.Types.Azimuth.S for horizontal ceilings and floors [rad|deg]",\
 4.71238898038469, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.A", "Component surface area [m2]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.nWin", "Use this factor to scale the component to nWin identical components",\
 1, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.QTra_design", "Design heat losses at reference temperature of the boundary space [W]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.T_start", "Start temperature for each of the layers [K|degC]",\
 293.15, 0.0,1E+100,300.0,0,2561)
DeclareParameter("case900Template.outD.TRef_a", "Reference temperature of zone on side of propsBus_a, for calculation of design heat loss [K|degC]",\
 789, 291.15, 0.0,1E+100,300.0,0,2608)
DeclareVariable("case900Template.outD.linIntCon_a", "= true, if convective heat transfer should be linearised [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.dT_nominal_a", "Nominal temperature difference used for linearisation, negative temperatures indicate the solid is colder [K,]",\
 -3.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.energyDynamics", "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outD.propsBus_a.numIncAndAziInBus", \
"Number of calculated azimuth angles, set to sim.numIncAndAziInBus [:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outD.propsBus_a.outputAngles", "Set to false when linearising in Dymola only [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.propsBus_a.QTra_design", "[W]", \
"case900Template.outD.QTra_design", 1, 5, 5346, 1028)
DeclareAlias2("case900Template.outD.propsBus_a.area", "[m2]", "case900Template.outD.layMul.A", 1,\
 5, 5386, 1028)
DeclareAlias2("case900Template.outD.propsBus_a.epsLw", "[1]", "case900Template.outD.layMul.mats[3].epsLw_a", 1,\
 5, 5436, 1028)
DeclareAlias2("case900Template.outD.propsBus_a.epsSw", "[1]", "case900Template.outD.layMul.mats[3].epsSw_a", 1,\
 5, 5438, 1028)
DeclareAlias2("case900Template.outD.propsBus_a.surfCon.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outD.propsBus_a.surfCon.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "case900Template.airModel.ports_surf[4].Q_flow", -1, 5, 3303, 1156)
DeclareAlias2("case900Template.outD.propsBus_a.surfRad.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 34, 1028)
DeclareVariable("case900Template.outD.propsBus_a.surfRad.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outD.propsBus_a.iSolDir.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.propsBus_a.iSolDir.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.propsBus_a.iSolDif.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.propsBus_a.iSolDif.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.numSolBus", \
"[:#(type=Integer)]", 6, 0.0,0.0,0.0,0,1549)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solTim", "Solar time [s]",\
 "weaBus.solTim", 1, 3, 24, 516)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.solBus[1].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[1].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[1].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 516)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.solBus[1].HGroDifTil", \
"[W/(m2)]", 0.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[1].angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[1].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[1].angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 516)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.solBus[2].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[2].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[2].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[2].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[2].angInc", \
"[rad|deg]", "sim.radSol[2].incAng.incAng", 1, 5, 130, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[2].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[2].angAzi", \
"[rad|deg]", "sim.radSol[2].relAzi.y", 1, 5, 151, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 516)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.solBus[3].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[3].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[3].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[3].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[3].angInc", \
"[rad|deg]", "sim.radSol[3].incAng.incAng", 1, 5, 167, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[3].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[3].angAzi", \
"[rad|deg]", "sim.radSol[3].relAzi.y", 1, 5, 188, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 516)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.solBus[4].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[4].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[4].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[4].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[4].angInc", \
"[rad|deg]", "sim.radSol[4].incAng.incAng", 1, 5, 204, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[4].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[4].angAzi", \
"[rad|deg]", "sim.radSol[4].relAzi.y", 1, 5, 225, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 516)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.solBus[5].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[5].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[5].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[5].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[5].angInc", \
"[rad|deg]", "sim.radSol[5].incAng.incAng", 1, 5, 241, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[5].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[5].angAzi", \
"[rad|deg]", "sim.radSol[5].relAzi.y", 1, 5, 262, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 516)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.solBus[6].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[6].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[6].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[6].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[6].angInc", \
"[rad|deg]", "sim.radSol[6].incAng.incAng", 1, 5, 278, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[6].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 516)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.Tdes", "Design temperature? [K|degC]",\
 265.15, 0.0,1E+100,300.0,0,1545)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,1545)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.hConExt", "Exterior convective heat transfer coefficient [W/(m2.K)]",\
 "sim.hCon", 1, 5, 35, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.X_wEnv", "Environment air water mass fraction",\
 "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1, 5, 649, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.CEnv", "Environment air trace substance mass fraction",\
 "sim.weaBus.CEnv", 1, 5, 76, 516)
DeclareVariable("case900Template.outD.propsBus_a.weaBus.dummy", "Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.F1", "", "sim.weaBus.F1", 1,\
 5, 80, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.F2", "", "sim.weaBus.F2", 1,\
 5, 81, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 516)
DeclareAlias2("case900Template.outD.propsBus_a.weaBus.phi", "", "weaBus.relHum", 1,\
 3, 20, 516)
DeclareAlias2("case900Template.outD.propsBus_a.Qgai.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareVariable("case900Template.outD.propsBus_a.Qgai.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareVariable("case900Template.outD.propsBus_a.E.E", "Energy port [J]", 0.0, \
0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.propsBus_a.E.Etot", "Energy port [J]", 0.0,\
 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.propsBus_a.inc", "[rad|deg]", \
1.5707963267948966, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.propsBus_a.azi", "[rad|deg]", \
4.71238898038469, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.intCon_a.A", "surface area [m2]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.intCon_a.inc", "inclination [rad|deg]", \
1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.intCon_a.linearise", "= true, if convective heat transfer should be linearised [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.intCon_a.dT_nominal", "Nominal temperature difference used for linearisation, negative temperatures indicate the solid is colder [K,]",\
 -3.0, 0.0,0.0,0.0,0,2561)
DeclareParameter("case900Template.outD.intCon_a.hZone", "Zone height, for calculation of hydraulic diameter [m]",\
 790, 2.7, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outD.intCon_a.DhWall", "Hydraulic diameter for walls [m]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.intCon_a.DhFloor", "Hydraulic diameter for ceiling/floor [m]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.intCon_a.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 34, 1028)
DeclareAlias2("case900Template.outD.intCon_a.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "case900Template.airModel.ports_surf[4].Q_flow", 1, 5, 3303, 1156)
DeclareAlias2("case900Template.outD.intCon_a.port_b.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outD.intCon_a.port_b.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "case900Template.airModel.ports_surf[4].Q_flow", -1, 5, 3303, 1156)
DeclareVariable("case900Template.outD.intCon_a.dT", "[K,]", 0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outD.intCon_a.coeffWall", "For avoiding calculation of power at every time step",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.intCon_a.coeffFloor", "For avoiding calculations at every time step",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.intCon_a.coeffCeiling", "For avoiding calculations at every time step",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.intCon_a.isCeiling", "true if ceiling [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.intCon_a.isFloor", "true if floor [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.intCon_a.ceilingSign", "Coefficient for buoyancy direction",\
 -1, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.A", "total multilayer area [m2]", \
0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.inc", "Inclinination angle of the multilayer at port_a [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.nLay", "number of layers [:#(type=Integer)]",\
 3, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.mats[1].k", "Thermal conductivity [W/(m.K)]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].c", "Specific thermal capacity [J/(kg.K)]",\
 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].rho", "Density [kg/m3|g/cm3]",\
 530.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].d", "Layer thickness [m]", \
0.009, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].epsLw", "Longwave emisivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].epsSw", "Shortwave emissivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].gas", "Boolean whether the material is a gas [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.mats[1].glass", "Boolean whether the material is made of glass [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.mats[1].mhu", "Viscosity, i.e. if the material is a fluid [m2/s]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].epsLw_a", "Longwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].epsLw_b", "Longwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].epsSw_a", "Shortwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].epsSw_b", "Shortwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].R", "[m2.K/W]", \
0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].alpha", "Thermal diffusivity [m2/s]",\
 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].nStaRef", "Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.mats[1].piRef", "d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete",\
 224.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].piLay", "d/sqrt(mat.alpha) of the depicted layer",\
 16.612602789104763, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[1].nSta", "Actual number of state variables in material [:#(type=Integer)]",\
 2, 2.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.mats[2].k", "Thermal conductivity [W/(m.K)]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].c", "Specific thermal capacity [J/(kg.K)]",\
 1400.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].rho", "Density [kg/m3|g/cm3]",\
 10.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].d", "Layer thickness [m]", \
0.0615, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].epsLw", "Longwave emisivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].epsSw", "Shortwave emissivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].gas", "Boolean whether the material is a gas [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.mats[2].glass", "Boolean whether the material is made of glass [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.mats[2].mhu", "Viscosity, i.e. if the material is a fluid [m2/s]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].epsLw_a", "Longwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].epsLw_b", "Longwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].epsSw_a", "Shortwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].epsSw_b", "Shortwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].R", "[m2.K/W]", \
1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].alpha", "Thermal diffusivity [m2/s]",\
 2.8571428571428573E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].nStaRef", "Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.mats[2].piRef", "d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete",\
 224.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].piLay", "d/sqrt(mat.alpha) of the depicted layer",\
 36.38389066606264, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[2].nSta", "Actual number of state variables in material [:#(type=Integer)]",\
 2, 2.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.mats[3].k", "Thermal conductivity [W/(m.K)]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].c", "Specific thermal capacity [J/(kg.K)]",\
 1000.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].rho", "Density [kg/m3|g/cm3]",\
 1400.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].d", "Layer thickness [m]", \
0.1, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].epsLw", "Longwave emisivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].epsSw", "Shortwave emissivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].gas", "Boolean whether the material is a gas [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.mats[3].glass", "Boolean whether the material is made of glass [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.mats[3].mhu", "Viscosity, i.e. if the material is a fluid [m2/s]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].epsLw_a", "Longwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].epsLw_b", "Longwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].epsSw_a", "Shortwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].epsSw_b", "Shortwave emisivity for surface a if different [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].R", "[m2.K/W]", \
0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].alpha", "Thermal diffusivity [m2/s]",\
 3.642857142857143E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].nStaRef", "Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.mats[3].piRef", "d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete",\
 224.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].piLay", "d/sqrt(mat.alpha) of the depicted layer",\
 165.68337391590282, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.mats[3].nSta", "Actual number of state variables in material [:#(type=Integer)]",\
 3, 2.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.nGain", "Number of gains [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.linIntCon", "Linearise interior convection inside air layers / cavities in walls [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.R", "total specific thermal resistance [m2.K/W]",\
 1.7978641456582631, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.C", "Total heat capacity of the layers [J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.T_start[1]", "Start temperature from port_b to port_a [K|degC]",\
 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outD.layMul.T_start[2]", "Start temperature from port_b to port_a [K|degC]",\
 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outD.layMul.T_start[3]", "Start temperature from port_b to port_a [K|degC]",\
 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outD.layMul.energyDynamics", "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.disableInitPortA", "Remove initial equation at port a [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.disableInitPortB", "Remove initial equation at port b [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("case900Template.outD.layMul.dT_nom_air", "Nominal temperature difference for air layers, used for linearising Rayleigh number [K,]",\
 791, 1, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outD.layMul.E", "[J]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outD.layMul.monLay[1].A", "Layer surface area [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.k", "Thermal conductivity [W/(m.K)]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.c", "Specific thermal capacity [J/(kg.K)]",\
 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.rho", \
"Density [kg/m3|g/cm3]", 530.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.d", "Layer thickness [m]",\
 0.009, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.R", "[m2.K/W]", \
0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.alpha", \
"Thermal diffusivity [m2/s]", 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 16.612602789104763, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[1].inc", "Inclinination angle of the layer at port_a [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].epsLw_a", \
"Longwave emissivity of material connected at port_a [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].epsLw_b", \
"Longwave emissivity on material connected at port_b [1]", 0.85, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].linIntCon", \
"Linearise interior convection inside air layers / cavities in walls [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[1].energyDynamics", \
"Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[1].T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].R", "Total specific thermal resistance [m2.K/W]",\
 0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].isDynamic", \
"[:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[1].E", "[J]", 0.0, 0.0,0.0,\
0.0,0,2560)
DeclareAlias2("case900Template.outD.layMul.monLay[1].port_a.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[1].monLayDyn.T[1]", 1, 1, 31, 1028)
DeclareVariable("case900Template.outD.layMul.monLay[1].port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outD.layMul.monLay[1].port_b.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 32, 1028)
DeclareAlias2("case900Template.outD.layMul.monLay[1].port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.layMul.port_b.Q_flow", 1, 5, 5565, 1156)
DeclareAlias2("case900Template.outD.layMul.monLay[1].port_gain.T", \
"Port temperature [K|degC]", "case900Template.outD.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 31, 1028)
DeclareVariable("case900Template.outD.layMul.monLay[1].port_gain.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.layMul.monLay[1].E_internal", "", \
"case900Template.outD.layMul.monLay[1].E", 1, 5, 5485, 1024)
DeclareVariable("case900Template.outD.layMul.monLay[1].dynamicLayer", \
"True when modelling thermal dynamics [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[1].realLayer", \
"True when the layer has a non-zero thickness [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[1].airLayer", \
"True when a convection + radiation equation should be used to model the layer instead of conduction [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[1].dT_nom_air", \
"Nominal temperature difference for air layers, used for linearising Rayleigh number [K,]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].A", "Layer surface area [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.k", "Thermal conductivity [W/(m.K)]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.c", "Specific thermal capacity [J/(kg.K)]",\
 1400.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.rho", \
"Density [kg/m3|g/cm3]", 10.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.d", "Layer thickness [m]",\
 0.0615, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.R", "[m2.K/W]", \
1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.alpha", \
"Thermal diffusivity [m2/s]", 2.8571428571428573E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 36.38389066606264, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[2].inc", "Inclinination angle of the layer at port_a [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].epsLw_a", \
"Longwave emissivity of material connected at port_a [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].epsLw_b", \
"Longwave emissivity on material connected at port_b [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].linIntCon", \
"Linearise interior convection inside air layers / cavities in walls [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[2].energyDynamics", \
"Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[2].T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].R", "Total specific thermal resistance [m2.K/W]",\
 1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].isDynamic", \
"[:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[2].E", "[J]", 0.0, 0.0,0.0,\
0.0,0,2560)
DeclareAlias2("case900Template.outD.layMul.monLay[2].port_a.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[2].monLayDyn.T[1]", 1, 1, 33, 1028)
DeclareVariable("case900Template.outD.layMul.monLay[2].port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outD.layMul.monLay[2].port_b.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[1].monLayDyn.T[1]", 1, 1, 31, 1028)
DeclareAlias2("case900Template.outD.layMul.monLay[2].port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.layMul.monLay[1].port_a.Q_flow", -1, 5, 5486, 1156)
DeclareAlias2("case900Template.outD.layMul.monLay[2].port_gain.T", \
"Port temperature [K|degC]", "case900Template.outD.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 33, 1028)
DeclareVariable("case900Template.outD.layMul.monLay[2].port_gain.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.layMul.monLay[2].E_internal", "", \
"case900Template.outD.layMul.monLay[2].E", 1, 5, 5520, 1024)
DeclareVariable("case900Template.outD.layMul.monLay[2].dynamicLayer", \
"True when modelling thermal dynamics [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[2].realLayer", \
"True when the layer has a non-zero thickness [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[2].airLayer", \
"True when a convection + radiation equation should be used to model the layer instead of conduction [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[2].dT_nom_air", \
"Nominal temperature difference for air layers, used for linearising Rayleigh number [K,]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].A", "Layer surface area [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.k", "Thermal conductivity [W/(m.K)]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.c", "Specific thermal capacity [J/(kg.K)]",\
 1000.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.rho", \
"Density [kg/m3|g/cm3]", 1400.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.d", "Layer thickness [m]",\
 0.1, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.R", "[m2.K/W]", \
0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.alpha", \
"Thermal diffusivity [m2/s]", 3.642857142857143E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 165.68337391590282, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 3, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[3].inc", "Inclinination angle of the layer at port_a [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].epsLw_a", \
"Longwave emissivity of material connected at port_a [1]", 0.85, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].epsLw_b", \
"Longwave emissivity on material connected at port_b [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].linIntCon", \
"Linearise interior convection inside air layers / cavities in walls [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[3].energyDynamics", \
"Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[3].T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].R", "Total specific thermal resistance [m2.K/W]",\
 0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].isDynamic", \
"[:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[3].E", "[J]", 0.0, 0.0,0.0,\
0.0,0,2560)
DeclareAlias2("case900Template.outD.layMul.monLay[3].port_a.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 34, 1028)
DeclareAlias2("case900Template.outD.layMul.monLay[3].port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.layMul.port_a.Q_flow", 1, 5, 5564, 1156)
DeclareAlias2("case900Template.outD.layMul.monLay[3].port_b.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[2].monLayDyn.T[1]", 1, 1, 33, 1028)
DeclareAlias2("case900Template.outD.layMul.monLay[3].port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.layMul.monLay[2].port_a.Q_flow", -1, 5, 5521, 1156)
DeclareAlias2("case900Template.outD.layMul.monLay[3].port_gain.T", \
"Port temperature [K|degC]", "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1,\
 1, 34, 1028)
DeclareVariable("case900Template.outD.layMul.monLay[3].port_gain.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.layMul.monLay[3].E_internal", "", \
"case900Template.outD.layMul.monLay[3].E", 1, 5, 5555, 1024)
DeclareVariable("case900Template.outD.layMul.monLay[3].dynamicLayer", \
"True when modelling thermal dynamics [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[3].realLayer", \
"True when the layer has a non-zero thickness [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[3].airLayer", \
"True when a convection + radiation equation should be used to model the layer instead of conduction [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[3].dT_nom_air", \
"Nominal temperature difference for air layers, used for linearising Rayleigh number [K,]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.layMul.port_gain[1].T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[1].monLayDyn.T[1]", 1, 1, 31, 1028)
DeclareVariable("case900Template.outD.layMul.port_gain[1].Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.layMul.port_gain[2].T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[2].monLayDyn.T[1]", 1, 1, 33, 1028)
DeclareVariable("case900Template.outD.layMul.port_gain[2].Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.layMul.port_gain[3].T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 34, 1028)
DeclareVariable("case900Template.outD.layMul.port_gain[3].Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.layMul.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 34, 1028)
DeclareVariable("case900Template.outD.layMul.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outD.layMul.port_b.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 32, 1028)
DeclareVariable("case900Template.outD.layMul.port_b.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outD.layMul.iEpsLw_b", "output of the interior emissivity for radiative heat losses",\
 "case900Template.outD.layMul.mats[1].epsLw_b", 1, 5, 5399, 1024)
DeclareAlias2("case900Template.outD.layMul.iEpsSw_b", "output of the interior emissivity for radiative heat losses",\
 "case900Template.outD.layMul.mats[1].epsSw_b", 1, 5, 5401, 1024)
DeclareAlias2("case900Template.outD.layMul.iEpsLw_a", "output of the interior emissivity for radiative heat losses",\
 "case900Template.outD.layMul.mats[3].epsLw_a", 1, 5, 5436, 1024)
DeclareAlias2("case900Template.outD.layMul.iEpsSw_a", "output of the interior emissivity for radiative heat losses",\
 "case900Template.outD.layMul.mats[3].epsSw_a", 1, 5, 5438, 1024)
DeclareAlias2("case900Template.outD.layMul.area", "output of the interior emissivity for radiative heat losses",\
 "case900Template.outD.layMul.A", 1, 5, 5386, 1024)
DeclareAlias2("case900Template.outD.QDesign.y", "Value of Real output", \
"case900Template.outD.QTra_design", 1, 5, 5346, 1024)
DeclareVariable("case900Template.outD.aziExp.y", "Value of Real output", \
4.71238898038469, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.incExp.y", "Value of Real output", \
1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.E.y", "Value of Real output", 0, 0.0,0.0,\
0.0,0,2561)
DeclareVariable("case900Template.outD.prescribedHeatFlowE.E", "[J]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.prescribedHeatFlowE.port.E", \
"Energy port [J]", 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.prescribedHeatFlowE.port.Etot", \
"Energy port [J]", 0.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outD.Qgai.y", "Value of Real output", \
"case900Template.outD.layMul.port_b.Q_flow", 1, 5, 5565, 1024)
DeclareParameter("case900Template.outD.prescribedHeatFlowQgai.T_ref", \
"Reference temperature [K|degC]", 792, 293.15, 0.0,1E+100,300.0,0,2608)
DeclareParameter("case900Template.outD.prescribedHeatFlowQgai.alpha", \
"Temperature coefficient of heat flow rate [1/K]", 793, 0, 0.0,0.0,0.0,0,2608)
DeclareAlias2("case900Template.outD.prescribedHeatFlowQgai.Q_flow", "[W]", \
"case900Template.outD.layMul.port_b.Q_flow", 1, 5, 5565, 1024)
DeclareAlias2("case900Template.outD.prescribedHeatFlowQgai.port.T", \
"Port temperature [K|degC]", "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareAlias2("case900Template.outD.prescribedHeatFlowQgai.port.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.propsBus_a.Qgai.Q_flow", 1, 5, 5368, 1156)
DeclareVariable("case900Template.outD.gain.k", "Scaling factor", 1.0, 0.0,0.0,\
0.0,0,2561)
DeclareVariable("case900Template.outD.gain.propsBus_a.numIncAndAziInBus", \
"Number of calculated azimuth angles, set to sim.numIncAndAziInBus [:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outD.gain.propsBus_a.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.gain.propsBus_a.QTra_design", "[W]", \
"case900Template.outD.QTra_design", 1, 5, 5346, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_a.area", "[m2]", \
"case900Template.outD.layMul.A", 1, 5, 5386, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_a.epsLw", "[1]", \
"case900Template.outD.layMul.mats[3].epsLw_a", 1, 5, 5436, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_a.epsSw", "[1]", \
"case900Template.outD.layMul.mats[3].epsSw_a", 1, 5, 5438, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_a.surfCon.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_a.surfCon.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.airModel.ports_surf[4].Q_flow", 1, 5, 3303, 1156)
DeclareAlias2("case900Template.outD.gain.propsBus_a.surfRad.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 34, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_a.surfRad.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.propsBus_a.surfRad.Q_flow", -1, 5, 5353, 1156)
DeclareAlias2("case900Template.outD.gain.propsBus_a.iSolDir.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.gain.propsBus_a.iSolDir.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.gain.propsBus_a.iSolDif.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.gain.propsBus_a.iSolDif.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.numSolBus", \
"[:#(type=Integer)]", 6, 0.0,0.0,0.0,0,1549)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solTim", \
"Solar time [s]", "weaBus.solTim", 1, 3, 24, 516)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.solBus[1].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[1].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[1].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 516)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.solBus[1].HGroDifTil",\
 "[W/(m2)]", 0.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[1].angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[1].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[1].angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 516)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.solBus[2].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[2].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[2].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[2].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[2].angInc", \
"[rad|deg]", "sim.radSol[2].incAng.incAng", 1, 5, 130, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[2].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[2].angAzi", \
"[rad|deg]", "sim.radSol[2].relAzi.y", 1, 5, 151, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 516)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.solBus[3].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[3].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[3].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[3].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[3].angInc", \
"[rad|deg]", "sim.radSol[3].incAng.incAng", 1, 5, 167, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[3].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[3].angAzi", \
"[rad|deg]", "sim.radSol[3].relAzi.y", 1, 5, 188, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 516)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.solBus[4].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[4].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[4].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[4].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[4].angInc", \
"[rad|deg]", "sim.radSol[4].incAng.incAng", 1, 5, 204, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[4].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[4].angAzi", \
"[rad|deg]", "sim.radSol[4].relAzi.y", 1, 5, 225, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 516)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.solBus[5].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[5].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[5].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[5].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[5].angInc", \
"[rad|deg]", "sim.radSol[5].incAng.incAng", 1, 5, 241, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[5].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[5].angAzi", \
"[rad|deg]", "sim.radSol[5].relAzi.y", 1, 5, 262, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 516)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.solBus[6].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[6].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[6].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[6].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[6].angInc", \
"[rad|deg]", "sim.radSol[6].incAng.incAng", 1, 5, 278, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[6].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 516)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.Tdes", \
"Design temperature? [K|degC]", 265.15, 0.0,1E+100,300.0,0,1545)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,1545)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.hConExt", \
"Exterior convective heat transfer coefficient [W/(m2.K)]", "sim.hCon", 1, 5, 35,\
 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.X_wEnv", \
"Environment air water mass fraction", "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1,\
 5, 649, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.CEnv", \
"Environment air trace substance mass fraction", "sim.weaBus.CEnv", 1, 5, 76, 516)
DeclareVariable("case900Template.outD.gain.propsBus_a.weaBus.dummy", \
"Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.F1", "", \
"sim.weaBus.F1", 1, 5, 80, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.F2", "", \
"sim.weaBus.F2", 1, 5, 81, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.weaBus.phi", "", \
"weaBus.relHum", 1, 3, 20, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_a.Qgai.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_a.Qgai.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.propsBus_a.Qgai.Q_flow", -1, 5, 5368, 1156)
DeclareVariable("case900Template.outD.gain.propsBus_a.E.E", "Energy port [J]", \
0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.gain.propsBus_a.E.Etot", "Energy port [J]",\
 0.0, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.gain.propsBus_a.inc", "[rad|deg]", \
1.5707963267948966, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.gain.propsBus_a.azi", "[rad|deg]", \
4.71238898038469, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.gain.propsBus_b.numIncAndAziInBus", \
"Number of calculated azimuth angles, set to sim.numIncAndAziInBus [:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outD.gain.propsBus_b.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.gain.propsBus_b.QTra_design", "[W]", \
"case900Template.outD.QTra_design", 1, 5, 5346, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_b.area", "[m2]", \
"case900Template.outD.layMul.A", 1, 5, 5386, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_b.epsLw", "[1]", \
"case900Template.outD.layMul.mats[3].epsLw_a", 1, 5, 5436, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_b.epsSw", "[1]", \
"case900Template.outD.layMul.mats[3].epsSw_a", 1, 5, 5438, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_b.surfCon.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_b.surfCon.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.airModel.ports_surf[4].Q_flow", -1, 5, 3303, 1156)
DeclareAlias2("case900Template.outD.gain.propsBus_b.surfRad.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 34, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_b.surfRad.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.propsBus_a.surfRad.Q_flow", 1, 5, 5353, 1156)
DeclareAlias2("case900Template.outD.gain.propsBus_b.iSolDir.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.gain.propsBus_b.iSolDir.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.gain.propsBus_b.iSolDif.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.gain.propsBus_b.iSolDif.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.numSolBus", \
"[:#(type=Integer)]", 6, 0.0,0.0,0.0,0,1549)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solTim", \
"Solar time [s]", "weaBus.solTim", 1, 3, 24, 516)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.solBus[1].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[1].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[1].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 516)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.solBus[1].HGroDifTil",\
 "[W/(m2)]", 0.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[1].angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[1].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[1].angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 516)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.solBus[2].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[2].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[2].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[2].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[2].angInc", \
"[rad|deg]", "sim.radSol[2].incAng.incAng", 1, 5, 130, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[2].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[2].angAzi", \
"[rad|deg]", "sim.radSol[2].relAzi.y", 1, 5, 151, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 516)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.solBus[3].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[3].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[3].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[3].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[3].angInc", \
"[rad|deg]", "sim.radSol[3].incAng.incAng", 1, 5, 167, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[3].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[3].angAzi", \
"[rad|deg]", "sim.radSol[3].relAzi.y", 1, 5, 188, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 516)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.solBus[4].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[4].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[4].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[4].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[4].angInc", \
"[rad|deg]", "sim.radSol[4].incAng.incAng", 1, 5, 204, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[4].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[4].angAzi", \
"[rad|deg]", "sim.radSol[4].relAzi.y", 1, 5, 225, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 516)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.solBus[5].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[5].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[5].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[5].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[5].angInc", \
"[rad|deg]", "sim.radSol[5].incAng.incAng", 1, 5, 241, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[5].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[5].angAzi", \
"[rad|deg]", "sim.radSol[5].relAzi.y", 1, 5, 262, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 516)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.solBus[6].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[6].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[6].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[6].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[6].angInc", \
"[rad|deg]", "sim.radSol[6].incAng.incAng", 1, 5, 278, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[6].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 516)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.Tdes", \
"Design temperature? [K|degC]", 265.15, 0.0,1E+100,300.0,0,1545)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,1545)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.hConExt", \
"Exterior convective heat transfer coefficient [W/(m2.K)]", "sim.hCon", 1, 5, 35,\
 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.X_wEnv", \
"Environment air water mass fraction", "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1,\
 5, 649, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.CEnv", \
"Environment air trace substance mass fraction", "sim.weaBus.CEnv", 1, 5, 76, 516)
DeclareVariable("case900Template.outD.gain.propsBus_b.weaBus.dummy", \
"Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.F1", "", \
"sim.weaBus.F1", 1, 5, 80, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.F2", "", \
"sim.weaBus.F2", 1, 5, 81, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.weaBus.phi", "", \
"weaBus.relHum", 1, 3, 20, 516)
DeclareAlias2("case900Template.outD.gain.propsBus_b.Qgai.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareAlias2("case900Template.outD.gain.propsBus_b.Qgai.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.propsBus_a.Qgai.Q_flow", 1, 5, 5368, 1156)
DeclareVariable("case900Template.outD.gain.propsBus_b.E.E", "Energy port [J]", \
0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.gain.propsBus_b.E.Etot", "Energy port [J]",\
 0.0, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.gain.propsBus_b.inc", "[rad|deg]", \
1.5707963267948966, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.gain.propsBus_b.azi", "[rad|deg]", \
4.71238898038469, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.gain.QTra_desgin.k", "Gain value multiplied with input signal [1]",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.gain.QTra_desgin.u", "Input signal connector",\
 "case900Template.outD.QTra_design", 1, 5, 5346, 1024)
DeclareAlias2("case900Template.outD.gain.QTra_desgin.y", "Output signal connector",\
 "case900Template.outD.QTra_design", 1, 5, 5346, 1024)
DeclareVariable("case900Template.outD.gain.area.k", "Gain value multiplied with input signal [1]",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.gain.area.u", "Input signal connector", \
"case900Template.outD.layMul.A", 1, 5, 5386, 1024)
DeclareAlias2("case900Template.outD.gain.area.y", "Output signal connector", \
"case900Template.outD.layMul.A", 1, 5, 5386, 1024)
DeclareVariable("case900Template.outD.gain.surfCon.k", "Multiplication factor for heat flow rate",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.gain.surfCon.port_a.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outD.gain.surfCon.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.airModel.ports_surf[4].Q_flow", 1, 5, 3303, 1156)
DeclareAlias2("case900Template.outD.gain.surfCon.port_b.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outD.gain.surfCon.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.airModel.ports_surf[4].Q_flow", -1, 5, 3303, 1156)
DeclareVariable("case900Template.outD.gain.surfRad.k", "Multiplication factor for heat flow rate",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.gain.surfRad.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 34, 1028)
DeclareAlias2("case900Template.outD.gain.surfRad.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.propsBus_a.surfRad.Q_flow", -1, 5, 5353, 1156)
DeclareAlias2("case900Template.outD.gain.surfRad.port_b.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 34, 1028)
DeclareAlias2("case900Template.outD.gain.surfRad.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.propsBus_a.surfRad.Q_flow", 1, 5, 5353, 1156)
DeclareVariable("case900Template.outD.gain.iSolDir.k", "Multiplication factor for heat flow rate",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.gain.iSolDir.port_a.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.gain.iSolDir.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.gain.iSolDir.port_b.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.gain.iSolDir.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.gain.iSolDif.k", "Multiplication factor for heat flow rate",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.gain.iSolDif.port_a.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.gain.iSolDif.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.gain.iSolDif.port_b.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.gain.iSolDif.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.gain.QGai.k", "Multiplication factor for heat flow rate",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.gain.QGai.port_a.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareAlias2("case900Template.outD.gain.QGai.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "case900Template.outD.propsBus_a.Qgai.Q_flow", -1, 5, 5368, 1156)
DeclareAlias2("case900Template.outD.gain.QGai.port_b.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareAlias2("case900Template.outD.gain.QGai.port_b.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "case900Template.outD.propsBus_a.Qgai.Q_flow", 1, 5, 5368, 1156)
DeclareVariable("case900Template.outD.gain.E.k", "Multiplication factor for heat flow",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.gain.E.E_a.E", "Energy port [J]", 0.0, \
0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.gain.E.E_a.Etot", "Energy port [J]", 0.0, \
0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.gain.E.E_b.E", "Energy port [J]", 0.0, \
0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.gain.E.E_b.Etot", "Energy port [J]", 0.0, \
0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.gain.weaBus.numSolBus", "[:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outD.gain.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.gain.weaBus.solTim", "Solar time [s]", \
"weaBus.solTim", 1, 3, 24, 1028)
DeclareVariable("case900Template.outD.gain.weaBus.solBus[1].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[1].HDirTil", "[W/(m2)]", \
"sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[1].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 1028)
DeclareVariable("case900Template.outD.gain.weaBus.solBus[1].HGroDifTil", \
"[W/(m2)]", 0.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[1].angInc", "[rad|deg]", \
"sim.radSol[1].incAng.incAng", 1, 5, 92, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[1].angZen", "[rad|deg]", \
"weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[1].angAzi", "[rad|deg]", \
"sim.radSol[1].relAzi.y", 1, 5, 114, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 1028)
DeclareVariable("case900Template.outD.gain.weaBus.solBus[2].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[2].HDirTil", "[W/(m2)]", \
"sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[2].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[2].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[2].angInc", "[rad|deg]", \
"sim.radSol[2].incAng.incAng", 1, 5, 130, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[2].angZen", "[rad|deg]", \
"weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[2].angAzi", "[rad|deg]", \
"sim.radSol[2].relAzi.y", 1, 5, 151, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 1028)
DeclareVariable("case900Template.outD.gain.weaBus.solBus[3].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[3].HDirTil", "[W/(m2)]", \
"sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[3].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[3].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[3].angInc", "[rad|deg]", \
"sim.radSol[3].incAng.incAng", 1, 5, 167, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[3].angZen", "[rad|deg]", \
"weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[3].angAzi", "[rad|deg]", \
"sim.radSol[3].relAzi.y", 1, 5, 188, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 1028)
DeclareVariable("case900Template.outD.gain.weaBus.solBus[4].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[4].HDirTil", "[W/(m2)]", \
"sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[4].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[4].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[4].angInc", "[rad|deg]", \
"sim.radSol[4].incAng.incAng", 1, 5, 204, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[4].angZen", "[rad|deg]", \
"weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[4].angAzi", "[rad|deg]", \
"sim.radSol[4].relAzi.y", 1, 5, 225, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 1028)
DeclareVariable("case900Template.outD.gain.weaBus.solBus[5].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[5].HDirTil", "[W/(m2)]", \
"sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[5].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[5].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[5].angInc", "[rad|deg]", \
"sim.radSol[5].incAng.incAng", 1, 5, 241, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[5].angZen", "[rad|deg]", \
"weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[5].angAzi", "[rad|deg]", \
"sim.radSol[5].relAzi.y", 1, 5, 262, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 1028)
DeclareVariable("case900Template.outD.gain.weaBus.solBus[6].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[6].HDirTil", "[W/(m2)]", \
"sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[6].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[6].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[6].angInc", "[rad|deg]", \
"sim.radSol[6].incAng.incAng", 1, 5, 278, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[6].angZen", "[rad|deg]", \
"weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[6].angAzi", "[rad|deg]", \
"sim.radSol[6].relAzi.y", 1, 5, 299, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 1028)
DeclareVariable("case900Template.outD.gain.weaBus.Tdes", "Design temperature? [K|degC]",\
 265.15, 0.0,1E+100,300.0,0,2569)
DeclareVariable("case900Template.outD.gain.weaBus.TGroundDes", "Design ground temperature [K|degC]",\
 283.15, 0.0,1E+100,300.0,0,2569)
DeclareAlias2("case900Template.outD.gain.weaBus.hConExt", "Exterior convective heat transfer coefficient [W/(m2.K)]",\
 "sim.hCon", 1, 5, 35, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.X_wEnv", "Environment air water mass fraction",\
 "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1, 5, 649, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.CEnv", "Environment air trace substance mass fraction",\
 "sim.weaBus.CEnv", 1, 5, 76, 1028)
DeclareVariable("case900Template.outD.gain.weaBus.dummy", "Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outD.gain.weaBus.TskyPow4", "", "sim.weaBus.TskyPow4", 1,\
 5, 78, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.TePow4", "", "sim.weaBus.TePow4", 1,\
 5, 79, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solGloHor", "", "weaBus.HGloHor", 1,\
 3, 7, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solDifHor", "", "weaBus.HDifHor", 1,\
 3, 5, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.F1", "", "sim.weaBus.F1", 1, 5, 80,\
 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.F2", "", "sim.weaBus.F2", 1, 5, 81,\
 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.angZen", "", "weaBus.solZen", 1,\
 3, 25, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.angHou", "", "weaBus.solHouAng", 1,\
 3, 23, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.angDec", "", "weaBus.solDec", 1,\
 3, 22, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.solDirPer", "", "weaBus.HDirNor", 1,\
 3, 6, 1028)
DeclareAlias2("case900Template.outD.gain.weaBus.phi", "", "weaBus.relHum", 1, 3,\
 20, 1028)
DeclareVariable("case900Template.outD.gain.inc.u", "Connector of Real input signal",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.gain.inc.y", "Connector of Real output signal",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.gain.azi.u", "Connector of Real input signal",\
 4.71238898038469, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.gain.azi.y", "Connector of Real output signal",\
 4.71238898038469, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.gain.epsLw.u", "Connector of Real input signal",\
 "case900Template.outD.layMul.mats[3].epsLw_a", 1, 5, 5436, 1024)
DeclareAlias2("case900Template.outD.gain.epsLw.y", "Connector of Real output signal",\
 "case900Template.outD.layMul.mats[3].epsLw_a", 1, 5, 5436, 1024)
DeclareAlias2("case900Template.outD.gain.epsSw.u", "Connector of Real input signal",\
 "case900Template.outD.layMul.mats[3].epsSw_a", 1, 5, 5438, 1024)
DeclareAlias2("case900Template.outD.gain.epsSw.y", "Connector of Real output signal",\
 "case900Template.outD.layMul.mats[3].epsSw_a", 1, 5, 5438, 1024)
DeclareVariable("case900Template.outD.propsBusInt.numIncAndAziInBus", \
"Number of calculated azimuth angles, set to sim.numIncAndAziInBus [:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outD.propsBusInt.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.propsBusInt.QTra_design", "[W]", \
"case900Template.outD.QTra_design", 1, 5, 5346, 1028)
DeclareAlias2("case900Template.outD.propsBusInt.area", "[m2]", "case900Template.outD.layMul.A", 1,\
 5, 5386, 1028)
DeclareAlias2("case900Template.outD.propsBusInt.epsLw", "[1]", "case900Template.outD.layMul.mats[3].epsLw_a", 1,\
 5, 5436, 1028)
DeclareAlias2("case900Template.outD.propsBusInt.epsSw", "[1]", "case900Template.outD.layMul.mats[3].epsSw_a", 1,\
 5, 5438, 1028)
DeclareAlias2("case900Template.outD.propsBusInt.surfCon.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareVariable("case900Template.outD.propsBusInt.surfCon.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.propsBusInt.surfRad.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 34, 1028)
DeclareVariable("case900Template.outD.propsBusInt.surfRad.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.propsBusInt.iSolDir.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.propsBusInt.iSolDir.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outD.propsBusInt.iSolDif.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.propsBusInt.iSolDif.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.numSolBus", \
"[:#(type=Integer)]", 6, 0.0,0.0,0.0,0,1549)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solTim", "Solar time [s]",\
 "weaBus.solTim", 1, 3, 24, 516)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.solBus[1].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[1].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[1].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 516)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.solBus[1].HGroDifTil", \
"[W/(m2)]", 0.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[1].angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[1].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[1].angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 516)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.solBus[2].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[2].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[2].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[2].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[2].angInc", \
"[rad|deg]", "sim.radSol[2].incAng.incAng", 1, 5, 130, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[2].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[2].angAzi", \
"[rad|deg]", "sim.radSol[2].relAzi.y", 1, 5, 151, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 516)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.solBus[3].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[3].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[3].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[3].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[3].angInc", \
"[rad|deg]", "sim.radSol[3].incAng.incAng", 1, 5, 167, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[3].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[3].angAzi", \
"[rad|deg]", "sim.radSol[3].relAzi.y", 1, 5, 188, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 516)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.solBus[4].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[4].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[4].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[4].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[4].angInc", \
"[rad|deg]", "sim.radSol[4].incAng.incAng", 1, 5, 204, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[4].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[4].angAzi", \
"[rad|deg]", "sim.radSol[4].relAzi.y", 1, 5, 225, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 516)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.solBus[5].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[5].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[5].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[5].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[5].angInc", \
"[rad|deg]", "sim.radSol[5].incAng.incAng", 1, 5, 241, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[5].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[5].angAzi", \
"[rad|deg]", "sim.radSol[5].relAzi.y", 1, 5, 262, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 516)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.solBus[6].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[6].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[6].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[6].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[6].angInc", \
"[rad|deg]", "sim.radSol[6].incAng.incAng", 1, 5, 278, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[6].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 516)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.Tdes", "Design temperature? [K|degC]",\
 265.15, 0.0,1E+100,300.0,0,1545)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,1545)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.hConExt", \
"Exterior convective heat transfer coefficient [W/(m2.K)]", "sim.hCon", 1, 5, 35,\
 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.X_wEnv", "Environment air water mass fraction",\
 "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1, 5, 649, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.CEnv", "Environment air trace substance mass fraction",\
 "sim.weaBus.CEnv", 1, 5, 76, 516)
DeclareVariable("case900Template.outD.propsBusInt.weaBus.dummy", \
"Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.F1", "", "sim.weaBus.F1", 1,\
 5, 80, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.F2", "", "sim.weaBus.F2", 1,\
 5, 81, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 516)
DeclareAlias2("case900Template.outD.propsBusInt.weaBus.phi", "", "weaBus.relHum", 1,\
 3, 20, 516)
DeclareAlias2("case900Template.outD.propsBusInt.Qgai.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareVariable("case900Template.outD.propsBusInt.Qgai.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.propsBusInt.E.E", "Energy port [J]", 0.0, \
0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.propsBusInt.E.Etot", "Energy port [J]", \
0.0, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.propsBusInt.inc", "[rad|deg]", \
1.5707963267948966, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outD.propsBusInt.azi", "[rad|deg]", \
4.71238898038469, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outD.port_emb[1].T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[1].monLayDyn.T[1]", 1, 1, 31, 1028)
DeclareVariable("case900Template.outD.port_emb[1].Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.iSolDir.Q_flow", "Fixed heat flow rate at port [W]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareParameter("case900Template.outD.iSolDir.T_ref", "Reference temperature [K|degC]",\
 794, 293.15, 0.0,1E+100,300.0,0,2608)
DeclareParameter("case900Template.outD.iSolDir.alpha", "Temperature coefficient of heat flow rate [1/K]",\
 795, 0, 0.0,0.0,0.0,0,2608)
DeclareAlias2("case900Template.outD.iSolDir.port.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.iSolDir.port.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.iSolDif.Q_flow", "Fixed heat flow rate at port [W]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareParameter("case900Template.outD.iSolDif.T_ref", "Reference temperature [K|degC]",\
 796, 293.15, 0.0,1E+100,300.0,0,2608)
DeclareParameter("case900Template.outD.iSolDif.alpha", "Temperature coefficient of heat flow rate [1/K]",\
 797, 0, 0.0,0.0,0.0,0,2608)
DeclareAlias2("case900Template.outD.iSolDif.port.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outD.iSolDif.port.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outD.linExtCon", "= true, if exterior convective heat transfer should be linearised (uses average wind speed) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.linExtRad", "= true, if exterior radiative heat transfer should be linearised [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.hasBuildingShade", "=true, to enable computation of shade cast by opposite building or object [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.L", "Distance between object and wall, perpendicular to wall [m]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.dh", "Height difference between top of object and top of wall [m]",\
 0.0, -2.7,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.hWal", "Wall height [m]", 2.7, 0.0,1E+100,\
0.0,0,2561)
DeclareVariable("case900Template.outD.U_value", "Wall U-value", 0.5094596089148297,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.extCon.A", "surface area [m2]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.extCon.linearise", "Use constant convection coefficient [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("case900Template.outD.extCon.hConExtLin", "Fixed exterior convection coefficient used when linearising equations [W/(m2.K)]",\
 798, 18.3, 0.0,0.0,0.0,0,2608)
DeclareAlias2("case900Template.outD.extCon.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 32, 1028)
DeclareVariable("case900Template.outD.extCon.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outD.extCon.Te", "[K|degC]", "weaBus.TDryBul", 1,\
 3, 3, 1024)
DeclareAlias2("case900Template.outD.extCon.hConExt", "Exterior convective heat transfer coefficient [W/(m2.K)]",\
 "sim.hCon", 1, 5, 35, 1024)
DeclareVariable("case900Template.outD.solAbs.A", "Surface area [m2]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.solAbs.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 32, 1028)
DeclareVariable("case900Template.outD.solAbs.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outD.solAbs.solDir", "Direct solar irradiation on surface [W/m2]",\
 "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 1024)
DeclareVariable("case900Template.outD.solAbs.solDif", "Diffuse solar irradiation on surface [W/m2]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outD.solAbs.epsSw", "Shortwave emissivity of the surface",\
 "case900Template.outD.layMul.mats[1].epsSw_b", 1, 5, 5401, 1024)
DeclareVariable("case900Template.outD.solAbs.ASw", "Dummy for converting continuous variable into parameter [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.extRad.A", "Surface area of heat exchange surface [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareParameter("case900Template.outD.extRad.Tenv_nom", "Nominal temperature of environment [K|degC]",\
 799, 280, 0.0,1E+100,300.0,0,2608)
DeclareVariable("case900Template.outD.extRad.linearise", "If true, linearise radiative heat transfer [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareAlias2("case900Template.outD.extRad.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 32, 1028)
DeclareVariable("case900Template.outD.extRad.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outD.extRad.Tenv", "Radiative temperature of the environment",\
 "sim.weaBus.solBus[5].Tenv", 1, 5, 68, 1024)
DeclareAlias2("case900Template.outD.extRad.preTem.port.T", "Port temperature [K|degC]",\
 "sim.weaBus.solBus[5].Tenv", 1, 5, 68, 1028)
DeclareAlias2("case900Template.outD.extRad.preTem.port.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "case900Template.outD.extRad.port_a.Q_flow", 1, 5, 5689, 1156)
DeclareAlias2("case900Template.outD.extRad.preTem.T", "[K]", "sim.weaBus.solBus[5].Tenv", 1,\
 5, 68, 1024)
DeclareAlias2("case900Template.outD.extRad.epsLw", "Longwave emissivity of the surface",\
 "case900Template.outD.layMul.mats[1].epsLw_b", 1, 5, 5399, 1024)
DeclareVariable("case900Template.outD.extRad.heaRad.R", "Heat resistance for longwave radiative heat exchange [K4/W]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.extRad.heaRad.linearise", "If true, linearise radiative heat transfer [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.extRad.heaRad.Tzone_nom", "Nominal temperature of environment, used for linearisation [K|degC]",\
 288.15, 0.0,1E+100,300.0,0,2561)
DeclareParameter("case900Template.outD.extRad.heaRad.dT_nom", "Nominal temperature difference between solid and air, used for linearisation [K,]",\
 800, 5, 0.0,0.0,0.0,0,2608)
DeclareAlias2("case900Template.outD.extRad.heaRad.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outD.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 32, 1028)
DeclareAlias2("case900Template.outD.extRad.heaRad.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.extRad.port_a.Q_flow", 1, 5, 5689, 1156)
DeclareAlias2("case900Template.outD.extRad.heaRad.port_b.T", "Port temperature [K|degC]",\
 "sim.weaBus.solBus[5].Tenv", 1, 5, 68, 1028)
DeclareAlias2("case900Template.outD.extRad.heaRad.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.extRad.port_a.Q_flow", -1, 5, 5689, 1156)
DeclareVariable("case900Template.outD.extRad.heaRad.coeffLin", "Coefficient allowing less overhead for evaluation functions. This implementation is an approximation of the real linearization f(u)_lin = df/du|(u=u_bar) * (u-u_bar) + f|u_bar. The accuracy of it has been checked. [W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.extRad.heaRad.coeffNonLin", \
"Coefficient allowing less overhead for evaluation functions. [W/K4]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.extRad.R", "", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.inc", "inclination [rad|deg]", \
1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.azi", "azimuth [rad|deg]", \
4.71238898038469, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.lat", "latitude [rad|deg]", \
0.8866674025859153, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.useLinearisation", \
"Set to true if used for linearisation [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.radSolData.numIncAndAziInBus", \
"Number of pre-computed combination of inc and azi for solar radiation [:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[1, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[1, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[2, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[2, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[3, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[3, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[4, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[4, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 3.141592653589793, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[5, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[5, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 -1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[6, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 3.141592653589793, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.incAndAziInBus[6, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.radSolData.outputAngles", "Set to false when linearising only [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.radSolData.weaBus.numSolBus", \
"[:#(type=Integer)]", 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outD.radSolData.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solTim", "Solar time [s]",\
 "weaBus.solTim", 1, 3, 24, 1028)
DeclareVariable("case900Template.outD.radSolData.weaBus.solBus[1].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[1].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[1].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 1028)
DeclareVariable("case900Template.outD.radSolData.weaBus.solBus[1].HGroDifTil", \
"[W/(m2)]", 0.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[1].angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[1].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[1].angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 1028)
DeclareVariable("case900Template.outD.radSolData.weaBus.solBus[2].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[2].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[2].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[2].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[2].angInc", \
"[rad|deg]", "sim.radSol[2].incAng.incAng", 1, 5, 130, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[2].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[2].angAzi", \
"[rad|deg]", "sim.radSol[2].relAzi.y", 1, 5, 151, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 1028)
DeclareVariable("case900Template.outD.radSolData.weaBus.solBus[3].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[3].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[3].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[3].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[3].angInc", \
"[rad|deg]", "sim.radSol[3].incAng.incAng", 1, 5, 167, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[3].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[3].angAzi", \
"[rad|deg]", "sim.radSol[3].relAzi.y", 1, 5, 188, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 1028)
DeclareVariable("case900Template.outD.radSolData.weaBus.solBus[4].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[4].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[4].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[4].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[4].angInc", \
"[rad|deg]", "sim.radSol[4].incAng.incAng", 1, 5, 204, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[4].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[4].angAzi", \
"[rad|deg]", "sim.radSol[4].relAzi.y", 1, 5, 225, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 1028)
DeclareVariable("case900Template.outD.radSolData.weaBus.solBus[5].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[5].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[5].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[5].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[5].angInc", \
"[rad|deg]", "sim.radSol[5].incAng.incAng", 1, 5, 241, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[5].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[5].angAzi", \
"[rad|deg]", "sim.radSol[5].relAzi.y", 1, 5, 262, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 1028)
DeclareVariable("case900Template.outD.radSolData.weaBus.solBus[6].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[6].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[6].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[6].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[6].angInc", \
"[rad|deg]", "sim.radSol[6].incAng.incAng", 1, 5, 278, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[6].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 1028)
DeclareVariable("case900Template.outD.radSolData.weaBus.Tdes", "Design temperature? [K|degC]",\
 265.15, 0.0,1E+100,300.0,0,2569)
DeclareVariable("case900Template.outD.radSolData.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,2569)
DeclareAlias2("case900Template.outD.radSolData.weaBus.hConExt", "Exterior convective heat transfer coefficient [W/(m2.K)]",\
 "sim.hCon", 1, 5, 35, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.X_wEnv", "Environment air water mass fraction",\
 "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1, 5, 649, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.CEnv", "Environment air trace substance mass fraction",\
 "sim.weaBus.CEnv", 1, 5, 76, 1028)
DeclareVariable("case900Template.outD.radSolData.weaBus.dummy", "Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outD.radSolData.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.F1", "", "sim.weaBus.F1", 1,\
 5, 80, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.F2", "", "sim.weaBus.F2", 1,\
 5, 81, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 1028)
DeclareAlias2("case900Template.outD.radSolData.weaBus.phi", "", "weaBus.relHum", 1,\
 3, 20, 1028)
DeclareAlias2("case900Template.outD.radSolData.HDirTil", "Direct solar irradiation on a tilted surface",\
 "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 1024)
DeclareAlias2("case900Template.outD.radSolData.HGroDifTil", "Diffuse sky solar irradiance on a tilted surface",\
 "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 1024)
DeclareAlias2("case900Template.outD.radSolData.HSkyDifTil", "Diffuse sky solar irradiance on a tilted surface",\
 "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 1024)
DeclareAlias2("case900Template.outD.radSolData.angInc", "", "sim.radSol[5].incAng.incAng", 1,\
 5, 241, 1024)
DeclareAlias2("case900Template.outD.radSolData.angZen", "", "weaBus.solZen", 1, 3,\
 25, 1024)
DeclareAlias2("case900Template.outD.radSolData.angAzi", "", "sim.radSol[5].relAzi.y", 1,\
 5, 262, 1024)
DeclareAlias2("case900Template.outD.radSolData.angHou", "Hour angle", \
"weaBus.solHouAng", 1, 3, 23, 1024)
DeclareAlias2("case900Template.outD.radSolData.Tenv", "Environment temperature",\
 "sim.weaBus.solBus[5].Tenv", 1, 5, 68, 1024)
DeclareVariable("case900Template.outD.radSolData.numMatches", "[:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.radSolData.solDataInBus", "True if the {inc,azi} combination is found in incAndAziInBus [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.radSolData.solDataIndex", "Index of the {inc,azi} combination in incAndAziInBus [:#(type=Integer)]",\
 5, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.radSolData.solBusDummy.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outD.radSolData.solBusDummy.HDirTil", "[W/(m2)]",\
 "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 1028)
DeclareAlias2("case900Template.outD.radSolData.solBusDummy.HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 1028)
DeclareAlias2("case900Template.outD.radSolData.solBusDummy.HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 1028)
DeclareAlias2("case900Template.outD.radSolData.solBusDummy.angInc", "[rad|deg]",\
 "sim.radSol[5].incAng.incAng", 1, 5, 241, 1028)
DeclareAlias2("case900Template.outD.radSolData.solBusDummy.angZen", "[rad|deg]",\
 "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outD.radSolData.solBusDummy.angAzi", "[rad|deg]",\
 "sim.radSol[5].relAzi.y", 1, 5, 262, 1028)
DeclareAlias2("case900Template.outD.radSolData.solBusDummy.Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 1028)
DeclareVariable("case900Template.outD.Tdes.u", "Connector of Real input signal",\
 265.15, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.Tdes.y", "Connector of Real output signal",\
 265.15, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outD.solDif.u1", "Connector of Real input signal 1",\
 "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 1024)
DeclareAlias2("case900Template.outD.solDif.u2", "Connector of Real input signal 2",\
 "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 1024)
DeclareAlias2("case900Template.outD.solDif.y", "Connector of Real output signal",\
 "case900Template.outD.solAbs.solDif", 1, 5, 5685, 1024)
DeclareVariable("case900Template.outD.solDif.k1", "Gain of upper input", 1, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.solDif.k2", "Gain of lower input", 1, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.nLay", "Number of layers of the construction, including gaps [:#(type=Integer)]",\
 3, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outCei.constructionType.nGain", \
"Number of gain heat ports [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.constructionType.locGain[1]", \
"Location of possible embedded system: between layer locGain and layer locGain + 1 [:#(type=Integer)]",\
 1, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outCei.constructionType.mats[1].k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].c", \
"Specific thermal capacity [J/(kg.K)]", 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].rho", \
"Density [kg/m3|g/cm3]", 530.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].d", \
"Layer thickness [m]", 0.019, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.constructionType.mats[1].glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.constructionType.mats[1].mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].R", "[m2.K/W]",\
 0.1357142857142857, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].alpha", \
"Thermal diffusivity [m2/s]", 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.constructionType.mats[1].piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 35.0710503325545, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[1].nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outCei.constructionType.mats[2].k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].c", \
"Specific thermal capacity [J/(kg.K)]", 840.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].rho", \
"Density [kg/m3|g/cm3]", 12.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].d", \
"Layer thickness [m]", 0.1118, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.constructionType.mats[2].glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.constructionType.mats[2].mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].R", "[m2.K/W]",\
 2.795, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].alpha", \
"Thermal diffusivity [m2/s]", 3.968253968253968E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.constructionType.mats[2].piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 56.12315457990579, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[2].nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outCei.constructionType.mats[3].k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].c", \
"Specific thermal capacity [J/(kg.K)]", 840.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].rho", \
"Density [kg/m3|g/cm3]", 950.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].d", \
"Layer thickness [m]", 0.01, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.constructionType.mats[3].glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.constructionType.mats[3].mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].R", "[m2.K/W]",\
 0.0625, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].alpha", \
"Thermal diffusivity [m2/s]", 2.0050125313283207E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.constructionType.mats[3].piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 22.332711434127297, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.constructionType.mats[3].nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outCei.constructionType.incLastLay", \
"Set to IDEAS.Types.Tilt.Floor if the last layer of mats is a floor, to .Ceiling if it is a ceiling and to .Other if other. For verification purposes. [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.inc", "Inclination (tilt) angle of the wall, see IDEAS.Types.Tilt [rad|deg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.azi", "Azimuth angle of the wall, i.e. see IDEAS.Types.Azimuth, set IDEAS.Types.Azimuth.S for horizontal ceilings and floors [rad|deg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.A", "Component surface area [m2]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.nWin", "Use this factor to scale the component to nWin identical components",\
 1, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.QTra_design", "Design heat losses at reference temperature of the boundary space [W]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.T_start", "Start temperature for each of the layers [K|degC]",\
 293.15, 0.0,1E+100,300.0,0,2561)
DeclareParameter("case900Template.outCei.TRef_a", "Reference temperature of zone on side of propsBus_a, for calculation of design heat loss [K|degC]",\
 801, 291.15, 0.0,1E+100,300.0,0,2608)
DeclareVariable("case900Template.outCei.linIntCon_a", "= true, if convective heat transfer should be linearised [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.dT_nominal_a", "Nominal temperature difference used for linearisation, negative temperatures indicate the solid is colder [K,]",\
 -3.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.energyDynamics", "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.propsBus_a.numIncAndAziInBus", \
"Number of calculated azimuth angles, set to sim.numIncAndAziInBus [:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outCei.propsBus_a.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.propsBus_a.QTra_design", "[W]", \
"case900Template.outCei.QTra_design", 1, 5, 5799, 1028)
DeclareAlias2("case900Template.outCei.propsBus_a.area", "[m2]", "case900Template.outCei.layMul.A", 1,\
 5, 5839, 1028)
DeclareAlias2("case900Template.outCei.propsBus_a.epsLw", "[1]", "case900Template.outCei.layMul.mats[3].epsLw_a", 1,\
 5, 5889, 1028)
DeclareAlias2("case900Template.outCei.propsBus_a.epsSw", "[1]", "case900Template.outCei.layMul.mats[3].epsSw_a", 1,\
 5, 5891, 1028)
DeclareAlias2("case900Template.outCei.propsBus_a.surfCon.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outCei.propsBus_a.surfCon.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.airModel.ports_surf[6].Q_flow", -1, 5, 3305, 1156)
DeclareAlias2("case900Template.outCei.propsBus_a.surfRad.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 39, 1028)
DeclareVariable("case900Template.outCei.propsBus_a.surfRad.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outCei.propsBus_a.iSolDir.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.propsBus_a.iSolDir.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.propsBus_a.iSolDif.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.propsBus_a.iSolDif.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.numSolBus", \
"[:#(type=Integer)]", 6, 0.0,0.0,0.0,0,1549)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solTim", \
"Solar time [s]", "weaBus.solTim", 1, 3, 24, 516)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.solBus[1].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[1].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[1].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 516)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.solBus[1].HGroDifTil",\
 "[W/(m2)]", 0.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[1].angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[1].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[1].angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 516)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.solBus[2].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[2].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[2].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[2].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[2].angInc", \
"[rad|deg]", "sim.radSol[2].incAng.incAng", 1, 5, 130, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[2].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[2].angAzi", \
"[rad|deg]", "sim.radSol[2].relAzi.y", 1, 5, 151, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 516)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.solBus[3].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[3].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[3].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[3].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[3].angInc", \
"[rad|deg]", "sim.radSol[3].incAng.incAng", 1, 5, 167, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[3].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[3].angAzi", \
"[rad|deg]", "sim.radSol[3].relAzi.y", 1, 5, 188, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 516)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.solBus[4].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[4].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[4].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[4].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[4].angInc", \
"[rad|deg]", "sim.radSol[4].incAng.incAng", 1, 5, 204, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[4].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[4].angAzi", \
"[rad|deg]", "sim.radSol[4].relAzi.y", 1, 5, 225, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 516)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.solBus[5].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[5].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[5].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[5].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[5].angInc", \
"[rad|deg]", "sim.radSol[5].incAng.incAng", 1, 5, 241, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[5].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[5].angAzi", \
"[rad|deg]", "sim.radSol[5].relAzi.y", 1, 5, 262, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 516)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.solBus[6].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[6].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[6].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[6].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[6].angInc", \
"[rad|deg]", "sim.radSol[6].incAng.incAng", 1, 5, 278, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[6].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 516)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.Tdes", \
"Design temperature? [K|degC]", 265.15, 0.0,1E+100,300.0,0,1545)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,1545)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.hConExt", \
"Exterior convective heat transfer coefficient [W/(m2.K)]", "sim.hCon", 1, 5, 35,\
 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.X_wEnv", \
"Environment air water mass fraction", "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1,\
 5, 649, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.CEnv", "Environment air trace substance mass fraction",\
 "sim.weaBus.CEnv", 1, 5, 76, 516)
DeclareVariable("case900Template.outCei.propsBus_a.weaBus.dummy", \
"Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.F1", "", "sim.weaBus.F1", 1,\
 5, 80, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.F2", "", "sim.weaBus.F2", 1,\
 5, 81, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.weaBus.phi", "", \
"weaBus.relHum", 1, 3, 20, 516)
DeclareAlias2("case900Template.outCei.propsBus_a.Qgai.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareVariable("case900Template.outCei.propsBus_a.Qgai.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2824)
DeclareVariable("case900Template.outCei.propsBus_a.E.E", "Energy port [J]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.propsBus_a.E.Etot", "Energy port [J]", \
0.0, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.propsBus_a.inc", "[rad|deg]", 0.0, \
0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.propsBus_a.azi", "[rad|deg]", 0.0, \
0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.intCon_a.A", "surface area [m2]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.intCon_a.inc", "inclination [rad|deg]", 0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.intCon_a.linearise", "= true, if convective heat transfer should be linearised [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.intCon_a.dT_nominal", "Nominal temperature difference used for linearisation, negative temperatures indicate the solid is colder [K,]",\
 -3.0, 0.0,0.0,0.0,0,2561)
DeclareParameter("case900Template.outCei.intCon_a.hZone", "Zone height, for calculation of hydraulic diameter [m]",\
 802, 2.7, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outCei.intCon_a.DhWall", "Hydraulic diameter for walls [m]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.intCon_a.DhFloor", "Hydraulic diameter for ceiling/floor [m]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.intCon_a.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 39, 1028)
DeclareAlias2("case900Template.outCei.intCon_a.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "case900Template.airModel.ports_surf[6].Q_flow", 1, 5, 3305, 1156)
DeclareAlias2("case900Template.outCei.intCon_a.port_b.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outCei.intCon_a.port_b.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "case900Template.airModel.ports_surf[6].Q_flow", -1, 5, 3305, 1156)
DeclareVariable("case900Template.outCei.intCon_a.dT", "[K,]", 0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outCei.intCon_a.coeffWall", "For avoiding calculation of power at every time step",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.intCon_a.coeffFloor", "For avoiding calculations at every time step",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.intCon_a.coeffCeiling", "For avoiding calculations at every time step",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.intCon_a.isCeiling", "true if ceiling [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.intCon_a.isFloor", "true if floor [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.intCon_a.ceilingSign", "Coefficient for buoyancy direction",\
 1, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.A", "total multilayer area [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.inc", "Inclinination angle of the multilayer at port_a [rad|deg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.nLay", "number of layers [:#(type=Integer)]",\
 3, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.mats[1].k", "Thermal conductivity [W/(m.K)]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].c", "Specific thermal capacity [J/(kg.K)]",\
 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].rho", "Density [kg/m3|g/cm3]",\
 530.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].d", "Layer thickness [m]",\
 0.019, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].epsLw", "Longwave emisivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].epsSw", "Shortwave emissivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].gas", "Boolean whether the material is a gas [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.mats[1].glass", "Boolean whether the material is made of glass [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.mats[1].mhu", "Viscosity, i.e. if the material is a fluid [m2/s]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].R", "[m2.K/W]", \
0.1357142857142857, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].alpha", "Thermal diffusivity [m2/s]",\
 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.mats[1].piRef", "d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete",\
 224.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].piLay", "d/sqrt(mat.alpha) of the depicted layer",\
 35.0710503325545, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[1].nSta", "Actual number of state variables in material [:#(type=Integer)]",\
 2, 2.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.mats[2].k", "Thermal conductivity [W/(m.K)]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].c", "Specific thermal capacity [J/(kg.K)]",\
 840.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].rho", "Density [kg/m3|g/cm3]",\
 12.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].d", "Layer thickness [m]",\
 0.1118, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].epsLw", "Longwave emisivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].epsSw", "Shortwave emissivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].gas", "Boolean whether the material is a gas [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.mats[2].glass", "Boolean whether the material is made of glass [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.mats[2].mhu", "Viscosity, i.e. if the material is a fluid [m2/s]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].R", "[m2.K/W]", 2.795, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].alpha", "Thermal diffusivity [m2/s]",\
 3.968253968253968E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.mats[2].piRef", "d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete",\
 224.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].piLay", "d/sqrt(mat.alpha) of the depicted layer",\
 56.12315457990579, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[2].nSta", "Actual number of state variables in material [:#(type=Integer)]",\
 2, 2.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.mats[3].k", "Thermal conductivity [W/(m.K)]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].c", "Specific thermal capacity [J/(kg.K)]",\
 840.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].rho", "Density [kg/m3|g/cm3]",\
 950.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].d", "Layer thickness [m]",\
 0.01, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].epsLw", "Longwave emisivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].epsSw", "Shortwave emissivity [1]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].gas", "Boolean whether the material is a gas [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.mats[3].glass", "Boolean whether the material is made of glass [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.mats[3].mhu", "Viscosity, i.e. if the material is a fluid [m2/s]",\
 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].R", "[m2.K/W]", 0.0625, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].alpha", "Thermal diffusivity [m2/s]",\
 2.0050125313283207E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.mats[3].piRef", "d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete",\
 224.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].piLay", "d/sqrt(mat.alpha) of the depicted layer",\
 22.332711434127297, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.mats[3].nSta", "Actual number of state variables in material [:#(type=Integer)]",\
 2, 2.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.nGain", "Number of gains [:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.linIntCon", "Linearise interior convection inside air layers / cavities in walls [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.R", "total specific thermal resistance [m2.K/W]",\
 2.9932142857142856, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.C", "Total heat capacity of the layers [J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.T_start[1]", "Start temperature from port_b to port_a [K|degC]",\
 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.T_start[2]", "Start temperature from port_b to port_a [K|degC]",\
 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.T_start[3]", "Start temperature from port_b to port_a [K|degC]",\
 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.energyDynamics", "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.disableInitPortA", \
"Remove initial equation at port a [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.disableInitPortB", \
"Remove initial equation at port b [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareParameter("case900Template.outCei.layMul.dT_nom_air", "Nominal temperature difference for air layers, used for linearising Rayleigh number [K,]",\
 803, 1, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outCei.layMul.E", "[J]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outCei.layMul.monLay[1].A", "Layer surface area [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.c", \
"Specific thermal capacity [J/(kg.K)]", 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.rho", \
"Density [kg/m3|g/cm3]", 530.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.d", \
"Layer thickness [m]", 0.019, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.R", "[m2.K/W]", \
0.1357142857142857, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.alpha", \
"Thermal diffusivity [m2/s]", 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 35.0710503325545, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[1].inc", "Inclinination angle of the layer at port_a [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].epsLw_a", \
"Longwave emissivity of material connected at port_a [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].epsLw_b", \
"Longwave emissivity on material connected at port_b [1]", 0.85, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].linIntCon", \
"Linearise interior convection inside air layers / cavities in walls [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[1].energyDynamics", \
"Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[1].T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].R", "Total specific thermal resistance [m2.K/W]",\
 0.1357142857142857, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].isDynamic", \
"[:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[1].E", "[J]", 0.0, \
0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outCei.layMul.monLay[1].port_a.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 36, 1028)
DeclareVariable("case900Template.outCei.layMul.monLay[1].port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outCei.layMul.monLay[1].port_b.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[1].monLayDyn.T[2]", 1,\
 1, 37, 1028)
DeclareAlias2("case900Template.outCei.layMul.monLay[1].port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.layMul.port_b.Q_flow", 1, 5, 6018, 1156)
DeclareAlias2("case900Template.outCei.layMul.monLay[1].port_gain.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 36, 1028)
DeclareVariable("case900Template.outCei.layMul.monLay[1].port_gain.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.layMul.monLay[1].E_internal", "", \
"case900Template.outCei.layMul.monLay[1].E", 1, 5, 5938, 1024)
DeclareVariable("case900Template.outCei.layMul.monLay[1].dynamicLayer", \
"True when modelling thermal dynamics [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[1].realLayer", \
"True when the layer has a non-zero thickness [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[1].airLayer", \
"True when a convection + radiation equation should be used to model the layer instead of conduction [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[1].dT_nom_air", \
"Nominal temperature difference for air layers, used for linearising Rayleigh number [K,]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].A", "Layer surface area [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.c", \
"Specific thermal capacity [J/(kg.K)]", 840.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.rho", \
"Density [kg/m3|g/cm3]", 12.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.d", \
"Layer thickness [m]", 0.1118, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.R", "[m2.K/W]", \
2.795, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.alpha", \
"Thermal diffusivity [m2/s]", 3.968253968253968E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 56.12315457990579, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[2].inc", "Inclinination angle of the layer at port_a [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].epsLw_a", \
"Longwave emissivity of material connected at port_a [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].epsLw_b", \
"Longwave emissivity on material connected at port_b [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].linIntCon", \
"Linearise interior convection inside air layers / cavities in walls [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[2].energyDynamics", \
"Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[2].T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].R", "Total specific thermal resistance [m2.K/W]",\
 2.795, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].isDynamic", \
"[:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[2].E", "[J]", 0.0, \
0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outCei.layMul.monLay[2].port_a.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 38, 1028)
DeclareVariable("case900Template.outCei.layMul.monLay[2].port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outCei.layMul.monLay[2].port_b.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 36, 1028)
DeclareAlias2("case900Template.outCei.layMul.monLay[2].port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.layMul.monLay[1].port_a.Q_flow", -1, 5, 5939, 1156)
DeclareAlias2("case900Template.outCei.layMul.monLay[2].port_gain.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 38, 1028)
DeclareVariable("case900Template.outCei.layMul.monLay[2].port_gain.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.layMul.monLay[2].E_internal", "", \
"case900Template.outCei.layMul.monLay[2].E", 1, 5, 5973, 1024)
DeclareVariable("case900Template.outCei.layMul.monLay[2].dynamicLayer", \
"True when modelling thermal dynamics [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[2].realLayer", \
"True when the layer has a non-zero thickness [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[2].airLayer", \
"True when a convection + radiation equation should be used to model the layer instead of conduction [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[2].dT_nom_air", \
"Nominal temperature difference for air layers, used for linearising Rayleigh number [K,]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].A", "Layer surface area [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.c", \
"Specific thermal capacity [J/(kg.K)]", 840.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.rho", \
"Density [kg/m3|g/cm3]", 950.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.d", \
"Layer thickness [m]", 0.01, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.R", "[m2.K/W]", \
0.0625, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.alpha", \
"Thermal diffusivity [m2/s]", 2.0050125313283207E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 22.332711434127297, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[3].inc", "Inclinination angle of the layer at port_a [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].epsLw_a", \
"Longwave emissivity of material connected at port_a [1]", 0.85, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].epsLw_b", \
"Longwave emissivity on material connected at port_b [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].linIntCon", \
"Linearise interior convection inside air layers / cavities in walls [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[3].energyDynamics", \
"Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[3].T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].R", "Total specific thermal resistance [m2.K/W]",\
 0.0625, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].isDynamic", \
"[:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[3].E", "[J]", 0.0, \
0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].port_a.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1,\
 1, 39, 1028)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.layMul.port_a.Q_flow", 1, 5, 6017, 1156)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].port_b.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 38, 1028)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.layMul.monLay[2].port_a.Q_flow", -1, 5, 5974, 1156)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].port_gain.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1,\
 1, 39, 1028)
DeclareVariable("case900Template.outCei.layMul.monLay[3].port_gain.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].E_internal", "", \
"case900Template.outCei.layMul.monLay[3].E", 1, 5, 6008, 1024)
DeclareVariable("case900Template.outCei.layMul.monLay[3].dynamicLayer", \
"True when modelling thermal dynamics [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[3].realLayer", \
"True when the layer has a non-zero thickness [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[3].airLayer", \
"True when a convection + radiation equation should be used to model the layer instead of conduction [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[3].dT_nom_air", \
"Nominal temperature difference for air layers, used for linearising Rayleigh number [K,]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.layMul.port_gain[1].T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[1].monLayDyn.T[1]", 1, 1, 36, 1028)
DeclareVariable("case900Template.outCei.layMul.port_gain[1].Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.layMul.port_gain[2].T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[2].monLayDyn.T[1]", 1, 1, 38, 1028)
DeclareVariable("case900Template.outCei.layMul.port_gain[2].Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.layMul.port_gain[3].T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 39, 1028)
DeclareVariable("case900Template.outCei.layMul.port_gain[3].Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.layMul.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 39, 1028)
DeclareVariable("case900Template.outCei.layMul.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outCei.layMul.port_b.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 37, 1028)
DeclareVariable("case900Template.outCei.layMul.port_b.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outCei.layMul.iEpsLw_b", "output of the interior emissivity for radiative heat losses",\
 "case900Template.outCei.layMul.mats[1].epsLw_b", 1, 5, 5852, 1024)
DeclareAlias2("case900Template.outCei.layMul.iEpsSw_b", "output of the interior emissivity for radiative heat losses",\
 "case900Template.outCei.layMul.mats[1].epsSw_b", 1, 5, 5854, 1024)
DeclareAlias2("case900Template.outCei.layMul.iEpsLw_a", "output of the interior emissivity for radiative heat losses",\
 "case900Template.outCei.layMul.mats[3].epsLw_a", 1, 5, 5889, 1024)
DeclareAlias2("case900Template.outCei.layMul.iEpsSw_a", "output of the interior emissivity for radiative heat losses",\
 "case900Template.outCei.layMul.mats[3].epsSw_a", 1, 5, 5891, 1024)
DeclareAlias2("case900Template.outCei.layMul.area", "output of the interior emissivity for radiative heat losses",\
 "case900Template.outCei.layMul.A", 1, 5, 5839, 1024)
DeclareAlias2("case900Template.outCei.QDesign.y", "Value of Real output", \
"case900Template.outCei.QTra_design", 1, 5, 5799, 1024)
DeclareVariable("case900Template.outCei.aziExp.y", "Value of Real output", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.incExp.y", "Value of Real output", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.E.y", "Value of Real output", 0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.prescribedHeatFlowE.E", "[J]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.prescribedHeatFlowE.port.E", \
"Energy port [J]", 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.prescribedHeatFlowE.port.Etot", \
"Energy port [J]", 0.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outCei.Qgai.y", "Value of Real output", \
"case900Template.outCei.layMul.port_b.Q_flow", 1, 5, 6018, 1024)
DeclareParameter("case900Template.outCei.prescribedHeatFlowQgai.T_ref", \
"Reference temperature [K|degC]", 804, 293.15, 0.0,1E+100,300.0,0,2608)
DeclareParameter("case900Template.outCei.prescribedHeatFlowQgai.alpha", \
"Temperature coefficient of heat flow rate [1/K]", 805, 0, 0.0,0.0,0.0,0,2608)
DeclareAlias2("case900Template.outCei.prescribedHeatFlowQgai.Q_flow", "[W]", \
"case900Template.outCei.layMul.port_b.Q_flow", 1, 5, 6018, 1024)
DeclareAlias2("case900Template.outCei.prescribedHeatFlowQgai.port.T", \
"Port temperature [K|degC]", "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareAlias2("case900Template.outCei.prescribedHeatFlowQgai.port.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.propsBus_a.Qgai.Q_flow", 1, 5, 5821, 1156)
DeclareVariable("case900Template.outCei.gain.k", "Scaling factor", 1.0, 0.0,0.0,\
0.0,0,2561)
DeclareVariable("case900Template.outCei.gain.propsBus_a.numIncAndAziInBus", \
"Number of calculated azimuth angles, set to sim.numIncAndAziInBus [:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outCei.gain.propsBus_a.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.QTra_design", "[W]", \
"case900Template.outCei.QTra_design", 1, 5, 5799, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.area", "[m2]", \
"case900Template.outCei.layMul.A", 1, 5, 5839, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.epsLw", "[1]", \
"case900Template.outCei.layMul.mats[3].epsLw_a", 1, 5, 5889, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.epsSw", "[1]", \
"case900Template.outCei.layMul.mats[3].epsSw_a", 1, 5, 5891, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.surfCon.T", \
"Port temperature [K|degC]", "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.surfCon.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.airModel.ports_surf[6].Q_flow", 1, 5, 3305, 1156)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.surfRad.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1,\
 1, 39, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.surfRad.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.propsBus_a.surfRad.Q_flow", -1, 5, 5806, 1156)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.iSolDir.T", \
"Port temperature [K|degC]", "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.gain.propsBus_a.iSolDir.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.iSolDif.T", \
"Port temperature [K|degC]", "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.gain.propsBus_a.iSolDif.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.numSolBus", \
"[:#(type=Integer)]", 6, 0.0,0.0,0.0,0,1549)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solTim", \
"Solar time [s]", "weaBus.solTim", 1, 3, 24, 516)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.solBus[1].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[1].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[1].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 516)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.solBus[1].HGroDifTil",\
 "[W/(m2)]", 0.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[1].angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[1].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[1].angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 516)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.solBus[2].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[2].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[2].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[2].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[2].angInc", \
"[rad|deg]", "sim.radSol[2].incAng.incAng", 1, 5, 130, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[2].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[2].angAzi", \
"[rad|deg]", "sim.radSol[2].relAzi.y", 1, 5, 151, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 516)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.solBus[3].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[3].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[3].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[3].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[3].angInc", \
"[rad|deg]", "sim.radSol[3].incAng.incAng", 1, 5, 167, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[3].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[3].angAzi", \
"[rad|deg]", "sim.radSol[3].relAzi.y", 1, 5, 188, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 516)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.solBus[4].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[4].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[4].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[4].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[4].angInc", \
"[rad|deg]", "sim.radSol[4].incAng.incAng", 1, 5, 204, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[4].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[4].angAzi", \
"[rad|deg]", "sim.radSol[4].relAzi.y", 1, 5, 225, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 516)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.solBus[5].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[5].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[5].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[5].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[5].angInc", \
"[rad|deg]", "sim.radSol[5].incAng.incAng", 1, 5, 241, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[5].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[5].angAzi", \
"[rad|deg]", "sim.radSol[5].relAzi.y", 1, 5, 262, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 516)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.solBus[6].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[6].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[6].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[6].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[6].angInc", \
"[rad|deg]", "sim.radSol[6].incAng.incAng", 1, 5, 278, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[6].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.Te", \
"Ambient sensible temperature [K|degC]", "weaBus.TDryBul", 1, 3, 3, 516)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.Tdes", \
"Design temperature? [K|degC]", 265.15, 0.0,1E+100,300.0,0,1545)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,1545)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.hConExt", \
"Exterior convective heat transfer coefficient [W/(m2.K)]", "sim.hCon", 1, 5, 35,\
 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.X_wEnv", \
"Environment air water mass fraction", "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1,\
 5, 649, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.CEnv", \
"Environment air trace substance mass fraction", "sim.weaBus.CEnv", 1, 5, 76, 516)
DeclareVariable("case900Template.outCei.gain.propsBus_a.weaBus.dummy", \
"Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.F1", "", \
"sim.weaBus.F1", 1, 5, 80, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.F2", "", \
"sim.weaBus.F2", 1, 5, 81, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.weaBus.phi", "", \
"weaBus.relHum", 1, 3, 20, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.Qgai.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_a.Qgai.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.propsBus_a.Qgai.Q_flow", -1, 5, 5821, 1156)
DeclareVariable("case900Template.outCei.gain.propsBus_a.E.E", "Energy port [J]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.gain.propsBus_a.E.Etot", \
"Energy port [J]", 0.0, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.gain.propsBus_a.inc", "[rad|deg]", 0.0, \
0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.gain.propsBus_a.azi", "[rad|deg]", 0.0, \
0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.gain.propsBus_b.numIncAndAziInBus", \
"Number of calculated azimuth angles, set to sim.numIncAndAziInBus [:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outCei.gain.propsBus_b.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.QTra_design", "[W]", \
"case900Template.outCei.QTra_design", 1, 5, 5799, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.area", "[m2]", \
"case900Template.outCei.layMul.A", 1, 5, 5839, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.epsLw", "[1]", \
"case900Template.outCei.layMul.mats[3].epsLw_a", 1, 5, 5889, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.epsSw", "[1]", \
"case900Template.outCei.layMul.mats[3].epsSw_a", 1, 5, 5891, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.surfCon.T", \
"Port temperature [K|degC]", "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.surfCon.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.airModel.ports_surf[6].Q_flow", -1, 5, 3305, 1156)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.surfRad.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1,\
 1, 39, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.surfRad.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.propsBus_a.surfRad.Q_flow", 1, 5, 5806, 1156)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.iSolDir.T", \
"Port temperature [K|degC]", "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.gain.propsBus_b.iSolDir.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.iSolDif.T", \
"Port temperature [K|degC]", "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.gain.propsBus_b.iSolDif.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.numSolBus", \
"[:#(type=Integer)]", 6, 0.0,0.0,0.0,0,1549)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solTim", \
"Solar time [s]", "weaBus.solTim", 1, 3, 24, 516)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.solBus[1].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[1].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[1].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 516)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.solBus[1].HGroDifTil",\
 "[W/(m2)]", 0.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[1].angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[1].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[1].angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 516)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.solBus[2].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[2].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[2].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[2].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[2].angInc", \
"[rad|deg]", "sim.radSol[2].incAng.incAng", 1, 5, 130, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[2].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[2].angAzi", \
"[rad|deg]", "sim.radSol[2].relAzi.y", 1, 5, 151, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 516)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.solBus[3].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[3].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[3].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[3].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[3].angInc", \
"[rad|deg]", "sim.radSol[3].incAng.incAng", 1, 5, 167, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[3].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[3].angAzi", \
"[rad|deg]", "sim.radSol[3].relAzi.y", 1, 5, 188, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 516)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.solBus[4].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[4].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[4].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[4].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[4].angInc", \
"[rad|deg]", "sim.radSol[4].incAng.incAng", 1, 5, 204, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[4].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[4].angAzi", \
"[rad|deg]", "sim.radSol[4].relAzi.y", 1, 5, 225, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 516)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.solBus[5].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[5].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[5].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[5].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[5].angInc", \
"[rad|deg]", "sim.radSol[5].incAng.incAng", 1, 5, 241, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[5].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[5].angAzi", \
"[rad|deg]", "sim.radSol[5].relAzi.y", 1, 5, 262, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 516)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.solBus[6].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[6].HDirTil",\
 "[W/(m2)]", "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[6].HSkyDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[6].HGroDifTil",\
 "[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[6].angInc", \
"[rad|deg]", "sim.radSol[6].incAng.incAng", 1, 5, 278, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[6].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.Te", \
"Ambient sensible temperature [K|degC]", "weaBus.TDryBul", 1, 3, 3, 516)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.Tdes", \
"Design temperature? [K|degC]", 265.15, 0.0,1E+100,300.0,0,1545)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,1545)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.hConExt", \
"Exterior convective heat transfer coefficient [W/(m2.K)]", "sim.hCon", 1, 5, 35,\
 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.X_wEnv", \
"Environment air water mass fraction", "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1,\
 5, 649, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.CEnv", \
"Environment air trace substance mass fraction", "sim.weaBus.CEnv", 1, 5, 76, 516)
DeclareVariable("case900Template.outCei.gain.propsBus_b.weaBus.dummy", \
"Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.F1", "", \
"sim.weaBus.F1", 1, 5, 80, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.F2", "", \
"sim.weaBus.F2", 1, 5, 81, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.weaBus.phi", "", \
"weaBus.relHum", 1, 3, 20, 516)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.Qgai.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareAlias2("case900Template.outCei.gain.propsBus_b.Qgai.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.propsBus_a.Qgai.Q_flow", 1, 5, 5821, 1156)
DeclareVariable("case900Template.outCei.gain.propsBus_b.E.E", "Energy port [J]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.gain.propsBus_b.E.Etot", \
"Energy port [J]", 0.0, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.gain.propsBus_b.inc", "[rad|deg]", 0.0, \
0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.gain.propsBus_b.azi", "[rad|deg]", 0.0, \
0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.gain.QTra_desgin.k", "Gain value multiplied with input signal [1]",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.gain.QTra_desgin.u", "Input signal connector",\
 "case900Template.outCei.QTra_design", 1, 5, 5799, 1024)
DeclareAlias2("case900Template.outCei.gain.QTra_desgin.y", "Output signal connector",\
 "case900Template.outCei.QTra_design", 1, 5, 5799, 1024)
DeclareVariable("case900Template.outCei.gain.area.k", "Gain value multiplied with input signal [1]",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.gain.area.u", "Input signal connector", \
"case900Template.outCei.layMul.A", 1, 5, 5839, 1024)
DeclareAlias2("case900Template.outCei.gain.area.y", "Output signal connector", \
"case900Template.outCei.layMul.A", 1, 5, 5839, 1024)
DeclareVariable("case900Template.outCei.gain.surfCon.k", "Multiplication factor for heat flow rate",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.gain.surfCon.port_a.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outCei.gain.surfCon.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.airModel.ports_surf[6].Q_flow", 1, 5, 3305, 1156)
DeclareAlias2("case900Template.outCei.gain.surfCon.port_b.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareAlias2("case900Template.outCei.gain.surfCon.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.airModel.ports_surf[6].Q_flow", -1, 5, 3305, 1156)
DeclareVariable("case900Template.outCei.gain.surfRad.k", "Multiplication factor for heat flow rate",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.gain.surfRad.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 39, 1028)
DeclareAlias2("case900Template.outCei.gain.surfRad.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.propsBus_a.surfRad.Q_flow", -1, 5, 5806, 1156)
DeclareAlias2("case900Template.outCei.gain.surfRad.port_b.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 39, 1028)
DeclareAlias2("case900Template.outCei.gain.surfRad.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.propsBus_a.surfRad.Q_flow", 1, 5, 5806, 1156)
DeclareVariable("case900Template.outCei.gain.iSolDir.k", "Multiplication factor for heat flow rate",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.gain.iSolDir.port_a.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.gain.iSolDir.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.gain.iSolDir.port_b.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.gain.iSolDir.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.gain.iSolDif.k", "Multiplication factor for heat flow rate",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.gain.iSolDif.port_a.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.gain.iSolDif.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.gain.iSolDif.port_b.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.gain.iSolDif.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.gain.QGai.k", "Multiplication factor for heat flow rate",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.gain.QGai.port_a.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareAlias2("case900Template.outCei.gain.QGai.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "case900Template.outCei.propsBus_a.Qgai.Q_flow", -1, 5, 5821, 1156)
DeclareAlias2("case900Template.outCei.gain.QGai.port_b.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareAlias2("case900Template.outCei.gain.QGai.port_b.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 "case900Template.outCei.propsBus_a.Qgai.Q_flow", 1, 5, 5821, 1156)
DeclareVariable("case900Template.outCei.gain.E.k", "Multiplication factor for heat flow",\
 1.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.gain.E.E_a.E", "Energy port [J]", 0.0, \
0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.gain.E.E_a.Etot", "Energy port [J]", 0.0,\
 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.gain.E.E_b.E", "Energy port [J]", 0.0, \
0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.gain.E.E_b.Etot", "Energy port [J]", 0.0,\
 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.gain.weaBus.numSolBus", "[:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outCei.gain.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.gain.weaBus.solTim", "Solar time [s]", \
"weaBus.solTim", 1, 3, 24, 1028)
DeclareVariable("case900Template.outCei.gain.weaBus.solBus[1].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[1].HDirTil", "[W/(m2)]",\
 "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[1].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 1028)
DeclareVariable("case900Template.outCei.gain.weaBus.solBus[1].HGroDifTil", \
"[W/(m2)]", 0.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[1].angInc", "[rad|deg]",\
 "sim.radSol[1].incAng.incAng", 1, 5, 92, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[1].angZen", "[rad|deg]",\
 "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[1].angAzi", "[rad|deg]",\
 "sim.radSol[1].relAzi.y", 1, 5, 114, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 1028)
DeclareVariable("case900Template.outCei.gain.weaBus.solBus[2].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[2].HDirTil", "[W/(m2)]",\
 "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[2].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[2].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[2].angInc", "[rad|deg]",\
 "sim.radSol[2].incAng.incAng", 1, 5, 130, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[2].angZen", "[rad|deg]",\
 "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[2].angAzi", "[rad|deg]",\
 "sim.radSol[2].relAzi.y", 1, 5, 151, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 1028)
DeclareVariable("case900Template.outCei.gain.weaBus.solBus[3].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[3].HDirTil", "[W/(m2)]",\
 "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[3].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[3].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[3].angInc", "[rad|deg]",\
 "sim.radSol[3].incAng.incAng", 1, 5, 167, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[3].angZen", "[rad|deg]",\
 "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[3].angAzi", "[rad|deg]",\
 "sim.radSol[3].relAzi.y", 1, 5, 188, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 1028)
DeclareVariable("case900Template.outCei.gain.weaBus.solBus[4].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[4].HDirTil", "[W/(m2)]",\
 "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[4].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[4].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[4].angInc", "[rad|deg]",\
 "sim.radSol[4].incAng.incAng", 1, 5, 204, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[4].angZen", "[rad|deg]",\
 "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[4].angAzi", "[rad|deg]",\
 "sim.radSol[4].relAzi.y", 1, 5, 225, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 1028)
DeclareVariable("case900Template.outCei.gain.weaBus.solBus[5].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[5].HDirTil", "[W/(m2)]",\
 "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[5].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[5].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[5].angInc", "[rad|deg]",\
 "sim.radSol[5].incAng.incAng", 1, 5, 241, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[5].angZen", "[rad|deg]",\
 "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[5].angAzi", "[rad|deg]",\
 "sim.radSol[5].relAzi.y", 1, 5, 262, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 1028)
DeclareVariable("case900Template.outCei.gain.weaBus.solBus[6].outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[6].HDirTil", "[W/(m2)]",\
 "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[6].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[6].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[6].angInc", "[rad|deg]",\
 "sim.radSol[6].incAng.incAng", 1, 5, 278, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[6].angZen", "[rad|deg]",\
 "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[6].angAzi", "[rad|deg]",\
 "sim.radSol[6].relAzi.y", 1, 5, 299, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 1028)
DeclareVariable("case900Template.outCei.gain.weaBus.Tdes", "Design temperature? [K|degC]",\
 265.15, 0.0,1E+100,300.0,0,2569)
DeclareVariable("case900Template.outCei.gain.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,2569)
DeclareAlias2("case900Template.outCei.gain.weaBus.hConExt", "Exterior convective heat transfer coefficient [W/(m2.K)]",\
 "sim.hCon", 1, 5, 35, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.X_wEnv", "Environment air water mass fraction",\
 "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1, 5, 649, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.CEnv", "Environment air trace substance mass fraction",\
 "sim.weaBus.CEnv", 1, 5, 76, 1028)
DeclareVariable("case900Template.outCei.gain.weaBus.dummy", "Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outCei.gain.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.TePow4", "", "sim.weaBus.TePow4", 1,\
 5, 79, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.F1", "", "sim.weaBus.F1", 1, 5,\
 80, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.F2", "", "sim.weaBus.F2", 1, 5,\
 81, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.angZen", "", "weaBus.solZen", 1,\
 3, 25, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.angHou", "", "weaBus.solHouAng", 1,\
 3, 23, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.angDec", "", "weaBus.solDec", 1,\
 3, 22, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 1028)
DeclareAlias2("case900Template.outCei.gain.weaBus.phi", "", "weaBus.relHum", 1, 3,\
 20, 1028)
DeclareVariable("case900Template.outCei.gain.inc.u", "Connector of Real input signal",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.gain.inc.y", "Connector of Real output signal",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.gain.azi.u", "Connector of Real input signal",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.gain.azi.y", "Connector of Real output signal",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.gain.epsLw.u", "Connector of Real input signal",\
 "case900Template.outCei.layMul.mats[3].epsLw_a", 1, 5, 5889, 1024)
DeclareAlias2("case900Template.outCei.gain.epsLw.y", "Connector of Real output signal",\
 "case900Template.outCei.layMul.mats[3].epsLw_a", 1, 5, 5889, 1024)
DeclareAlias2("case900Template.outCei.gain.epsSw.u", "Connector of Real input signal",\
 "case900Template.outCei.layMul.mats[3].epsSw_a", 1, 5, 5891, 1024)
DeclareAlias2("case900Template.outCei.gain.epsSw.y", "Connector of Real output signal",\
 "case900Template.outCei.layMul.mats[3].epsSw_a", 1, 5, 5891, 1024)
DeclareVariable("case900Template.outCei.propsBusInt.numIncAndAziInBus", \
"Number of calculated azimuth angles, set to sim.numIncAndAziInBus [:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outCei.propsBusInt.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.propsBusInt.QTra_design", "[W]", \
"case900Template.outCei.QTra_design", 1, 5, 5799, 1028)
DeclareAlias2("case900Template.outCei.propsBusInt.area", "[m2]", \
"case900Template.outCei.layMul.A", 1, 5, 5839, 1028)
DeclareAlias2("case900Template.outCei.propsBusInt.epsLw", "[1]", \
"case900Template.outCei.layMul.mats[3].epsLw_a", 1, 5, 5889, 1028)
DeclareAlias2("case900Template.outCei.propsBusInt.epsSw", "[1]", \
"case900Template.outCei.layMul.mats[3].epsSw_a", 1, 5, 5891, 1028)
DeclareAlias2("case900Template.outCei.propsBusInt.surfCon.T", "Port temperature [K|degC]",\
 "case900Template.gainCon.T", 1, 5, 503, 1028)
DeclareVariable("case900Template.outCei.propsBusInt.surfCon.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.propsBusInt.surfRad.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1, 1, 39, 1028)
DeclareVariable("case900Template.outCei.propsBusInt.surfRad.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.propsBusInt.iSolDir.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.propsBusInt.iSolDir.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareAlias2("case900Template.outCei.propsBusInt.iSolDif.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.propsBusInt.iSolDif.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.numSolBus", \
"[:#(type=Integer)]", 6, 0.0,0.0,0.0,0,1549)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solTim", \
"Solar time [s]", "weaBus.solTim", 1, 3, 24, 516)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.solBus[1].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[1].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[1].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 516)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.solBus[1].HGroDifTil",\
 "[W/(m2)]", 0.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[1].angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[1].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[1].angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 516)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.solBus[2].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[2].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[2].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[2].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[2].angInc", \
"[rad|deg]", "sim.radSol[2].incAng.incAng", 1, 5, 130, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[2].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[2].angAzi", \
"[rad|deg]", "sim.radSol[2].relAzi.y", 1, 5, 151, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 516)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.solBus[3].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[3].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[3].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[3].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[3].angInc", \
"[rad|deg]", "sim.radSol[3].incAng.incAng", 1, 5, 167, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[3].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[3].angAzi", \
"[rad|deg]", "sim.radSol[3].relAzi.y", 1, 5, 188, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 516)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.solBus[4].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[4].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[4].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[4].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[4].angInc", \
"[rad|deg]", "sim.radSol[4].incAng.incAng", 1, 5, 204, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[4].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[4].angAzi", \
"[rad|deg]", "sim.radSol[4].relAzi.y", 1, 5, 225, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 516)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.solBus[5].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[5].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[5].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[5].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[5].angInc", \
"[rad|deg]", "sim.radSol[5].incAng.incAng", 1, 5, 241, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[5].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[5].angAzi", \
"[rad|deg]", "sim.radSol[5].relAzi.y", 1, 5, 262, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 516)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.solBus[6].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,1547)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[6].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[6].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[6].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[6].angInc", \
"[rad|deg]", "sim.radSol[6].incAng.incAng", 1, 5, 278, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[6].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 516)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.Tdes", \
"Design temperature? [K|degC]", 265.15, 0.0,1E+100,300.0,0,1545)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,1545)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.hConExt", \
"Exterior convective heat transfer coefficient [W/(m2.K)]", "sim.hCon", 1, 5, 35,\
 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.X_wEnv", \
"Environment air water mass fraction", "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1,\
 5, 649, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.CEnv", "Environment air trace substance mass fraction",\
 "sim.weaBus.CEnv", 1, 5, 76, 516)
DeclareVariable("case900Template.outCei.propsBusInt.weaBus.dummy", \
"Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,1545)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.F1", "", \
"sim.weaBus.F1", 1, 5, 80, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.F2", "", \
"sim.weaBus.F2", 1, 5, 81, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.weaBus.phi", "", \
"weaBus.relHum", 1, 3, 20, 516)
DeclareAlias2("case900Template.outCei.propsBusInt.Qgai.T", "Port temperature [K|degC]",\
 "sim.fixedTemperature.T", 1, 7, 23, 1028)
DeclareVariable("case900Template.outCei.propsBusInt.Qgai.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.propsBusInt.E.E", "Energy port [J]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.propsBusInt.E.Etot", "Energy port [J]", \
0.0, 0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.propsBusInt.inc", "[rad|deg]", 0.0, \
0.0,0.0,0.0,0,2569)
DeclareVariable("case900Template.outCei.propsBusInt.azi", "[rad|deg]", 0.0, \
0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outCei.port_emb[1].T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[1].monLayDyn.T[1]", 1, 1, 36, 1028)
DeclareVariable("case900Template.outCei.port_emb[1].Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.iSolDir.Q_flow", "Fixed heat flow rate at port [W]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareParameter("case900Template.outCei.iSolDir.T_ref", "Reference temperature [K|degC]",\
 806, 293.15, 0.0,1E+100,300.0,0,2608)
DeclareParameter("case900Template.outCei.iSolDir.alpha", "Temperature coefficient of heat flow rate [1/K]",\
 807, 0, 0.0,0.0,0.0,0,2608)
DeclareAlias2("case900Template.outCei.iSolDir.port.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.iSolDir.port.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.iSolDif.Q_flow", "Fixed heat flow rate at port [W]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareParameter("case900Template.outCei.iSolDif.T_ref", "Reference temperature [K|degC]",\
 808, 293.15, 0.0,1E+100,300.0,0,2608)
DeclareParameter("case900Template.outCei.iSolDif.alpha", "Temperature coefficient of heat flow rate [1/K]",\
 809, 0, 0.0,0.0,0.0,0,2608)
DeclareAlias2("case900Template.outCei.iSolDif.port.T", "Port temperature [K|degC]",\
 "case900Template.gainRad.T", 1, 5, 501, 1028)
DeclareVariable("case900Template.outCei.iSolDif.port.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.outCei.linExtCon", "= true, if exterior convective heat transfer should be linearised (uses average wind speed) [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.linExtRad", "= true, if exterior radiative heat transfer should be linearised [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.hasBuildingShade", "=true, to enable computation of shade cast by opposite building or object [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("case900Template.outCei.L", "Distance between object and wall, perpendicular to wall [m]",\
 810, 0, 0.0,1E+100,0.0,0,2608)
DeclareParameter("case900Template.outCei.dh", "Height difference between top of object and top of wall [m]",\
 811, 0, 0.0,1E+100,0.0,0,2608)
DeclareVariable("case900Template.outCei.hWal", "Wall height [m]", 0, 0.0,1E+100,\
0.0,0,2561)
DeclareVariable("case900Template.outCei.U_value", "Wall U-value", \
0.3166346262580572, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.extCon.A", "surface area [m2]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.extCon.linearise", "Use constant convection coefficient [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareParameter("case900Template.outCei.extCon.hConExtLin", "Fixed exterior convection coefficient used when linearising equations [W/(m2.K)]",\
 812, 18.3, 0.0,0.0,0.0,0,2608)
DeclareAlias2("case900Template.outCei.extCon.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 37, 1028)
DeclareVariable("case900Template.outCei.extCon.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outCei.extCon.Te", "[K|degC]", "weaBus.TDryBul", 1,\
 3, 3, 1024)
DeclareAlias2("case900Template.outCei.extCon.hConExt", "Exterior convective heat transfer coefficient [W/(m2.K)]",\
 "sim.hCon", 1, 5, 35, 1024)
DeclareVariable("case900Template.outCei.solAbs.A", "Surface area [m2]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.solAbs.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 37, 1028)
DeclareVariable("case900Template.outCei.solAbs.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outCei.solAbs.solDir", "Direct solar irradiation on surface [W/m2]",\
 "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 1024)
DeclareAlias2("case900Template.outCei.solAbs.solDif", "Diffuse solar irradiation on surface [W/m2]",\
 "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 1024)
DeclareAlias2("case900Template.outCei.solAbs.epsSw", "Shortwave emissivity of the surface",\
 "case900Template.outCei.layMul.mats[1].epsSw_b", 1, 5, 5854, 1024)
DeclareVariable("case900Template.outCei.solAbs.ASw", "Dummy for converting continuous variable into parameter [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.extRad.A", "Surface area of heat exchange surface [m2]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareParameter("case900Template.outCei.extRad.Tenv_nom", "Nominal temperature of environment [K|degC]",\
 813, 280, 0.0,1E+100,300.0,0,2608)
DeclareVariable("case900Template.outCei.extRad.linearise", "If true, linearise radiative heat transfer [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareAlias2("case900Template.outCei.extRad.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 37, 1028)
DeclareVariable("case900Template.outCei.extRad.port_a.Q_flow", "Heat flow rate (positive if flowing from outside into the component) [W]",\
 0.0, 0.0,0.0,0.0,0,2824)
DeclareAlias2("case900Template.outCei.extRad.Tenv", "Radiative temperature of the environment",\
 "sim.weaBus.solBus[1].Tenv", 1, 5, 48, 1024)
DeclareAlias2("case900Template.outCei.extRad.preTem.port.T", "Port temperature [K|degC]",\
 "sim.weaBus.solBus[1].Tenv", 1, 5, 48, 1028)
DeclareAlias2("case900Template.outCei.extRad.preTem.port.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.extRad.port_a.Q_flow", 1, 5, 6139, 1156)
DeclareAlias2("case900Template.outCei.extRad.preTem.T", "[K]", "sim.weaBus.solBus[1].Tenv", 1,\
 5, 48, 1024)
DeclareAlias2("case900Template.outCei.extRad.epsLw", "Longwave emissivity of the surface",\
 "case900Template.outCei.layMul.mats[1].epsLw_b", 1, 5, 5852, 1024)
DeclareVariable("case900Template.outCei.extRad.heaRad.R", "Heat resistance for longwave radiative heat exchange [K4/W]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.extRad.heaRad.linearise", \
"If true, linearise radiative heat transfer [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareVariable("case900Template.outCei.extRad.heaRad.Tzone_nom", \
"Nominal temperature of environment, used for linearisation [K|degC]", 288.15, \
0.0,1E+100,300.0,0,2561)
DeclareParameter("case900Template.outCei.extRad.heaRad.dT_nom", "Nominal temperature difference between solid and air, used for linearisation [K,]",\
 814, 5, 0.0,0.0,0.0,0,2608)
DeclareAlias2("case900Template.outCei.extRad.heaRad.port_a.T", "Port temperature [K|degC]",\
 "case900Template.outCei.layMul.monLay[1].monLayDyn.T[2]", 1, 1, 37, 1028)
DeclareAlias2("case900Template.outCei.extRad.heaRad.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.extRad.port_a.Q_flow", 1, 5, 6139, 1156)
DeclareAlias2("case900Template.outCei.extRad.heaRad.port_b.T", "Port temperature [K|degC]",\
 "sim.weaBus.solBus[1].Tenv", 1, 5, 48, 1028)
DeclareAlias2("case900Template.outCei.extRad.heaRad.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.extRad.port_a.Q_flow", -1, 5, 6139, 1156)
DeclareVariable("case900Template.outCei.extRad.heaRad.coeffLin", \
"Coefficient allowing less overhead for evaluation functions. This implementation is an approximation of the real linearization f(u)_lin = df/du|(u=u_bar) * (u-u_bar) + f|u_bar. The accuracy of it has been checked. [W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.extRad.heaRad.coeffNonLin", \
"Coefficient allowing less overhead for evaluation functions. [W/K4]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.extRad.R", "", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.inc", "inclination [rad|deg]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.azi", "azimuth [rad|deg]", 0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.lat", "latitude [rad|deg]", \
0.8866674025859153, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.useLinearisation", \
"Set to true if used for linearisation [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.radSolData.numIncAndAziInBus", \
"Number of pre-computed combination of inc and azi for solar radiation [:#(type=Integer)]",\
 6, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[1, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[1, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[2, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[2, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[3, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[3, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[4, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[4, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 3.141592653589793, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[5, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[5, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 -1.5707963267948966, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[6, 1]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 3.141592653589793, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.incAndAziInBus[6, 2]", \
"Combination of {inclination, azimuth} for which the solar data is available in weaBus. [rad|deg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.radSolData.outputAngles", \
"Set to false when linearising only [:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.radSolData.weaBus.numSolBus", \
"[:#(type=Integer)]", 6, 0.0,0.0,0.0,0,2573)
DeclareVariable("case900Template.outCei.radSolData.weaBus.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solTim", \
"Solar time [s]", "weaBus.solTim", 1, 3, 24, 1028)
DeclareVariable("case900Template.outCei.radSolData.weaBus.solBus[1].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[1].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[1].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 1028)
DeclareVariable("case900Template.outCei.radSolData.weaBus.solBus[1].HGroDifTil",\
 "[W/(m2)]", 0.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[1].angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[1].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[1].angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[1].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 1028)
DeclareVariable("case900Template.outCei.radSolData.weaBus.solBus[2].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[2].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HDirTil", 1, 5, 50, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[2].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HSkyDifTil", 1, 5, 51, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[2].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[2].HGroDifTil", 1, 5, 52, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[2].angInc", \
"[rad|deg]", "sim.radSol[2].incAng.incAng", 1, 5, 130, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[2].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[2].angAzi", \
"[rad|deg]", "sim.radSol[2].relAzi.y", 1, 5, 151, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[2].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[2].Tenv", 1, 5, 53,\
 1028)
DeclareVariable("case900Template.outCei.radSolData.weaBus.solBus[3].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[3].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HDirTil", 1, 5, 55, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[3].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HSkyDifTil", 1, 5, 56, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[3].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[3].HGroDifTil", 1, 5, 57, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[3].angInc", \
"[rad|deg]", "sim.radSol[3].incAng.incAng", 1, 5, 167, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[3].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[3].angAzi", \
"[rad|deg]", "sim.radSol[3].relAzi.y", 1, 5, 188, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[3].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[3].Tenv", 1, 5, 58,\
 1028)
DeclareVariable("case900Template.outCei.radSolData.weaBus.solBus[4].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[4].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HDirTil", 1, 5, 60, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[4].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HSkyDifTil", 1, 5, 61, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[4].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[4].HGroDifTil", 1, 5, 62, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[4].angInc", \
"[rad|deg]", "sim.radSol[4].incAng.incAng", 1, 5, 204, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[4].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[4].angAzi", \
"[rad|deg]", "sim.radSol[4].relAzi.y", 1, 5, 225, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[4].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[4].Tenv", 1, 5, 63,\
 1028)
DeclareVariable("case900Template.outCei.radSolData.weaBus.solBus[5].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[5].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HDirTil", 1, 5, 65, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[5].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HSkyDifTil", 1, 5, 66, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[5].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[5].HGroDifTil", 1, 5, 67, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[5].angInc", \
"[rad|deg]", "sim.radSol[5].incAng.incAng", 1, 5, 241, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[5].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[5].angAzi", \
"[rad|deg]", "sim.radSol[5].relAzi.y", 1, 5, 262, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[5].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[5].Tenv", 1, 5, 68,\
 1028)
DeclareVariable("case900Template.outCei.radSolData.weaBus.solBus[6].outputAngles",\
 "Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[6].HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HDirTil", 1, 5, 70, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[6].HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HSkyDifTil", 1, 5, 71, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[6].HGroDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[6].HGroDifTil", 1, 5, 72, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[6].angInc", \
"[rad|deg]", "sim.radSol[6].incAng.incAng", 1, 5, 278, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[6].angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[6].angAzi", \
"[rad|deg]", "sim.radSol[6].relAzi.y", 1, 5, 299, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solBus[6].Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[6].Tenv", 1, 5, 73,\
 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.Te", "Ambient sensible temperature [K|degC]",\
 "weaBus.TDryBul", 1, 3, 3, 1028)
DeclareVariable("case900Template.outCei.radSolData.weaBus.Tdes", \
"Design temperature? [K|degC]", 265.15, 0.0,1E+100,300.0,0,2569)
DeclareVariable("case900Template.outCei.radSolData.weaBus.TGroundDes", \
"Design ground temperature [K|degC]", 283.15, 0.0,1E+100,300.0,0,2569)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.hConExt", \
"Exterior convective heat transfer coefficient [W/(m2.K)]", "sim.hCon", 1, 5, 35,\
 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.X_wEnv", \
"Environment air water mass fraction", "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1,\
 5, 649, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.CEnv", "Environment air trace substance mass fraction",\
 "sim.weaBus.CEnv", 1, 5, 76, 1028)
DeclareVariable("case900Template.outCei.radSolData.weaBus.dummy", \
"Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)",\
 1.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.TskyPow4", "", \
"sim.weaBus.TskyPow4", 1, 5, 78, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.TePow4", "", \
"sim.weaBus.TePow4", 1, 5, 79, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solGloHor", "", \
"weaBus.HGloHor", 1, 3, 7, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solDifHor", "", \
"weaBus.HDifHor", 1, 3, 5, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.F1", "", "sim.weaBus.F1", 1,\
 5, 80, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.F2", "", "sim.weaBus.F2", 1,\
 5, 81, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.angZen", "", \
"weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.angHou", "", \
"weaBus.solHouAng", 1, 3, 23, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.angDec", "", \
"weaBus.solDec", 1, 3, 22, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.solDirPer", "", \
"weaBus.HDirNor", 1, 3, 6, 1028)
DeclareAlias2("case900Template.outCei.radSolData.weaBus.phi", "", \
"weaBus.relHum", 1, 3, 20, 1028)
DeclareAlias2("case900Template.outCei.radSolData.HDirTil", "Direct solar irradiation on a tilted surface",\
 "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 1024)
DeclareVariable("case900Template.outCei.radSolData.HGroDifTil", "Diffuse sky solar irradiance on a tilted surface",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.radSolData.HSkyDifTil", "Diffuse sky solar irradiance on a tilted surface",\
 "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 1024)
DeclareAlias2("case900Template.outCei.radSolData.angInc", "", "sim.radSol[1].incAng.incAng", 1,\
 5, 92, 1024)
DeclareAlias2("case900Template.outCei.radSolData.angZen", "", "weaBus.solZen", 1,\
 3, 25, 1024)
DeclareAlias2("case900Template.outCei.radSolData.angAzi", "", "sim.radSol[1].relAzi.y", 1,\
 5, 114, 1024)
DeclareAlias2("case900Template.outCei.radSolData.angHou", "Hour angle", \
"weaBus.solHouAng", 1, 3, 23, 1024)
DeclareAlias2("case900Template.outCei.radSolData.Tenv", "Environment temperature",\
 "sim.weaBus.solBus[1].Tenv", 1, 5, 48, 1024)
DeclareVariable("case900Template.outCei.radSolData.numMatches", "[:#(type=Integer)]",\
 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.radSolData.solDataInBus", \
"True if the {inc,azi} combination is found in incAndAziInBus [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.radSolData.solDataIndex", \
"Index of the {inc,azi} combination in incAndAziInBus [:#(type=Integer)]", 1, \
0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.radSolData.solBusDummy.outputAngles", \
"Set to false when linearising in Dymola only [:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2571)
DeclareAlias2("case900Template.outCei.radSolData.solBusDummy.HDirTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HDirTil", 1, 5, 45, 1028)
DeclareAlias2("case900Template.outCei.radSolData.solBusDummy.HSkyDifTil", \
"[W/(m2)]", "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 1028)
DeclareVariable("case900Template.outCei.radSolData.solBusDummy.HGroDifTil", \
"[W/(m2)]", 0.0, 0.0,0.0,0.0,0,2569)
DeclareAlias2("case900Template.outCei.radSolData.solBusDummy.angInc", \
"[rad|deg]", "sim.radSol[1].incAng.incAng", 1, 5, 92, 1028)
DeclareAlias2("case900Template.outCei.radSolData.solBusDummy.angZen", \
"[rad|deg]", "weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("case900Template.outCei.radSolData.solBusDummy.angAzi", \
"[rad|deg]", "sim.radSol[1].relAzi.y", 1, 5, 114, 1028)
DeclareAlias2("case900Template.outCei.radSolData.solBusDummy.Tenv", \
"Equivalent radiant temperature [K|degC]", "sim.weaBus.solBus[1].Tenv", 1, 5, 48,\
 1028)
DeclareVariable("case900Template.outCei.Tdes.u", "Connector of Real input signal",\
 265.15, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.Tdes.y", "Connector of Real output signal",\
 265.15, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.solDif.u1", "Connector of Real input signal 1",\
 "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 1024)
DeclareVariable("case900Template.outCei.solDif.u2", "Connector of Real input signal 2",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.outCei.solDif.y", "Connector of Real output signal",\
 "sim.weaBus.solBus[1].HSkyDifTil", 1, 5, 46, 1024)
DeclareVariable("case900Template.outCei.solDif.k1", "Gain of upper input", 1, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.solDif.k2", "Gain of lower input", 1, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.winA.layMul.monLay[1].monLaySta.R", \
"Total specific thermal resistance [K/W]", 0.00024960691823899367, 0.0,0.0,0.0,0,513)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.theCon_a.Q_flow",\
 "Heat flow rate from port_a -> port_b [W]", "case900Template.winA.layMul.monLay[1].port_a.Q_flow", 1,\
 5, 2137, 0)
DeclareVariable("case900Template.winA.layMul.monLay[1].monLaySta.theCon_a.dT", \
"port_a.T - port_b.T [K,]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.theCon_a.port_a.T",\
 "Port temperature [K|degC]", "case900Template.winA.layMul.monLay[1].port_a.T", 1,\
 5, 2136, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.theCon_a.port_a.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.monLay[1].port_a.Q_flow", 1, 5, 2137, 132)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.theCon_a.port_b.T",\
 "Port temperature [K|degC]", "case900Template.winA.layMul.port_gain[1].T", 1, 5,\
 2213, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.theCon_a.port_b.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.monLay[1].port_a.Q_flow", -1, 5, 2137, 132)
DeclareVariable("case900Template.winA.layMul.monLay[1].monLaySta.theCon_a.G", \
"Constant thermal conductance of material [W/K]", 8012.598425196852, 0.0,0.0,0.0,\
0,513)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.port_gain.T", \
"Port temperature [K|degC]", "case900Template.winA.layMul.port_gain[1].T", 1, 5,\
 2213, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.port_gain.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.port_gain[1].Q_flow", 1, 5, 2214, 132)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.theCon_b.Q_flow",\
 "Heat flow rate from port_a -> port_b [W]", "case900Template.winA.layMul.port_b.Q_flow", -1,\
 5, 2221, 0)
DeclareVariable("case900Template.winA.layMul.monLay[1].monLaySta.theCon_b.dT", \
"port_a.T - port_b.T [K,]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.theCon_b.port_a.T",\
 "Port temperature [K|degC]", "case900Template.winA.layMul.port_gain[1].T", 1, 5,\
 2213, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.theCon_b.port_a.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.port_b.Q_flow", -1, 5, 2221, 132)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.theCon_b.port_b.T",\
 "Port temperature [K|degC]", "case900Template.winA.layMul.port_b.T", 1, 5, 2220,\
 4)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.theCon_b.port_b.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.port_b.Q_flow", 1, 5, 2221, 132)
DeclareVariable("case900Template.winA.layMul.monLay[1].monLaySta.theCon_b.G", \
"Constant thermal conductance of material [W/K]", 8012.598425196852, 0.0,0.0,0.0,\
0,513)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.port_a.T", \
"Port temperature [K|degC]", "case900Template.winA.layMul.monLay[1].port_a.T", 1,\
 5, 2136, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.monLay[1].port_a.Q_flow", 1, 5, 2137, 132)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.port_b.T", \
"Port temperature [K|degC]", "case900Template.winA.layMul.port_b.T", 1, 5, 2220,\
 4)
DeclareAlias2("case900Template.winA.layMul.monLay[1].monLaySta.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.port_b.Q_flow", 1, 5, 2221, 132)
DeclareVariable("case900Template.winA.layMul.monLay[1].monLaySta.G2", "[W/K]", \
8012.598425196852, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.A", \
"Surface area [m2]", 12.0, 0.0,0.0,0.0,0,513)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.inc", \
"Inclination of surface at port a [rad|deg]", 1.5707963267948966, 0.0,0.0,0.0,0,513)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.d", \
"Cavity width [m]", 0.013, 0.0,0.0,0.0,0,513)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.epsLw_a", \
"Longwave emissivity of material connected at port_a [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.epsLw_b", \
"Longwave emissivity on material connected at port_b [1]", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.dT_nominal", \
"Nominal temperature difference, used for linearising Rayleigh number [K,]", 5.0,\
 0.0,0.0,0.0,0,513)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.k", \
"Thermal conductivity of medium, default for air, T=20C [W/(m.K)]", 0.0, \
0.0,0.0,0.0,0,513)
DeclareParameter("case900Template.winA.layMul.monLay[2].monLayAir.beta", \
"Thermal expansion coefficient of medium, default for air, T=20C [1/K]", 815, \
0.00343, 0.0,100000000.0,0.0,0,560)
DeclareParameter("case900Template.winA.layMul.monLay[2].monLayAir.nu", \
"Kinematic viscosity of medium, default for air, T=20C [m2/s]", 816, 1.5E-05, \
0.0,1E+100,0.0,0,560)
DeclareParameter("case900Template.winA.layMul.monLay[2].monLayAir.alpha", \
"Thermal diffusivity of medium, default for air, T=300K [m2/s]", 817, 2.2E-05, \
0.0,0.0,0.0,0,560)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.linearise", \
"Linearise Grashoff number around expected nominal temperature difference [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,515)
DeclareAlias2("case900Template.winA.layMul.monLay[2].monLayAir.port_a.T", \
"Port temperature [K|degC]", "case900Template.winA.layMul.monLay[2].port_a.T", 1,\
 5, 2172, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[2].monLayAir.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.monLay[2].port_a.Q_flow", 1, 5, 2173, 132)
DeclareAlias2("case900Template.winA.layMul.monLay[2].monLayAir.port_b.T", \
"Port temperature [K|degC]", "case900Template.winA.layMul.monLay[1].port_a.T", 1,\
 5, 2136, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[2].monLayAir.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.monLay[1].port_a.Q_flow", -1, 5, 2137, 132)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.G", "[W/K]", \
0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.Nu", \
"Correlations from Hollands et al. and Wright et al.", 0.0, 0.0,0.0,0.0,0,513)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.ceiling", \
"true if ceiling [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.floor", \
"true if floor [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.vertical", \
"[:#(type=Boolean)]", true, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.coeffRa", \
"Coefficient for evaluating less operations at run time", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.Ra", "", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.winA.layMul.monLay[2].monLayAir.h", \
"[W/(m2.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareAlias2("case900Template.winA.layMul.monLay[2].monLayAir.port_emb.T", \
"Port temperature [K|degC]", "case900Template.winA.layMul.port_gain[2].T", 1, 5,\
 2215, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[2].monLayAir.port_emb.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.port_gain[2].Q_flow", 1, 5, 2216, 132)
DeclareVariable("case900Template.winA.layMul.monLay[3].monLaySta.R", \
"Total specific thermal resistance [K/W]", 0.00024960691823899367, 0.0,0.0,0.0,0,513)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.theCon_a.Q_flow",\
 "Heat flow rate from port_a -> port_b [W]", "case900Template.winA.layMul.port_a.Q_flow", 1,\
 5, 2219, 0)
DeclareVariable("case900Template.winA.layMul.monLay[3].monLaySta.theCon_a.dT", \
"port_a.T - port_b.T [K,]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.theCon_a.port_a.T",\
 "Port temperature [K|degC]", "case900Template.winA.heaCapGla.T", 1, 1, 0, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.theCon_a.port_a.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.port_a.Q_flow", 1, 5, 2219, 132)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.theCon_a.port_b.T",\
 "Port temperature [K|degC]", "case900Template.winA.layMul.port_gain[3].T", 1, 5,\
 2217, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.theCon_a.port_b.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.port_a.Q_flow", -1, 5, 2219, 132)
DeclareVariable("case900Template.winA.layMul.monLay[3].monLaySta.theCon_a.G", \
"Constant thermal conductance of material [W/K]", 8012.598425196852, 0.0,0.0,0.0,\
0,513)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.port_gain.T", \
"Port temperature [K|degC]", "case900Template.winA.layMul.port_gain[3].T", 1, 5,\
 2217, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.port_gain.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.port_gain[3].Q_flow", 1, 5, 2218, 132)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.theCon_b.Q_flow",\
 "Heat flow rate from port_a -> port_b [W]", "case900Template.winA.layMul.monLay[2].port_a.Q_flow", 1,\
 5, 2173, 0)
DeclareVariable("case900Template.winA.layMul.monLay[3].monLaySta.theCon_b.dT", \
"port_a.T - port_b.T [K,]", 0.0, 0.0,0.0,0.0,0,512)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.theCon_b.port_a.T",\
 "Port temperature [K|degC]", "case900Template.winA.layMul.port_gain[3].T", 1, 5,\
 2217, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.theCon_b.port_a.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.monLay[2].port_a.Q_flow", 1, 5, 2173, 132)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.theCon_b.port_b.T",\
 "Port temperature [K|degC]", "case900Template.winA.layMul.monLay[2].port_a.T", 1,\
 5, 2172, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.theCon_b.port_b.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.monLay[2].port_a.Q_flow", -1, 5, 2173, 132)
EndNonAlias(5)
PreNonAliasNew(6)
StartNonAlias(6)
DeclareVariable("case900Template.winA.layMul.monLay[3].monLaySta.theCon_b.G", \
"Constant thermal conductance of material [W/K]", 8012.598425196852, 0.0,0.0,0.0,\
0,513)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.port_a.T", \
"Port temperature [K|degC]", "case900Template.winA.heaCapGla.T", 1, 1, 0, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.port_a.Q_flow", 1, 5, 2219, 132)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.port_b.T", \
"Port temperature [K|degC]", "case900Template.winA.layMul.monLay[2].port_a.T", 1,\
 5, 2172, 4)
DeclareAlias2("case900Template.winA.layMul.monLay[3].monLaySta.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.winA.layMul.monLay[2].port_a.Q_flow", -1, 5, 2173, 132)
DeclareVariable("case900Template.winA.layMul.monLay[3].monLaySta.G2", "[W/K]", \
8012.598425196852, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.energyDynamics", "Type of energy balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[1].dynBal.massDynamics", "Type of mass balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[1].dynBal.substanceDynamics", "Type of independent mass fraction balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[1].dynBal.traceDynamics", "Type of trace substance balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[1].dynBal.p_start", "Start value of pressure [Pa|bar]",\
 300000, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.T_start", "Start value of temperature [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.X_start[1]", "Start value of mass fractions m_i/m [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,2561)
DeclareVariable("rad.vol[1].dynBal.mSenFac", "Factor for scaling the sensible thermal mass of the volume",\
 1.5442861740360443, 1.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("rad.vol[1].dynBal.simplify_mWat_flow", "Set to true to cause port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero. Used only if Medium.nX > 1 [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[1].dynBal.nPorts", "Number of ports [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("rad.vol[1].dynBal.use_mWat_flow", "Set to true to enable input connector for moisture mass flow rate [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[1].dynBal.use_C_flow", "Set to true to enable input connector for trace substance [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareAlias2("rad.vol[1].dynBal.Q_flow", "Sensible plus latent heat flow rate transferred into the medium [W]",\
 "rad.vol[1].heatPort.Q_flow", 1, 5, 2822, 1024)
DeclareAlias2("rad.vol[1].dynBal.hOut", "Leaving specific enthalpy of the component [J/kg]",\
 "rad.port_a.h_outflow", 1, 5, 2765, 1024)
DeclareAlias2("rad.vol[1].dynBal.UOut", "Internal energy of the component [J]", \
"rad.vol[1].dynBal.U", 1, 1, 8, 1024)
DeclareVariable("rad.vol[1].dynBal.mOut", "Mass of the component [kg]", \
2.3097595200000005, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("rad.vol[1].dynBal.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", 1, 5, 3140, 1156)
DeclareAlias2("rad.vol[1].dynBal.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("rad.vol[1].dynBal.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "rad.port_a.h_outflow", 1, 5, 2765, 1028)
DeclareAlias2("rad.vol[1].dynBal.ports[2].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", -1, 5, 3140, 1156)
DeclareAlias2("rad.vol[1].dynBal.ports[2].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("rad.vol[1].dynBal.ports[2].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "rad.port_a.h_outflow", 1, 5, 2765, 1028)
DeclareVariable("rad.vol[1].dynBal.medium.T", "Temperature of medium [K|degC]", \
300.0, 1.0,10000.0,300.0,0,2560)
DeclareAlias2("rad.vol[1].dynBal.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "bou.p", 1, 7, 729, 1024)
DeclareAlias2("rad.vol[1].dynBal.medium.h", "Specific enthalpy of medium [J/kg]",\
 "rad.port_a.h_outflow", 1, 5, 2765, 1024)
DeclareAlias2("rad.vol[1].dynBal.medium.u", "Specific internal energy of medium [J/kg]",\
 "rad.port_a.h_outflow", 1, 5, 2765, 1024)
DeclareVariable("rad.vol[1].dynBal.medium.d", "Density of medium [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [1]",\
 1, 0.0,1.0,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.medium.R", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("rad.vol[1].dynBal.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "bou.p", 1, 7, 729, 1024)
DeclareAlias2("rad.vol[1].dynBal.medium.state.T", "Temperature of medium [K|degC]",\
 "rad.vol[1].dynBal.medium.T", 1, 5, 6229, 1024)
DeclareVariable("rad.vol[1].dynBal.medium.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[1].dynBal.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[1].dynBal.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[1].dynBal.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareState("rad.vol[1].dynBal.U", "Internal energy of fluid [J]", 8, 0.0, \
0.0,0.0,100000.0,0,2592)
DeclareDerivative("rad.vol[1].dynBal.der(U)", "der(Internal energy of fluid) [W]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[1].dynBal.m", "Mass of fluid [kg]", 2.3097595200000005,\
 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.der(m)", "der(Mass of fluid) [kg/s]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.mb_flow", "Mass flows across boundaries [kg/s]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.Hb_flow", "Enthalpy flow across boundaries or energy source/sink [W]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[1].dynBal.fluidVolume", "Volume [m3]", 0.0023200000000000004,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.CSen", "Aditional heat capacity for implementing mFactor [J/K]",\
 5260.000000000002, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.ports_H_flow[1]", "[W]", 0.0, -100000000.0,\
100000000.0,1000.0,0,2560)
DeclareVariable("rad.vol[1].dynBal.ports_H_flow[2]", "[W]", 0.0, -100000000.0,\
100000000.0,1000.0,0,2560)
DeclareVariable("rad.vol[1].dynBal.cp_default", "Heat capacity, to compute additional dry mass [J/(kg.K)]",\
 4184, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.rho_start", "Density, used to compute fluid mass [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.computeCSen", "[:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[1].dynBal.state_default.p", "Absolute pressure of medium [Pa|bar]",\
 300000.0, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.state_default.T", "Temperature of medium [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.rho_default", "Density, used to compute fluid mass [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal.hStart", "Start value for specific enthalpy [J/kg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[1].dynBal._simplify_mWat_flow", "If true, then port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero, and equations are simplified [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[1].dynBal.mWat_flow_internal", "Needed to connect to conditional connector [kg/s]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.energyDynamics", "Type of energy balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[2].dynBal.massDynamics", "Type of mass balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[2].dynBal.substanceDynamics", "Type of independent mass fraction balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[2].dynBal.traceDynamics", "Type of trace substance balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[2].dynBal.p_start", "Start value of pressure [Pa|bar]",\
 300000, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.T_start", "Start value of temperature [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.X_start[1]", "Start value of mass fractions m_i/m [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,2561)
DeclareVariable("rad.vol[2].dynBal.mSenFac", "Factor for scaling the sensible thermal mass of the volume",\
 1.5442861740360443, 1.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("rad.vol[2].dynBal.simplify_mWat_flow", "Set to true to cause port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero. Used only if Medium.nX > 1 [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[2].dynBal.nPorts", "Number of ports [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("rad.vol[2].dynBal.use_mWat_flow", "Set to true to enable input connector for moisture mass flow rate [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[2].dynBal.use_C_flow", "Set to true to enable input connector for trace substance [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareAlias2("rad.vol[2].dynBal.Q_flow", "Sensible plus latent heat flow rate transferred into the medium [W]",\
 "rad.vol[2].heatPort.Q_flow", 1, 5, 2850, 1024)
DeclareAlias2("rad.vol[2].dynBal.hOut", "Leaving specific enthalpy of the component [J/kg]",\
 "rad.vol[2].ports[1].h_outflow", 1, 5, 2839, 1024)
DeclareAlias2("rad.vol[2].dynBal.UOut", "Internal energy of the component [J]", \
"rad.vol[2].dynBal.U", 1, 1, 9, 1024)
DeclareVariable("rad.vol[2].dynBal.mOut", "Mass of the component [kg]", \
2.3097595200000005, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("rad.vol[2].dynBal.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", 1, 5, 3140, 1156)
DeclareAlias2("rad.vol[2].dynBal.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("rad.vol[2].dynBal.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "rad.vol[2].ports[1].h_outflow", 1, 5, 2839, 1028)
DeclareAlias2("rad.vol[2].dynBal.ports[2].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", -1, 5, 3140, 1156)
DeclareAlias2("rad.vol[2].dynBal.ports[2].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("rad.vol[2].dynBal.ports[2].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "rad.vol[2].ports[1].h_outflow", 1, 5, 2839, 1028)
DeclareVariable("rad.vol[2].dynBal.medium.T", "Temperature of medium [K|degC]", \
300.0, 1.0,10000.0,300.0,0,2560)
DeclareAlias2("rad.vol[2].dynBal.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "bou.p", 1, 7, 729, 1024)
DeclareAlias2("rad.vol[2].dynBal.medium.h", "Specific enthalpy of medium [J/kg]",\
 "rad.vol[2].ports[1].h_outflow", 1, 5, 2839, 1024)
DeclareAlias2("rad.vol[2].dynBal.medium.u", "Specific internal energy of medium [J/kg]",\
 "rad.vol[2].ports[1].h_outflow", 1, 5, 2839, 1024)
DeclareVariable("rad.vol[2].dynBal.medium.d", "Density of medium [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [1]",\
 1, 0.0,1.0,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.medium.R", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("rad.vol[2].dynBal.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "bou.p", 1, 7, 729, 1024)
DeclareAlias2("rad.vol[2].dynBal.medium.state.T", "Temperature of medium [K|degC]",\
 "rad.vol[2].dynBal.medium.T", 1, 5, 6269, 1024)
DeclareVariable("rad.vol[2].dynBal.medium.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[2].dynBal.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[2].dynBal.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[2].dynBal.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareState("rad.vol[2].dynBal.U", "Internal energy of fluid [J]", 9, 0.0, \
0.0,0.0,100000.0,0,2592)
DeclareDerivative("rad.vol[2].dynBal.der(U)", "der(Internal energy of fluid) [W]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[2].dynBal.m", "Mass of fluid [kg]", 2.3097595200000005,\
 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.der(m)", "der(Mass of fluid) [kg/s]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.mb_flow", "Mass flows across boundaries [kg/s]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.Hb_flow", "Enthalpy flow across boundaries or energy source/sink [W]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[2].dynBal.fluidVolume", "Volume [m3]", 0.0023200000000000004,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.CSen", "Aditional heat capacity for implementing mFactor [J/K]",\
 5260.000000000002, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.ports_H_flow[1]", "[W]", 0.0, -100000000.0,\
100000000.0,1000.0,0,2560)
DeclareVariable("rad.vol[2].dynBal.ports_H_flow[2]", "[W]", 0.0, -100000000.0,\
100000000.0,1000.0,0,2560)
DeclareVariable("rad.vol[2].dynBal.cp_default", "Heat capacity, to compute additional dry mass [J/(kg.K)]",\
 4184, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.rho_start", "Density, used to compute fluid mass [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.computeCSen", "[:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[2].dynBal.state_default.p", "Absolute pressure of medium [Pa|bar]",\
 300000.0, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.state_default.T", "Temperature of medium [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.rho_default", "Density, used to compute fluid mass [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal.hStart", "Start value for specific enthalpy [J/kg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[2].dynBal._simplify_mWat_flow", "If true, then port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero, and equations are simplified [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[2].dynBal.mWat_flow_internal", "Needed to connect to conditional connector [kg/s]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.energyDynamics", "Type of energy balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[3].dynBal.massDynamics", "Type of mass balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[3].dynBal.substanceDynamics", "Type of independent mass fraction balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[3].dynBal.traceDynamics", "Type of trace substance balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[3].dynBal.p_start", "Start value of pressure [Pa|bar]",\
 300000, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.T_start", "Start value of temperature [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.X_start[1]", "Start value of mass fractions m_i/m [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,2561)
DeclareVariable("rad.vol[3].dynBal.mSenFac", "Factor for scaling the sensible thermal mass of the volume",\
 1.5442861740360443, 1.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("rad.vol[3].dynBal.simplify_mWat_flow", "Set to true to cause port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero. Used only if Medium.nX > 1 [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[3].dynBal.nPorts", "Number of ports [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("rad.vol[3].dynBal.use_mWat_flow", "Set to true to enable input connector for moisture mass flow rate [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[3].dynBal.use_C_flow", "Set to true to enable input connector for trace substance [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareAlias2("rad.vol[3].dynBal.Q_flow", "Sensible plus latent heat flow rate transferred into the medium [W]",\
 "rad.vol[3].heatPort.Q_flow", 1, 5, 2878, 1024)
DeclareAlias2("rad.vol[3].dynBal.hOut", "Leaving specific enthalpy of the component [J/kg]",\
 "rad.vol[3].ports[1].h_outflow", 1, 5, 2867, 1024)
DeclareAlias2("rad.vol[3].dynBal.UOut", "Internal energy of the component [J]", \
"rad.vol[3].dynBal.U", 1, 1, 10, 1024)
DeclareVariable("rad.vol[3].dynBal.mOut", "Mass of the component [kg]", \
2.3097595200000005, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("rad.vol[3].dynBal.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", 1, 5, 3140, 1156)
DeclareAlias2("rad.vol[3].dynBal.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("rad.vol[3].dynBal.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "rad.vol[3].ports[1].h_outflow", 1, 5, 2867, 1028)
DeclareAlias2("rad.vol[3].dynBal.ports[2].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", -1, 5, 3140, 1156)
DeclareAlias2("rad.vol[3].dynBal.ports[2].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("rad.vol[3].dynBal.ports[2].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "rad.vol[3].ports[1].h_outflow", 1, 5, 2867, 1028)
DeclareVariable("rad.vol[3].dynBal.medium.T", "Temperature of medium [K|degC]", \
300.0, 1.0,10000.0,300.0,0,2560)
DeclareAlias2("rad.vol[3].dynBal.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "bou.p", 1, 7, 729, 1024)
DeclareAlias2("rad.vol[3].dynBal.medium.h", "Specific enthalpy of medium [J/kg]",\
 "rad.vol[3].ports[1].h_outflow", 1, 5, 2867, 1024)
DeclareAlias2("rad.vol[3].dynBal.medium.u", "Specific internal energy of medium [J/kg]",\
 "rad.vol[3].ports[1].h_outflow", 1, 5, 2867, 1024)
DeclareVariable("rad.vol[3].dynBal.medium.d", "Density of medium [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [1]",\
 1, 0.0,1.0,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.medium.R", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("rad.vol[3].dynBal.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "bou.p", 1, 7, 729, 1024)
DeclareAlias2("rad.vol[3].dynBal.medium.state.T", "Temperature of medium [K|degC]",\
 "rad.vol[3].dynBal.medium.T", 1, 5, 6309, 1024)
DeclareVariable("rad.vol[3].dynBal.medium.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[3].dynBal.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[3].dynBal.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[3].dynBal.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareState("rad.vol[3].dynBal.U", "Internal energy of fluid [J]", 10, 0.0, \
0.0,0.0,100000.0,0,2592)
DeclareDerivative("rad.vol[3].dynBal.der(U)", "der(Internal energy of fluid) [W]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[3].dynBal.m", "Mass of fluid [kg]", 2.3097595200000005,\
 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.der(m)", "der(Mass of fluid) [kg/s]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.mb_flow", "Mass flows across boundaries [kg/s]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.Hb_flow", "Enthalpy flow across boundaries or energy source/sink [W]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[3].dynBal.fluidVolume", "Volume [m3]", 0.0023200000000000004,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.CSen", "Aditional heat capacity for implementing mFactor [J/K]",\
 5260.000000000002, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.ports_H_flow[1]", "[W]", 0.0, -100000000.0,\
100000000.0,1000.0,0,2560)
DeclareVariable("rad.vol[3].dynBal.ports_H_flow[2]", "[W]", 0.0, -100000000.0,\
100000000.0,1000.0,0,2560)
DeclareVariable("rad.vol[3].dynBal.cp_default", "Heat capacity, to compute additional dry mass [J/(kg.K)]",\
 4184, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.rho_start", "Density, used to compute fluid mass [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.computeCSen", "[:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[3].dynBal.state_default.p", "Absolute pressure of medium [Pa|bar]",\
 300000.0, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.state_default.T", "Temperature of medium [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.rho_default", "Density, used to compute fluid mass [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal.hStart", "Start value for specific enthalpy [J/kg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[3].dynBal._simplify_mWat_flow", "If true, then port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero, and equations are simplified [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[3].dynBal.mWat_flow_internal", "Needed to connect to conditional connector [kg/s]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.energyDynamics", "Type of energy balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[4].dynBal.massDynamics", "Type of mass balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[4].dynBal.substanceDynamics", "Type of independent mass fraction balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[4].dynBal.traceDynamics", "Type of trace substance balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[4].dynBal.p_start", "Start value of pressure [Pa|bar]",\
 300000, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.T_start", "Start value of temperature [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.X_start[1]", "Start value of mass fractions m_i/m [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,2561)
DeclareVariable("rad.vol[4].dynBal.mSenFac", "Factor for scaling the sensible thermal mass of the volume",\
 1.5442861740360443, 1.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("rad.vol[4].dynBal.simplify_mWat_flow", "Set to true to cause port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero. Used only if Medium.nX > 1 [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[4].dynBal.nPorts", "Number of ports [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("rad.vol[4].dynBal.use_mWat_flow", "Set to true to enable input connector for moisture mass flow rate [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[4].dynBal.use_C_flow", "Set to true to enable input connector for trace substance [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareAlias2("rad.vol[4].dynBal.Q_flow", "Sensible plus latent heat flow rate transferred into the medium [W]",\
 "rad.vol[4].heatPort.Q_flow", 1, 5, 2906, 1024)
DeclareAlias2("rad.vol[4].dynBal.hOut", "Leaving specific enthalpy of the component [J/kg]",\
 "rad.vol[4].ports[1].h_outflow", 1, 5, 2895, 1024)
DeclareAlias2("rad.vol[4].dynBal.UOut", "Internal energy of the component [J]", \
"rad.vol[4].dynBal.U", 1, 1, 11, 1024)
DeclareVariable("rad.vol[4].dynBal.mOut", "Mass of the component [kg]", \
2.3097595200000005, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("rad.vol[4].dynBal.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", 1, 5, 3140, 1156)
DeclareAlias2("rad.vol[4].dynBal.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("rad.vol[4].dynBal.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "rad.vol[4].ports[1].h_outflow", 1, 5, 2895, 1028)
DeclareAlias2("rad.vol[4].dynBal.ports[2].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", -1, 5, 3140, 1156)
DeclareAlias2("rad.vol[4].dynBal.ports[2].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("rad.vol[4].dynBal.ports[2].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "rad.vol[4].ports[1].h_outflow", 1, 5, 2895, 1028)
DeclareVariable("rad.vol[4].dynBal.medium.T", "Temperature of medium [K|degC]", \
300.0, 1.0,10000.0,300.0,0,2560)
DeclareAlias2("rad.vol[4].dynBal.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "bou.p", 1, 7, 729, 1024)
DeclareAlias2("rad.vol[4].dynBal.medium.h", "Specific enthalpy of medium [J/kg]",\
 "rad.vol[4].ports[1].h_outflow", 1, 5, 2895, 1024)
DeclareAlias2("rad.vol[4].dynBal.medium.u", "Specific internal energy of medium [J/kg]",\
 "rad.vol[4].ports[1].h_outflow", 1, 5, 2895, 1024)
DeclareVariable("rad.vol[4].dynBal.medium.d", "Density of medium [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [1]",\
 1, 0.0,1.0,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.medium.R", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("rad.vol[4].dynBal.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "bou.p", 1, 7, 729, 1024)
DeclareAlias2("rad.vol[4].dynBal.medium.state.T", "Temperature of medium [K|degC]",\
 "rad.vol[4].dynBal.medium.T", 1, 5, 6349, 1024)
DeclareVariable("rad.vol[4].dynBal.medium.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[4].dynBal.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[4].dynBal.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[4].dynBal.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareState("rad.vol[4].dynBal.U", "Internal energy of fluid [J]", 11, 0.0, \
0.0,0.0,100000.0,0,2592)
DeclareDerivative("rad.vol[4].dynBal.der(U)", "der(Internal energy of fluid) [W]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[4].dynBal.m", "Mass of fluid [kg]", 2.3097595200000005,\
 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.der(m)", "der(Mass of fluid) [kg/s]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.mb_flow", "Mass flows across boundaries [kg/s]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.Hb_flow", "Enthalpy flow across boundaries or energy source/sink [W]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[4].dynBal.fluidVolume", "Volume [m3]", 0.0023200000000000004,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.CSen", "Aditional heat capacity for implementing mFactor [J/K]",\
 5260.000000000002, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.ports_H_flow[1]", "[W]", 0.0, -100000000.0,\
100000000.0,1000.0,0,2560)
DeclareVariable("rad.vol[4].dynBal.ports_H_flow[2]", "[W]", 0.0, -100000000.0,\
100000000.0,1000.0,0,2560)
DeclareVariable("rad.vol[4].dynBal.cp_default", "Heat capacity, to compute additional dry mass [J/(kg.K)]",\
 4184, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.rho_start", "Density, used to compute fluid mass [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.computeCSen", "[:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[4].dynBal.state_default.p", "Absolute pressure of medium [Pa|bar]",\
 300000.0, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.state_default.T", "Temperature of medium [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.rho_default", "Density, used to compute fluid mass [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal.hStart", "Start value for specific enthalpy [J/kg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[4].dynBal._simplify_mWat_flow", "If true, then port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero, and equations are simplified [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[4].dynBal.mWat_flow_internal", "Needed to connect to conditional connector [kg/s]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.energyDynamics", "Type of energy balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[5].dynBal.massDynamics", "Type of mass balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[5].dynBal.substanceDynamics", "Type of independent mass fraction balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[5].dynBal.traceDynamics", "Type of trace substance balance: dynamic (3 initialization options) or steady state [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("rad.vol[5].dynBal.p_start", "Start value of pressure [Pa|bar]",\
 300000, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.T_start", "Start value of temperature [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.X_start[1]", "Start value of mass fractions m_i/m [kg/kg]",\
 1.0, 0.0,1.0,0.1,0,2561)
DeclareVariable("rad.vol[5].dynBal.mSenFac", "Factor for scaling the sensible thermal mass of the volume",\
 1.5442861740360443, 1.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.initialize_p", "= true to set up initial equations for pressure [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,1539)
DeclareVariable("rad.vol[5].dynBal.simplify_mWat_flow", "Set to true to cause port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero. Used only if Medium.nX > 1 [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[5].dynBal.nPorts", "Number of ports [:#(type=Integer)]",\
 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("rad.vol[5].dynBal.use_mWat_flow", "Set to true to enable input connector for moisture mass flow rate [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[5].dynBal.use_C_flow", "Set to true to enable input connector for trace substance [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareAlias2("rad.vol[5].dynBal.Q_flow", "Sensible plus latent heat flow rate transferred into the medium [W]",\
 "rad.vol[5].heatPort.Q_flow", 1, 5, 2933, 1024)
DeclareAlias2("rad.vol[5].dynBal.hOut", "Leaving specific enthalpy of the component [J/kg]",\
 "rad.port_b.h_outflow", 1, 5, 2766, 1024)
DeclareAlias2("rad.vol[5].dynBal.UOut", "Internal energy of the component [J]", \
"rad.vol[5].dynBal.U", 1, 1, 12, 1024)
DeclareVariable("rad.vol[5].dynBal.mOut", "Mass of the component [kg]", \
2.3097595200000005, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("rad.vol[5].dynBal.ports[1].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", 1, 5, 3140, 1156)
DeclareAlias2("rad.vol[5].dynBal.ports[1].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("rad.vol[5].dynBal.ports[1].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "rad.port_b.h_outflow", 1, 5, 2766, 1028)
DeclareAlias2("rad.vol[5].dynBal.ports[2].m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", -1, 5, 3140, 1156)
DeclareAlias2("rad.vol[5].dynBal.ports[2].p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("rad.vol[5].dynBal.ports[2].h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "rad.port_b.h_outflow", 1, 5, 2766, 1028)
DeclareVariable("rad.vol[5].dynBal.medium.T", "Temperature of medium [K|degC]", \
300.0, 1.0,10000.0,300.0,0,2560)
DeclareAlias2("rad.vol[5].dynBal.medium.p", "Absolute pressure of medium [Pa|bar]",\
 "bou.p", 1, 7, 729, 1024)
DeclareAlias2("rad.vol[5].dynBal.medium.h", "Specific enthalpy of medium [J/kg]",\
 "rad.port_b.h_outflow", 1, 5, 2766, 1024)
DeclareAlias2("rad.vol[5].dynBal.medium.u", "Specific internal energy of medium [J/kg]",\
 "rad.port_b.h_outflow", 1, 5, 2766, 1024)
DeclareVariable("rad.vol[5].dynBal.medium.d", "Density of medium [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.medium.X[1]", "Mass fractions (= (component mass)/total mass  m_i/m) [1]",\
 1, 0.0,1.0,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.medium.R", "Gas constant (of mixture if applicable) [J/(kg.K)]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.medium.MM", "Molar mass (of mixture or single fluid) [kg/mol]",\
 0.018015268, 0.0,1E+100,0.0,0,2561)
DeclareAlias2("rad.vol[5].dynBal.medium.state.p", "Absolute pressure of medium [Pa|bar]",\
 "bou.p", 1, 7, 729, 1024)
DeclareAlias2("rad.vol[5].dynBal.medium.state.T", "Temperature of medium [K|degC]",\
 "rad.vol[5].dynBal.medium.T", 1, 5, 6389, 1024)
DeclareVariable("rad.vol[5].dynBal.medium.preferredMediumStates", \
"= true if StateSelect.prefer shall be used for the independent property variables of the medium [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[5].dynBal.medium.standardOrderComponents", \
"If true, and reducedX = true, the last element of X will be computed from the other ones [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[5].dynBal.medium.T_degC", "Temperature of medium in [degC] [degC;]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[5].dynBal.medium.p_bar", "Absolute pressure of medium in [bar] [bar]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareState("rad.vol[5].dynBal.U", "Internal energy of fluid [J]", 12, 0.0, \
0.0,0.0,100000.0,0,2592)
DeclareDerivative("rad.vol[5].dynBal.der(U)", "der(Internal energy of fluid) [W]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[5].dynBal.m", "Mass of fluid [kg]", 2.3097595200000005,\
 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.der(m)", "der(Mass of fluid) [kg/s]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.mb_flow", "Mass flows across boundaries [kg/s]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.Hb_flow", "Enthalpy flow across boundaries or energy source/sink [W]",\
 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("rad.vol[5].dynBal.fluidVolume", "Volume [m3]", 0.0023200000000000004,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.CSen", "Aditional heat capacity for implementing mFactor [J/K]",\
 5260.000000000002, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.ports_H_flow[1]", "[W]", 0.0, -100000000.0,\
100000000.0,1000.0,0,2560)
DeclareVariable("rad.vol[5].dynBal.ports_H_flow[2]", "[W]", 0.0, -100000000.0,\
100000000.0,1000.0,0,2560)
DeclareVariable("rad.vol[5].dynBal.cp_default", "Heat capacity, to compute additional dry mass [J/(kg.K)]",\
 4184, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.rho_start", "Density, used to compute fluid mass [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.computeCSen", "[:#(type=Boolean)]", true, \
0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[5].dynBal.state_default.p", "Absolute pressure of medium [Pa|bar]",\
 300000.0, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.state_default.T", "Temperature of medium [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.rho_default", "Density, used to compute fluid mass [kg/m3|g/cm3]",\
 995.586, 0.0,1E+100,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal.hStart", "Start value for specific enthalpy [J/kg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("rad.vol[5].dynBal._simplify_mWat_flow", "If true, then port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero, and equations are simplified [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("rad.vol[5].dynBal.mWat_flow_internal", "Needed to connect to conditional connector [kg/s]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.allowFlowReversal", "= false to simplify equations, assuming, but not enforcing, no flow reversal [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareAlias2("pump.vol.steBal.port_a.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", 1, 5, 3140, 1156)
DeclareAlias2("pump.vol.steBal.port_a.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("pump.vol.steBal.port_a.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "pump.port_a.h_outflow", 1, 5, 3097, 1028)
DeclareAlias2("pump.vol.steBal.port_b.m_flow", "Mass flow rate from the connection point into the component [kg/s]",\
 "pump.setConst.k", -1, 5, 3140, 1156)
DeclareAlias2("pump.vol.steBal.port_b.p", "Thermodynamic pressure in the connection point [Pa|bar]",\
 "bou.p", 1, 7, 729, 1028)
DeclareAlias2("pump.vol.steBal.port_b.h_outflow", "Specific thermodynamic enthalpy close to the connection point if m_flow < 0 [J/kg]",\
 "pump.vol.ports[2].h_outflow", 1, 5, 3157, 1028)
DeclareVariable("pump.vol.steBal.m_flow_nominal", "Nominal mass flow rate [kg/s]",\
 0.02390057361376673, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.m_flow_small", "Small mass flow rate for regularization of zero flow [kg/s]",\
 2.390057361376673E-06, 0.0,1E+100,0.0,0,2561)
DeclareVariable("pump.vol.steBal.show_T", "= true, if actual temperature at port is computed [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareAlias2("pump.vol.steBal.m_flow", "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction) [kg/s]",\
 "pump.setConst.k", 1, 5, 3140, 1024)
DeclareVariable("pump.vol.steBal.dp", "Pressure difference between port_a and port_b [Pa|Pa]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal._m_flow_start", "Start value for m_flow, used to avoid a warning if not set in m_flow, and to avoid m_flow.start in parameter window [kg/s]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal._dp_start", "Start value for dp, used to avoid a warning if not set in dp, and to avoid dp.start in parameter window [Pa|Pa]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.simplify_mWat_flow", "Set to true to cause port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("pump.vol.steBal.prescribedHeatFlowRate", "Set to true if the heat flow rate is not a function of a temperature difference to the fluid temperature [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("pump.vol.steBal.use_mWat_flow", "Set to true to enable input connector for moisture mass flow rate [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareVariable("pump.vol.steBal.use_C_flow", "Set to true to enable input connector for trace substance [:#(type=Boolean)]",\
 false, 0.0,0.0,0.0,0,2563)
DeclareAlias2("pump.vol.steBal.Q_flow", "Sensible plus latent heat flow rate transferred into the medium [W]",\
 "pump.vol.heatPort.Q_flow", 1, 5, 3169, 1024)
DeclareAlias2("pump.vol.steBal.hOut", "Leaving specific enthalpy of the component [J/kg]",\
 "pump.vol.hOut_internal", 1, 5, 3167, 1024)
DeclareVariable("pump.vol.steBal.use_m_flowInv", "Flag, true if m_flowInv is used in the model [:#(type=Boolean)]",\
 true, 0.0,0.0,0.0,0,2563)
DeclareVariable("pump.vol.steBal.m_flowInv", "Regularization of 1/m_flow of port_a [s/kg]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.deltaReg", "Smoothing region for inverseXRegularized",\
 2.390057361376673E-09, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.deltaInvReg", "Inverse value of delta for inverseXRegularized",\
 418400000.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.aReg", "Polynomial coefficient for inverseXRegularized",\
 -6276000000.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.bReg", "Polynomial coefficient for inverseXRegularized",\
 2.083196864E+19, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.cReg", "Polynomial coefficient for inverseXRegularized",\
 -2.6441265042944E+28, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.dReg", "Polynomial coefficient for inverseXRegularized",\
 1.6364696695232104E+37, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.eReg", "Polynomial coefficient for inverseXRegularized",\
 -4.872389245259068E+45, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.fReg", "Polynomial coefficient for inverseXRegularized",\
 5.579347280592237E+53, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.state_default.p", "Absolute pressure of medium [Pa|bar]",\
 300000.0, 0.0,100000000.0,100000.0,0,2561)
DeclareVariable("pump.vol.steBal.state_default.T", "Temperature of medium [K|degC]",\
 293.15, 1.0,10000.0,300.0,0,2561)
DeclareVariable("pump.vol.steBal.cp_default", "Specific heat capacity, used to verify energy conservation [J/(kg.K)]",\
 4184, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.vol.steBal.dTMax", "Maximum temperature difference across the StaticTwoPortConservationEquation [K,]",\
 200, 1.0,1E+100,0.0,0,2561)
DeclareVariable("pump.vol.steBal.mWat_flow_internal", "Needed to connect to conditional connector [kg/s]",\
 0, 0.0,0.0,0.0,0,2561)
DeclareVariable("pump.eff.dp_in", "Prescribed pressure increase [Pa]", 0.0, \
0.0,0.0,0.0,0,2561)
DeclareParameter("heatingCurve.TSupMin", "Minimum supply temperature if enabled [K|degC]",\
 818, 293.15, 0.0,1E+100,300.0,0,560)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.A", \
"Layer area [m2]", 48.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 10.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 10.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.d", \
"Layer thickness [m]", 819, 1.007, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.epsLw_a",\
 "Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.epsLw_b",\
 "Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.epsSw_a",\
 "Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.epsSw_b",\
 "Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.R", \
"[m2.K/W]", 25.174999999999997, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 0.0004, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.nStaRef",\
 "Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 50.349999999999994, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.R", \
"Total specific thermal resistance", 25.174999999999997, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.bouFlo.layMul.monLay[1].monLayDyn.E", "[J]", \
"case900Template.bouFlo.layMul.monLay[1].E", 1, 5, 3752, 1024)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.G[1]", \
"[W/K]", 1.9066534260178751, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.C[1]", \
"[J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.C[2]", \
"[J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.bouFlo.layMul.monLay[1].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 13, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.bouFlo.layMul.monLay[1].monLayDyn.der(T[1])",\
 "der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareState("case900Template.bouFlo.layMul.monLay[1].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 14, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.bouFlo.layMul.monLay[1].monLayDyn.der(T[2])",\
 "der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.bouFlo.layMul.monLay[1].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.bouFlo.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 13, 1028)
DeclareAlias2("case900Template.bouFlo.layMul.monLay[1].monLayDyn.port_a.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.bouFlo.layMul.monLay[1].port_a.Q_flow", 1, 5, 3753, 1156)
DeclareAlias2("case900Template.bouFlo.layMul.monLay[1].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.bouFlo.layMul.monLay[1].monLayDyn.T[2]", 1,\
 1, 14, 1028)
DeclareVariable("case900Template.bouFlo.layMul.monLay[1].monLayDyn.port_b.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", 0.0,\
 0.0,0.0,0.0,0,2825)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.A", \
"Layer area [m2]", 48.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 1000.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 1400.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.d", \
"Layer thickness [m]", 820, 0.08, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.epsLw_a",\
 "Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.epsLw_b",\
 "Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.epsSw_a",\
 "Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.epsSw_b",\
 "Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.R", \
"[m2.K/W]", 0.07079646017699116, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 8.071428571428571E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.nStaRef",\
 "Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 89.04607537574584, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.R", \
"Total specific thermal resistance", 0.07079646017699116, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.bouFlo.layMul.monLay[2].monLayDyn.E", "[J]", \
"case900Template.bouFlo.layMul.monLay[2].E", 1, 5, 3788, 1024)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.G[1]", \
"[W/K]", 677.9999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.C[1]", \
"[J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.C[2]", \
"[J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.bouFlo.layMul.monLay[2].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 15, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.bouFlo.layMul.monLay[2].monLayDyn.der(T[1])",\
 "der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.bouFlo.layMul.monLay[2].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.bouFlo.layMul.monLay[2].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.bouFlo.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 15, 1028)
DeclareAlias2("case900Template.bouFlo.layMul.monLay[2].monLayDyn.port_a.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.bouFlo.layMul.port_a.Q_flow", 1, 5, 3796, 1156)
DeclareAlias2("case900Template.bouFlo.layMul.monLay[2].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.bouFlo.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 13, 1028)
DeclareAlias2("case900Template.bouFlo.layMul.monLay[2].monLayDyn.port_b.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.bouFlo.layMul.monLay[1].port_a.Q_flow", -1, 5, 3753, 1156)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 530.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outA.layMul.monLay[1].monLayDyn.mat.d", \
"Layer thickness [m]", 821, 0.009, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.R", \
"[m2.K/W]", 0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 16.612602789104763, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.R", \
"Total specific thermal resistance", 0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outA.layMul.monLay[1].monLayDyn.E", "[J]", \
"case900Template.outA.layMul.monLay[1].E", 1, 5, 4126, 1024)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outA.layMul.monLay[1].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 16, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outA.layMul.monLay[1].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareState("case900Template.outA.layMul.monLay[1].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 17, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outA.layMul.monLay[1].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outA.layMul.monLay[1].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outA.layMul.monLay[1].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outA.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 16, 1028)
DeclareAlias2("case900Template.outA.layMul.monLay[1].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outA.layMul.monLay[1].port_a.Q_flow", 1, 5, 4127, 1156)
DeclareAlias2("case900Template.outA.layMul.monLay[1].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outA.layMul.monLay[1].monLayDyn.T[2]", 1,\
 1, 17, 1028)
DeclareAlias2("case900Template.outA.layMul.monLay[1].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outA.layMul.port_b.Q_flow", 1, 5, 4206, 1156)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 1400.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 10.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outA.layMul.monLay[2].monLayDyn.mat.d", \
"Layer thickness [m]", 822, 0.0615, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.R", \
"[m2.K/W]", 1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 2.8571428571428573E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 36.38389066606264, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.R", \
"Total specific thermal resistance", 1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outA.layMul.monLay[2].monLayDyn.E", "[J]", \
"case900Template.outA.layMul.monLay[2].E", 1, 5, 4161, 1024)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outA.layMul.monLay[2].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 18, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outA.layMul.monLay[2].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outA.layMul.monLay[2].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outA.layMul.monLay[2].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outA.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 18, 1028)
DeclareAlias2("case900Template.outA.layMul.monLay[2].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outA.layMul.monLay[2].port_a.Q_flow", 1, 5, 4162, 1156)
DeclareAlias2("case900Template.outA.layMul.monLay[2].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outA.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 16, 1028)
DeclareAlias2("case900Template.outA.layMul.monLay[2].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outA.layMul.monLay[1].port_a.Q_flow", -1, 5, 4127, 1156)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 1000.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 1400.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outA.layMul.monLay[3].monLayDyn.mat.d", \
"Layer thickness [m]", 823, 0.1, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.R", \
"[m2.K/W]", 0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 3.642857142857143E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 165.68337391590282, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 3, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.R", \
"Total specific thermal resistance", 0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outA.layMul.monLay[3].monLayDyn.E", "[J]", \
"case900Template.outA.layMul.monLay[3].E", 1, 5, 4196, 1024)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.G[2]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.C[3]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.Cinv[3]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outA.layMul.monLay[3].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 19, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outA.layMul.monLay[3].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareState("case900Template.outA.layMul.monLay[3].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 20, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outA.layMul.monLay[3].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.T[3]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.der(T[3])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outA.layMul.monLay[3].monLayDyn.Q_flow[2]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outA.layMul.monLay[3].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outA.layMul.monLay[3].monLayDyn.T[1]", 1,\
 1, 19, 1028)
DeclareAlias2("case900Template.outA.layMul.monLay[3].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outA.layMul.port_a.Q_flow", 1, 5, 4205, 1156)
DeclareAlias2("case900Template.outA.layMul.monLay[3].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outA.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 18, 1028)
DeclareAlias2("case900Template.outA.layMul.monLay[3].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outA.layMul.monLay[2].port_a.Q_flow", -1, 5, 4162, 1156)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 530.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outB.layMul.monLay[1].monLayDyn.mat.d", \
"Layer thickness [m]", 824, 0.009, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.R", \
"[m2.K/W]", 0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 16.612602789104763, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.R", \
"Total specific thermal resistance", 0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outB.layMul.monLay[1].monLayDyn.E", "[J]", \
"case900Template.outB.layMul.monLay[1].E", 1, 5, 4579, 1024)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outB.layMul.monLay[1].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 21, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outB.layMul.monLay[1].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareState("case900Template.outB.layMul.monLay[1].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 22, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outB.layMul.monLay[1].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outB.layMul.monLay[1].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outB.layMul.monLay[1].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outB.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 21, 1028)
DeclareAlias2("case900Template.outB.layMul.monLay[1].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outB.layMul.monLay[1].port_a.Q_flow", 1, 5, 4580, 1156)
DeclareAlias2("case900Template.outB.layMul.monLay[1].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outB.layMul.monLay[1].monLayDyn.T[2]", 1,\
 1, 22, 1028)
DeclareAlias2("case900Template.outB.layMul.monLay[1].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outB.layMul.port_b.Q_flow", 1, 5, 4659, 1156)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 1400.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 10.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outB.layMul.monLay[2].monLayDyn.mat.d", \
"Layer thickness [m]", 825, 0.0615, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.R", \
"[m2.K/W]", 1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 2.8571428571428573E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 36.38389066606264, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.R", \
"Total specific thermal resistance", 1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outB.layMul.monLay[2].monLayDyn.E", "[J]", \
"case900Template.outB.layMul.monLay[2].E", 1, 5, 4614, 1024)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outB.layMul.monLay[2].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 23, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outB.layMul.monLay[2].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outB.layMul.monLay[2].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outB.layMul.monLay[2].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outB.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 23, 1028)
DeclareAlias2("case900Template.outB.layMul.monLay[2].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outB.layMul.monLay[2].port_a.Q_flow", 1, 5, 4615, 1156)
DeclareAlias2("case900Template.outB.layMul.monLay[2].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outB.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 21, 1028)
DeclareAlias2("case900Template.outB.layMul.monLay[2].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outB.layMul.monLay[1].port_a.Q_flow", -1, 5, 4580, 1156)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 1000.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 1400.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outB.layMul.monLay[3].monLayDyn.mat.d", \
"Layer thickness [m]", 826, 0.1, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.R", \
"[m2.K/W]", 0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 3.642857142857143E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 165.68337391590282, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 3, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.R", \
"Total specific thermal resistance", 0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outB.layMul.monLay[3].monLayDyn.E", "[J]", \
"case900Template.outB.layMul.monLay[3].E", 1, 5, 4649, 1024)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.G[2]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.C[3]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.Cinv[3]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outB.layMul.monLay[3].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 24, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outB.layMul.monLay[3].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareState("case900Template.outB.layMul.monLay[3].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 25, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outB.layMul.monLay[3].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.T[3]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.der(T[3])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outB.layMul.monLay[3].monLayDyn.Q_flow[2]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outB.layMul.monLay[3].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outB.layMul.monLay[3].monLayDyn.T[1]", 1,\
 1, 24, 1028)
DeclareAlias2("case900Template.outB.layMul.monLay[3].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outB.layMul.port_a.Q_flow", 1, 5, 4658, 1156)
DeclareAlias2("case900Template.outB.layMul.monLay[3].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outB.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 23, 1028)
DeclareAlias2("case900Template.outB.layMul.monLay[3].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outB.layMul.monLay[2].port_a.Q_flow", -1, 5, 4615, 1156)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 530.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outC.layMul.monLay[1].monLayDyn.mat.d", \
"Layer thickness [m]", 827, 0.009, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.R", \
"[m2.K/W]", 0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 16.612602789104763, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.R", \
"Total specific thermal resistance", 0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outC.layMul.monLay[1].monLayDyn.E", "[J]", \
"case900Template.outC.layMul.monLay[1].E", 1, 5, 5032, 1024)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outC.layMul.monLay[1].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 26, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outC.layMul.monLay[1].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareState("case900Template.outC.layMul.monLay[1].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 27, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outC.layMul.monLay[1].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outC.layMul.monLay[1].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outC.layMul.monLay[1].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outC.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 26, 1028)
DeclareAlias2("case900Template.outC.layMul.monLay[1].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outC.layMul.monLay[1].port_a.Q_flow", 1, 5, 5033, 1156)
DeclareAlias2("case900Template.outC.layMul.monLay[1].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outC.layMul.monLay[1].monLayDyn.T[2]", 1,\
 1, 27, 1028)
DeclareAlias2("case900Template.outC.layMul.monLay[1].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outC.layMul.port_b.Q_flow", 1, 5, 5112, 1156)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 1400.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 10.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outC.layMul.monLay[2].monLayDyn.mat.d", \
"Layer thickness [m]", 828, 0.0615, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.R", \
"[m2.K/W]", 1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 2.8571428571428573E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 36.38389066606264, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.R", \
"Total specific thermal resistance", 1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outC.layMul.monLay[2].monLayDyn.E", "[J]", \
"case900Template.outC.layMul.monLay[2].E", 1, 5, 5067, 1024)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outC.layMul.monLay[2].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 28, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outC.layMul.monLay[2].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outC.layMul.monLay[2].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outC.layMul.monLay[2].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outC.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 28, 1028)
DeclareAlias2("case900Template.outC.layMul.monLay[2].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outC.layMul.monLay[2].port_a.Q_flow", 1, 5, 5068, 1156)
DeclareAlias2("case900Template.outC.layMul.monLay[2].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outC.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 26, 1028)
DeclareAlias2("case900Template.outC.layMul.monLay[2].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outC.layMul.monLay[1].port_a.Q_flow", -1, 5, 5033, 1156)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 1000.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 1400.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outC.layMul.monLay[3].monLayDyn.mat.d", \
"Layer thickness [m]", 829, 0.1, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.R", \
"[m2.K/W]", 0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 3.642857142857143E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 165.68337391590282, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 3, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.R", \
"Total specific thermal resistance", 0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outC.layMul.monLay[3].monLayDyn.E", "[J]", \
"case900Template.outC.layMul.monLay[3].E", 1, 5, 5102, 1024)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.G[2]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.C[3]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.Cinv[3]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outC.layMul.monLay[3].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 29, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outC.layMul.monLay[3].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareState("case900Template.outC.layMul.monLay[3].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 30, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outC.layMul.monLay[3].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.T[3]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.der(T[3])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outC.layMul.monLay[3].monLayDyn.Q_flow[2]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outC.layMul.monLay[3].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outC.layMul.monLay[3].monLayDyn.T[1]", 1,\
 1, 29, 1028)
DeclareAlias2("case900Template.outC.layMul.monLay[3].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outC.layMul.port_a.Q_flow", 1, 5, 5111, 1156)
DeclareAlias2("case900Template.outC.layMul.monLay[3].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outC.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 28, 1028)
DeclareAlias2("case900Template.outC.layMul.monLay[3].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outC.layMul.monLay[2].port_a.Q_flow", -1, 5, 5068, 1156)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 530.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outD.layMul.monLay[1].monLayDyn.mat.d", \
"Layer thickness [m]", 830, 0.009, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.R", \
"[m2.K/W]", 0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 16.612602789104763, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.R", \
"Total specific thermal resistance", 0.06428571428571428, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outD.layMul.monLay[1].monLayDyn.E", "[J]", \
"case900Template.outD.layMul.monLay[1].E", 1, 5, 5485, 1024)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outD.layMul.monLay[1].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 31, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outD.layMul.monLay[1].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareState("case900Template.outD.layMul.monLay[1].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 32, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outD.layMul.monLay[1].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outD.layMul.monLay[1].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outD.layMul.monLay[1].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outD.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 31, 1028)
DeclareAlias2("case900Template.outD.layMul.monLay[1].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.layMul.monLay[1].port_a.Q_flow", 1, 5, 5486, 1156)
DeclareAlias2("case900Template.outD.layMul.monLay[1].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outD.layMul.monLay[1].monLayDyn.T[2]", 1,\
 1, 32, 1028)
DeclareAlias2("case900Template.outD.layMul.monLay[1].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.layMul.port_b.Q_flow", 1, 5, 5565, 1156)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 1400.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 10.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outD.layMul.monLay[2].monLayDyn.mat.d", \
"Layer thickness [m]", 831, 0.0615, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.R", \
"[m2.K/W]", 1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 2.8571428571428573E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 36.38389066606264, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.R", \
"Total specific thermal resistance", 1.5374999999999999, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outD.layMul.monLay[2].monLayDyn.E", "[J]", \
"case900Template.outD.layMul.monLay[2].E", 1, 5, 5520, 1024)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outD.layMul.monLay[2].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 33, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outD.layMul.monLay[2].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outD.layMul.monLay[2].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outD.layMul.monLay[2].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outD.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 33, 1028)
DeclareAlias2("case900Template.outD.layMul.monLay[2].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.layMul.monLay[2].port_a.Q_flow", 1, 5, 5521, 1156)
DeclareAlias2("case900Template.outD.layMul.monLay[2].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outD.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 31, 1028)
DeclareAlias2("case900Template.outD.layMul.monLay[2].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.layMul.monLay[1].port_a.Q_flow", -1, 5, 5486, 1156)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 1000.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 1400.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outD.layMul.monLay[3].monLayDyn.mat.d", \
"Layer thickness [m]", 832, 0.1, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.epsLw_a", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.epsLw_b", \
"Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.epsSw_a", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.epsSw_b", \
"Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.R", \
"[m2.K/W]", 0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 3.642857142857143E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.nStaRef", \
"Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 165.68337391590282, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 3, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.R", \
"Total specific thermal resistance", 0.19607843137254902, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outD.layMul.monLay[3].monLayDyn.E", "[J]", \
"case900Template.outD.layMul.monLay[3].E", 1, 5, 5555, 1024)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.G[1]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.G[2]", "[W/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.C[1]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.C[2]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.C[3]", "[J/K]",\
 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.Cinv[3]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 34, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outD.layMul.monLay[3].monLayDyn.der(T[1])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareState("case900Template.outD.layMul.monLay[3].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 35, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outD.layMul.monLay[3].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.T[3]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.der(T[3])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outD.layMul.monLay[3].monLayDyn.Q_flow[2]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outD.layMul.monLay[3].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outD.layMul.monLay[3].monLayDyn.T[1]", 1,\
 1, 34, 1028)
DeclareAlias2("case900Template.outD.layMul.monLay[3].monLayDyn.port_a.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.layMul.port_a.Q_flow", 1, 5, 5564, 1156)
DeclareAlias2("case900Template.outD.layMul.monLay[3].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outD.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 33, 1028)
DeclareAlias2("case900Template.outD.layMul.monLay[3].monLayDyn.port_b.Q_flow", \
"Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outD.layMul.monLay[2].port_a.Q_flow", -1, 5, 5521, 1156)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 900.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 530.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.d", \
"Layer thickness [m]", 833, 0.019, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.epsLw_a",\
 "Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.epsLw_b",\
 "Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.epsSw_a",\
 "Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.epsSw_b",\
 "Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.R", \
"[m2.K/W]", 0.1357142857142857, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 2.9350104821802937E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.nStaRef",\
 "Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 35.0710503325545, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.R", \
"Total specific thermal resistance", 0.1357142857142857, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outCei.layMul.monLay[1].monLayDyn.E", "[J]", \
"case900Template.outCei.layMul.monLay[1].E", 1, 5, 5938, 1024)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.G[1]", \
"[W/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.C[1]", \
"[J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.C[2]", \
"[J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outCei.layMul.monLay[1].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 36, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outCei.layMul.monLay[1].monLayDyn.der(T[1])",\
 "der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareState("case900Template.outCei.layMul.monLay[1].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 37, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outCei.layMul.monLay[1].monLayDyn.der(T[2])",\
 "der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outCei.layMul.monLay[1].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outCei.layMul.monLay[1].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 36, 1028)
DeclareAlias2("case900Template.outCei.layMul.monLay[1].monLayDyn.port_a.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.layMul.monLay[1].port_a.Q_flow", 1, 5, 5939, 1156)
DeclareAlias2("case900Template.outCei.layMul.monLay[1].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[1].monLayDyn.T[2]", 1,\
 1, 37, 1028)
DeclareAlias2("case900Template.outCei.layMul.monLay[1].monLayDyn.port_b.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.layMul.port_b.Q_flow", 1, 5, 6018, 1156)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 840.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 12.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.d", \
"Layer thickness [m]", 834, 0.1118, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.epsLw_a",\
 "Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.epsLw_b",\
 "Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.epsSw_a",\
 "Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.epsSw_b",\
 "Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.R", \
"[m2.K/W]", 2.795, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 3.968253968253968E-06, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.nStaRef",\
 "Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 56.12315457990579, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.R", \
"Total specific thermal resistance", 2.795, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outCei.layMul.monLay[2].monLayDyn.E", "[J]", \
"case900Template.outCei.layMul.monLay[2].E", 1, 5, 5973, 1024)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.G[1]", \
"[W/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.C[1]", \
"[J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.C[2]", \
"[J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outCei.layMul.monLay[2].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 38, 293.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outCei.layMul.monLay[2].monLayDyn.der(T[1])",\
 "der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outCei.layMul.monLay[2].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outCei.layMul.monLay[2].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 38, 1028)
DeclareAlias2("case900Template.outCei.layMul.monLay[2].monLayDyn.port_a.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.layMul.monLay[2].port_a.Q_flow", 1, 5, 5974, 1156)
DeclareAlias2("case900Template.outCei.layMul.monLay[2].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[1].monLayDyn.T[1]", 1,\
 1, 36, 1028)
DeclareAlias2("case900Template.outCei.layMul.monLay[2].monLayDyn.port_b.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.layMul.monLay[1].port_a.Q_flow", -1, 5, 5939, 1156)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.A", \
"Layer area [m2]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.k", \
"Thermal conductivity [W/(m.K)]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.c", \
"Specific thermal capacity [J/(kg.K)]", 840.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.rho", \
"Density [kg/m3|g/cm3]", 950.0, 0.0,1E+100,0.0,0,2561)
DeclareParameter("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.d", \
"Layer thickness [m]", 835, 0.01, 0.0,0.0,0.0,0,2608)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.epsLw", \
"Longwave emisivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.epsSw", \
"Shortwave emissivity [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.gas", \
"Boolean whether the material is a gas [:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.glass", \
"Boolean whether the material is made of glass [:#(type=Boolean)]", false, \
0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.mhu", \
"Viscosity, i.e. if the material is a fluid [m2/s]", 0.0, 0.0,1E+100,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.epsLw_a",\
 "Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.epsLw_b",\
 "Longwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.epsSw_a",\
 "Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.epsSw_b",\
 "Shortwave emisivity for surface a if different [1]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.R", \
"[m2.K/W]", 0.0625, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.alpha", \
"Thermal diffusivity [m2/s]", 2.0050125313283207E-07, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.nStaRef",\
 "Number of states of a reference case, ie. 20 cm dense concrete [:#(type=Integer)]",\
 3, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.piRef", \
"d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete", 224.0, \
0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.piLay", \
"d/sqrt(mat.alpha) of the depicted layer", 22.332711434127297, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.mat.nSta", \
"Actual number of state variables in material [:#(type=Integer)]", 2, 2.0,1E+100,\
0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.T_start", \
"Start temperature for each of the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.nStaMin", \
"Minimum number of states [:#(type=Integer)]", 2, 1.0,1E+100,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.energyDynamics",\
 "Static (steady state) or transient (dynamic) thermal conduction model [:#(type=Modelica.Fluid.Types.Dynamics)]",\
 2, 1.0,4.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.present", \
"[:#(type=Boolean)]", false, 0.0,0.0,0.0,0,2563)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.nSta", \
"Number of states [:#(type=Integer)]", 2, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.R", \
"Total specific thermal resistance", 0.0625, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.Ctot", \
"Total heat capacity [J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.addRes_b", \
"Set to true to add a resistor at port b. [:#(type=Boolean)]", false, 0.0,0.0,\
0.0,0,2563)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].monLayDyn.E", "[J]", \
"case900Template.outCei.layMul.monLay[3].E", 1, 5, 6008, 1024)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.nRes", \
"Number of thermal resistances [:#(type=Integer)]", 1, 0.0,0.0,0.0,0,2565)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.G[1]", \
"[W/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.C[1]", \
"[J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.C[2]", \
"[J/K]", 0.0, 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.Cinv[1]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.Cinv[2]", \
"Dummy parameter for efficiently handling check for division by zero [K/J]", 0.0,\
 0.0,0.0,0.0,0,2561)
DeclareState("case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", \
"Temperature at the states [K|degC]", 39, 289.15, 0.0,1E+100,300.0,0,2592)
DeclareDerivative("case900Template.outCei.layMul.monLay[3].monLayDyn.der(T[1])",\
 "der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.T[2]", \
"Temperature at the states [K|degC]", 293.15, 0.0,1E+100,300.0,0,2560)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.der(T[2])", \
"der(Temperature at the states) [K/s]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareVariable("case900Template.outCei.layMul.monLay[3].monLayDyn.Q_flow[1]", \
"Heat flow rate from state i to i-1 [W]", 0.0, 0.0,0.0,0.0,0,2560)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].monLayDyn.port_a.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[3].monLayDyn.T[1]", 1,\
 1, 39, 1028)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].monLayDyn.port_a.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.layMul.port_a.Q_flow", 1, 5, 6017, 1156)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].monLayDyn.port_b.T", \
"Port temperature [K|degC]", "case900Template.outCei.layMul.monLay[2].monLayDyn.T[1]", 1,\
 1, 38, 1028)
DeclareAlias2("case900Template.outCei.layMul.monLay[3].monLayDyn.port_b.Q_flow",\
 "Heat flow rate (positive if flowing from outside into the component) [W]", \
"case900Template.outCei.layMul.monLay[2].port_a.Q_flow", -1, 5, 5974, 1156)
DeclareAlias2("sim.weaDat.weaBus.pAtm", "Atmospheric pressure [Pa]", \
"sim.weaDat.pAtm", 1, 7, 24, 1028)
DeclareAlias2("sim.weaDat.weaBus.nTot", "Sky cover [0, 1] [1]", "weaBus.nTot", 1,\
 3, 18, 1028)
DeclareAlias2("sim.weaDat.weaBus.nOpa", "Sky cover [0, 1] [1]", "weaBus.nOpa", 1,\
 3, 17, 1028)
DeclareAlias2("sim.weaDat.weaBus.HGloHor", "Radiation [W/m2]", "weaBus.HGloHor", 1,\
 3, 7, 1028)
DeclareAlias2("sim.weaDat.weaBus.HDifHor", "Radiation [W/m2]", "weaBus.HDifHor", 1,\
 3, 5, 1028)
DeclareAlias2("sim.weaDat.weaBus.HDirNor", "Radiation [W/m2]", "weaBus.HDirNor", 1,\
 3, 6, 1028)
DeclareAlias2("sim.weaDat.weaBus.celHei", "Ceiling height [m]", "weaBus.celHei", 1,\
 3, 13, 1028)
DeclareAlias2("sim.weaDat.weaBus.winSpe", "Wind speed [m/s]", "weaBus.winSpe", 1,\
 3, 27, 1028)
DeclareAlias2("sim.weaDat.weaBus.HHorIR", "Horizontal infrared irradiation [W/m2]",\
 "weaBus.HHorIR", 1, 3, 8, 1028)
DeclareAlias2("sim.weaDat.weaBus.winDir", "Wind direction [rad|deg]", \
"weaBus.winDir", 1, 3, 26, 1028)
DeclareAlias2("sim.weaDat.weaBus.cloTim", "Connector of Real output signal", \
"weaBus.cloTim", 1, 3, 14, 1028)
DeclareAlias2("sim.weaDat.weaBus.solTim", "Solar time [s|s]", "weaBus.solTim", 1,\
 3, 24, 1028)
DeclareAlias2("sim.weaDat.weaBus.TDewPoi", "Output temperature [K|degC]", \
"weaBus.TDewPoi", 1, 3, 10, 1028)
DeclareAlias2("sim.weaDat.weaBus.relHum", "Relative humidity [1]", \
"weaBus.relHum", 1, 3, 20, 1028)
DeclareAlias2("sim.weaDat.weaBus.TDryBul", "Output temperature [K|degC]", \
"weaBus.TDryBul", 1, 3, 3, 1028)
DeclareAlias2("sim.weaDat.weaBus.TWetBul", "Wet bulb temperature [K]", \
"weaBus.TWetBul", 1, 3, 11, 1028)
DeclareAlias2("sim.weaDat.weaBus.solAlt", "Solar altitude angle [rad|deg]", \
"weaBus.solAlt", 1, 3, 21, 1028)
DeclareAlias2("sim.weaDat.weaBus.solZen", "Zenith angle [rad|deg]", \
"weaBus.solZen", 1, 3, 25, 1028)
DeclareAlias2("sim.weaDat.weaBus.solDec", "Solar declination angle [rad|deg]", \
"weaBus.solDec", 1, 3, 22, 1028)
DeclareAlias2("sim.weaDat.weaBus.solHouAng", "Solar hour angle [rad|deg]", \
"weaBus.solHouAng", 1, 3, 23, 1028)
DeclareVariable("sim.weaDat.weaBus.lon", "Longitude of the location [rad|deg]", \
0.07573681756104195, 0.0,0.0,0.0,0,2569)
DeclareVariable("sim.weaDat.weaBus.lat", "Latitude of the location [rad|deg]", \
0.8866674025859153, 0.0,0.0,0.0,0,2569)
DeclareAlias2("sim.weaDat.weaBus.TBlaSky", "Black-body sky temperature [K|degC]",\
 "weaBus.TBlaSky", 1, 3, 9, 1028)
DeclareAlias2("sim.weaDatBus.X_wEnv", "Steam mass fraction", "case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1,\
 5, 649, 4)
DeclareAlias2("sim.weaDatBus.solTim", "Connector of Real input signal", \
"weaBus.solTim", 1, 3, 24, 4)
DeclareAlias2("sim.weaDatBus.solZen", "Connector of Real input signal", \
"weaBus.solZen", 1, 3, 25, 4)
DeclareAlias2("sim.weaDatBus.HDifHor", "Connector of Real input signal", \
"weaBus.HDifHor", 1, 3, 5, 4)
DeclareAlias2("sim.weaDatBus.HGloHor", "Connector of Real input signal", \
"weaBus.HGloHor", 1, 3, 7, 4)
DeclareAlias2("sim.weaDatBus.HDirNor", "Connector of Real input signal", \
"weaBus.HDirNor", 1, 3, 6, 4)
DeclareAlias2("sim.weaDatBus.solDec", "Connector of Real input signal", \
"weaBus.solDec", 1, 3, 22, 4)
DeclareAlias2("sim.weaDatBus.solHouAng", "Connector of Real input signal", \
"weaBus.solHouAng", 1, 3, 23, 4)
DeclareAlias2("sim.weaDatBus.TDryBul", "Connector of Real input signal", \
"weaBus.TDryBul", 1, 3, 3, 4)
DeclareAlias2("sim.weaDatBus.relHum", "Connector of Real input signal", \
"weaBus.relHum", 1, 3, 20, 4)
DeclareAlias2("sim.weaDatBus.CEnv", "Value of Real output", "sim.weaBus.CEnv", 1,\
 5, 76, 4)
DeclareAlias2("sim.weaDatBus.TDewPoi", "Connector of Real input signal", \
"weaBus.TDewPoi", 1, 3, 10, 4)
DeclareAlias2("sim.weaDatBus.nOpa", "Connector of Real input signal", \
"weaBus.nOpa", 1, 3, 17, 4)
DeclareAlias2("sim.weaDatBus.winSpe", "Connector of Real input signal", \
"weaBus.winSpe", 1, 3, 27, 4)
DeclareAlias2("sim.weaDatBus.TBlaSky", "Connector of Real input signal", \
"weaBus.TBlaSky", 1, 3, 9, 4)
DeclareOutput("weaBus.TDryBul", "Outside temperature [K|degC]", 3, 293.15, 0.0,\
1E+100,300.0,0,520)
DeclareAlias2("sim.weaDat.weaBus.CEnv", "Value of Real output", "sim.weaBus.CEnv", 1,\
 5, 76, 1028)
DeclareAlias2("sim.weaDat.weaBus.X_wEnv", "Steam mass fraction", \
"case900Template.interzonalAirFlow.bou.X_in_internal[1]", 1, 5, 649, 1028)
DeclareAlias2("sim.weaDatBus.HHorIR", "Horizontal infrared irradiation [W/m2]", \
"weaBus.HHorIR", 1, 3, 8, 4)
DeclareAlias2("sim.weaDatBus.TWetBul", "Wet bulb temperature [K]", \
"weaBus.TWetBul", 1, 3, 11, 4)
DeclareAlias2("sim.weaDatBus.celHei", "Ceiling height [m]", "weaBus.celHei", 1, 3,\
 13, 4)
DeclareAlias2("sim.weaDatBus.cloTim", "Connector of Real output signal", \
"weaBus.cloTim", 1, 3, 14, 4)
DeclareVariable("sim.weaDatBus.lat", "Latitude of the location [rad|deg]", \
0.8866674025859153, 0.0,0.0,0.0,0,521)
DeclareVariable("sim.weaDatBus.lon", "Longitude of the location [rad|deg]", \
0.07573681756104195, 0.0,0.0,0.0,0,521)
DeclareAlias2("sim.weaDatBus.nTot", "Sky cover [0, 1] [1]", "weaBus.nTot", 1, 3,\
 18, 4)
DeclareAlias2("sim.weaDatBus.pAtm", "Atmospheric pressure [Pa]", \
"sim.weaDat.pAtm", 1, 7, 24, 4)
DeclareAlias2("sim.weaDatBus.solAlt", "Solar altitude angle [rad|deg]", \
"weaBus.solAlt", 1, 3, 21, 4)
DeclareAlias2("sim.weaDatBus.winDir", "Wind direction [rad|deg]", \
"weaBus.winDir", 1, 3, 26, 4)
DeclareOutput("weaBus.CEnv", "Value of Real output", 4, 0.0, 0.0,0.0,0.0,0,521)
DeclareOutput("weaBus.HDifHor", "Connector of Real input signal [W/m2]", 5, 100,\
 0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.HDirNor", "Connector of Real input signal [W/m2]", 6, 1, \
0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.HGloHor", "Connector of Real input signal [W/m2]", 7, 100,\
 0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.HHorIR", "Horizontal infrared irradiation [W/m2]", 8, 0.0,\
 0.0,1E+100,100.0,0,520)
DeclareOutput("weaBus.TBlaSky", "Connector of Real input signal [K|degC]", 9, \
288.15, 0.0,1E+100,300.0,0,520)
DeclareOutput("weaBus.TDewPoi", "Connector of Real input signal [K|degC]", 10, \
288.15, 0.0,1E+100,300.0,0,520)
DeclareOutput("weaBus.TWetBul", "Wet bulb temperature [K]", 11, 291.15, 0.0,\
1E+100,0.0,0,584)
DeclareOutput("weaBus.X_wEnv", "Steam mass fraction", 12, 0.0, 0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.celHei", "Ceiling height [m]", 13, 0.0, 0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.cloTim", "Connector of Real output signal", 14, 0.0, \
0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.lat", "Latitude of the location [rad|deg]", 15, \
0.8866674025859153, 0.0,0.0,0.0,0,521)
DeclareOutput("weaBus.lon", "Longitude of the location [rad|deg]", 16, \
0.07573681756104195, 0.0,0.0,0.0,0,521)
DeclareOutput("weaBus.nOpa", "Connector of Real input signal [1]", 17, 0.0, 0.0,\
1.0,0.0,0,520)
DeclareOutput("weaBus.nTot", "Sky cover [0, 1] [1]", 18, 0.0, 0.0,1.0,0.0,0,520)
DeclareOutput("weaBus.pAtm", "Atmospheric pressure [Pa]", 19, 0.0, 0.0,0.0,0.0,0,521)
DeclareOutput("weaBus.relHum", "Connector of Real input signal [1]", 20, 1, 0.0,\
1.0,0.0,0,520)
DeclareOutput("weaBus.solAlt", "Solar altitude angle [rad|deg]", 21, 0.0, \
0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.solDec", "Connector of Real input signal [rad|deg]", 22, 1,\
 0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.solHouAng", "Connector of Real input signal [rad|deg]", 23,\
 1, 0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.solTim", "Connector of Real input signal [s|s]", 24, 1, \
0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.solZen", "Connector of Real input signal [rad|deg]", 25, 1,\
 0.0,0.0,0.0,0,520)
DeclareOutput("weaBus.winDir", "Wind direction [rad|deg]", 26, 0.0, 0.0,0.0,0.0,\
0,520)
DeclareOutput("weaBus.winSpe", "Connector of Real input signal [m/s]", 27, 0.0, \
0.0,0.0,0.0,0,520)
EndNonAlias(6)
PreNonAliasNew(7)
