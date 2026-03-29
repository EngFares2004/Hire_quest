import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/widgets/customer_arrow_back.dart';
import 'package:hire_quest/features/authentication/domain/services/otp_service.dart';

import '../../../../configuration/route/route.dart';
import '../../../../configuration/theme/theme.dart';

import '../../../../configuration/validatoin.dart';
import '../../blocs/forgetpasswordbloc/forgot.dart';
import '../../blocs/forgetpasswordbloc/forgot_state.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../blocs/otp_verification_bloc/otp_cubit.dart';
import '../../../../configuration/widgets/customer_text_field.dart';
import 'otp_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailaddressController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ForgetBloc(),
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomerArrowBack(),
                    const SizedBox(height: 64),

                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Don’t worry! It happens. Please enter the email associated with your account.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.secondary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    CustomTextField(
                      label: 'Email',
                      hintText: 'Email Address',
                      controller: emailaddressController,
                        validator: (value) =>
                            Validation.validateEmail(value ?? ''),
                    ),




                    const SizedBox(height: 24),

                    BlocBuilder<ForgetBloc, ForgetState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.primary,
                            ),
                          );
                        }

                        return CustomBottom(
                          title: 'Send the Code',
                          onTap: () {
                            String email = emailaddressController.text;

                            if (key.currentState!.validate()) {


                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) => OtpCubit(OtpService()),
                                    child: OtpScreen(email: email),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),

                    SizedBox(
                        height: MediaQuery.of(context).size.height/3),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.bodyMedium?.color),

                          children: [
                            const TextSpan(text: "Remember password ? "),
                            TextSpan(
                              text: 'Login',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoute.login,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
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
