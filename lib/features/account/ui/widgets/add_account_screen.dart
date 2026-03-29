import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/widgets/customer_arrow_back.dart';
import 'package:hire_quest/configuration/widgets/customer_bottom.dart';

import '../../../../configuration/route/route.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/validatoin.dart';
import '../../../../configuration/widgets/CustomPhoneField.dart';
import '../../../authentication/blocs/forgetpasswordbloc/forgot_state.dart' hide SuccessState, AppState, LoadingState;
import '../../../authentication/blocs/singupbloc/signup_event.dart';
import '../../../authentication/blocs/singupbloc/signup_state.dart';
import '../../../authentication/blocs/singupbloc/singup.dart';
import '../../../authentication/domain/model_data/user_data.dart';
import '../../../authentication/ui/screens/singup_screen.dart';
import '../../../../configuration/widgets/customer_text_field.dart' show CustomTextField;
import '../../../authentication/ui/widget/social_media_auth.dart';




class AddAccountScreen extends StatelessWidget {
  const AddAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: const SingUpView(),
    );
  }
}

class SingUpView extends StatelessWidget {
  const SingUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SignupBloc>(context);

    return Scaffold(
      body: BlocListener<SignupBloc, AppState>(
        listener: (context, state) {
          if (state is SuccessState)  {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.data),
                backgroundColor:AppTheme.success,
                duration: const Duration(seconds: 1),
              ),
            );

            Future.delayed(const Duration(milliseconds: 400), () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.otpVerification,
                    (route) => false,
              );
            });
          }
          if (state is FailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppTheme.error,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: bloc.formKey,
              child:GestureDetector(
                onTap: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomerArrowBack(title: 'Add Account',),
                   // const SizedBox(height: 80),

                    const SizedBox(height: 40),
                    CustomTextField(
                      label: 'Full Name',
                      hintText: 'username ',
                      controller: bloc.nameController,
                      validator: (value) =>
                          Validation.validateUsername(value ?? ''),
                    ),

                    const SizedBox(height: 10),
                    CustomTextField(
                      label: 'Email',
                      hintText: 'example@gmail.com',
                      controller: bloc.emailController,
                      validator: (value) =>
                          Validation.validateEmail(value ?? ''),
                    ),

                    const SizedBox(height: 10),

                    CustomPhoneField(
                      label: 'Phone',
                      controller: bloc.phoneController,
                      validator: (value) =>
                          Validation.validatePhoneNumber(value??''),
                    ),

                    const SizedBox(height: 10),
                    CustomTextField(
                      label: 'Create a Password',
                      hintText: 'must be 8 characters',
                      isPassword: true,
                      controller: bloc.passwordController,
                      validator: (value) =>
                          Validation.validatePassword(value ?? ''),
                    ),

                    const SizedBox(height: 10),

                    CustomTextField(
                      label: 'Confirm Password',
                      hintText: 'must be 8 characters',
                      isPassword: true,
                      controller: bloc.confirmPasswordController,
                      validator: (value) => Validation.validatePasswordMatch(
                        bloc.passwordController.text,
                        value ?? '',
                      ),
                    ),

                    const SizedBox(height: 12),

                    BlocBuilder<SignupBloc, AppState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                bloc.add(ToggleTermsEvent());
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: bloc.isAccepted
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppTheme.backgroundWhite,
                                ),
                                child: bloc.isAccepted
                                    ? const Icon(
                                  Icons.check,
                                  color: AppTheme.primary,
                                  size: 16,
                                )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.black),
                                children: [
                                  const TextSpan(text: 'I Accept the '),
                                  TextSpan(
                                    text: 'terms & Conditions',
                                    style: const TextStyle(
                                        color: AppTheme.primary),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    BlocBuilder<SignupBloc, AppState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.primary,
                            ),
                          );
                        }

                        return CustomBottom(
                          title: 'Add New Account',
                          textSize: 16,
                          onTap: () {
                            final termsError =
                            Validation.validateTermsAccepted(
                                bloc.isAccepted);

                            if (termsError != null) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Attention'),
                                  content: Text(termsError),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            if (bloc.formKey.currentState?.validate() ?? false) {
                              final fullName = bloc.nameController.text.trim().split(' ');

                              bloc.add(
                                SignupEvent(
                                  userData: UserData(
                                    country: '',
                                    phoneNumber:bloc.phoneController.text ,
                                    email: bloc.emailController.text,
                                    password: bloc.passwordController.text,
                                    passwordConfirmation:
                                    bloc.confirmPasswordController.text,
                                    firstName: fullName.isNotEmpty ? fullName.first : '',
                                    lastName: fullName.length > 1 ? fullName.last : '',

                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    SocialMediaAuth(title: 'Register'),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
