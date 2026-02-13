from http import HTTPStatus
from typing import Any
from urllib.parse import quote

import httpx

from ... import errors
from ...client import AuthenticatedClient, Client
from ...models.put_scenario_testid_body import PutScenarioTestidBody
from ...models.put_scenario_testid_response_200 import PutScenarioTestidResponse200
from ...types import Response


def _get_kwargs(
    testid: str,
    *,
    body: PutScenarioTestidBody,
) -> dict[str, Any]:
    headers: dict[str, Any] = {}

    _kwargs: dict[str, Any] = {
        "method": "put",
        "url": "/scenario/{testid}".format(
            testid=quote(str(testid), safe=""),
        ),
    }

    _kwargs["json"] = body.to_dict()

    headers["Content-Type"] = "application/json"

    _kwargs["headers"] = headers
    return _kwargs


def _parse_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> PutScenarioTestidResponse200 | None:
    if response.status_code == 200:
        response_200 = PutScenarioTestidResponse200.from_dict(response.json())

        return response_200

    if client.raise_on_unexpected_status:
        raise errors.UnexpectedStatus(response.status_code, response.content)
    else:
        return None


def _build_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> Response[PutScenarioTestidResponse200]:
    return Response(
        status_code=HTTPStatus(response.status_code),
        content=response.content,
        headers=response.headers,
        parsed=_parse_response(client=client, response=response),
    )


def sync_detailed(
    testid: str,
    *,
    client: AuthenticatedClient | Client,
    body: PutScenarioTestidBody,
) -> Response[PutScenarioTestidResponse200]:
    r"""Set a test scenario

     Set the scenario for the running test. Optional properties may trigger an initialization (see
    README).
    Typically, the supported scenario settings include:
      * electricity_price: \"constant\" or \"dynamic\" or \"highly_dynamic\"
      * time_period: \"typical_heat_day\" or \"peak_heat_day\"
      * temperature_uncertainty: *null* or \"low\" or \"medium\" or \"high\"
      * solar_uncertainty: *null* or \"low\" or \"medium\" or \"high\"
      * seed: *int*

    However, this is partly test case specific. See the test case documentation for supported scenarios.

    Args:
        testid (str):
        body (PutScenarioTestidBody): Generic scenario payload.

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[PutScenarioTestidResponse200]
    """

    kwargs = _get_kwargs(
        testid=testid,
        body=body,
    )

    response = client.get_httpx_client().request(
        **kwargs,
    )

    return _build_response(client=client, response=response)


def sync(
    testid: str,
    *,
    client: AuthenticatedClient | Client,
    body: PutScenarioTestidBody,
) -> PutScenarioTestidResponse200 | None:
    r"""Set a test scenario

     Set the scenario for the running test. Optional properties may trigger an initialization (see
    README).
    Typically, the supported scenario settings include:
      * electricity_price: \"constant\" or \"dynamic\" or \"highly_dynamic\"
      * time_period: \"typical_heat_day\" or \"peak_heat_day\"
      * temperature_uncertainty: *null* or \"low\" or \"medium\" or \"high\"
      * solar_uncertainty: *null* or \"low\" or \"medium\" or \"high\"
      * seed: *int*

    However, this is partly test case specific. See the test case documentation for supported scenarios.

    Args:
        testid (str):
        body (PutScenarioTestidBody): Generic scenario payload.

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        PutScenarioTestidResponse200
    """

    return sync_detailed(
        testid=testid,
        client=client,
        body=body,
    ).parsed


async def asyncio_detailed(
    testid: str,
    *,
    client: AuthenticatedClient | Client,
    body: PutScenarioTestidBody,
) -> Response[PutScenarioTestidResponse200]:
    r"""Set a test scenario

     Set the scenario for the running test. Optional properties may trigger an initialization (see
    README).
    Typically, the supported scenario settings include:
      * electricity_price: \"constant\" or \"dynamic\" or \"highly_dynamic\"
      * time_period: \"typical_heat_day\" or \"peak_heat_day\"
      * temperature_uncertainty: *null* or \"low\" or \"medium\" or \"high\"
      * solar_uncertainty: *null* or \"low\" or \"medium\" or \"high\"
      * seed: *int*

    However, this is partly test case specific. See the test case documentation for supported scenarios.

    Args:
        testid (str):
        body (PutScenarioTestidBody): Generic scenario payload.

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[PutScenarioTestidResponse200]
    """

    kwargs = _get_kwargs(
        testid=testid,
        body=body,
    )

    response = await client.get_async_httpx_client().request(**kwargs)

    return _build_response(client=client, response=response)


async def asyncio(
    testid: str,
    *,
    client: AuthenticatedClient | Client,
    body: PutScenarioTestidBody,
) -> PutScenarioTestidResponse200 | None:
    r"""Set a test scenario

     Set the scenario for the running test. Optional properties may trigger an initialization (see
    README).
    Typically, the supported scenario settings include:
      * electricity_price: \"constant\" or \"dynamic\" or \"highly_dynamic\"
      * time_period: \"typical_heat_day\" or \"peak_heat_day\"
      * temperature_uncertainty: *null* or \"low\" or \"medium\" or \"high\"
      * solar_uncertainty: *null* or \"low\" or \"medium\" or \"high\"
      * seed: *int*

    However, this is partly test case specific. See the test case documentation for supported scenarios.

    Args:
        testid (str):
        body (PutScenarioTestidBody): Generic scenario payload.

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        PutScenarioTestidResponse200
    """

    return (
        await asyncio_detailed(
            testid=testid,
            client=client,
            body=body,
        )
    ).parsed
