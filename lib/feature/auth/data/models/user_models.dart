

import '../../../../core/common/entities/user.dart';

class UserModels extends User {
  UserModels({required super.id, required super.name, required super.email});

  factory UserModels.fromJson(Map<String, dynamic> map) {
    return UserModels(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '');
  }

  UserModels copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModels(
        id: id ?? this.id, name: name ?? this.name, email: email ?? this.email);
  }
}
