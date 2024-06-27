import 'dart:convert';

import 'package:collection/collection.dart';


class PointModel {
  final int? id;
  final int? porint;
  final int? price;
  final String? createdAt;
  final String? updatedAt;

  const PointModel({
    this.id,
    this.porint,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'PointModel(id: $id, porint: $porint, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory PointModel.fromMap(Map<String, dynamic> data) => PointModel(
        id: data['id'] as int?,
        porint: data['porint'] as int?,
        price: data['price'] as int?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'porint': porint,
        'price': price,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PointModel].
  factory PointModel.fromJson(String data) {
    return PointModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PointModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PointModel copyWith({
    int? id,
    int? porint,
    int? price,
    String? createdAt,
    String? updatedAt,
  }) {
    return PointModel(
      id: id ?? this.id,
      porint: porint ?? this.porint,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PointModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      porint.hashCode ^
      price.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
