import 'dart:convert';

import 'package:collection/collection.dart';


class SubCategory {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? nameKu;

  const SubCategory({this.id, this.nameEn, this.nameAr, this.nameKu});

  @override
  String toString() {
    return 'SubCategory(id: $id, nameEn: $nameEn, nameAr: $nameAr, nameKu: $nameKu)';
  }

  factory SubCategory.fromMap(Map<String, dynamic> data) => SubCategory(
        id: data['id'] as int?,
        nameEn: data['nameEN'] as String?,
        nameAr: data['nameAR'] as String?,
        nameKu: data['nameKU'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nameEN': nameEn,
        'nameAR': nameAr,
        'nameKU': nameKu,
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
    String? nameEn,
    String? nameAr,
    String? nameKu,
  }) {
    return SubCategory(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      nameKu: nameKu ?? this.nameKu,
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
  int get hashCode =>
      id.hashCode ^ nameEn.hashCode ^ nameAr.hashCode ^ nameKu.hashCode;
}
