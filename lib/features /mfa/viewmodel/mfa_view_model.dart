// lib/features/mfa/viewmodel/mfa_viewmodel.dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mfa_state.dart';

final mfaViewModelProvider =
StateNotifierProvider<MfaViewModel, MfaState>(
      (ref) => MfaViewModel(),
);

class MfaViewModel extends StateNotifier<MfaState> {
  Timer? _timer;

  MfaViewModel() : super(const MfaState()) {
    startTimer();
  }

  void updateDigit(int index, String value) {
    final updated = [...state.digits];
    updated[index] = value;

    final filled = updated.every((d) => d.isNotEmpty);
    state = state.copyWith(digits: updated, canVerify: filled, status: MfaStatus.idle);
  }

  void clearDigits() {
    state = state.copyWith(
      digits: const ['', '', '', '', '', ''],
      canVerify: false,
      status: MfaStatus.idle,
    );
  }

  Future<void> verifyCode() async {
    final code = state.digits.join();
    if (code.length != 6) return;

    state = state.copyWith(status: MfaStatus.verifying);

    await Future.delayed(const Duration(milliseconds: 1500));

    if (code == '123456') {
      state = state.copyWith(status: MfaStatus.success);
    } else {
      state = state.copyWith(status: MfaStatus.error);
      clearDigits();
    }
  }

  void startTimer() {
    _timer?.cancel();
    state = state.copyWith(canResend: false, resendSeconds: 60);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendSeconds <= 1) {
        timer.cancel();
        state = state.copyWith(canResend: true);
      } else {
        state = state.copyWith(resendSeconds: state.resendSeconds - 1);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
