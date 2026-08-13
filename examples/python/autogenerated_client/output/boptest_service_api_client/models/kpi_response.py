from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field

from ..types import UNSET, Unset

T = TypeVar("T", bound="KPIResponse")


@_attrs_define
class KPIResponse:
    """Standard KPIs.

    Attributes:
        ener_tot (float | Unset): HVAC energy total in kWh/m2.
        cost_tot (float | Unset): HVAC energy cost in $/m2 or Euro/m2.
        emis_tot (float | Unset): HVAC energy emissions in kgCO2e/m2.
        pele_tot (float | Unset): HVAC peak electrical demand in kW/m2.
        pgas_tot (float | Unset): HVAC peak gas demand in kW/m2.
        pdih_tot (float | Unset): HVAC peak district heating demand in kW/m2.
        tdis_tot (float | Unset): Thermal discomfort in Kh/zone.
        idis_tot (float | Unset): Indoor air quality discomfort in ppmh/zone.
        time_rat (float | Unset): Computational time ratio in s/s.
    """

    ener_tot: float | Unset = UNSET
    cost_tot: float | Unset = UNSET
    emis_tot: float | Unset = UNSET
    pele_tot: float | Unset = UNSET
    pgas_tot: float | Unset = UNSET
    pdih_tot: float | Unset = UNSET
    tdis_tot: float | Unset = UNSET
    idis_tot: float | Unset = UNSET
    time_rat: float | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        ener_tot = self.ener_tot

        cost_tot = self.cost_tot

        emis_tot = self.emis_tot

        pele_tot = self.pele_tot

        pgas_tot = self.pgas_tot

        pdih_tot = self.pdih_tot

        tdis_tot = self.tdis_tot

        idis_tot = self.idis_tot

        time_rat = self.time_rat

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if ener_tot is not UNSET:
            field_dict["ener_tot"] = ener_tot
        if cost_tot is not UNSET:
            field_dict["cost_tot"] = cost_tot
        if emis_tot is not UNSET:
            field_dict["emis_tot"] = emis_tot
        if pele_tot is not UNSET:
            field_dict["pele_tot"] = pele_tot
        if pgas_tot is not UNSET:
            field_dict["pgas_tot"] = pgas_tot
        if pdih_tot is not UNSET:
            field_dict["pdih_tot"] = pdih_tot
        if tdis_tot is not UNSET:
            field_dict["tdis_tot"] = tdis_tot
        if idis_tot is not UNSET:
            field_dict["idis_tot"] = idis_tot
        if time_rat is not UNSET:
            field_dict["time_rat"] = time_rat

        return field_dict

    @classmethod
    def from_dict(cls: type[T], src_dict: Mapping[str, Any]) -> T:
        d = dict(src_dict)
        ener_tot = d.pop("ener_tot", UNSET)

        cost_tot = d.pop("cost_tot", UNSET)

        emis_tot = d.pop("emis_tot", UNSET)

        pele_tot = d.pop("pele_tot", UNSET)

        pgas_tot = d.pop("pgas_tot", UNSET)

        pdih_tot = d.pop("pdih_tot", UNSET)

        tdis_tot = d.pop("tdis_tot", UNSET)

        idis_tot = d.pop("idis_tot", UNSET)

        time_rat = d.pop("time_rat", UNSET)

        kpi_response = cls(
            ener_tot=ener_tot,
            cost_tot=cost_tot,
            emis_tot=emis_tot,
            pele_tot=pele_tot,
            pgas_tot=pgas_tot,
            pdih_tot=pdih_tot,
            tdis_tot=tdis_tot,
            idis_tot=idis_tot,
            time_rat=time_rat,
        )

        kpi_response.additional_properties = d
        return kpi_response

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
