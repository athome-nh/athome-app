import 'dart:convert';

import 'package:collection/collection.dart';

class ProductModel {
  int? id;
  String? nameEn;
  String? nameAr;
  String? nameKu;
  String? contentsEn;
  String? contentsAr;
  String? contentsKu;
  String? descriptionEn;
  String? descriptionAr;
  String? descriptionKu;
  int? categoryId;
  int? subCategoryId;
  int? purchasePrice;
  int? price;
  int? price2;
  int? offerPrice;
  int? stock;
  int? orderLimit;
  bool? highlight;
  bool? bestSell;
  bool? available;
  String? coverImg;

  ProductModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.nameKu,
    this.contentsEn,
    this.contentsAr,
    this.contentsKu,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionKu,
    this.categoryId,
    this.subCategoryId,
    this.purchasePrice,
    this.price,
    this.price2,
    this.offerPrice,
    this.stock,
    this.orderLimit,
    this.highlight,
    this.bestSell,
    this.available,
    this.coverImg,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int?,
        nameEn: data['nameEN'] as String?,
        nameAr: data['nameAR'] as String?,
        nameKu: data['nameKU'] as String?,
        contentsEn: data['contentsEN'] as String?,
        contentsAr: data['contentsAR'] as String?,
        contentsKu: data['contentsKU'] as String?,
        descriptionEn: data['descriptionEN'] as String?,
        descriptionAr: data['descriptionAR'] as String?,
        descriptionKu: data['descriptionKU'] as String?,
        categoryId: data['categoryId'] as int?,
        subCategoryId: data['SubCategoryId'] as int?,
        purchasePrice: data['purchase_price'] as int?,
        price: data['price'] as int?,
        price2: data['price2'] as int?,
        offerPrice: data['offer_price'] as int?,
        stock: data['stock'] as int?,
        orderLimit: data['order_limit'] as int?,
        highlight: data['highlight'] as bool?,
        bestSell: data['bestSell'] as bool?,
        available: data['available'] as bool?,
        coverImg: data['coverImg'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nameEN': nameEn,
        'nameAR': nameAr,
        'nameKU': nameKu,
        'contentsEN': contentsEn,
        'contentsAR': contentsAr,
        'contentsKU': contentsKu,
        'descriptionEN': descriptionEn,
        'descriptionAR': descriptionAr,
        'descriptionKU': descriptionKu,
        'categoryId': categoryId,
        'SubCategoryId': subCategoryId,
        'purchase_price': purchasePrice,
        'price': price,
        'price2': price2,
        'offer_price': offerPrice,
        'stock': stock,
        'order_limit': orderLimit,
        'highlight': highlight,
        'bestSell': bestSell,
        'available': available,
        'coverImg': coverImg,
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
    String? nameEn,
    String? nameAr,
    String? nameKu,
    String? contentsEn,
    String? contentsAr,
    String? contentsKu,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionKu,
    int? categoryId,
    int? subCategoryId,
    int? purchasePrice,
    int? price,
    int? price2,
    int? offerPrice,
    int? stock,
    int? orderLimit,
    bool? highlight,
    bool? bestSell,
    bool? available,
    String? coverImg,
  }) {
    return ProductModel(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      nameKu: nameKu ?? this.nameKu,
      contentsEn: contentsEn ?? this.contentsEn,
      contentsAr: contentsAr ?? this.contentsAr,
      contentsKu: contentsKu ?? this.contentsKu,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionKu: descriptionKu ?? this.descriptionKu,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      price: price ?? this.price,
      price2: price2 ?? this.price2,
      offerPrice: offerPrice ?? this.offerPrice,
      stock: stock ?? this.stock,
      orderLimit: orderLimit ?? this.orderLimit,
      highlight: highlight ?? this.highlight,
      bestSell: bestSell ?? this.bestSell,
      available: available ?? this.available,
      coverImg: coverImg ?? this.coverImg,
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
      nameEn.hashCode ^
      nameAr.hashCode ^
      nameKu.hashCode ^
      contentsEn.hashCode ^
      contentsAr.hashCode ^
      contentsKu.hashCode ^
      descriptionEn.hashCode ^
      descriptionAr.hashCode ^
      descriptionKu.hashCode ^
      categoryId.hashCode ^
      subCategoryId.hashCode ^
      purchasePrice.hashCode ^
      price.hashCode ^
      price2.hashCode ^
      offerPrice.hashCode ^
      stock.hashCode ^
      orderLimit.hashCode ^
      highlight.hashCode ^
      bestSell.hashCode ^
      available.hashCode ^
      coverImg.hashCode;
}
