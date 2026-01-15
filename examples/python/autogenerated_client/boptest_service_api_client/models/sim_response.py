from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.sim_response_payload import SimResponsePayload


T = TypeVar("T", bound="SimResponse")


@_attrs_define
class SimResponse:
    """
    Attributes:
        message (str | Unset): A message describing the response.
        payload (SimResponsePayload | Unset): Current values of all input and measurement signals; always includes
            "time".
        status (int | Unset): HTTP status code.
    """

    message: str | Unset = UNSET
    payload: SimResponsePayload | Unset = UNSET
    status: int | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        message = self.message

        payload: dict[str, Any] | Unset = UNSET
        if not isinstance(self.payload, Unset):
            payload = self.payload.to_dict()

        status = self.status

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if message is not UNSET:
            field_dict["message"] = message
        if payload is not UNSET:
            field_dict["payload"] = payload
        if status is not UNSET:
            field_dict["status"] = status

        return field_dict

    @classmethod
    def from_dict(cls: type[T], src_dict: Mapping[str, Any]) -> T:
        from ..models.sim_response_payload import SimResponsePayload

        d = dict(src_dict)
        message = d.pop("message", UNSET)

        _payload = d.pop("payload", UNSET)
        payload: SimResponsePayload | Unset
        if isinstance(_payload, Unset):
            payload = UNSET
        else:
            payload = SimResponsePayload.from_dict(_payload)

        status = d.pop("status", UNSET)

        sim_response = cls(
            message=message,
            payload=payload,
            status=status,
        )

        sim_response.additional_properties = d
        return sim_response

    @property
    def additional_keys(self) -> list[str]:
        return list(self.additional_properties.keys())

    def __getitem__(self, key: str) -> Any:
        return self.additional_properties[key]

    def __setitem__(self, key: str, value: Any) -> None:
        self.additional_properties[key] = value

    def __delitem__(self, key: str) -> None:
        del self.additional_properties[key]

    def __contains__(self, key: str) -> bool:
        return key in self.additional_properties
