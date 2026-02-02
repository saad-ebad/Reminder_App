// lib/features/reminder_detail/viewmodel/reminder_detail_state.dart
class ReminderDetailState {
  final bool showOptions;
  final bool showCancelConfirm;

  const ReminderDetailState({
    this.showOptions = false,
    this.showCancelConfirm = false,
  });

  ReminderDetailState copyWith({
    bool? showOptions,
    bool? showCancelConfirm,
  }) {
    return ReminderDetailState(
      showOptions: showOptions ?? this.showOptions,
      showCancelConfirm: showCancelConfirm ?? this.showCancelConfirm,
    );
  }
}
