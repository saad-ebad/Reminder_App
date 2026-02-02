// lib/features/parent_settings/viewmodel/parent_settings_state.dart
import '../model/parent_settings_model.dart';

class ParentSettingsState {
  final bool pushNotifications;
  final bool notificationSound;
  final bool quietHoursEnabled;
  final bool showLeaveClass;
  final bool showJoinClass;
  final String? selectedClass;
  final List<ParentClass> classes;

  const ParentSettingsState({
    this.pushNotifications = true,
    this.notificationSound = true,
    this.quietHoursEnabled = false,
    this.showLeaveClass = false,
    this.showJoinClass = false,
    this.selectedClass,
    this.classes = const [],
  });

  ParentSettingsState copyWith({
    bool? pushNotifications,
    bool? notificationSound,
    bool? quietHoursEnabled,
    bool? showLeaveClass,
    bool? showJoinClass,
    String? selectedClass,
    List<ParentClass>? classes,
  }) {
    return ParentSettingsState(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      notificationSound: notificationSound ?? this.notificationSound,
      quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
      showLeaveClass: showLeaveClass ?? this.showLeaveClass,
      showJoinClass: showJoinClass ?? this.showJoinClass,
      selectedClass: selectedClass,
      classes: classes ?? this.classes,
    );
  }
}
