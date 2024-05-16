import 'dart:convert';

import 'package:collection/collection.dart';

class ScheduleModel {
  final int? id;
  final String? weekId;
  final String? from;
  final String? to;

  const ScheduleModel({this.id, this.weekId, this.from, this.to});

  @override
  String toString() {
    return 'ScheduleModel(id: $id, weekId: $weekId, from: $from, to: $to)';
  }

  factory ScheduleModel.fromMap(Map<String, dynamic> data) => ScheduleModel(
        id: data['id'] as int?,
        weekId: data['weekID'] as String?,
        from: data['from'] as String?,
        to: data['to'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'weekID': weekId,
        'from': from,
        'to': to,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ScheduleModel].
  factory ScheduleModel.fromJson(String data) {
    return ScheduleModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ScheduleModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ScheduleModel copyWith({
    int? id,
    String? weekId,
    String? from,
    String? to,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      weekId: weekId ?? this.weekId,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ScheduleModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^ weekId.hashCode ^ from.hashCode ^ to.hashCode;
}
