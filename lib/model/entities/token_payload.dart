import 'dart:convert';
/// email : ""
/// uuid : ""
/// role : ""

TokenPayload tokenPayloadFromJson(String str) => TokenPayload.fromJson(json.decode(str));
String tokenPayloadToJson(TokenPayload data) => json.encode(data.toJson());

class TokenPayload {
  String? _email;
  String? _uuid;
  String? _role;

  String? get email => _email;
  String? get uuid => _uuid;
  String? get role => _role;

  TokenPayload({
    String? email,
    String? uuid,
    String? role
  }) {
    _email = email;
    _uuid = uuid;
    _role = role;
  }

  TokenPayload.fromJson(dynamic json) {
    _email = json['email'];
    _uuid = json['uuid'];
    _role = json['role'];
  }

  TokenPayload copyWith({
    String? email,
    String? uuid,
    String? role,
  }) => TokenPayload(
    email: email ?? _email,
    uuid: uuid ?? _uuid,
    role: role ?? _role
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['uuid'] = _uuid;
    map['role'] = _role;
    return map;
  }

}