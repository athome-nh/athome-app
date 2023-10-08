import 'dart:convert';

import 'package:collection/collection.dart';

class OrderModel {
  final int? id;
  final String? orderCode;
  final int? locationId;
  final int? totalPrice;
  final dynamic note;
  final int? status;
  final String? userAcceptTime;
  final DateTime? createdAt;

  const OrderModel({
    this.id,
    this.orderCode,
    this.locationId,
    this.totalPrice,
    this.note,
    this.status,
    this.userAcceptTime,
    this.createdAt,
  });

  @override
  String toString() {
    return 'OrderModel(id: $id, orderCode: $orderCode, locationId: $locationId, totalPrice: $totalPrice, note: $note, status: $status, userAcceptTime: $userAcceptTime, createdAt: $createdAt)';
  }

  factory OrderModel.fromMap(Map<String, dynamic> data) => OrderModel(
        id: data['id'] as int?,
        orderCode: data['order_code'] as String?,
        locationId: data['location_id'] as int?,
        totalPrice: data['total_price'] as int?,
        note: data['note'] as dynamic,
        status: data['status'] as int?,
        userAcceptTime: data['userAcceptTime'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_code': orderCode,
        'location_id': locationId,
        'total_price': totalPrice,
        'note': note,
        'status': status,
        'userAcceptTime': userAcceptTime,
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
    int? id,
    String? orderCode,
    int? locationId,
    int? totalPrice,
    dynamic note,
    int? status,
    String? userAcceptTime,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderCode: orderCode ?? this.orderCode,
      locationId: locationId ?? this.locationId,
      totalPrice: totalPrice ?? this.totalPrice,
      note: note ?? this.note,
      status: status ?? this.status,
      userAcceptTime: userAcceptTime ?? this.userAcceptTime,
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
      id.hashCode ^
      orderCode.hashCode ^
      locationId.hashCode ^
      totalPrice.hashCode ^
      note.hashCode ^
      status.hashCode ^
      userAcceptTime.hashCode ^
      createdAt.hashCode;
}
