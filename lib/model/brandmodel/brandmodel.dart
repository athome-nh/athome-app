import 'dart:convert';

import 'package:collection/collection.dart';

class Brandmodel {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? nameKu;
  final String? simg;
  final String? limg;

  const Brandmodel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.nameKu,
    this.simg,
    this.limg,
  });

  @override
  String toString() {
    return 'Brandmodel(id: $id, nameEn: $nameEn, nameAr: $nameAr, nameKu: $nameKu, simg: $simg, limg: $limg)';
  }

  factory Brandmodel.fromMap(Map<String, dynamic> data) => Brandmodel(
        id: data['id'] as int?,
        nameEn: data['nameEN'] as String?,
        nameAr: data['nameAR'] as String?,
        nameKu: data['nameKU'] as String?,
        simg: data['simg'] as String?,
        limg: data['limg'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nameEN': nameEn,
        'nameAR': nameAr,
        'nameKU': nameKu,
        'simg': simg,
        'limg': limg,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Brandmodel].
  factory Brandmodel.fromJson(String data) {
    return Brandmodel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Brandmodel] to a JSON string.
  String toJson() => json.encode(toMap());

  Brandmodel copyWith({
    int? id,
    String? nameEn,
    String? nameAr,
    String? nameKu,
    String? simg,
    String? limg,
  }) {
    return Brandmodel(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      nameKu: nameKu ?? this.nameKu,
      simg: simg ?? this.simg,
      limg: limg ?? this.limg,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Brandmodel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nameEn.hashCode ^
      nameAr.hashCode ^
      nameKu.hashCode ^
      simg.hashCode ^
      limg.hashCode;
}
