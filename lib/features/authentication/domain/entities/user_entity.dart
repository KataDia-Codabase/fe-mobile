class User {
  final String id;
  final String name;
  final String email;
  final String cefrLevel;
  final int xp;
  final int streak;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.cefrLevel = 'A1',
    this.xp = 0,
    this.streak = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
