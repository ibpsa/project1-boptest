from http import HTTPStatus
from typing import Any
from urllib.parse import quote

import httpx

from ... import errors
from ...client import AuthenticatedClient, Client
from ...models.put_results_testid_response_200 import PutResultsTestidResponse200
from ...models.results_query import ResultsQuery
from ...types import Response


def _get_kwargs(
    testid: str,
    *,
    body: ResultsQuery,
) -> dict[str, Any]:
    headers: dict[str, Any] = {}

    _kwargs: dict[str, Any] = {
        "method": "put",
        "url": "/results/{testid}".format(
            testid=quote(str(testid), safe=""),
        ),
    }

    _kwargs["json"] = body.to_dict()

    headers["Content-Type"] = "application/json"

    _kwargs["headers"] = headers
    return _kwargs


def _parse_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> PutResultsTestidResponse200 | None:
    if response.status_code == 200:
        response_200 = PutResultsTestidResponse200.from_dict(response.json())

        return response_200

    if client.raise_on_unexpected_status:
        raise errors.UnexpectedStatus(response.status_code, response.content)
    else:
        return None


def _build_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> Response[PutResultsTestidResponse200]:
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
    body: ResultsQuery,
) -> Response[PutResultsTestidResponse200]:
    """Query results.

     Returns simulation data for the given point names over a time period.
    Data for control input points will be the values used for simulation,
    meaning embedded default control if not overwritten or user-specified
    value if overwritten.

    Args:
        testid (str):
        body (ResultsQuery):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[PutResultsTestidResponse200]
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
    body: ResultsQuery,
) -> PutResultsTestidResponse200 | None:
    """Query results.

     Returns simulation data for the given point names over a time period.
    Data for control input points will be the values used for simulation,
    meaning embedded default control if not overwritten or user-specified
    value if overwritten.

    Args:
        testid (str):
        body (ResultsQuery):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        PutResultsTestidResponse200
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
    body: ResultsQuery,
) -> Response[PutResultsTestidResponse200]:
    """Query results.

     Returns simulation data for the given point names over a time period.
    Data for control input points will be the values used for simulation,
    meaning embedded default control if not overwritten or user-specified
    value if overwritten.

    Args:
        testid (str):
        body (ResultsQuery):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[PutResultsTestidResponse200]
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
    body: ResultsQuery,
) -> PutResultsTestidResponse200 | None:
    """Query results.

     Returns simulation data for the given point names over a time period.
    Data for control input points will be the values used for simulation,
    meaning embedded default control if not overwritten or user-specified
    value if overwritten.

    Args:
        testid (str):
        body (ResultsQuery):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        PutResultsTestidResponse200
    """

    return (
        await asyncio_detailed(
            testid=testid,
            client=client,
            body=body,
        )
    ).parsed
