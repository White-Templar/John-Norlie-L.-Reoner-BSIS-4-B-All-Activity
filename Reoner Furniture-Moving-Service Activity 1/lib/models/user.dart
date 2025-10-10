class User {
  final String name;
  final String email;
  final String role;
  final bool notificationsEnabled;
  final DateTime registrationDate;
  final String username;

  User({
    required this.name,
    required this.email,
    required this.role,
    required this.notificationsEnabled,
    required this.registrationDate,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'notificationsEnabled': notificationsEnabled,
      'registrationDate': registrationDate.toIso8601String(),
      'username': username,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'User',
      notificationsEnabled: map['notificationsEnabled'] ?? false,
      registrationDate: DateTime.parse(map['registrationDate']),
      username: map['username'] ?? '',
    );
  }
}