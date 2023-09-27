import 'dart:convert';

import 'package:collection/collection.dart';

class ProductModel {
  final int? id;
  final String? name;
  final int? price;
  final bool? bestsell;
  final bool? highlight;
  final bool? discount;
  final String? content;
  final String? description;
  final int? quantity;
  final int? category;
  final String? imageUrl;

  const ProductModel({
    this.id,
    this.name,
    this.price,
    this.bestsell,
    this.highlight,
    this.discount,
    this.content,
    this.description,
    this.quantity,
    this.category,
    this.imageUrl,
  });

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price, bestsell: $bestsell, highlight: $highlight, discount: $discount, content: $content, description: $description, quantity: $quantity, category: $category, imageUrl: $imageUrl)';
  }

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        price: data['price'] as int?,
        bestsell: data['bestsell'] as bool?,
        highlight: data['highlight'] as bool?,
        discount: data['discount'] as bool?,
        content: data['content'] as String?,
        description: data['description'] as String?,
        quantity: data['quantity'] as int?,
        category: data['category'] as int?,
        imageUrl: data['image_url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'bestsell': bestsell,
        'highlight': highlight,
        'discount': discount,
        'content': content,
        'description': description,
        'quantity': quantity,
        'category': category,
        'image_url': imageUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductModel].
  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ProductModel copyWith({
    int? id,
    String? name,
    int? price,
    bool? bestsell,
    bool? highlight,
    bool? discount,
    String? content,
    String? description,
    int? quantity,
    int? category,
    String? imageUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      bestsell: bestsell ?? this.bestsell,
      highlight: highlight ?? this.highlight,
      discount: discount ?? this.discount,
      content: content ?? this.content,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProductModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      bestsell.hashCode ^
      highlight.hashCode ^
      discount.hashCode ^
      content.hashCode ^
      description.hashCode ^
      quantity.hashCode ^
      category.hashCode ^
      imageUrl.hashCode;
}
