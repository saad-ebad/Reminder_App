import '../model/join_classs_model.dart';

enum JoinClassDialogType { none, error, success }

class JoinClassState {
  final String classCode; // always stored uppercase
  final bool isJoinEnabled;
  final JoinClassDialogType dialogType;
  final VerifiedClassInfo? verifiedInfo;

  const JoinClassState({
    this.classCode = '',
    this.isJoinEnabled = false,
    this.dialogType = JoinClassDialogType.none,
    this.verifiedInfo,
  });

  JoinClassState copyWith({
    String? classCode,
    bool? isJoinEnabled,
    JoinClassDialogType? dialogType,
    VerifiedClassInfo? verifiedInfo,
  }) {
    return JoinClassState(
      classCode: classCode ?? this.classCode,
      isJoinEnabled: isJoinEnabled ?? this.isJoinEnabled,
      dialogType: dialogType ?? this.dialogType,
      verifiedInfo: verifiedInfo ?? this.verifiedInfo,
    );
  }
}
