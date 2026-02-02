// lib/features/parent_home/widgets/reminder_widgets.dart
import 'package:flutter/material.dart';
import '../model/parent_home_model.dart';

Color priorityColor(ReminderPriority p) {
  switch (p) {
    case ReminderPriority.important:
      return Colors.red;
    case ReminderPriority.notice:
      return Colors.orange;
    case ReminderPriority.academic:
      return Colors.green;
    default:
      return Colors.grey;
  }
}

class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onTap;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = priorityColor(reminder.priority);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: reminder.isUnread ? Colors.white : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(
              color: reminder.isUnread ? color : Colors.grey.shade300,
              width: 4,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (reminder.isUnread)
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(right: 8, top: 6),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                Expanded(
                  child: Text(
                    reminder.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: reminder.isUnread
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
                Text(
                  reminder.timeAgo,
                  style: TextStyle(
                    fontSize: 11,
                    color: reminder.isUnread
                        ? Colors.grey
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              reminder.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: reminder.isUnread
                    ? Colors.grey.shade700
                    : Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(reminder.className),
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  reminder.priority.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
