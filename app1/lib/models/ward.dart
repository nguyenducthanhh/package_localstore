import 'dart:convert';

class Ward {
  String? name;
  String? level;
  String? id;
  String? districtId;
  String? provinceId;

  Ward({
    required this.name,
    required this.level,
    required this.id,
    required this.districtId,
    required this.provinceId,
  });

  Ward copyWith({
    String? name,
    String? level,
    String? id,
    String? districtId,
    String? provinceId,
  }) {
    return Ward(
      name: name ?? this.name,
      level: level ?? this.level,
      id: id ?? this.id,
      districtId: districtId ?? this.districtId,
      provinceId: provinceId ?? this.provinceId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'level': level,
      'id': id,
      'districtId': districtId,
      'provinceId': provinceId,
    };
  }

  factory Ward.fromMap(Map<String, dynamic> map) {
    String? name = map['name'];
    String? level = map['level'];
    String? id = map['id'];
    String? districtId = map['districtId'];
    String? provinceId = map['provinceId'];

    if (name == null ||
        level == null ||
        id == null ||
        districtId == null ||
        provinceId == null) {
      name = '';
      level = '';
      id = '';
      districtId = '';
      provinceId = '';
    }

    if (!(name is String) ||
        !(level is String) ||
        !(id is String) ||
        !(districtId is String) ||
        !(provinceId is String)) {
      name = name.toString();
      level = level.toString();
      id = id.toString();
      districtId = districtId.toString();
      provinceId = provinceId.toString();
    }

    return Ward(
      name: name,
      level: level,
      id: id,
      districtId: districtId,
      provinceId: provinceId,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ward.fromJson(String source) =>
      Ward.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ward(name: $name, level: $level, id: $id, districtId: $districtId, provinceId: $provinceId)';
  }

  @override
  bool operator ==(covariant Ward other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.level == level &&
        other.id == id &&
        other.districtId == districtId &&
        other.provinceId == provinceId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        level.hashCode ^
        id.hashCode ^
        districtId.hashCode ^
        provinceId.hashCode;
  }
}