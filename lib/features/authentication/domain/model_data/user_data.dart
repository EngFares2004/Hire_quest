class UserData {
  String email;
  String password;
  String firstName;
  String lastName;
  String phoneNumber;
  String country;
  String passwordConfirmation;
  UserData({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.country
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": '+201026450812',
      "country": '+20',
    };
  }
}
