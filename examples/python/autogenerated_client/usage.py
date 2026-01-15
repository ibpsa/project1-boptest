import asyncio
import pandas as pd
from output.boptest_service_api_client.api.test_case_management_and_inspection import (
    get_forecast_points_testid,
    get_inputs_testid,
    get_measurements_testid,
    get_testcases,
    post_testcases_testcase_name_select,
    put_stop_testid
)
from output.boptest_service_api_client.api.test_simulation_and_data import (
    get_kpi_testid,
    post_advance_testid,
    put_forecast_testid,
    put_results_testid,
)
from output.boptest_service_api_client.client import Client
from output.boptest_service_api_client.models.forecast_query import ForecastQuery
from output.boptest_service_api_client.models.post_advance_testid_body import PostAdvanceTestidBody
from output.boptest_service_api_client.models.post_testcases_testcase_name_select_body import PostTestcasesTestcaseNameSelectBody
from output.boptest_service_api_client.models.results_query import ResultsQuery


def main():
    client = Client("http://localhost")
    testcases_resp = get_testcases.sync(client=client)

    print("Available testcases:")
    for tc in testcases_resp:
        print(tc.testcaseid)

    testcase = "bestest_hydronic"
    print(f"\nSelecting testcase: {testcase}")
    my_test = post_testcases_testcase_name_select.sync(
        testcase,
        client=client,
        body=PostTestcasesTestcaseNameSelectBody()
    )
    if my_test is None:
        print("Could not start new test")
        return

    print(f"Successfully created testcase '{testcase}' with id '{my_test.testid}'")
    try:
        inputs = get_inputs_testid.sync(my_test.testid, client=client)
        df_input = pd.DataFrame.from_dict(inputs.payload.to_dict(), orient="index")
        print("\nAvailable inputs:")
        print(df_input)

        measurement_points = get_measurements_testid.sync(my_test.testid, client=client)
        df_measurements = pd.DataFrame.from_dict(measurement_points.payload.to_dict(), orient="index")
        print("\nAvailable measurements:")
        print(df_measurements)

        forecast_points = get_forecast_points_testid.sync(my_test.testid, client=client)
        df_forecasts = pd.DataFrame.from_dict(forecast_points.payload.to_dict(), orient="index")
        print("\nAvailable forecasts:")
        print(df_forecasts)

        fc_names = [s for s in df_forecasts.index.values]
        forecast_resp = put_forecast_testid.sync(
            my_test.testid,
            client=client,
            body=ForecastQuery(point_names=fc_names, horizon=36000, interval=3600)
        )
        forecasts = pd.DataFrame(forecast_resp.payload.to_dict())
        print("\nForecast data:")
        print(forecasts.head())

        print("\nStepping 10 steps:")
        res = []
        for _ in range(10):
            u = {}
            _resp = post_advance_testid.sync(
                my_test.testid,
                client=client,
                body=PostAdvanceTestidBody.from_dict(u)
            )
            y = _resp.payload.to_dict()
            res.append(y)

        df = pd.DataFrame(res)
        print(df)

        # Need to be built-in python types for JSON serialization, i.e. list, int, float
        # numpy types like np.ndarray, np.int64 are not allowed
        measurement_names = df_measurements.index.values.tolist()
        final_time = float(df["time"].iloc[-1])
        sim_res = put_results_testid.sync(
            my_test.testid,
            client=client,
            body=ResultsQuery(point_names=measurement_names, start_time=0, final_time=final_time)
        )

        # Accessing properties defined in schema
        print("\nFirst 5 measurement times:")
        print(sim_res.payload.time[:5])
        # Accessing properties not defined in schema
        print("\nFirst 5 measurement CO2 values:")
        print(sim_res.payload["reaCO2RooAir_y"][:5])

        df_res = pd.DataFrame.from_dict(sim_res.payload.to_dict(), orient="columns")
        print("\nMeasurements:")
        print(df_res.head())

        kpi = get_kpi_testid.sync(my_test.testid, client=client)
        print("\nKPI:")
        for metric, value in kpi.payload.to_dict().items():
            print(f"{metric}: {value}")
    finally:
        print(f"\nStopping test with id '{my_test.testid}'")
        put_stop_testid.sync(my_test.testid, client=client)


async def async_main():
    client = Client("http://localhost")

    print("\nUsing asynchronous I/O to get testcases:")
    testcases_res = await get_testcases.asyncio(client=client)
    for tc in testcases_res:
        print(tc.testcaseid)

if __name__ == "__main__":
    main()
    asyncio.run(async_main())
