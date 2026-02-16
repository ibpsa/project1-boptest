from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field

from ..types import UNSET, Unset

T = TypeVar("T", bound="ResultsQuery")


@_attrs_define
class ResultsQuery:
    """
    Attributes:
        point_names (list[str] | Unset): List of point names.
        start_time (float | Unset): Start time of the results query (seconds since Jan 1st, 00:00:00).
        final_time (float | Unset): Final time of the results query (seconds since Jan 1st, 00:00:00).
    """

    point_names: list[str] | Unset = UNSET
    start_time: float | Unset = UNSET
    final_time: float | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        point_names: list[str] | Unset = UNSET
        if not isinstance(self.point_names, Unset):
            point_names = self.point_names

        start_time = self.start_time

        final_time = self.final_time

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if point_names is not UNSET:
            field_dict["point_names"] = point_names
        if start_time is not UNSET:
            field_dict["start_time"] = start_time
        if final_time is not UNSET:
            field_dict["final_time"] = final_time

        return field_dict

    @classmethod
    def from_dict(cls: type[T], src_dict: Mapping[str, Any]) -> T:
        d = dict(src_dict)
        point_names = cast(list[str], d.pop("point_names", UNSET))

        start_time = d.pop("start_time", UNSET)

        final_time = d.pop("final_time", UNSET)

        results_query = cls(
            point_names=point_names,
            start_time=start_time,
            final_time=final_time,
        )

        results_query.additional_properties = d
        return results_query

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
