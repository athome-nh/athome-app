import 'dart:convert';

import 'package:collection/collection.dart';

class SubCategory {
  final int? id;
  final int? idcate;
  final String? name;

  const SubCategory({this.id, this.idcate, this.name});

  @override
  String toString() => 'SubCategory(id: $id, idcate: $idcate, name: $name)';

  factory SubCategory.fromMap(Map<String, dynamic> data) => SubCategory(
        id: data['id'] as int?,
        idcate: data['idcate'] as int?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'idcate': idcate,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SubCategory].
  factory SubCategory.fromJson(String data) {
    return SubCategory.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SubCategory] to a JSON string.
  String toJson() => json.encode(toMap());

  SubCategory copyWith({
    int? id,
    int? idcate,
    String? name,
  }) {
    return SubCategory(
      id: id ?? this.id,
      idcate: idcate ?? this.idcate,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SubCategory) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ idcate.hashCode ^ name.hashCode;
}
