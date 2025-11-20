import '../../features/authentication/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String? avatar;
  final String? accessToken;
  final String cefrLevel;
  final int xp;
  final int streak;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.avatar,
    this.accessToken,
    this.cefrLevel = 'A1',
    this.xp = 0,
    this.streak = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      email: json['email'] as String? ?? '',
      password: json['password'] as String?,
      avatar: json['avatar'] as String?,
      accessToken: json['accessToken'] as String?,
      cefrLevel: json['cefrLevel'] as String? ?? 'A1',
      xp: json['xp'] as int? ?? 0,
      streak: json['streak'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
      'accessToken': accessToken,
      'cefrLevel': cefrLevel,
      'xp': xp,
      'streak': streak,
    };
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      cefrLevel: cefrLevel,
      xp: xp,
      streak: streak,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? avatar,
    String? accessToken,
    String? cefrLevel,
    int? xp,
    int? streak,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      accessToken: accessToken ?? this.accessToken,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      xp: xp ?? this.xp,
      streak: streak ?? this.streak,
    );
  }
}
