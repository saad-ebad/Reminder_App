// lib/features/reminder_detail/viewmodel/reminder_detail_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'reminder_detail_state.dart';

final reminderDetailViewModelProvider =
StateNotifierProvider<ReminderDetailViewModel, ReminderDetailState>(
      (ref) => ReminderDetailViewModel(),
);

class ReminderDetailViewModel extends StateNotifier<ReminderDetailState> {
  ReminderDetailViewModel() : super(const ReminderDetailState());

  void openOptions() {
    state = state.copyWith(showOptions: true);
  }

  void closeOptions() {
    state = state.copyWith(showOptions: false);
  }

  void openCancelConfirm() {
    state = state.copyWith(showCancelConfirm: true);
  }

  void closeCancelConfirm() {
    state = state.copyWith(showCancelConfirm: false);
  }
}
