import 'dart:convert';

import 'package:collection/collection.dart';


class SubCategory {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? nameKu;
  final int? categoryId;
  final bool? isShow;
  final String? img;

  const SubCategory({
    this.id,
    this.nameEn,
    this.nameAr,
    this.nameKu,
    this.categoryId,
    this.isShow,
    this.img,
  });

  @override
  String toString() {
    return 'SubCategory(id: $id, nameEn: $nameEn, nameAr: $nameAr, nameKu: $nameKu, categoryId: $categoryId, isShow: $isShow, img: $img)';
  }

  factory SubCategory.fromMap(Map<String, dynamic> data) => SubCategory(
        id: data['id'] as int?,
        nameEn: data['nameEN'] as String?,
        nameAr: data['nameAR'] as String?,
        nameKu: data['nameKU'] as String?,
        categoryId: data['categoryId'] as int?,
        isShow: data['isShow'] as bool?,
        img: data['img'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nameEN': nameEn,
        'nameAR': nameAr,
        'nameKU': nameKu,
        'categoryId': categoryId,
        'isShow': isShow,
        'img': img,
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
    int? categoryId,
    bool? isShow,
    String? img,
  }) {
    return SubCategory(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      nameKu: nameKu ?? this.nameKu,
      categoryId: categoryId ?? this.categoryId,
      isShow: isShow ?? this.isShow,
      img: img ?? this.img,
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
      id.hashCode ^
      nameEn.hashCode ^
      nameAr.hashCode ^
      nameKu.hashCode ^
      categoryId.hashCode ^
      isShow.hashCode ^
      img.hashCode;
}
