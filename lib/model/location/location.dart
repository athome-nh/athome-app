import 'dart:convert';

import 'package:collection/collection.dart';

class Locationuser {
  final int? id;
  final int? customerId;
  final double? longitude;
  final double? latitude;
  final String? name;
  final String? type;
  final String? area;
  final dynamic floor;
  final String? number;
  final dynamic buildingName;
  final int? inRange;
  final dynamic phone;

  const Locationuser({
    this.id,
    this.customerId,
    this.longitude,
    this.latitude,
    this.name,
    this.type,
    this.area,
    this.floor,
    this.number,
    this.buildingName,
    this.inRange,
    this.phone,
  });

  @override
  String toString() {
    return 'Location(id: $id, customerId: $customerId, longitude: $longitude, latitude: $latitude, name: $name, type: $type, area: $area, floor: $floor, number: $number, buildingName: $buildingName, inRange: $inRange, phone: $phone)';
  }

  factory Locationuser.fromMap(Map<String, dynamic> data) => Locationuser(
        id: data['id'] as int?,
        customerId: data['customerId'] as int?,
        longitude: (data['longitude'] as num?)?.toDouble(),
        latitude: (data['latitude'] as num?)?.toDouble(),
        name: data['name'] as String?,
        type: data['type'] as String?,
        area: data['area'] as String?,
        floor: data['floor'] as dynamic,
        number: data['number'] as String?,
        buildingName: data['building_name'] as dynamic,
        inRange: data['in_range'] as int?,
        phone: data['phone'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'customerId': customerId,
        'longitude': longitude,
        'latitude': latitude,
        'name': name,
        'type': type,
        'area': area,
        'floor': floor,
        'number': number,
        'building_name': buildingName,
        'in_range': inRange,
        'phone': phone,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Location].
  factory Locationuser.fromJson(String data) {
    return Locationuser.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Location] to a JSON string.
  String toJson() => json.encode(toMap());

  Locationuser copyWith({
    int? id,
    int? customerId,
    double? longitude,
    double? latitude,
    String? name,
    String? type,
    String? area,
    dynamic floor,
    String? number,
    dynamic buildingName,
    int? inRange,
    dynamic phone,
  }) {
    return Locationuser(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      name: name ?? this.name,
      type: type ?? this.type,
      area: area ?? this.area,
      floor: floor ?? this.floor,
      number: number ?? this.number,
      buildingName: buildingName ?? this.buildingName,
      inRange: inRange ?? this.inRange,
      phone: phone ?? this.phone,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Locationuser) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      customerId.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      name.hashCode ^
      type.hashCode ^
      area.hashCode ^
      floor.hashCode ^
      number.hashCode ^
      buildingName.hashCode ^
      inRange.hashCode ^
      phone.hashCode;
}
