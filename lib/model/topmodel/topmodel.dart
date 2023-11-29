import 'dart:convert';

import 'package:collection/collection.dart';

class Topmodel {
  final int? brandId;
  final String? imgEn;
  final String? imgAr;
  final String? imgKur;

  const Topmodel({this.brandId, this.imgEn, this.imgAr, this.imgKur});

  @override
  String toString() {
    return 'Topmodel(brandId: $brandId, imgEn: $imgEn, imgAr: $imgAr, imgKur: $imgKur)';
  }

  factory Topmodel.fromMap(Map<String, dynamic> data) => Topmodel(
        brandId: data['brand_id'] as int?,
        imgEn: data['imgEN'] as String?,
        imgAr: data['imgAR'] as String?,
        imgKur: data['imgKUR'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'brand_id': brandId,
        'imgEN': imgEn,
        'imgAR': imgAr,
        'imgKUR': imgKur,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Topmodel].
  factory Topmodel.fromJson(String data) {
    return Topmodel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Topmodel] to a JSON string.
  String toJson() => json.encode(toMap());

  Topmodel copyWith({
    int? brandId,
    String? imgEn,
    String? imgAr,
    String? imgKur,
  }) {
    return Topmodel(
      brandId: brandId ?? this.brandId,
      imgEn: imgEn ?? this.imgEn,
      imgAr: imgAr ?? this.imgAr,
      imgKur: imgKur ?? this.imgKur,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Topmodel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      brandId.hashCode ^ imgEn.hashCode ^ imgAr.hashCode ^ imgKur.hashCode;
}
