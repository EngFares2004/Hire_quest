import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/route/route.dart';
import 'package:hire_quest/features/authentication/blocs/reset_pass_bloc/reset_pass_cubit.dart';
import 'package:hire_quest/features/authentication/blocs/reset_pass_bloc/reset_pass_state.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/validatoin.dart';
import '../../../../configuration/widgets/customer_bottom.dart';

import '../../../../configuration/widgets/customer_text_field.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPassCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocListener<ResetPassCubit, ResetPassState>(
            listener: (context, state) {
              if (state is PasswordSuccess) {
                Navigator.pushNamed(context, AppRoute.successPassword);
              } else if (state is PasswordError) {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 140),
                      const Text(
                        "Reset password",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Please type something you'll remember",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Builder(
                        builder: (context) {
                          final bloc = context.read<ResetPassCubit>();
                          return Column(
                            children: [
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
                                validator: (value) =>
                                    Validation.validatePasswordMatch(
                                      bloc.passwordController.text,
                                      value ?? '',
                                    ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      BlocBuilder<ResetPassCubit, ResetPassState>(
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
                                title: isLoading ? 'Please wait...' : 'Reset password',
                                onTap: isLoading
                                    ? (){}
                                    : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ResetPassCubit>().resetPassword() ;
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
