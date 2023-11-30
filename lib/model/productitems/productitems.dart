import 'dart:convert';

import 'package:collection/collection.dart';

class Productitems {
  final int? id;
  final String? nameEn;
  final String? nameAR;
  final String? nameKU;
  final String? contentsEn;
  final String? contentsAR;
  final String? contentsKU;
  final String? coverImg;

  const Productitems({
    this.id,
    this.nameEn,
    this.nameAR,
    this.nameKU,
    this.contentsEn,
    this.contentsAR,
    this.contentsKU,
    this.coverImg,
  });

  @override
  String toString() {
    return 'Productitems(id: $id, nameEn: $nameEn, contentsEn: $contentsEn, coverImg: $coverImg)';
  }

  factory Productitems.fromMap(Map<String, dynamic> data) => Productitems(
        id: data['id'] as int?,
        nameEn: data['nameEN'] as String?,
        nameAR: data['nameAR'] as String?,
        nameKU: data['nameKU'] as String?,
        contentsEn: data['contentsEN'] as String?,
        contentsAR: data['contentsAR'] as String?,
        contentsKU: data['contentsKU'] as String?,
        coverImg: data['coverImg'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nameEN': nameEn,
        'nameAR': nameAR,
        'nameKU': nameKU,
        'contentsEN': contentsEn,
        'contentsAR': contentsAR,
        'contentsKU': contentsKU,
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
