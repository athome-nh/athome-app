import 'dart:convert';

import 'package:collection/collection.dart';

class UserModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? city;
  final int? age;
  final String? gender;
  final String? img;
  final int? isActive;
  final int? isApprove;

  const UserModel({
    this.id,
    this.name,
    this.phone,
    this.city,
    this.age,
    this.gender,
    this.img,
    this.isActive,
    this.isApprove,
  });

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, phone: $phone, city: $city, age: $age, gender: $gender, img: $img, isActive: $isActive, isApprove: $isApprove,)';
  }

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        city: data['city'] as String?,
        age: data['age'] as int?,
        gender: data['gender'] as String?,
        img: data['img'] as String?,
        isActive: data['isActive'] as int?,
        isApprove: data['isApprove'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'city': city,
        'age': age,
        'gender': gender,
        'img': img,
        'isActive': isActive,
        'isApprove': isApprove,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserModel].
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserModel] to a JSON string.
  String toJson() => json.encode(toMap());

  UserModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? city,
    int? age,
    String? gender,
    String? img,
    int? isActive,
    int? isApprove,
    int? isDeleted,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      img: img ?? this.img,
      isActive: isActive ?? this.isActive,
      isApprove: isApprove ?? this.isApprove,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      city.hashCode ^
      age.hashCode ^
      gender.hashCode ^
      img.hashCode ^
      isActive.hashCode ^
      isApprove.hashCode;
}
