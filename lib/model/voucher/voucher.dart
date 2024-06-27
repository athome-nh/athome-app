import 'dart:convert';

import 'package:collection/collection.dart';

class Voucher {
  final int? id;
  final String? titleEn;
  final String? titleKu;
  final String? titleAr;
  final String? code;
  final int? customerId;
  final int? mimimumAmount;
  final int? discountAmount;
  final int? limit;
  final int? isDeleted;
  final String? expireDate;
  final String? createdAt;
  final String? updatedAt;

  const Voucher({
    this.id,
    this.titleEn,
    this.titleKu,
    this.titleAr,
    this.code,
    this.customerId,
    this.mimimumAmount,
    this.discountAmount,
    this.limit,
    this.isDeleted,
    this.expireDate,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Voucher(id: $id, titleEn: $titleEn, titleKu: $titleKu, titleAr: $titleAr, code: $code, customerId: $customerId, mimimumAmount: $mimimumAmount, discountAmount: $discountAmount, limit: $limit, isDeleted: $isDeleted, expireDate: $expireDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Voucher.fromMap(Map<String, dynamic> data) => Voucher(
        id: data['id'] as int?,
        titleEn: data['title_en'] as String?,
        titleKu: data['title_ku'] as String?,
        titleAr: data['title_ar'] as String?,
        code: data['code'] as String?,
        customerId: data['customer_id'] as int?,
        mimimumAmount: data['mimimum_amount'] as int?,
        discountAmount: data['discount_amount'] as int?,
        limit: data['limit'] as int?,
        isDeleted: data['isDeleted'] as int?,
        expireDate: data['expire_date'] as String?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title_en': titleEn,
        'title_ku': titleKu,
        'title_ar': titleAr,
        'code': code,
        'customer_id': customerId,
        'mimimum_amount': mimimumAmount,
        'discount_amount': discountAmount,
        'limit': limit,
        'isDeleted': isDeleted,
        'expire_date': expireDate,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Voucher].
  factory Voucher.fromJson(String data) {
    return Voucher.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Voucher] to a JSON string.
  String toJson() => json.encode(toMap());

  Voucher copyWith({
    int? id,
    String? titleEn,
    String? titleKu,
    String? titleAr,
    String? code,
    int? customerId,
    int? mimimumAmount,
    int? discountAmount,
    int? limit,
    int? isDeleted,
    String? expireDate,
    String? createdAt,
    String? updatedAt,
  }) {
    return Voucher(
      id: id ?? this.id,
      titleEn: titleEn ?? this.titleEn,
      titleKu: titleKu ?? this.titleKu,
      titleAr: titleAr ?? this.titleAr,
      code: code ?? this.code,
      customerId: customerId ?? this.customerId,
      mimimumAmount: mimimumAmount ?? this.mimimumAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      limit: limit ?? this.limit,
      isDeleted: isDeleted ?? this.isDeleted,
      expireDate: expireDate ?? this.expireDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Voucher) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      titleEn.hashCode ^
      titleKu.hashCode ^
      titleAr.hashCode ^
      code.hashCode ^
      customerId.hashCode ^
      mimimumAmount.hashCode ^
      discountAmount.hashCode ^
      limit.hashCode ^
      isDeleted.hashCode ^
      expireDate.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
