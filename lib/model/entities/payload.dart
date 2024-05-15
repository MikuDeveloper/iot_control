import 'dart:convert';
/// uuid : ""
/// email : ""
/// role : ""

Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));
String payloadToJson(Payload data) => json.encode(data.toJson());

class Payload {
  String? _uuid;
  String? _email;
  String? _role;

  String? get uuid => _uuid;
  String? get email => _email;
  String? get role => _role;

  Payload({
    String? uuid,
    String? email,
    String? role
  }){
    _uuid = uuid;
    _email = email;
    _role = role;
  }

  Payload.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _email = json['email'];
    _role = json['role'];
  }

  Payload copyWith({
    String? uuid,
    String? email,
    String? role,
  }) => Payload(
    uuid: uuid ?? _uuid,
    email: email ?? _email,
    role: role ?? _role,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['email'] = _email;
    map['role'] = _role;
    return map;
  }
}