import 'dart:convert';

import 'package:collection/collection.dart';

class NotficaionModel {
  final int? id;
  final String? title;
  final String? content;
  final int? customerId;
  final String? type;
  final int? relationId;
  final String? subrelation;
  final int? createBy;
  final dynamic updatedBy;
  final String? createdAt;
  final String? updatedAt;

  const NotficaionModel({
    this.id,
    this.title,
    this.content,
    this.customerId,
    this.type,
    this.relationId,
    this.subrelation,
    this.createBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'NotficaionModel(id: $id, title: $title, content: $content, customerId: $customerId, type: $type, relationId: $relationId, subrelation: $subrelation, createBy: $createBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory NotficaionModel.fromMap(Map<String, dynamic> data) {
    return NotficaionModel(
      id: data['id'] as int?,
      title: data['title'] as String?,
      content: data['content'] as String?,
      customerId: data['customerId'] as int?,
      type: data['type'] as String?,
      relationId: data['relationID'] as int?,
      subrelation: data['subrelation'] as String?,
      createBy: data['createBy'] as int?,
      updatedBy: data['updatedBy'] as dynamic,
      createdAt: data['created_at'] as String?,
      updatedAt: data['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'customerId': customerId,
        'type': type,
        'relationID': relationId,
        'subrelation': subrelation,
        'createBy': createBy,
        'updatedBy': updatedBy,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NotficaionModel].
  factory NotficaionModel.fromJson(String data) {
    return NotficaionModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NotficaionModel] to a JSON string.
  String toJson() => json.encode(toMap());

  NotficaionModel copyWith({
    int? id,
    String? title,
    String? content,
    int? customerId,
    String? type,
    int? relationId,
    String? subrelation,
    int? createBy,
    dynamic updatedBy,
    String? createdAt,
    String? updatedAt,
  }) {
    return NotficaionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      customerId: customerId ?? this.customerId,
      type: type ?? this.type,
      relationId: relationId ?? this.relationId,
      subrelation: subrelation ?? this.subrelation,
      createBy: createBy ?? this.createBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! NotficaionModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      customerId.hashCode ^
      type.hashCode ^
      relationId.hashCode ^
      subrelation.hashCode ^
      createBy.hashCode ^
      updatedBy.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
