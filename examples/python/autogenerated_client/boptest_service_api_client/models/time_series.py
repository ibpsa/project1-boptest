from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field

T = TypeVar("T", bound="TimeSeries")


@_attrs_define
class TimeSeries:
    """Time series response. Always includes a "time" array and any number of series arrays keyed by signal name.

    Attributes:
        time (list[float]): Array of time points (seconds since Jan 1st, 00:00:00).
    """

    time: list[float]
    additional_properties: dict[str, list[float]] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        time = self.time

        field_dict: dict[str, Any] = {}
        for prop_name, prop in self.additional_properties.items():
            field_dict[prop_name] = prop

        field_dict.update(
            {
                "time": time,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls: type[T], src_dict: Mapping[str, Any]) -> T:
        d = dict(src_dict)
        time = cast(list[float], d.pop("time"))

        time_series = cls(
            time=time,
        )

        additional_properties = {}
        for prop_name, prop_dict in d.items():
            additional_property = cast(list[float], prop_dict)

            additional_properties[prop_name] = additional_property

        time_series.additional_properties = additional_properties
        return time_series

    @property
    def additional_keys(self) -> list[str]:
        return list(self.additional_properties.keys())

    def __getitem__(self, key: str) -> list[float]:
        return self.additional_properties[key]

    def __setitem__(self, key: str, value: list[float]) -> None:
        self.additional_properties[key] = value

    def __delitem__(self, key: str) -> None:
        del self.additional_properties[key]

    def __contains__(self, key: str) -> bool:
        return key in self.additional_properties
