class UserProfileModel {
  final String userId;
  final String fullName;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String country;
  final String? profilePictureUrl;

  UserProfileModel({
    required this.userId,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.country,
    this.profilePictureUrl,
  });

  // ======================= fromJson =======================
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final fullName = json['fullName'] ?? '';
    final names = fullName.split(' ');
    final firstName = names.isNotEmpty ? names.first : '';
    final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

    return UserProfileModel(
      userId: json['userId'] ?? '',
      fullName: fullName,
      firstName: firstName,
      lastName: lastName,
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      country: json['country'] ?? 'Egypt',
      profilePictureUrl: json['profilePictureUrl'],
    );
  }

  // ======================= copyWith =======================
  UserProfileModel copyWith({
    String? fullName,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? country,
    String? profilePictureUrl,
  }) {
    return UserProfileModel(
      userId: userId,
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }
}