within IBPSA.Experimental.Benchmarks.AirFlow;
package Components "Zonal components for a scalable air flow benchmark"
annotation (Documentation(info="<html>
<p>This package contains modular zone models that can be combined for a scalable airflow benchmark.
The individual zone models are combined in the <code>Floor</code> model, in which a number of Zones <code>nZones</code> can
be specified. The model will then accordingly adjust the number of the vectorized zones.</p>
</html>"));
end Components;
