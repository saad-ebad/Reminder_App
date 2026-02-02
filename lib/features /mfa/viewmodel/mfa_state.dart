// lib/features/mfa/viewmodel/mfa_state.dart
enum MfaStatus { idle, verifying, error, success }

class MfaState {
  final List<String> digits;
  final bool canVerify;
  final bool canResend;
  final int resendSeconds;
  final MfaStatus status;

  const MfaState({
    this.digits = const ['', '', '', '', '', ''],
    this.canVerify = false,
    this.canResend = false,
    this.resendSeconds = 60,
    this.status = MfaStatus.idle,
  });

  MfaState copyWith({
    List<String>? digits,
    bool? canVerify,
    bool? canResend,
    int? resendSeconds,
    MfaStatus? status,
  }) {
    return MfaState(
      digits: digits ?? this.digits,
      canVerify: canVerify ?? this.canVerify,
      canResend: canResend ?? this.canResend,
      resendSeconds: resendSeconds ?? this.resendSeconds,
      status: status ?? this.status,
    );
  }
}
