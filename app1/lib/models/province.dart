import 'dart:convert';

class Province {
  String? name;
  String? level;
  String? id;

  Province({
    required this.name,
    required this.level,
    required this.id,
  });

  Province copyWith({
    String? name,
    String? level,
    String? id,
  }) {
    return Province(
      name: name ?? this.name,
      level: level ?? this.level,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'level': level,
      'id': id,
    };
  }

  factory Province.fromMap(Map<String, dynamic> map) {
    String? name = map['name'];
    String? level = map['level'];
    String? id = map['id'];

    // Kiểm tra và gán giá trị mặc định nếu các trường bị thiếu
    if (name == null || level == null || id == null) {
      name = '';
      level = '';
      id = '';
    }

    // Kiểm tra và chuyển đổi kiểu dữ liệu nếu cần thiết
    if (!(name is String) || !(level is String) || !(id is String)) {
      name = name.toString();
      level = level.toString();
      id = id.toString();
    }

    return Province(
      name: name,
      level: level,
      id: id,
    );
  }

  String toJson() => json.encode(toMap());

  factory Province.fromJson(String source) =>
      Province.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Province(name: $name, level: $level, id: $id)';

  @override
  bool operator ==(covariant Province other) {
    if (identical(this, other)) return true;

    return other.name == name && other.level == level && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ level.hashCode ^ id.hashCode;
}