import 'dart:convert';

import 'package:collection/collection.dart';

class CategoryModel {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? nameKu;
  final int? branchId;
  final bool? isShow;
  final String? img;

  const CategoryModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.nameKu,
    this.branchId,
    this.isShow,
    this.img,
  });

  @override
  String toString() {
    return 'CategoryModel(id: $id, nameEn: $nameEn, nameAr: $nameAr, nameKu: $nameKu, branchId: $branchId, isShow: $isShow, img: $img)';
  }

  factory CategoryModel.fromMap(Map<String, dynamic> data) => CategoryModel(
        id: data['id'] as int?,
        nameEn: data['nameEN'] as String?,
        nameAr: data['nameAR'] as String?,
        nameKu: data['nameKU'] as String?,
        branchId: data['branch_id'] as int?,
        isShow: data['isShow'] as bool?,
        img: data['img'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nameEN': nameEn,
        'nameAR': nameAr,
        'nameKU': nameKu,
        'branch_id': branchId,
        'isShow': isShow,
        'img': img,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CategoryModel].
  factory CategoryModel.fromJson(String data) {
    return CategoryModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CategoryModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CategoryModel copyWith({
    int? id,
    String? nameEn,
    String? nameAr,
    String? nameKu,
    int? branchId,
    bool? isShow,
    String? img,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      nameKu: nameKu ?? this.nameKu,
      branchId: branchId ?? this.branchId,
      isShow: isShow ?? this.isShow,
      img: img ?? this.img,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CategoryModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nameEn.hashCode ^
      nameAr.hashCode ^
      nameKu.hashCode ^
      branchId.hashCode ^
      isShow.hashCode ^
      img.hashCode;
}
