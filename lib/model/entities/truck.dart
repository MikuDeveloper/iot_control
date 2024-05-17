import 'dart:convert';
/// id : ""
/// operator : ""
/// location : ""
/// status : ""

Truck truckFromJson(String str) => Truck.fromJson(json.decode(str));
String truckToJson(Truck data) => json.encode(data.toJson());

class Truck {
  String? _id;
  String? _operator;
  String? _location;
  String? _status;

  String? get id => _id;
  String? get operator => _operator;
  String? get location => _location;
  String? get status => _status;

  Truck({
    String? id,
    String? operator,
    String? location,
    String? status})
  {
    _id = id;
    _operator = operator;
    _location = location;
    _status = status;
  }

  Truck.fromJson(dynamic json) {
    _id = json['id'];
    _operator = json['operator'];
    _location = json['location'];
    _status = json['status'];
  }
  Truck copyWith({  String? id,
    String? operator,
    String? location,
    String? status,
  }) => Truck(  id: id ?? _id,
    operator: operator ?? _operator,
    location: location ?? _location,
    status: status ?? _status,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['operator'] = _operator;
    map['location'] = _location;
    map['status'] = _status;
    return map;
  }
}