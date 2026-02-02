// lib/features/reminder_detail/model/reminder_detail_model.dart
class ReminderDetail {
  final String title;
  final String classes;
  final String scheduledTime;
  final String message;
  final String priority;
  final String category;
  final String createdBy;

  const ReminderDetail({
    required this.title,
    required this.classes,
    required this.scheduledTime,
    required this.message,
    required this.priority,
    required this.category,
    required this.createdBy,
  });
}
