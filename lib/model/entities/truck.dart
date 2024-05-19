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
  Location? _location;
  String? _status;

  String? get id => _id;
  String? get operator => _operator;
  Location? get location => _location;
  String? get status => _status;

  Truck({
    String? id,
    String? operator,
    Location? location,
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
    _location = Location.fromJson(json['location']);
    _status = json['status'];
  }

  Truck copyWith({
    String? id,
    String? operator,
    Location? location,
    String? status,
  }) => Truck(
    id: id ?? _id,
    operator: operator ?? _operator,
    location: location ?? _location,
    status: status ?? _status,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['operator'] = _operator;
    map['location'] = locationToJson(_location!);
    map['status'] = _status;
    return map;
  }
}

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  num? _latitude;
  num? _longitude;

  num? get latitude => _latitude;
  num? get longitude => _longitude;

  Location({num? latitude, num? longitude}) {
    _latitude = latitude;
    _longitude = longitude;
  }

  Location.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  Location copyWith({num? latitude, num? longitude}) =>
      Location(
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}
