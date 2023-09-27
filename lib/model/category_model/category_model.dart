import 'dart:convert';

import 'package:collection/collection.dart';

class CategoryModel {
  final int? id;
  final String? name;
  final String? imageUrl;

  const CategoryModel({this.id, this.name, this.imageUrl});

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, imageUrl: $imageUrl)';
  }

  factory CategoryModel.fromMap(Map<String, dynamic> data) => CategoryModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        imageUrl: data['image_url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'image_url': imageUrl,
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
    String? name,
    String? imageUrl,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
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
  int get hashCode => id.hashCode ^ name.hashCode ^ imageUrl.hashCode;
}
