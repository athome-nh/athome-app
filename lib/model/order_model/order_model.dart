import 'dart:convert';

import 'package:collection/collection.dart';

class OrderModel {
  final String? orderCode;
  final int? customerId;
  final int? productId;
  final int? sellPrice;
  final int? offerPrice;
  final int? qt;
  final String? location;
  final int? status;
  final DateTime? createdAt;

  const OrderModel({
    this.orderCode,
    this.customerId,
    this.productId,
    this.sellPrice,
    this.offerPrice,
    this.qt,
    this.location,
    this.status,
    this.createdAt,
  });

  @override
  String toString() {
    return 'OrderModel(orderCode: $orderCode, customerId: $customerId, productId: $productId, sellPrice: $sellPrice, offerPrice: $offerPrice, qt: $qt, location: $location, status: $status, createdAt: $createdAt)';
  }

  factory OrderModel.fromMap(Map<String, dynamic> data) => OrderModel(
        orderCode: data['order_code'] as String?,
        customerId: data['customerId'] as int?,
        productId: data['productId'] as int?,
        sellPrice: data['sell_price'] as int?,
        offerPrice: data['offer_price'] as int?,
        qt: data['qt'] as int?,
        location: data['location'] as String?,
        status: data['status'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'order_code': orderCode,
        'customerId': customerId,
        'productId': productId,
        'sell_price': sellPrice,
        'offer_price': offerPrice,
        'qt': qt,
        'location': location,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderModel].
  factory OrderModel.fromJson(String data) {
    return OrderModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderModel] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderModel copyWith({
    String? orderCode,
    int? customerId,
    int? productId,
    int? sellPrice,
    int? offerPrice,
    int? qt,
    String? location,
    int? status,
    DateTime? createdAt,
  }) {
    return OrderModel(
      orderCode: orderCode ?? this.orderCode,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      sellPrice: sellPrice ?? this.sellPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      qt: qt ?? this.qt,
      location: location ?? this.location,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      orderCode.hashCode ^
      customerId.hashCode ^
      productId.hashCode ^
      sellPrice.hashCode ^
      offerPrice.hashCode ^
      qt.hashCode ^
      location.hashCode ^
      status.hashCode ^
      createdAt.hashCode;
}
