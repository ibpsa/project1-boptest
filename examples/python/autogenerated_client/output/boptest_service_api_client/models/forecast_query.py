from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field

from ..types import UNSET, Unset

T = TypeVar("T", bound="ForecastQuery")


@_attrs_define
class ForecastQuery:
    """
    Attributes:
        point_names (list[str] | Unset): List of point names.
        horizon (float | Unset): Forecast horizon in seconds.
        interval (float | Unset): Time interval between forecast points in seconds.
    """

    point_names: list[str] | Unset = UNSET
    horizon: float | Unset = UNSET
    interval: float | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        point_names: list[str] | Unset = UNSET
        if not isinstance(self.point_names, Unset):
            point_names = self.point_names

        horizon = self.horizon

        interval = self.interval

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if point_names is not UNSET:
            field_dict["point_names"] = point_names
        if horizon is not UNSET:
            field_dict["horizon"] = horizon
        if interval is not UNSET:
            field_dict["interval"] = interval

        return field_dict

    @classmethod
    def from_dict(cls: type[T], src_dict: Mapping[str, Any]) -> T:
        d = dict(src_dict)
        point_names = cast(list[str], d.pop("point_names", UNSET))

        horizon = d.pop("horizon", UNSET)

        interval = d.pop("interval", UNSET)

        forecast_query = cls(
            point_names=point_names,
            horizon=horizon,
            interval=interval,
        )

        forecast_query.additional_properties = d
        return forecast_query

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
