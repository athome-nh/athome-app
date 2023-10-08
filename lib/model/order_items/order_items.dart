import 'dart:convert';

import 'package:collection/collection.dart';

class OrderItems {
  final int? id;
  final int? productId;
  final String? orderCode;
  final int? cost;
  final int? sellPrice;
  final int? offerPrice;
  final int? qt;

  const OrderItems({
    this.id,
    this.productId,
    this.orderCode,
    this.cost,
    this.sellPrice,
    this.offerPrice,
    this.qt,
  });

  @override
  String toString() {
    return 'OrderItems(id: $id, productId: $productId, orderCode: $orderCode, cost: $cost, sellPrice: $sellPrice, offerPrice: $offerPrice, qt: $qt)';
  }

  factory OrderItems.fromMap(Map<String, dynamic> data) => OrderItems(
        id: data['id'] as int?,
        productId: data['productId'] as int?,
        orderCode: data['order_code'] as String?,
        cost: data['cost'] as int?,
        sellPrice: data['sell_price'] as int?,
        offerPrice: data['offer_price'] as int?,
        qt: data['qt'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'productId': productId,
        'order_code': orderCode,
        'cost': cost,
        'sell_price': sellPrice,
        'offer_price': offerPrice,
        'qt': qt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderItems].
  factory OrderItems.fromJson(String data) {
    return OrderItems.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderItems] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderItems copyWith({
    int? id,
    int? productId,
    String? orderCode,
    int? cost,
    int? sellPrice,
    int? offerPrice,
    int? qt,
  }) {
    return OrderItems(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      orderCode: orderCode ?? this.orderCode,
      cost: cost ?? this.cost,
      sellPrice: sellPrice ?? this.sellPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      qt: qt ?? this.qt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderItems) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      productId.hashCode ^
      orderCode.hashCode ^
      cost.hashCode ^
      sellPrice.hashCode ^
      offerPrice.hashCode ^
      qt.hashCode;
}
