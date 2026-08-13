from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field

from ..types import UNSET, Unset

T = TypeVar("T", bound="BoundedSignalMeta")


@_attrs_define
class BoundedSignalMeta:
    """
    Attributes:
        description (str | Unset): Description of the signal.
        maximum (float | None | Unset): Maximum value of the signal.
        minimum (float | None | Unset): Minimum value of the signal.
        unit (None | str | Unset): Unit of the signal.
    """

    description: str | Unset = UNSET
    maximum: float | None | Unset = UNSET
    minimum: float | None | Unset = UNSET
    unit: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        description = self.description

        maximum: float | None | Unset
        if isinstance(self.maximum, Unset):
            maximum = UNSET
        else:
            maximum = self.maximum

        minimum: float | None | Unset
        if isinstance(self.minimum, Unset):
            minimum = UNSET
        else:
            minimum = self.minimum

        unit: None | str | Unset
        if isinstance(self.unit, Unset):
            unit = UNSET
        else:
            unit = self.unit

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if description is not UNSET:
            field_dict["Description"] = description
        if maximum is not UNSET:
            field_dict["Maximum"] = maximum
        if minimum is not UNSET:
            field_dict["Minimum"] = minimum
        if unit is not UNSET:
            field_dict["Unit"] = unit

        return field_dict

    @classmethod
    def from_dict(cls: type[T], src_dict: Mapping[str, Any]) -> T:
        d = dict(src_dict)
        description = d.pop("Description", UNSET)

        def _parse_maximum(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast(float | None | Unset, data)

        maximum = _parse_maximum(d.pop("Maximum", UNSET))

        def _parse_minimum(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast(float | None | Unset, data)

        minimum = _parse_minimum(d.pop("Minimum", UNSET))

        def _parse_unit(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast(None | str | Unset, data)

        unit = _parse_unit(d.pop("Unit", UNSET))

        bounded_signal_meta = cls(
            description=description,
            maximum=maximum,
            minimum=minimum,
            unit=unit,
        )

        bounded_signal_meta.additional_properties = d
        return bounded_signal_meta

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
