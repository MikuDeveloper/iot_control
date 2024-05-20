import 'dart:convert';

import 'location.dart';
/// truck : ""
/// location : {"latitude":0.0,"longitude":0.0}
/// materials : [{"name":"","precio":0.0},{"name":"","precio":0.0}]
/// employee : ""
/// client : ""
/// status : ""

Delivery deliveryFromJson(String str) => Delivery.fromJson(json.decode(str));
String deliveryToJson(Delivery data) => json.encode(data.toJson());

class Delivery {
  String? _uuid;
  String? _truck;
  Location? _location;
  List<Materials>? _materials;
  String? _employee;
  String? _client;
  String? _status;

  String? get uuid => _uuid;
  String? get truck => _truck;
  Location? get location => _location;
  List<Materials>? get materials => _materials;
  String? get employee => _employee;
  String? get client => _client;
  String? get status => _status;

  Delivery({
    String? uuid,
    String? truck,
    Location? location,
    List<Materials>? materials,
    String? employee,
    String? client,
    String? status
  }){
    _uuid = uuid;
    _truck = truck;
    _location = location;
    _materials = materials;
    _employee = employee;
    _client = client;
    _status = status;
  }

  Delivery.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _truck = json['truck'];
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    if (json['materials'] != null) {
      _materials = [];
      json['materials'].forEach((v) {
        _materials?.add(Materials.fromJson(v));
      });
    }
    _employee = json['employee'];
    _client = json['client'];
    _status = json['status'];
  }

  Delivery copyWith({
    String? uuid,
    String? truck,
    Location? location,
    List<Materials>? materials,
    String? employee,
    String? client,
    String? status,
  }) => Delivery(
    uuid: uuid ?? _uuid,
    truck: truck ?? _truck,
    location: location ?? _location,
    materials: materials ?? _materials,
    employee: employee ?? _employee,
    client: client ?? _client,
    status: status ?? _status,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['truck'] = _truck;
    if (_location != null) {
      //map['location'] = _location?.toJson();
      map['location'] = locationToJson(_location!);
    }
    if (_materials != null) {
      //map['materials'] = _materials?.map((v) => v.toJson()).toList();
      map['materials'] = jsonEncode(_materials);
    }
    map['employee'] = _employee;
    map['client'] = _client;
    map['status'] = _status;
    return map;
  }

}

/// name : ""
/// price : 0.0

Materials materialsFromJson(String str) => Materials.fromJson(json.decode(str));
String materialsToJson(Materials data) => json.encode(data.toJson());

class Materials {
  String? _name;
  num? _price;

  String? get name => _name;
  num? get price => _price;

  Materials({String? name, num? price}) {
    _name = name;
    _price = price;
  }

  Materials.fromJson(dynamic json) {
    _name = json['name'];
    _price = json['price'];
  }

  Materials copyWith({String? name, num? price}) =>
      Materials(
        name: name ?? _name,
        price: price ?? _price,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['price'] = _price;
    return map;
  }

}