import 'dart:convert';

/// latitude : 0.0
/// longitude : 0.0

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
        longitude: longitude ?? _longitude,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }

}