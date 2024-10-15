within IDEAS.Buildings.Validation.Tests;
model n50Test3
  extends n50Test2(disableAssert=true,zone1(use_custom_n50=false), zone(use_custom_n50=false));

  Real flowDelta = sum(bou.ports.m_flow) + rho_default*(zone1.V+zone.V)*sim.n50/3600;

equation
  assert(abs(flowDelta)< 1e-6 or time<2, "Flow rate consistency check failed");
  annotation (Documentation(revisions="<html>
<ul>
<li>
June 3, 2021, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>This model verifies the n50 recomputation implementation that is used for the interzonal airflow implementation.</p>
</html>"), experiment(StopTime=3, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Validation/Tests/n50Test3.mos"
        "Simulate and plot"));
end n50Test3;
