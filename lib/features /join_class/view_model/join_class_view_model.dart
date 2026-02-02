import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/join_classs_model.dart';
import 'join_class_state.dart';

final joinClassViewModelProvider =
StateNotifierProvider<JoinClassViewModel, JoinClassState>(
      (ref) => JoinClassViewModel(),
);

class JoinClassViewModel extends StateNotifier<JoinClassState> {
  JoinClassViewModel() : super(const JoinClassState());

  static const _validCodes = {'CLS-4829', 'CLS-5678'};

  void onCodeChanged(String raw) {
    final value = raw.trim().toUpperCase();

    final enabled = value.length == 8; // CLS-XXXX = 8 chars
    state = state.copyWith(
      classCode: value,
      isJoinEnabled: enabled,
    );
  }


  void submit() {
    if (!state.isJoinEnabled) return; // ⛔ hard guard

    final code = state.classCode.trim().toUpperCase();

    if (_validCodes.contains(code)) {
      state = state.copyWith(
        dialogType: JoinClassDialogType.success,
        verifiedInfo: const VerifiedClassInfo(
          grade: 'Grade 5A',
          school: 'Springfield Elementary',
        ),
      );
    } else {
      state = state.copyWith(dialogType: JoinClassDialogType.error);
    }
  }


  void closeDialog({bool clearInput = false}) {
    state = state.copyWith(
      dialogType: JoinClassDialogType.none,
      verifiedInfo: null,
      classCode: clearInput ? '' : state.classCode,
      isJoinEnabled: clearInput ? false : state.isJoinEnabled,
    );
  }
}
