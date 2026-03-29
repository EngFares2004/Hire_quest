class LoginResponse {
  final String? token;
  final String? message;
  final bool? isAuthenticated;

  LoginResponse({
    this.token,
    this.message,
    this.isAuthenticated,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ??
          json['access_token'] ??
          json['data']?['token'] ??
          json['result']?['token'],
      message: json['message'] ?? json['data']?['message'],
      isAuthenticated: json['isAuthenticated'] ?? true,
    );
  }
}
