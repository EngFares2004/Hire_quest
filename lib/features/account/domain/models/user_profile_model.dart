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

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final fullName = json['fullName'] ?? '';
    final parts = fullName.split(' ');

    return UserProfileModel(
      userId: json['userId'] ?? '',
      fullName: fullName,
      firstName: parts.isNotEmpty ? parts.first : '',
      lastName: parts.length > 1 ? parts.sublist(1).join(' ') : '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      country: json['country'] ?? 'Egypt',
      profilePictureUrl: json['profilePictureUrl'],
    );
  }

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