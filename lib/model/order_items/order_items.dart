import 'dart:convert';

import 'package:collection/collection.dart';

class OrderItems {
  final int? id;
  final int? productId;
  final int? orderId;
  final int? customerId;
  //final String? orderCode;
  final int? cost;
  final int? sellPrice;
  final int? offerPrice;
  final int? qt;
  final int? pickedQt;
  final int? returned;
  final int? returnedQt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OrderItems({
    this.id,
    this.productId,
    this.orderId,
    this.customerId,
    //this.orderCode,
    this.cost,
    this.sellPrice,
    this.offerPrice,
    this.qt,
    this.pickedQt,
    this.returned,
    this.returnedQt,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'OrderItems(id: $id, productId: $productId, orderId: $orderId, customerId: $customerId, orderCode: orderCode, cost: $cost, sellPrice: $sellPrice, offerPrice: $offerPrice, qt: $qt, pickedQt: $pickedQt, returned: $returned, returnedQt: $returnedQt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory OrderItems.fromMap(Map<String, dynamic> data) => OrderItems(
        id: data['id'] as int?,
        productId: data['productId'] as int?,
        orderId: data['order_id'] as int?,
        customerId: data['customerId'] as int?,
        // orderCode: data['order_code'] as String?,
        cost: data['cost'] as int?,
        sellPrice: data['sell_price'] as int?,
        offerPrice: data['offer_price'] as int?,
        qt: data['qt'] as int?,
        pickedQt: data['picked_qt'] as int?,
        returned: data['returned'] as int?,
        returnedQt: data['returned_qt'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'productId': productId,
        'order_id': orderId,
        'customerId': customerId,
        //'order_code': orderCode,
        'cost': cost,
        'sell_price': sellPrice,
        'offer_price': offerPrice,
        'qt': qt,
        'picked_qt': pickedQt,
        'returned': returned,
        'returned_qt': returnedQt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
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
    int? orderId,
    int? customerId,
    String? orderCode,
    int? cost,
    int? sellPrice,
    int? offerPrice,
    int? qt,
    int? pickedQt,
    int? returned,
    int? returnedQt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderItems(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      orderId: orderId ?? this.orderId,
      customerId: customerId ?? this.customerId,
      // orderCode: orderCode ?? this.orderCode,
      cost: cost ?? this.cost,
      sellPrice: sellPrice ?? this.sellPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      qt: qt ?? this.qt,
      pickedQt: pickedQt ?? this.pickedQt,
      returned: returned ?? this.returned,
      returnedQt: returnedQt ?? this.returnedQt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      orderId.hashCode ^
      customerId.hashCode ^
      //  orderCode.hashCode ^
      cost.hashCode ^
      sellPrice.hashCode ^
      offerPrice.hashCode ^
      qt.hashCode ^
      pickedQt.hashCode ^
      returned.hashCode ^
      returnedQt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
