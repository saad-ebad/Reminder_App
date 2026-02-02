// lib/features/parent_home/viewmodel/parent_home_state.dart
import '../model/parent_home_model.dart';

enum ReminderFilter { all, unread, today, week }

class ParentHomeState {
  final ReminderFilter activeFilter;
  final List<Reminder> reminders;
  final Reminder? selectedReminder;

  const ParentHomeState({
    this.activeFilter = ReminderFilter.all,
    this.reminders = const [],
    this.selectedReminder,
  });

  ParentHomeState copyWith({
    ReminderFilter? activeFilter,
    List<Reminder>? reminders,
    Reminder? selectedReminder,
  }) {
    return ParentHomeState(
      activeFilter: activeFilter ?? this.activeFilter,
      reminders: reminders ?? this.reminders,
      selectedReminder: selectedReminder,
    );
  }
}
