import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/user_profile_model.dart';
import '../../../domain/service/profile_api_service.dart';
import '../../../../../configuration/shared_handler/shared_handler.dart';
import '../../../domain/repo/change_password_service.dart';
import 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  final ProfileApiService api;

  ProfileEditCubit(this.api) : super(ProfileEditState()) {
    _loadSavedProfileImage();
  }

  final formKey = GlobalKey<FormState>();
  final ChangePassService service = ChangePassService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  String countryCode = 'EG';

  // ================= LOAD PROFILE =================
  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true));

    try {
      final res = await api.getMyProfile();

      if (res.data['success'] == true) {
        final profile = UserProfileModel.fromJson(res.data['data']);
        nameController.text = profile.fullName;
        emailController.text = profile.email;
        phoneController.text = profile.phoneNumber;
        countryCode = profile.country;

        final savedImageUrl = SharedHandler.instance.getString('profileImageUrl');
        final updatedProfile = savedImageUrl != null
            ? profile.copyWith(profilePictureUrl: savedImageUrl)
            : profile;

        emit(state.copyWith(
          isLoading: false,
          profile: updatedProfile,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: res.data['message'] ?? 'Failed to load profile',
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // ================= UPDATE PROFILE =================
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? country = 'EG',
    required BuildContext context,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (phone != null) body['phoneNumber'] = phone;
      if (country != null) body['country'] = country;
      if (firstName != null) body['firstName'] = firstName;
      if (lastName != null) body['lastName'] = lastName;
      if (email != null) body['email'] = email;

      if (body.isEmpty) return;

      final res = await api.updateProfile(body);

      if (res.data['success'] == true) {
        await loadProfile();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res.data['message'] ?? 'Failed to update profile')),
        );
      }
    } catch (e) {
      emit(state.copyWith(error: "Failed to update profile"));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  // ================= UPDATE PROFILE NAME LOCALLY =================


  UserProfileModel? editableProfile;

  void updateProfileName({
    required String fullName,
    required String firstName,
    required String lastName,
  }) {
    if (editableProfile != null) {
      editableProfile = editableProfile!.copyWith(
        fullName: fullName,
        firstName: firstName,
        lastName: lastName,
      );
      // حدث state
      emit(state.copyWith(profile: editableProfile));
    }
  }

  // بعد ما المستخدم يضغط Save على السيرفر
  Future<void> updateProfileOnServer({
    required BuildContext context,
    String? firstName,
    String? lastName,
  }) async {
    await updateProfile(
      context: context,
      firstName: firstName,
      lastName: lastName,
    );
  }

  // ================= UPLOAD AVATAR =================
  Future<void> updateProfileImage(File image, BuildContext context) async {
    emit(state.copyWith(profileImage: image));

    try {
      final res = await api.uploadAvatar(image);

      if (res.data['success'] == true) {
        final imageUrl = res.data['data']['profilePictureUrl'];
        await SharedHandler.instance.setString('profileImageUrl', imageUrl);

        emit(state.copyWith(
          profile: state.profile?.copyWith(profilePictureUrl: imageUrl),
          profileImage: null,
        ));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile image updated successfully!')),
        );
      }
    } catch (e) {
      emit(state.copyWith(error: 'Image upload failed'));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload image')),
      );
    }
  }

  Future<void> _loadSavedProfileImage() async {
    final savedImageUrl = SharedHandler.instance.getString('profileImageUrl');

    if (savedImageUrl == null) return;

    if (state.profile != null) {
      emit(
        state.copyWith(
          profile: state.profile!.copyWith(
            profilePictureUrl: savedImageUrl,
          ),
        ),
      );
    }
  }

  ImageProvider getProfileImage() {
    if (state.profileImage != null) {
      return FileImage(state.profileImage!);
    } else if (state.profile?.profilePictureUrl != null &&
        state.profile!.profilePictureUrl!.isNotEmpty) {
      return NetworkImage(state.profile!.profilePictureUrl!);
    } else {
      final savedImageUrl = SharedHandler.instance.getString('profileImageUrl');
      if (savedImageUrl != null && savedImageUrl.isNotEmpty) {
        return NetworkImage(savedImageUrl);
      }
      return const AssetImage('assets/images/profile.png');
    }
  }

  // ================= CHANGE PASSWORD =================
  Future<void> changePassword() async {
    final pass = currentPassController.text.trim();
    final newPass = newPassController.text.trim();
    final confirm = confirmPassController.text.trim();

    if (pass.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      emit(PasswordError("Please fill all fields"));
      return;
    }

    if (newPass != confirm) {
      emit(PasswordError("Passwords do not match"));
      return;
    }

    emit(PasswordLoading());

    try {
      final response = await service.changePassword(
        password: pass,
        newPassword: confirm,
      );

      final success = response.data["success"] ?? false;
      final errors = response.data["errors"];

      if (success == true) {
        emit(PasswordSuccess());
      } else {
        emit(PasswordError(
          errors != null && errors.isNotEmpty
              ? errors.first.toString()
              : "Something went wrong",
        ));
      }
    } catch (e) {
      emit(PasswordError("Failed to reset password"));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    currentPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    return super.close();
  }
}