
import 'dart:convert';

import 'district.dart';
import 'province.dart';
import 'ward.dart';

class AddressInfo {
  Province? province;
  District? district;
  Ward? ward;
  String? street;
  AddressInfo({
    this.province,
    this.district,
    this.ward,
    this.street,
  });

  AddressInfo copyWith({
    Province? province,
    District? district,
    Ward? ward,
    String? street,
  }) {
    return AddressInfo(
      province: province ?? this.province,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      street: street ?? this.street,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'province': province?.toMap(),
      'district': district?.toMap(),
      'ward': ward?.toMap(),
      'street': street,
    };
  }

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    final addressInfo = AddressInfo(
      province: map['province'] != null
          ? Province.fromMap(map['province'] as Map<String, dynamic>)
          : null,
      district: map['district'] != null
          ? District.fromMap(map['district'] as Map<String, dynamic>)
          : null,
      ward: map['ward'] != null
          ? Ward.fromMap(map['ward'] as Map<String, dynamic>)
          : null,
      street: map['street'] != null ? map['street'] as String : null,
    );

    if (addressInfo.province == null) {
      addressInfo.province = Province(name: '', level: '', id: '');
    }

    if (addressInfo.district == null) {
      addressInfo.district =
          District(name: '', level: '', id: '', provinceId: '');
    }

    if (addressInfo.ward == null) {
      addressInfo.ward =
          Ward(name: '', level: '', id: '', districtId: '', provinceId: '');
    }

    return addressInfo;
  }

  String toJson() => json.encode(toMap());

  factory AddressInfo.fromJson(String source) =>
      AddressInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressInfo(province: $province, district: $district, ward: $ward, street: $street)';
  }

  @override
  bool operator ==(covariant AddressInfo other) {
    if (identical(this, other)) return true;

    return other.province == province &&
        other.district == district &&
        other.ward == ward &&
        other.street == street;
  }

  @override
  int get hashCode {
    return province.hashCode ^
        district.hashCode ^
        ward.hashCode ^
        street.hashCode;
  }
}