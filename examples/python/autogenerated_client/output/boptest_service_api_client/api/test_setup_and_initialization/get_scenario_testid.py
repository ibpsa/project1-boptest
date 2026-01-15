from http import HTTPStatus
from typing import Any
from urllib.parse import quote

import httpx

from ... import errors
from ...client import AuthenticatedClient, Client
from ...models.get_scenario_testid_response_200 import GetScenarioTestidResponse200
from ...types import Response


def _get_kwargs(
    testid: str,
) -> dict[str, Any]:
    _kwargs: dict[str, Any] = {
        "method": "get",
        "url": "/scenario/{testid}".format(
            testid=quote(str(testid), safe=""),
        ),
    }

    return _kwargs


def _parse_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> GetScenarioTestidResponse200 | None:
    if response.status_code == 200:
        response_200 = GetScenarioTestidResponse200.from_dict(response.json())

        return response_200

    if client.raise_on_unexpected_status:
        raise errors.UnexpectedStatus(response.status_code, response.content)
    else:
        return None


def _build_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> Response[GetScenarioTestidResponse200]:
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
) -> Response[GetScenarioTestidResponse200]:
    """Get the current scenario setup

     Returns a description of the current scenario.

    Args:
        testid (str):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[GetScenarioTestidResponse200]
    """

    kwargs = _get_kwargs(
        testid=testid,
    )

    response = client.get_httpx_client().request(
        **kwargs,
    )

    return _build_response(client=client, response=response)


def sync(
    testid: str,
    *,
    client: AuthenticatedClient | Client,
) -> GetScenarioTestidResponse200 | None:
    """Get the current scenario setup

     Returns a description of the current scenario.

    Args:
        testid (str):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        GetScenarioTestidResponse200
    """

    return sync_detailed(
        testid=testid,
        client=client,
    ).parsed


async def asyncio_detailed(
    testid: str,
    *,
    client: AuthenticatedClient | Client,
) -> Response[GetScenarioTestidResponse200]:
    """Get the current scenario setup

     Returns a description of the current scenario.

    Args:
        testid (str):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[GetScenarioTestidResponse200]
    """

    kwargs = _get_kwargs(
        testid=testid,
    )

    response = await client.get_async_httpx_client().request(**kwargs)

    return _build_response(client=client, response=response)


async def asyncio(
    testid: str,
    *,
    client: AuthenticatedClient | Client,
) -> GetScenarioTestidResponse200 | None:
    """Get the current scenario setup

     Returns a description of the current scenario.

    Args:
        testid (str):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        GetScenarioTestidResponse200
    """

    return (
        await asyncio_detailed(
            testid=testid,
            client=client,
        )
    ).parsed
