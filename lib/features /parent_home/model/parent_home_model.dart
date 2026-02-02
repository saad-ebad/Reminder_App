// lib/features/parent_home/model/reminder_model.dart
enum ReminderPriority { important, notice, academic, financial, event, policy }

class Reminder {
  final int id;
  final String title;
  final String message;
  final String className;
  final String timeAgo;
  final ReminderPriority priority;
  final bool isUnread;

  const Reminder({
    required this.id,
    required this.title,
    required this.message,
    required this.className,
    required this.timeAgo,
    required this.priority,
    this.isUnread = true,
  });
}
