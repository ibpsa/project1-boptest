from http import HTTPStatus
from typing import Any
from urllib.parse import quote

import httpx

from ... import errors
from ...client import AuthenticatedClient, Client
from ...models.post_testcases_testcase_name_select_body import PostTestcasesTestcaseNameSelectBody
from ...models.post_testcases_testcase_name_select_response_200 import PostTestcasesTestcaseNameSelectResponse200
from ...types import Response


def _get_kwargs(
    testcase_name: str,
    *,
    body: PostTestcasesTestcaseNameSelectBody,
) -> dict[str, Any]:
    headers: dict[str, Any] = {}

    _kwargs: dict[str, Any] = {
        "method": "post",
        "url": "/testcases/{testcase_name}/select".format(
            testcase_name=quote(str(testcase_name), safe=""),
        ),
    }

    _kwargs["json"] = body.to_dict()

    headers["Content-Type"] = "application/json"

    _kwargs["headers"] = headers
    return _kwargs


def _parse_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> PostTestcasesTestcaseNameSelectResponse200 | None:
    if response.status_code == 200:
        response_200 = PostTestcasesTestcaseNameSelectResponse200.from_dict(response.json())

        return response_200

    if client.raise_on_unexpected_status:
        raise errors.UnexpectedStatus(response.status_code, response.content)
    else:
        return None


def _build_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> Response[PostTestcasesTestcaseNameSelectResponse200]:
    return Response(
        status_code=HTTPStatus(response.status_code),
        content=response.content,
        headers=response.headers,
        parsed=_parse_response(client=client, response=response),
    )


def sync_detailed(
    testcase_name: str,
    *,
    client: AuthenticatedClient | Client,
    body: PostTestcasesTestcaseNameSelectBody,
) -> Response[PostTestcasesTestcaseNameSelectResponse200]:
    """Select a test case and start a new test

     Selects an IBPSA BOPTEST test case and begins a new test. Returns a testid (UUID) required by other
    APIs.

    Args:
        testcase_name (str):
        body (PostTestcasesTestcaseNameSelectBody): Optional selection parameters (implementation-
            specific).

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[PostTestcasesTestcaseNameSelectResponse200]
    """

    kwargs = _get_kwargs(
        testcase_name=testcase_name,
        body=body,
    )

    response = client.get_httpx_client().request(
        **kwargs,
    )

    return _build_response(client=client, response=response)


def sync(
    testcase_name: str,
    *,
    client: AuthenticatedClient | Client,
    body: PostTestcasesTestcaseNameSelectBody,
) -> PostTestcasesTestcaseNameSelectResponse200 | None:
    """Select a test case and start a new test

     Selects an IBPSA BOPTEST test case and begins a new test. Returns a testid (UUID) required by other
    APIs.

    Args:
        testcase_name (str):
        body (PostTestcasesTestcaseNameSelectBody): Optional selection parameters (implementation-
            specific).

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        PostTestcasesTestcaseNameSelectResponse200
    """

    return sync_detailed(
        testcase_name=testcase_name,
        client=client,
        body=body,
    ).parsed


async def asyncio_detailed(
    testcase_name: str,
    *,
    client: AuthenticatedClient | Client,
    body: PostTestcasesTestcaseNameSelectBody,
) -> Response[PostTestcasesTestcaseNameSelectResponse200]:
    """Select a test case and start a new test

     Selects an IBPSA BOPTEST test case and begins a new test. Returns a testid (UUID) required by other
    APIs.

    Args:
        testcase_name (str):
        body (PostTestcasesTestcaseNameSelectBody): Optional selection parameters (implementation-
            specific).

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[PostTestcasesTestcaseNameSelectResponse200]
    """

    kwargs = _get_kwargs(
        testcase_name=testcase_name,
        body=body,
    )

    response = await client.get_async_httpx_client().request(**kwargs)

    return _build_response(client=client, response=response)


async def asyncio(
    testcase_name: str,
    *,
    client: AuthenticatedClient | Client,
    body: PostTestcasesTestcaseNameSelectBody,
) -> PostTestcasesTestcaseNameSelectResponse200 | None:
    """Select a test case and start a new test

     Selects an IBPSA BOPTEST test case and begins a new test. Returns a testid (UUID) required by other
    APIs.

    Args:
        testcase_name (str):
        body (PostTestcasesTestcaseNameSelectBody): Optional selection parameters (implementation-
            specific).

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        PostTestcasesTestcaseNameSelectResponse200
    """

    return (
        await asyncio_detailed(
            testcase_name=testcase_name,
            client=client,
            body=body,
        )
    ).parsed
