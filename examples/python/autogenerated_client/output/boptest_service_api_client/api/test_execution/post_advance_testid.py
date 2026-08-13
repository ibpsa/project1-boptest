from http import HTTPStatus
from typing import Any
from urllib.parse import quote

import httpx

from ... import errors
from ...client import AuthenticatedClient, Client
from ...models.post_advance_testid_body import PostAdvanceTestidBody
from ...models.sim_response import SimResponse
from ...types import Response


def _get_kwargs(
    testid: str,
    *,
    body: PostAdvanceTestidBody,
) -> dict[str, Any]:
    headers: dict[str, Any] = {}

    _kwargs: dict[str, Any] = {
        "method": "post",
        "url": "/advance/{testid}".format(
            testid=quote(str(testid), safe=""),
        ),
    }

    _kwargs["json"] = body.to_dict()

    headers["Content-Type"] = "application/json"

    _kwargs["headers"] = headers
    return _kwargs


def _parse_response(*, client: AuthenticatedClient | Client, response: httpx.Response) -> SimResponse | None:
    if response.status_code == 200:
        response_200 = SimResponse.from_dict(response.json())

        return response_200

    if client.raise_on_unexpected_status:
        raise errors.UnexpectedStatus(response.status_code, response.content)
    else:
        return None


def _build_response(*, client: AuthenticatedClient | Client, response: httpx.Response) -> Response[SimResponse]:
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
    body: PostAdvanceTestidBody,
) -> Response[SimResponse]:
    """Advance the simulation one control step with optional control input overrides.

     Advance simulation one control step with optional control input(s) and receive measurements.
    If specified, control input value(s) will be constant over the control step.
    Use <input_name_u> to specify value and corresponding <input_name_activate> to enable value
    overwrite for the input.

    Args:
        testid (str):
        body (PostAdvanceTestidBody):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[SimResponse]
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
    body: PostAdvanceTestidBody,
) -> SimResponse | None:
    """Advance the simulation one control step with optional control input overrides.

     Advance simulation one control step with optional control input(s) and receive measurements.
    If specified, control input value(s) will be constant over the control step.
    Use <input_name_u> to specify value and corresponding <input_name_activate> to enable value
    overwrite for the input.

    Args:
        testid (str):
        body (PostAdvanceTestidBody):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        SimResponse
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
    body: PostAdvanceTestidBody,
) -> Response[SimResponse]:
    """Advance the simulation one control step with optional control input overrides.

     Advance simulation one control step with optional control input(s) and receive measurements.
    If specified, control input value(s) will be constant over the control step.
    Use <input_name_u> to specify value and corresponding <input_name_activate> to enable value
    overwrite for the input.

    Args:
        testid (str):
        body (PostAdvanceTestidBody):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[SimResponse]
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
    body: PostAdvanceTestidBody,
) -> SimResponse | None:
    """Advance the simulation one control step with optional control input overrides.

     Advance simulation one control step with optional control input(s) and receive measurements.
    If specified, control input value(s) will be constant over the control step.
    Use <input_name_u> to specify value and corresponding <input_name_activate> to enable value
    overwrite for the input.

    Args:
        testid (str):
        body (PostAdvanceTestidBody):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        SimResponse
    """

    return (
        await asyncio_detailed(
            testid=testid,
            client=client,
            body=body,
        )
    ).parsed
