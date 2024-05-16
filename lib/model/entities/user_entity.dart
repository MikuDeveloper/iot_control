import 'dart:convert';
/// uuid : ""
/// email : ""
/// firstname : ""
/// lastname1 : ""
/// lastname2 : ""
/// role : ""

UserEntity userEntityFromJson(String str) => UserEntity.fromJson(json.decode(str));
String userEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity {
  String? _uuid;
  String? _email;
  String? _firstname;
  String? _lastname1;
  String? _lastname2;
  String? _role;

  String? get uuid => _uuid;
  String? get email => _email;
  String? get firstname => _firstname;
  String? get lastname1 => _lastname1;
  String? get lastname2 => _lastname2;
  String? get role => _role;

  UserEntity({
    String? uuid,
    String? email,
    String? firstname,
    String? lastname1,
    String? lastname2,
    String? role
  }) {
    _uuid = uuid;
    _email = email;
    _firstname = firstname;
    _lastname1 = lastname1;
    _lastname2 = lastname2;
    _role = role;
  }

  UserEntity.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _email = json['email'];
    _firstname = json['firstname'];
    _lastname1 = json['lastname1'];
    _lastname2 = json['lastname2'];
    _role = json['role'];
  }

  UserEntity copyWith({
    String? uuid,
    String? email,
    String? firstname,
    String? lastname1,
    String? lastname2,
    String? role,
  }) => UserEntity(
    uuid: uuid ?? _uuid,
    email: email ?? _email,
    firstname: firstname ?? _firstname,
    lastname1: lastname1 ?? _lastname1,
    lastname2: lastname2 ?? _lastname2,
    role: role ?? _role,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['email'] = _email;
    map['firstname'] = _firstname;
    map['lastname1'] = _lastname1;
    map['lastname2'] = _lastname2;
    map['role'] = _role;
    return map;
  }
}