import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/images/image_picker_service.dart';
import '../../../../configuration/shared_handler/shared_handler.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/validatoin.dart';
import '../../../../configuration/widgets/CustomPhoneField.dart';
import '../../../../configuration/widgets/customer_arrow_back.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../configuration/widgets/customer_sub_title.dart';
import '../../../../configuration/widgets/customer_text_field.dart';
import '../../../../generated/assets.dart';

import '../cubit/profile_edit_cubit/profile_edit_cubit.dart';
import '../cubit/profile_edit_cubit/profile_edit_state.dart';
import '../widgets/edit_profile_dialog.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileEditCubit>().loadProfile();
  }

  Future<void> _pickImage() async {
    final image = await ImagePickerService.pickImageFromGallery();
    if (image != null) {
      context.read<ProfileEditCubit>().updateProfileImage(image, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ProfileEditCubit>();

    return Scaffold(
      body: BlocBuilder<ProfileEditCubit, ProfileEditState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final savedImageUrl =
          SharedHandler.instance.getString('profileImageUrl');

          final ImageProvider imageProvider =
          (savedImageUrl != null && savedImageUrl.isNotEmpty)
              ? NetworkImage(savedImageUrl)
              :  AssetImage(Assets.images.heroEmployee as String);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomerArrowBack(),
                  const SizedBox(height: 20),

                  // ================= IMAGE =================
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 90,
                          backgroundImage: imageProvider,
                          backgroundColor: AppTheme.grey,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: const CircleAvatar(
                              radius: 18,
                              backgroundColor: AppTheme.primary,
                              child: Icon(Icons.edit,
                                  color: AppTheme.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  const SubTitle(title: "Personal Information"),
                  const SizedBox(height: 12),

                  // ================= NAME =================
                  _buildEditableField(
                    context: context,
                    controller: cubit.nameController,
                    title: "Edit Name",
                    hint: "Enter your full name",
                    prefixIcon: Icons.person_outline,
                    validator: (v) =>
                        Validation.validateUsername(v ?? ''),
                    onSave: () {
                      final fullName = cubit.nameController.text.trim();
                      final names = fullName.split(" ");

                      cubit.updateProfileName(
                        fullName: fullName,
                        firstName: names.first,
                        lastName: names.length > 1
                            ? names.sublist(1).join(" ")
                            : "",
                      );

                      cubit.updateProfile(
                        context: context,
                        firstName: names.first,
                        lastName:
                        names.length > 1 ? names.sublist(1).join(" ") : "",
                      );
                    },
                    theme: theme,
                  ),

                  const SizedBox(height: 12),

                  // ================= EMAIL =================
                  _buildEditableField(
                    context: context,
                    controller: cubit.emailController,
                    title: "Edit Email",
                    hint: "example@gmail.com",
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) =>
                        Validation.validateEmail(v ?? ''),
                    onSave: () {
                      cubit.updateProfile(
                        context: context,
                        email: cubit.emailController.text.trim(),
                      );
                    },
                    theme: theme,
                  ),

                  const SizedBox(height: 12),

                  // ================= PHONE =================
                  CustomPhoneField(
                    controller: cubit.phoneController,
                    validator: (v) =>
                        Validation.validatePhoneNumber(v ?? ''),
                    isSuffix: true,
                    suffixIcon: Icons.edit,
                    onTap: () {
                      showEditProfileDialog(
                        context: context,
                        title: "Edit Phone Number",
                        controller: cubit.phoneController,
                        validator: (v) =>
                            Validation.validatePhoneNumber(v ?? ''),
                        keyboardType: TextInputType.phone,
                        onSave: () {
                          cubit.updateProfile(
                            country: 'EG',
                            phone: cubit.phoneController.text.trim(),
                            context: context,
                          );
                        },
                      );
                    },
                  ),

                  // ================= PASSWORD =================
                  const SizedBox(height: 30),
                  const SubTitle(title: "Change Password"),
                  const SizedBox(height: 12),

                  _passwordField(
                    cubit.currentPassController,
                    "Enter current password",
                  ),
                  const SizedBox(height: 12),
                  _passwordField(
                    cubit.newPassController,
                    "Enter new password",
                  ),
                  const SizedBox(height: 12),
                  _passwordField(
                    cubit.confirmPassController,
                    "Confirm new password",
                    validator: (v) => Validation.validatePasswordMatch(
                      cubit.newPassController.text,
                      v ?? '',
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ================= BUTTONS =================
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: BlocBuilder<ProfileEditCubit,
                            ProfileEditState>(
                          builder: (context, state) {
                            final isLoading = state is PasswordLoading;

                            return Column(
                              children: [
                                if (state is PasswordError)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10),
                                    child: Text(
                                      state.message,
                                      style: const TextStyle(
                                        color: AppTheme.error,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                CustomBottom(
                                  textSize: 16,
                                  title: isLoading
                                      ? 'Please wait...'
                                      : 'Save Changes',
                                  onTap: isLoading
                                      ? () {}
                                      : () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.changePassword();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 5,
                        child: CustomBottom(
                          textSize: 16,
                          title: 'Forgot Password',
                          isOutline: true,
                          textColor: AppTheme.primary,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= HELPERS =================

  Widget _buildEditableField({
    required BuildContext context,
    required TextEditingController controller,
    required String title,
    required String hint,
    required IconData prefixIcon,
    required Function() onSave,
    ThemeData? theme,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return InkWell(
      onTap: () {
        showEditProfileDialog(
          context: context,
           title: title,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          onSave: onSave,
        );
      },
      child: CustomTextField(

        isEnabled: false,
        hintText: hint,
        controller: controller,
        isSuffix: true,
        suffixIcon: Icons.edit,

        prefixIcon: Icon(
          prefixIcon,
          color: theme?.brightness == Brightness.dark
              ? AppTheme.white
              : AppTheme.primary,
        ),
      ),
    );
  }

  Widget _passwordField(
      TextEditingController controller,
      String hint, {
        String? Function(String?)? validator,
      }) {
    return CustomTextField(
      hintText: hint,
      controller: controller,
      isPassword: true,
      prefixIcon: const Icon(CupertinoIcons.lock_shield),
      validator: validator ??
              (v) => Validation.validatePassword(v ?? ''),
    );
  }
}