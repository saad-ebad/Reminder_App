// lib/features/parent_settings/viewmodel/parent_settings_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/parent_settings_model.dart';
import 'parent_settings_state.dart';

final parentSettingsViewModelProvider =
StateNotifierProvider<ParentSettingsViewModel, ParentSettingsState>(
      (ref) => ParentSettingsViewModel(),
);

class ParentSettingsViewModel extends StateNotifier<ParentSettingsState> {
  ParentSettingsViewModel()
      : super(
    ParentSettingsState(
      classes: const [
        ParentClass(name: 'Grade 5A', joinedAgo: 'Joined 3 months ago'),
        ParentClass(name: 'Grade 6B', joinedAgo: 'Joined 2 months ago'),
      ],
    ),
  );

  void togglePush(bool value) =>
      state = state.copyWith(pushNotifications: value);

  void toggleSound(bool value) =>
      state = state.copyWith(notificationSound: value);

  void toggleQuietHours(bool value) =>
      state = state.copyWith(quietHoursEnabled: value);

  void openLeaveClass(String className) =>
      state = state.copyWith(showLeaveClass: true, selectedClass: className);

  void closeLeaveClass() =>
      state = state.copyWith(showLeaveClass: false);

  void confirmLeaveClass() {
    state = state.copyWith(
      classes: state.classes
          .where((c) => c.name != state.selectedClass)
          .toList(),
      showLeaveClass: false,
    );
  }

  void openJoinClass() =>
      state = state.copyWith(showJoinClass: true);

  void closeJoinClass() =>
      state = state.copyWith(showJoinClass: false);
}
