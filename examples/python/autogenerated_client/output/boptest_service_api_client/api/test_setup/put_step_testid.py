from http import HTTPStatus
from typing import Any
from urllib.parse import quote

import httpx

from ... import errors
from ...client import AuthenticatedClient, Client
from ...models.put_step_testid_body import PutStepTestidBody
from ...models.put_step_testid_response_200 import PutStepTestidResponse200
from ...types import Response


def _get_kwargs(
    testid: str,
    *,
    body: PutStepTestidBody,
) -> dict[str, Any]:
    headers: dict[str, Any] = {}

    _kwargs: dict[str, Any] = {
        "method": "put",
        "url": "/step/{testid}".format(
            testid=quote(str(testid), safe=""),
        ),
    }

    _kwargs["json"] = body.to_dict()

    headers["Content-Type"] = "application/json"

    _kwargs["headers"] = headers
    return _kwargs


def _parse_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> PutStepTestidResponse200 | None:
    if response.status_code == 200:
        response_200 = PutStepTestidResponse200.from_dict(response.json())

        return response_200

    if client.raise_on_unexpected_status:
        raise errors.UnexpectedStatus(response.status_code, response.content)
    else:
        return None


def _build_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> Response[PutStepTestidResponse200]:
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
    body: PutStepTestidBody,
) -> Response[PutStepTestidResponse200]:
    """Set the control time step

     Sets the time step used for control.

    Args:
        testid (str):
        body (PutStepTestidBody):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[PutStepTestidResponse200]
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
    body: PutStepTestidBody,
) -> PutStepTestidResponse200 | None:
    """Set the control time step

     Sets the time step used for control.

    Args:
        testid (str):
        body (PutStepTestidBody):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        PutStepTestidResponse200
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
    body: PutStepTestidBody,
) -> Response[PutStepTestidResponse200]:
    """Set the control time step

     Sets the time step used for control.

    Args:
        testid (str):
        body (PutStepTestidBody):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[PutStepTestidResponse200]
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
    body: PutStepTestidBody,
) -> PutStepTestidResponse200 | None:
    """Set the control time step

     Sets the time step used for control.

    Args:
        testid (str):
        body (PutStepTestidBody):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        PutStepTestidResponse200
    """

    return (
        await asyncio_detailed(
            testid=testid,
            client=client,
            body=body,
        )
    ).parsed
