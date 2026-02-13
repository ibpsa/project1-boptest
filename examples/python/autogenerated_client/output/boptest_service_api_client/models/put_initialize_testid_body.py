from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field

T = TypeVar("T", bound="PutInitializeTestidBody")


@_attrs_define
class PutInitializeTestidBody:
    """
    Attributes:
        start_time (float): Start time (seconds since Jan 1st, 00:00:00) to initialize the simulation to.
        warmup_period (float): Warmup period in seconds.
    """

    start_time: float
    warmup_period: float
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        start_time = self.start_time

        warmup_period = self.warmup_period

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "start_time": start_time,
                "warmup_period": warmup_period,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls: type[T], src_dict: Mapping[str, Any]) -> T:
        d = dict(src_dict)
        start_time = d.pop("start_time")

        warmup_period = d.pop("warmup_period")

        put_initialize_testid_body = cls(
            start_time=start_time,
            warmup_period=warmup_period,
        )

        put_initialize_testid_body.additional_properties = d
        return put_initialize_testid_body

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
