import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../domain/service/vr_code_service.dart';

part 'interview_code_state.dart';

class InterviewCodeCubit extends Cubit<InterviewCodeState> {
  final VrCodeService _vrService;

  InterviewCodeCubit(this._vrService)
      : super(InterviewCodeInitial());

  Timer? _timer;

  Future<void> generateCode() async {
    emit(InterviewCodeLoading());

    try {
      final response = await _vrService.generateVrCode();

      if (response["success"] == true &&
          response["data"] != null) {
        final data = response["data"];

        final code = data["formattedCode"] ?? data["code"];

        final expiresAt =
        DateTime.parse(data["expiresAt"]);

        _startCountdown(code, expiresAt);
      } else {
        emit(
          InterviewCodeError(
            response["message"] ?? "Unknown error",
          ),
        );
      }
    } catch (e) {
      emit(
        InterviewCodeError(
          "Failed to generate code",
        ),
      );
    }
  }

  void _startCountdown(String code, DateTime expiresAt) {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        final remaining =
            expiresAt.difference(DateTime.now()).inSeconds;

        if (remaining <= 0) {
          timer.cancel();
          emit(InterviewCodeExpired());
        } else {
          emit(
            InterviewCodeGenerated(
              code,
              remaining,
            ),
          );
        }
      },
    );
  }

  Future<void> regenerate() async {
    await generateCode();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}