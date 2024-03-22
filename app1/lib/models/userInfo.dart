import 'dart:convert';

import 'addressInfo.dart';

class UserInfo {
  String? name;
  String? email;
  String? phoneNumber;
  DateTime? birthDate;
  AddressInfo? address;
  UserInfo({
    this.name,
    this.email,
    this.phoneNumber,
    this.birthDate,
    this.address,
  });
  UserInfo.withDefaults()
      : name = '',
        email = '',
        phoneNumber = '',
        birthDate = DateTime.now(),
        address = AddressInfo();

  UserInfo copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    DateTime? birthDate,
    AddressInfo? address,
  }) {
    return UserInfo(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate?.millisecondsSinceEpoch,
      'address': address?.toMap(),
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    var processedBirthDate = map['birthDate'];

    if (processedBirthDate is int) {
      processedBirthDate =
          DateTime.fromMillisecondsSinceEpoch(processedBirthDate).toUtc();
    } else if (processedBirthDate is String) {
      processedBirthDate = DateTime.tryParse(processedBirthDate)?.toUtc();
    }

    var processedPhoneNumber = map['phoneNumber'];

    if (processedPhoneNumber is int) {
      processedPhoneNumber = processedPhoneNumber.toString();
    }

    return UserInfo(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          processedPhoneNumber != null ? processedPhoneNumber as String : null,
      birthDate:
          processedBirthDate != null ? processedBirthDate as DateTime : null,
      address: map['address'] != null
          ? AddressInfo.fromMap(map['address'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInfo(name: $name, email: $email, phoneNumber: $phoneNumber, birthDate: $birthDate, address: $address)';
  }

  @override
  bool operator ==(covariant UserInfo other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.birthDate == birthDate &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        birthDate.hashCode ^
        address.hashCode;
  }
}