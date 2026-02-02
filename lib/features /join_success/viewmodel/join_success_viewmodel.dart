// lib/features/join_success/viewmodel/join_success_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'join_success_state.dart';

final joinSuccessViewModelProvider =
StateNotifierProvider<JoinSuccessViewModel, JoinSuccessState>(
      (ref) => JoinSuccessViewModel(),
);

class JoinSuccessViewModel extends StateNotifier<JoinSuccessState> {
  JoinSuccessViewModel() : super(const JoinSuccessState());

  Future<void> goToHome(void Function() navigate) async {
    state = state.copyWith(isLoadingHome: true);
    await Future.delayed(const Duration(milliseconds: 800));
    navigate();
  }
}
