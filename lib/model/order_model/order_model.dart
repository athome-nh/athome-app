import 'dart:convert';

import 'package:collection/collection.dart';

class OrderModel {
  final int? id;
  //final String? orderCode;
  final int? customerId;
  final int? locationId;
  final int? pickerId;
  final int? supervisorId;
  final dynamic supervisorPriceId;
  final int? driverId;
  final dynamic adminPriceId;
  final dynamic adminId;
  final int? totalPrice;
  final int? returnTotalPrice;
  final int? isCorrect;
  final dynamic returnNote;
  final dynamic note;
  int? status;
  final DateTime? createdAt;

  OrderModel({
    this.id,
    //this.orderCode,
    this.customerId,
    this.locationId,
    this.pickerId,
    this.supervisorId,
    this.supervisorPriceId,
    this.driverId,
    this.adminPriceId,
    this.adminId,
    this.totalPrice,
    this.returnTotalPrice,
    this.isCorrect,
    this.returnNote,
    this.note,
    this.status,
    this.createdAt,
  });

  @override
  String toString() {
    return 'OrderModel(id: $id, orderCode: orderCode, customerId: $customerId, locationId: $locationId, pickerId: $pickerId, supervisorId: $supervisorId, supervisorPriceId: $supervisorPriceId, driverId: $driverId, adminPriceId: $adminPriceId, adminId: $adminId, totalPrice: $totalPrice, returnTotalPrice: $returnTotalPrice, isCorrect: $isCorrect, returnNote: $returnNote, note: $note, status: $status)';
  }

  factory OrderModel.fromMap(Map<String, dynamic> data) => OrderModel(
        id: data['id'] as int?,
        //orderCode: data['order_code'] as String?,
        customerId: data['customerId'] as int?,
        locationId: data['location_id'] as int?,
        pickerId: data['picker_id'] as int?,
        supervisorId: data['supervisor_id'] as int?,
        supervisorPriceId: data['supervisor_price_id'] as dynamic,
        driverId: data['driver_id'] as int?,
        adminPriceId: data['admin_price_id'] as dynamic,
        adminId: data['admin_id'] as dynamic,
        totalPrice: data['total_price'] as int?,
        returnTotalPrice: data['return_total_price'] as int?,
        isCorrect: data['isCorrect'] as int?,
        returnNote: data['return_note'] as dynamic,
        note: data['note'] as dynamic,
        status: data['status'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        //   'order_code': orderCode,
        'customerId': customerId,
        'location_id': locationId,
        'picker_id': pickerId,
        'supervisor_id': supervisorId,
        'supervisor_price_id': supervisorPriceId,
        'driver_id': driverId,
        'admin_price_id': adminPriceId,
        'admin_id': adminId,
        'total_price': totalPrice,
        'return_total_price': returnTotalPrice,
        'isCorrect': isCorrect,
        'return_note': returnNote,
        'note': note,
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
    int? id,
    String? orderCode,
    int? customerId,
    int? locationId,
    int? pickerId,
    int? supervisorId,
    dynamic supervisorPriceId,
    int? driverId,
    dynamic adminPriceId,
    dynamic adminId,
    int? totalPrice,
    int? returnTotalPrice,
    int? isCorrect,
    dynamic returnNote,
    dynamic note,
    int? status,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      //orderCode: orderCode ?? this.orderCode,
      customerId: customerId ?? this.customerId,
      locationId: locationId ?? this.locationId,
      pickerId: pickerId ?? this.pickerId,
      supervisorId: supervisorId ?? this.supervisorId,
      supervisorPriceId: supervisorPriceId ?? this.supervisorPriceId,
      driverId: driverId ?? this.driverId,
      adminPriceId: adminPriceId ?? this.adminPriceId,
      adminId: adminId ?? this.adminId,
      totalPrice: totalPrice ?? this.totalPrice,
      returnTotalPrice: returnTotalPrice ?? this.returnTotalPrice,
      isCorrect: isCorrect ?? this.isCorrect,
      returnNote: returnNote ?? this.returnNote,
      note: note ?? this.note,
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
      id.hashCode ^
      //  orderCode.hashCode ^
      customerId.hashCode ^
      locationId.hashCode ^
      pickerId.hashCode ^
      supervisorId.hashCode ^
      supervisorPriceId.hashCode ^
      driverId.hashCode ^
      adminPriceId.hashCode ^
      adminId.hashCode ^
      totalPrice.hashCode ^
      returnTotalPrice.hashCode ^
      isCorrect.hashCode ^
      returnNote.hashCode ^
      note.hashCode ^
      status.hashCode ^
      createdAt.hashCode;
}
