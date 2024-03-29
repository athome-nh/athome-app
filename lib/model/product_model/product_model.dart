import 'dart:convert';

import 'package:collection/collection.dart';

class ProductModel {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? nameKu;
  final String? contentsEn;
  final String? contentsAr;
  final String? contentsKu;
  final String? descriptionEn;
  final String? descriptionAr;
  final String? descriptionKu;
  final String? coverImg;
  final int? brandId;
  final int? categoryId;
  final int? subCategoryId;
  final int? purchasePrice;
  final int? price;
  final int? price2;
  final int? offerPrice;
  final int? orderLimit;
  final int? stock;
  final String? barcode;
  final int? highlight;
  final int? bestSell;
  final String? endOffer;

  const ProductModel({
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
    this.coverImg,
    this.brandId,
    this.categoryId,
    this.subCategoryId,
    this.purchasePrice,
    this.price,
    this.price2,
    this.offerPrice,
    this.orderLimit,
    this.stock,
    this.barcode,
    this.highlight,
    this.bestSell,
    this.endOffer,
  });

  @override
  String toString() {
    return 'ProductModel(id: $id, nameEn: $nameEn, nameAr: $nameAr, nameKu: $nameKu, contentsEn: $contentsEn, contentsAr: $contentsAr, contentsKu: $contentsKu, descriptionEn: $descriptionEn, descriptionAr: $descriptionAr, descriptionKu: $descriptionKu, coverImg: $coverImg, brandId: $brandId, categoryId: $categoryId, subCategoryId: $subCategoryId, purchasePrice: $purchasePrice, price: $price, price2: $price2, offerPrice: $offerPrice, orderLimit: $orderLimit, stock: $stock, highlight: $highlight, bestSell: $bestSell, endOffer: $endOffer)';
  }

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
        coverImg: data['coverImg'] as String?,
        brandId: data['brand_id'] as int?,
        categoryId: data['categoryId'] as int?,
        subCategoryId: data['SubCategoryId'] as int?,
        purchasePrice: data['purchase_price'] as int?,
        price: data['price'] as int?,
        price2: data['price2'] as int?,
        offerPrice: data['offer_price'] as int?,
        orderLimit: data['order_limit'] as int?,
        stock: data['stock'] as int?,
        barcode: data['barcode'] as String?,
        highlight: data['highlight'] as int?,
        bestSell: data['bestSell'] as int?,
        endOffer: data['end_offer'] as String?,
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
        'coverImg': coverImg,
        'brand_id': brandId,
        'categoryId': categoryId,
        'SubCategoryId': subCategoryId,
        'purchase_price': purchasePrice,
        'price': price,
        'price2': price2,
        'offer_price': offerPrice,
        'order_limit': orderLimit,
        'stock': stock,
        'barcode': barcode,
        'highlight': highlight,
        'bestSell': bestSell,
        'end_offer': endOffer,
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
    String? coverImg,
    int? brandId,
    int? categoryId,
    int? subCategoryId,
    int? purchasePrice,
    int? price,
    int? price2,
    int? offerPrice,
    int? orderLimit,
    int? stock,
    String? barcode,
    int? highlight,
    int? bestSell,
    String? endOffer,
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
      coverImg: coverImg ?? this.coverImg,
      brandId: brandId ?? this.brandId,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      price: price ?? this.price,
      price2: price2 ?? this.price2,
      offerPrice: offerPrice ?? this.offerPrice,
      orderLimit: orderLimit ?? this.orderLimit,
      stock: stock ?? this.stock,
      barcode: barcode ?? this.barcode,
      highlight: highlight ?? this.highlight,
      bestSell: bestSell ?? this.bestSell,
      endOffer: endOffer ?? this.endOffer,
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
      coverImg.hashCode ^
      brandId.hashCode ^
      categoryId.hashCode ^
      subCategoryId.hashCode ^
      purchasePrice.hashCode ^
      price.hashCode ^
      price2.hashCode ^
      offerPrice.hashCode ^
      orderLimit.hashCode ^
      stock.hashCode ^
      barcode.hashCode ^
      highlight.hashCode ^
      bestSell.hashCode ^
      endOffer.hashCode;
}
