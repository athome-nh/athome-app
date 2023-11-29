import 'dart:convert';

import 'package:collection/collection.dart';

class Slidemodel {
  final int? brandId;
  final String? img;

  const Slidemodel({this.brandId, this.img});

  @override
  String toString() => 'Slidemodel(brandId: $brandId, img: $img)';

  factory Slidemodel.fromMap(Map<String, dynamic> data) => Slidemodel(
        brandId: data['brand_id'] as int?,
        img: data['img'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'brand_id': brandId,
        'img': img,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Slidemodel].
  factory Slidemodel.fromJson(String data) {
    return Slidemodel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Slidemodel] to a JSON string.
  String toJson() => json.encode(toMap());

  Slidemodel copyWith({
    int? brandId,
    String? img,
  }) {
    return Slidemodel(
      brandId: brandId ?? this.brandId,
      img: img ?? this.img,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Slidemodel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => brandId.hashCode ^ img.hashCode;
}
