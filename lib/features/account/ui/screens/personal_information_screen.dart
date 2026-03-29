// ===================== PROFILE EDIT SCREEN =====================
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
    return Scaffold(
      body: BlocBuilder<ProfileEditCubit, ProfileEditState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final cubit = context.read<ProfileEditCubit>();

          ImageProvider imageProvider;


            final savedImageUrl = SharedHandler.instance.getString('profileImageUrl');
            if (savedImageUrl != null && savedImageUrl.isNotEmpty) {
              imageProvider = NetworkImage(savedImageUrl);
            } else {
              imageProvider = const AssetImage(Assets.imagesHeroEmployee);
            }



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
                          backgroundImage: cubit.getProfileImage(),
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
                              child: Icon(Icons.edit, color: AppTheme.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  const SubTitle(title: "Personal Information"),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {

                      showEditProfileDialog(
                        context: context,
                        title: "Edit Name",
                        controller: cubit.nameController,
                        validator: (value) => Validation.validateUsername(value ?? ''),
                        onSave: () {
                          final fullName = cubit.nameController.text.trim();
                          final names = fullName.split(" ");

                          cubit.updateProfileName(
                            fullName: fullName,
                            firstName: names.first,
                            lastName: names.length > 1 ? names.sublist(1).join(" ") : "",
                          );

                          cubit.updateProfile(
                            context: context,
                            firstName: names.first,
                            lastName: names.length > 1 ? names.last : "",
                          );
                        },
                      );
                    },
                    child: CustomTextField(
                      isEnabled: false,
                      hintText: "Enter your full name",
                      controller: cubit.nameController,
                      isSuffix: true,
                      suffixIcon: Icons.edit,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: theme.brightness == Brightness.dark
                            ? AppTheme.white
                            : AppTheme.primary,
                      ),
                    )
                  ),

                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {

                      showEditProfileDialog(
                        context: context,
                        title: "Edit Email",
                        controller: cubit.emailController,
                          validator:   (value) => Validation.validateEmail(value ?? ''),
                        onSave: () {

                          cubit.updateProfile(
                            context: context,
                            email: cubit.emailController.text.trim(),
                          );
                        },
                      );
                    },
                    child: CustomTextField(
                      isEnabled: false,
                      isSuffix: true,
                      suffixIcon: Icons.edit,

                      hintText: "example@gmail.com",
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email_outlined,

                        color: theme.brightness == Brightness.dark
                            ? AppTheme.white
                            : AppTheme.primary,
                      ),
                      isPassword: false,
                    ),
                  ),

                  const SizedBox(height: 12),
                  CustomPhoneField(
                    controller: cubit.phoneController,
                    validator:  (value) =>Validation.validatePhoneNumber(value ??''),
                    isSuffix: true,
                    suffixIcon: Icons.edit,
                    onTap: () {
                      showEditProfileDialog(
                        context: context,
                        title: "Edit Phone Number",
                        controller: cubit.phoneController,
                        validator:   (value) => Validation.validatePhoneNumber(value ?? ''),
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

                  // ================= CHANGE PASSWORD =================
                  const SizedBox(height: 30),
                  const SubTitle(title: "Change Password"),
                  const SizedBox(height: 12),
                  CustomTextField(
                    hintText: "Enter current password",
                    controller: cubit.currentPassController,
                    isPassword: true,
                    prefixIcon: const Icon(CupertinoIcons.lock_shield),
                    validator:   (value) => Validation.validatePassword(value ?? ''),

                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    hintText: "Enter new password",
                    controller: cubit.newPassController,
                    isPassword: true,
                    prefixIcon: const Icon(CupertinoIcons.lock_shield),
                    validator:    (value) => Validation.validatePassword(value ?? ''),

          ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    hintText: "Confirm new password",
                    controller: cubit.confirmPassController,
                    isPassword: true,
                    prefixIcon: const Icon(CupertinoIcons.lock_shield),
                    validator:   (value) => Validation.validatePasswordMatch(
                      cubit.newPassController.text,
                               value ?? '',
                      ),

                  ),

                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
                          builder: (context, state) {
                            final isLoading = state is PasswordLoading;
                            return Column(
                              children: [
                                if (state is PasswordError)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
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
}
