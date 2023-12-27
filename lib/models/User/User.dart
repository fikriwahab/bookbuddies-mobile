class User {
  final int id;
  final String password;
  final DateTime? lastLogin;
  final bool isSuperuser;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final bool isStaff;
  final bool isActive;
  final DateTime dateJoined;

  User({
    required this.id,
    required this.password,
    required this.lastLogin,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int? ?? 0,
      password: json['password'] as String? ?? '',
      lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login']) : null,
      isSuperuser: json['is_superuser'] as bool? ?? false,
      username: json['username'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isStaff: json['is_staff'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? false,
      dateJoined: DateTime.parse(json['date_joined'] as String)
    );
  }
}
