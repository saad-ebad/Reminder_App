// lib/features/parent_home/viewmodel/parent_home_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/parent_home_model.dart';
import 'parent_home_state.dart';

final parentHomeViewModelProvider =
StateNotifierProvider<ParentHomeViewModel, ParentHomeState>(
      (ref) => ParentHomeViewModel(),
);

class ParentHomeViewModel extends StateNotifier<ParentHomeState> {
  ParentHomeViewModel()
      : super(
    ParentHomeState(
      reminders: _seedData,
    ),
  );

  static const _seedData = [
    Reminder(
      id: 1,
      title: 'Parent-Teacher Meeting',
      message:
      'All parents are requested to attend the PTM scheduled for next week...',
      className: 'Grade 5A',
      timeAgo: '2 mins ago',
      priority: ReminderPriority.important,
    ),
    Reminder(
      id: 2,
      title: 'Holiday Announcement',
      message: 'School will remain closed tomorrow due to public holiday.',
      className: 'All Classes',
      timeAgo: '1 hour ago',
      priority: ReminderPriority.notice,
    ),
    Reminder(
      id: 3,
      title: 'Exam Schedule Released',
      message: 'The final exam schedule has been uploaded to the portal.',
      className: 'Grade 5A',
      timeAgo: '3 hours ago',
      priority: ReminderPriority.academic,
    ),
  ];

  void changeFilter(ReminderFilter filter) {
    state = state.copyWith(activeFilter: filter);
  }

  void openReminder(Reminder reminder) {
    final updated = state.reminders.map((r) {
      if (r.id == reminder.id) {
        return Reminder(
          id: r.id,
          title: r.title,
          message: r.message,
          className: r.className,
          timeAgo: r.timeAgo,
          priority: r.priority,
          isUnread: false,
        );
      }
      return r;
    }).toList();

    state = state.copyWith(
      reminders: updated,
      selectedReminder: reminder,
    );
  }

  void closeReminder() {
    state = state.copyWith(selectedReminder: null);
  }
}
