within IDEAS.Examples.TwinHouses.BaseClasses.Data;
package Shadings "Package containing the records for the shading devices"

  record ShaWin1 "Shading device for window type 1"
    extends IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties(
      shaType=IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.BoxAndScreen,
      hWin=1.30,
      wWin=0.99,
      wLeft=0.1,
      wRight=0.1,
      ovDep=0.15,
      ovGap=0.11,
      hFin=0.10,
      finDep=0.15,
      finGap=0.1,
      shaCorr=0.0,
      controlled=true);
  end ShaWin1;

  record ShaWin2 "Shading device for window type 2"
    extends IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties(
      shaType=IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.BoxAndScreen,
      hWin=2.40,
      wWin=0.88,
      wLeft=0.1,
      wRight=3,
      ovDep=0.15,
      ovGap=0.11,
      hFin=0.10,
      finDep=0.15,
      finGap=0.1,
      shaCorr=0.0,
      controlled=true);
  end ShaWin2;

  record ShaWin3 "Shading device for window type 3"
    extends IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties(
      shaType=IDEAS.Buildings.Components.Shading.Interfaces.ShadingType.BoxAndScreen,
      hWin=1.40,
      wWin=3.3,
      wLeft=1.2,
      wRight=0.1,
      ovDep=0.15,
      ovGap=0.11,
      hFin=0.10,
      finDep=0.15,
      finGap=0.1,
      shaCorr=0.0,
      controlled=true);
  end ShaWin3;
end Shadings;
