from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field

from ..models.post_advance_testid_body_additional_property_type_1 import PostAdvanceTestidBodyAdditionalPropertyType1

T = TypeVar("T", bound="PostAdvanceTestidBody")


@_attrs_define
class PostAdvanceTestidBody:
    """ """

    additional_properties: dict[str, float | PostAdvanceTestidBodyAdditionalPropertyType1] = _attrs_field(
        init=False, factory=dict
    )

    def to_dict(self) -> dict[str, Any]:
        field_dict: dict[str, Any] = {}
        for prop_name, prop in self.additional_properties.items():
            if isinstance(prop, PostAdvanceTestidBodyAdditionalPropertyType1):
                field_dict[prop_name] = prop.value
            else:
                field_dict[prop_name] = prop

        return field_dict

    @classmethod
    def from_dict(cls: type[T], src_dict: Mapping[str, Any]) -> T:
        d = dict(src_dict)
        post_advance_testid_body = cls()

        additional_properties = {}
        for prop_name, prop_dict in d.items():

            def _parse_additional_property(data: object) -> float | PostAdvanceTestidBodyAdditionalPropertyType1:
                try:
                    if not isinstance(data, int):
                        raise TypeError()
                    additional_property_type_1 = PostAdvanceTestidBodyAdditionalPropertyType1(data)

                    return additional_property_type_1
                except (TypeError, ValueError, AttributeError, KeyError):
                    pass
                return cast(float | PostAdvanceTestidBodyAdditionalPropertyType1, data)

            additional_property = _parse_additional_property(prop_dict)

            additional_properties[prop_name] = additional_property

        post_advance_testid_body.additional_properties = additional_properties
        return post_advance_testid_body

    @property
    def additional_keys(self) -> list[str]:
        return list(self.additional_properties.keys())

    def __getitem__(self, key: str) -> float | PostAdvanceTestidBodyAdditionalPropertyType1:
        return self.additional_properties[key]

    def __setitem__(self, key: str, value: float | PostAdvanceTestidBodyAdditionalPropertyType1) -> None:
        self.additional_properties[key] = value

    def __delitem__(self, key: str) -> None:
        del self.additional_properties[key]

    def __contains__(self, key: str) -> bool:
        return key in self.additional_properties
