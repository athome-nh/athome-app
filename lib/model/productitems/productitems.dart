import 'dart:convert';

import 'package:collection/collection.dart';

class Productitems {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? nameKu;
  final String? contentsEn;

  final String? contentsAr;
  final String? contentsKu;
  final String? coverImg;

  const Productitems({
    this.id,
    this.nameEn,
    this.nameAr,
    this.nameKu,
    this.contentsEn,
    this.contentsAr,
    this.contentsKu,
    this.coverImg,
  });

  @override
  String toString() {
    return 'Productitems(id: $id, nameEn: $nameEn, contentsEn: $contentsEn, coverImg: $coverImg)';
  }

  factory Productitems.fromMap(Map<String, dynamic> data) => Productitems(
        id: data['id'] as int?,
        nameEn: data['nameEN'] as String?,
        nameAr: data['nameAr'] as String?,
        nameKu: data['nameKu'] as String?,
        contentsEn: data['contentsEN'] as String?,
        contentsAr: data['contentsAr'] as String?,
        contentsKu: data['contentsKu'] as String?,
        coverImg: data['coverImg'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nameEN': nameEn,
        'nameAr': nameAr,
        'nameKu': nameKu,
        'contentsEN': contentsEn,
        'contentsAr': contentsAr,
        'contentsKu': contentsKu,
        'coverImg': coverImg,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Productitems].
  factory Productitems.fromJson(String data) {
    return Productitems.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Productitems] to a JSON string.
  String toJson() => json.encode(toMap());

  Productitems copyWith({
    int? id,
    String? nameEn,
    String? contentsEn,
    String? coverImg,
  }) {
    return Productitems(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      contentsEn: contentsEn ?? this.contentsEn,
      coverImg: coverImg ?? this.coverImg,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Productitems) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^ nameEn.hashCode ^ contentsEn.hashCode ^ coverImg.hashCode;
}
