// lib/features/reminder_detail/view/reminder_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../parent_home/model/parent_home_model.dart';
import '../model/reminder_detail_model.dart';
import '../view_model/reminder_detail_viewmodel.dart';
import '../widgets/reminder_detail_widget.dart';

class ReminderDetailScreen extends ConsumerWidget {
  Reminder? reminder;
   ReminderDetailScreen({this.reminder, super.key});
  //
  // final ReminderDetail reminder = const ReminderDetail(
  //   title: 'Parent-Teacher Meeting',
  //   classes: 'Grade 5A, 5B',
  //   scheduledTime: 'Today, 3:00 PM',
  //   message:
  //   'All parents are requested to attend the Parent-Teacher Meeting scheduled for next week.\n\n'
  //       'This is an important session where we will discuss your child\'s academic progress, behavior, and overall development.\n\n'
  //       'Please confirm your attendance by replying to this notification.',
  //   priority: 'High',
  //   category: 'Meeting',
  //   createdBy: 'School Admin',
  // );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reminderDetailViewModelProvider);
    final vm = ref.read(reminderDetailViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Reminder Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: vm.openOptions,
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                      ),
                    ),
                    child:
                    const Icon(Icons.notifications, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminder!.title.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.group,
                                size: 14, color: Color(0xFF4F46E5)),
                            const SizedBox(width: 4),
                            Text(reminder!.className,
                                style: const TextStyle(fontSize: 12)),
                            const SizedBox(width: 8),
                            const Text('•'),
                            const SizedBox(width: 8),
                            const Icon(Icons.access_time,
                                size: 14, color: Color(0xFF4F46E5)),
                            const SizedBox(width: 4),
                            Text(reminder!.timeAgo,
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Message
              SectionCard(
                title: 'Message',
                icon: Icons.message,
                child: Text(
                  reminder!.message,
                  style: const TextStyle(height: 1.5),
                ),
              ),

              const SizedBox(height: 16),

              SectionCard(
                title: 'Delivery Information',
                icon: Icons.send,
                child: Column(
                  children: const [
                    InfoTile(
                      label: 'Status',
                      value: Chip(label: Text('Scheduled')),
                    ),
                    SizedBox(height: 8),
                    InfoTile(
                      label: 'Created',
                      value: Text('Jan 15, 11:30 AM'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Actions
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('Edit Reminder', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: const Color(0xFF4F46E5),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.copy),
                      label: const Text('Duplicate'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: vm.openCancelConfirm,
                      icon: const Icon(Icons.close),
                      label: const Text('Cancel'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (state.showCancelConfirm)
            _CancelConfirm(
              onCancel: vm.closeCancelConfirm,
              onConfirm: () {
                vm.closeCancelConfirm();
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}


class _CancelConfirm extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const _CancelConfirm({
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCancel,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: AnimatedScale(
            scale: 1,
            duration: const Duration(milliseconds: 200),
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning,
                      color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  const Text(
                    'Cancel Reminder?',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This reminder will not be sent to parents.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Yes, Cancel Reminder'),
                  ),
                  TextButton(
                    onPressed: onCancel,
                    child: const Text('Keep Reminder'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

