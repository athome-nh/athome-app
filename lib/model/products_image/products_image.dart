import 'dart:convert';

import 'package:collection/collection.dart';

class ProductsImage {
  final String? img;
  final int? productId;

  const ProductsImage({this.img, this.productId});

  @override
  String toString() => 'ProductsImage(img: $img, productId: $productId)';

  factory ProductsImage.fromMap(Map<String, dynamic> data) => ProductsImage(
        img: data['Img'] as String?,
        productId: data['productId'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'Img': img,
        'productId': productId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductsImage].
  factory ProductsImage.fromJson(String data) {
    return ProductsImage.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductsImage] to a JSON string.
  String toJson() => json.encode(toMap());

  ProductsImage copyWith({
    String? img,
    int? productId,
  }) {
    return ProductsImage(
      img: img ?? this.img,
      productId: productId ?? this.productId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProductsImage) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => img.hashCode ^ productId.hashCode;
}
