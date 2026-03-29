class RegisterModel {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? country;
  final String? password;

  RegisterModel({
    this.name,
    this.email,
    this.password,
    this.country,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      "phoneNumber": phoneNumber,
      "country": country,
    };
  }

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      country: json['country']??'+20',
      phoneNumber: json['phoneNumber']??'01026450812'
    );
  }
}
