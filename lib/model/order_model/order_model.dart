import 'dart:convert';

import 'package:collection/collection.dart';

class OrderModel {
  final int? id;
  final String? orderCode;
  final int? customerId;
  final int? locationId;
  final dynamic pickerId;
  final dynamic supervisorId;
  final dynamic supervisorPriceId;
  final dynamic driverId;
  final dynamic adminPriceId;
  final dynamic adminId;
  final int? totalPrice;
  final int? returnTotalPrice;
  final int? isCorrect;
  final dynamic returnNote;
  final dynamic note;
  int? status;
  final String? userAcceptTime;
  final dynamic pickerAcceptTime;
  final dynamic pickerDoneTime;
  final dynamic supervisorAcceptTime;
  final dynamic adminCancelTime;
  final dynamic userCancelTime;
  final dynamic deliveredTime;
  final dynamic supervisorGetMounyDataTime;
  final dynamic adminGetMounyDataTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderModel({
    this.id,
    this.orderCode,
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
    this.userAcceptTime,
    this.pickerAcceptTime,
    this.pickerDoneTime,
    this.supervisorAcceptTime,
    this.adminCancelTime,
    this.userCancelTime,
    this.deliveredTime,
    this.supervisorGetMounyDataTime,
    this.adminGetMounyDataTime,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'OrderModel(id: $id, orderCode: $orderCode, customerId: $customerId, locationId: $locationId, pickerId: $pickerId, supervisorId: $supervisorId, supervisorPriceId: $supervisorPriceId, driverId: $driverId, adminPriceId: $adminPriceId, adminId: $adminId, totalPrice: $totalPrice, returnTotalPrice: $returnTotalPrice, isCorrect: $isCorrect, returnNote: $returnNote, note: $note, status: $status, userAcceptTime: $userAcceptTime, pickerAcceptTime: $pickerAcceptTime, pickerDoneTime: $pickerDoneTime, supervisorAcceptTime: $supervisorAcceptTime, adminCancelTime: $adminCancelTime, userCancelTime: $userCancelTime, deliveredTime: $deliveredTime, supervisorGetMounyDataTime: $supervisorGetMounyDataTime, adminGetMounyDataTime: $adminGetMounyDataTime, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory OrderModel.fromMap(Map<String, dynamic> data) => OrderModel(
        id: data['id'] as int?,
        orderCode: data['order_code'] as String?,
        customerId: data['customerId'] as int?,
        locationId: data['location_id'] as int?,
        pickerId: data['picker_id'] as dynamic,
        supervisorId: data['supervisor_id'] as dynamic,
        supervisorPriceId: data['supervisor_price_id'] as dynamic,
        driverId: data['driver_id'] as dynamic,
        adminPriceId: data['admin_price_id'] as dynamic,
        adminId: data['admin_id'] as dynamic,
        totalPrice: data['total_price'] as int?,
        returnTotalPrice: data['return_total_price'] as int?,
        isCorrect: data['isCorrect'] as int?,
        returnNote: data['return_note'] as dynamic,
        note: data['note'] as dynamic,
        status: data['status'] as int?,
        userAcceptTime: data['userAcceptTime'] as String?,
        pickerAcceptTime: data['pickerAcceptTime'] as dynamic,
        pickerDoneTime: data['pickerDoneTime'] as dynamic,
        supervisorAcceptTime: data['supervisorAcceptTime'] as dynamic,
        adminCancelTime: data['AdminCancelTime'] as dynamic,
        userCancelTime: data['UserCancelTime'] as dynamic,
        deliveredTime: data['deliveredTime'] as dynamic,
        supervisorGetMounyDataTime:
            data['supervisorGetMounyDataTime'] as dynamic,
        adminGetMounyDataTime: data['adminGetMounyDataTime'] as dynamic,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_code': orderCode,
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
        'userAcceptTime': userAcceptTime,
        'pickerAcceptTime': pickerAcceptTime,
        'pickerDoneTime': pickerDoneTime,
        'supervisorAcceptTime': supervisorAcceptTime,
        'AdminCancelTime': adminCancelTime,
        'UserCancelTime': userCancelTime,
        'deliveredTime': deliveredTime,
        'supervisorGetMounyDataTime': supervisorGetMounyDataTime,
        'adminGetMounyDataTime': adminGetMounyDataTime,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
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
    dynamic pickerId,
    dynamic supervisorId,
    dynamic supervisorPriceId,
    dynamic driverId,
    dynamic adminPriceId,
    dynamic adminId,
    int? totalPrice,
    int? returnTotalPrice,
    int? isCorrect,
    dynamic returnNote,
    dynamic note,
    int? status,
    String? userAcceptTime,
    dynamic pickerAcceptTime,
    dynamic pickerDoneTime,
    dynamic supervisorAcceptTime,
    dynamic adminCancelTime,
    dynamic userCancelTime,
    dynamic deliveredTime,
    dynamic supervisorGetMounyDataTime,
    dynamic adminGetMounyDataTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderCode: orderCode ?? this.orderCode,
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
      userAcceptTime: userAcceptTime ?? this.userAcceptTime,
      pickerAcceptTime: pickerAcceptTime ?? this.pickerAcceptTime,
      pickerDoneTime: pickerDoneTime ?? this.pickerDoneTime,
      supervisorAcceptTime: supervisorAcceptTime ?? this.supervisorAcceptTime,
      adminCancelTime: adminCancelTime ?? this.adminCancelTime,
      userCancelTime: userCancelTime ?? this.userCancelTime,
      deliveredTime: deliveredTime ?? this.deliveredTime,
      supervisorGetMounyDataTime:
          supervisorGetMounyDataTime ?? this.supervisorGetMounyDataTime,
      adminGetMounyDataTime:
          adminGetMounyDataTime ?? this.adminGetMounyDataTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      userAcceptTime.hashCode ^
      pickerAcceptTime.hashCode ^
      pickerDoneTime.hashCode ^
      supervisorAcceptTime.hashCode ^
      adminCancelTime.hashCode ^
      userCancelTime.hashCode ^
      deliveredTime.hashCode ^
      supervisorGetMounyDataTime.hashCode ^
      adminGetMounyDataTime.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
