class LoginData {
  final String email;
  final String password;

  LoginData({required this.email, required this.password});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
