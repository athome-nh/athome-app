import 'dart:convert';

import 'package:collection/collection.dart';

class Chatmodel {
  int? id;
  int? issueId;
  String? content;
  String? type;
  String? customerPhone;
  dynamic adminId;
  int? isSeen;
  String? createdAt;
  String? updatedAt;

  Chatmodel({
    this.id,
    this.issueId,
    this.content,
    this.type,
    this.customerPhone,
    this.adminId,
    this.isSeen,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Chatmodel(id: $id, issueId: $issueId, content: $content, type: $type, customerPhone: $customerPhone, adminId: $adminId, isSeen: $isSeen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Chatmodel.fromMap(Map<String, dynamic> data) => Chatmodel(
        id: data['id'] as int?,
        issueId: data['issue_id'] as int?,
        content: data['content'] as String?,
        type: data['type'] as String?,
        customerPhone: data['customer_phone'] as String?,
        adminId: data['admin_id'] as dynamic,
        isSeen: data['is_seen'] as int?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'issue_id': issueId,
        'content': content,
        'type': type,
        'customer_phone': customerPhone,
        'admin_id': adminId,
        'is_seen': isSeen,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Chatmodel].
  factory Chatmodel.fromJson(String data) {
    return Chatmodel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Chatmodel] to a JSON string.
  String toJson() => json.encode(toMap());

  Chatmodel copyWith({
    int? id,
    int? issueId,
    String? content,
    String? type,
    String? customerPhone,
    dynamic adminId,
    int? isSeen,
    String? createdAt,
    String? updatedAt,
  }) {
    return Chatmodel(
      id: id ?? this.id,
      issueId: issueId ?? this.issueId,
      content: content ?? this.content,
      type: type ?? this.type,
      customerPhone: customerPhone ?? this.customerPhone,
      adminId: adminId ?? this.adminId,
      isSeen: isSeen ?? this.isSeen,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Chatmodel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      issueId.hashCode ^
      content.hashCode ^
      type.hashCode ^
      customerPhone.hashCode ^
      adminId.hashCode ^
      isSeen.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
