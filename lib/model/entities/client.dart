import 'dart:convert';
/// uuid : ""
/// nickname : ""
/// address : ""
/// reference : ""
/// contact : ""

Client clientFromJson(String str) => Client.fromJson(json.decode(str));
String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  String? _uuid;
  String? _nickname;
  String? _address;
  String? _reference;
  String? _contact;

  String? get uuid => _uuid;
  String? get nickname => _nickname;
  String? get address => _address;
  String? get reference => _reference;
  String? get contact => _contact;

  Client({
    String? uuid,
    String? nickname,
    String? address,
    String? reference,
    String? contact
  }){
    _uuid = uuid;
    _nickname = nickname;
    _address = address;
    _reference = reference;
    _contact = contact;
  }

  Client.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _nickname = json['nickname'];
    _address = json['address'];
    _reference = json['reference'];
    _contact = json['contact'];
  }

  Client copyWith({
    String? uuid,
    String? nickname,
    String? address,
    String? reference,
    String? contact,
  }) => Client(
    uuid: uuid ?? _uuid,
    nickname: nickname ?? _nickname,
    address: address ?? _address,
    reference: reference ?? _reference,
    contact: contact ?? _contact,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['nickname'] = _nickname;
    map['address'] = _address;
    map['reference'] = _reference;
    map['contact'] = _contact;
    return map;
  }

}