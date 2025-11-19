import '../../domain/entities/user_entity.dart';

class UserModel extends User {
  final String accessToken;

  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required this.accessToken,
    super.cefrLevel = 'A1',
    super.xp = 0,
    super.streak = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String accessToken) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      cefrLevel: json['cefrLevel'] ?? 'A1',
      xp: json['xp'] ?? 0,
      streak: json['streak'] ?? 0,
      accessToken: accessToken,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'cefrLevel': cefrLevel,
      'xp': xp,
      'streak': streak,
    };
  }
}
