import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/features/authentication/ui/widget/social_media_auth.dart';

import '../../../../configuration/route/route.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/validatoin.dart';
import '../../../home/ui/screens/home_screen.dart';
import '../../blocs/loginbloc/login.dart';
import '../../blocs/loginbloc/login_event.dart';
import '../../blocs/loginbloc/login_state.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../configuration/widgets/customer_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          body: BlocProvider(
            create: (context) => LoginBloc(),
            child: Builder(
                builder: (context) {
                  final bloc = BlocProvider.of<LoginBloc>(context);

                  return
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: bloc.formKey,
                          child: GestureDetector(
                            onTap: (){
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 120),

                                Text("Log in",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.primary,
                                    )),

                                const SizedBox(height: 40),

                                CustomTextField(
                                  label: 'Email',
                                  hintText: 'example@gmail.com',
                                  controller: bloc.emailController,
                                  validator: (value) =>
                                      Validation.validateEmail(value ?? ''),
                                ),
                                const SizedBox(height: 10),

                                CustomTextField(
                                  label: 'Password',
                                  hintText: 'must be 8 characters',
                                  isPassword: true,
                                  controller: bloc.passwordController,
                                  validator: (value) =>
                                      Validation.validatePassword(value ?? ''),
                                ),
                                const SizedBox(height: 10),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () =>
                                        Navigator.pushNamed(
                                            context, AppRoute.forgetPassword),
                                    child: const Text(
                                      'Forget Password?',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.primary,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 40),

                                BlocConsumer<LoginBloc, AppState>(
                                  listener: (context, state) {
                                    if (state is SuccessState) {
                                      if (state.data == "Please verify your email first") {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(state.data),
                                            backgroundColor: AppTheme.success,
                                          ),
                                        );
                                      } else {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoute.onboarding,
                                              (route) => false,
                                        );
                                      }
                                    }

                                    if (state is FailureState) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(state.error),
                                          backgroundColor: AppTheme.error,
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is LoadingState) {
                                      return const Center(
                                        child: CircularProgressIndicator(color: AppTheme.primary),
                                      );
                                    }

                                    return CustomBottom(
                                      title: 'Login',
                                      onTap: () {
                                        final bloc = BlocProvider.of<LoginBloc>(context);
                                        if (bloc.formKey.currentState!.validate()) {
                                          bloc.add(LoginEvent(
                                            email: bloc.emailController.text,
                                            password: bloc.passwordController.text,
                                          ));
                                        }
                                      },
                                    );
                                  },
                                ),


                                SocialMediaAuth(title: 'login'),

                                const SizedBox(height: 50),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don’t have an account? ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).textTheme.bodyMedium?.color),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          Navigator.pushReplacementNamed(
                                              context, AppRoute.signup),
                                      child: const Text(
                                        'Sign up',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 45),
                              ],
                            ),
                          ),
                        ),
                          ),

                    );
                     }
          )
      )

      );
  }
}
