class RegisterModel {
  final bool? success;
  final String? message;
  final String? data;
  final List<String>? errors;

  RegisterModel({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      success: json['success'],
      message: json['message'],
      data: json['data']?.toString(),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }
}
