import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/route/route.dart';
import 'package:hire_quest/configuration/widgets/customer_arrow_back.dart';
import 'package:hire_quest/features/authentication/domain/services/otp_service.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../blocs/otp_verification_bloc/otp_cubit.dart';
import '../../blocs/otp_verification_bloc/otp_state.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}
class _OtpScreenState extends State<OtpScreen> {
  late OtpCubit cubit;

  final List<TextEditingController> controllers =
  List.generate(6, (index) => TextEditingController());

  String getOtp() => controllers.map((c) => c.text).join();

  @override
  void initState() {
    super.initState();
    cubit = OtpCubit(OtpService());


    cubit.startTimer();
    cubit.resendCode(widget.email); // ✅ reset / resend تلقائي
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body: BlocConsumer<OtpCubit, OtpState>(

          listener: (context, state) {
            if (state is  OtpSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.passwordChanged,
                    (route) => false,
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<OtpCubit>();

            bool isError = state is OtpError;
            bool isSuccess = state is OtpSuccess;

            int timer = state is OtpTimerChanged ? state.timer : 20;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child:GestureDetector(
                  onTap: (){
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Column(
                    children: [

                       CustomerArrowBack(),
                      const SizedBox(height: 80),

                      const Text(
                        "Please check your email",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primary),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "We sent a code to ${widget.email}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.secondary,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 7,
                            height: MediaQuery.of(context).size.width / 7,
                            child: TextField(
                              controller: controllers[index],
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor: Theme.of(context).colorScheme.surface, // 👈 Theme Aware
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: isError
                                        ? Theme.of(context).colorScheme.error
                                        : (isSuccess
                                        ? Colors.greenAccent
                                        : AppTheme.primary),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: isError
                                        ? Theme.of(context).colorScheme.error
                                        : (isSuccess
                                        ? Colors.greenAccent // ممكن تعمل ColorScheme.success
                                        : Theme.of(context).colorScheme.primary),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),


                      const SizedBox(height: 20),

                      if (state is OtpLoading)
                        const CircularProgressIndicator(),

                      if (isError)
                        Text(
                          (state).message,
                          style: const TextStyle(
                              color: AppTheme.error, fontSize: 14),
                        ),

                      const SizedBox(height: 30),
                      if (state is !OtpLoading)
                        CustomBottom(
                          title:isSuccess? "Success" :"Verify",
                          color: isSuccess?AppTheme.success : AppTheme.primary,
                          onTap: () {
                            cubit.verifyCode(widget.email, getOtp());
                          },
                        ),


                      const SizedBox(height: 15),

                      timer > 0
                          ? Text(
                        "Send code again 00:$timer",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.secondary,
                        ),
                      )
                          : GestureDetector(
                        onTap: () {
                          cubit.resendCode(widget.email);
                        },
                        child: const Text(
                          "Didn’t receive code? Resend",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
