import 'dart:io';
import 'package:flutter/material.dart';
import '../../../domain/models/user_profile_model.dart';

class ProfileEditState {
  final bool isLoading;
  final String? error;
  final UserProfileModel? profile;
  final File? profileImage;
  final AutovalidateMode autoValidate;

  ProfileEditState({
    this.isLoading = false,
    this.error,
    this.profile,
    this.profileImage,
    this.autoValidate = AutovalidateMode.disabled,
  });

  ProfileEditState copyWith({
    bool? isLoading,
    String? error,
    UserProfileModel? profile,
    File? profileImage,
    AutovalidateMode? autoValidate,
  }) {
    return ProfileEditState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      profile: profile ?? this.profile,
      profileImage: profileImage ?? this.profileImage,
      autoValidate: autoValidate ?? this.autoValidate,
    );
  }
}
abstract class PasswordState extends ProfileEditState  {
  @override
  List<Object?> get props => [];
}

class PasswordInitial extends PasswordState {}

class PasswordLoading extends PasswordState {}

class PasswordSuccess extends PasswordState {}

class PasswordError extends PasswordState {
  final String message;

  PasswordError(this.message);

  @override
  List<Object?> get props => [message];
}