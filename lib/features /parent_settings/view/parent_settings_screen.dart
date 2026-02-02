// lib/features/parent_settings/view/parent_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/parent_settings_viewmodel.dart';
import '../widgets/parent_settings_widgets.dart';

class ParentSettingsScreen extends ConsumerWidget {
  const ParentSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(parentSettingsViewModelProvider);
    final vm = ref.read(parentSettingsViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SettingsSection(
                title: 'Notifications',
                icon: Icons.notifications,
                child: Column(
                  children: [
                    SettingsSwitch(
                      title: 'Push Notifications',
                      subtitle: 'Receive notifications on this device',
                      value: state.pushNotifications,
                      activeColor: const Color(0xFF4F46E5),
                      onChanged: vm.togglePush,
                    ),
                    const SizedBox(height: 12),
                    SettingsSwitch(
                      title: 'Sound',
                      subtitle: 'Play sound with notifications',
                      value: state.notificationSound,
                      activeColor: const Color(0xFF4F46E5),
                      onChanged: vm.toggleSound,
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 16),

              SettingsSection(
                title: 'Notifications',
                icon: Icons.notifications,
                child: Column(
                  children: [
                    SettingsSwitch(
                      title: 'Push Notifications',
                      subtitle: 'Receive notifications on this device',
                      value: state.pushNotifications,
                      activeColor: const Color(0xFF4F46E5),
                      onChanged: vm.togglePush,
                    ),
                    const SizedBox(height: 12),
                    SettingsSwitch(
                      title: 'Sound',
                      subtitle: 'Play sound with notifications',
                      value: state.notificationSound,
                      activeColor: const Color(0xFF4F46E5),
                      onChanged: vm.toggleSound,
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 16),

              SettingsSection(
                title: 'Notifications',
                icon: Icons.notifications,
                child: Column(
                  children: [
                    SettingsSwitch(
                      title: 'Push Notifications',
                      subtitle: 'Receive notifications on this device',
                      value: state.pushNotifications,
                      activeColor: const Color(0xFF4F46E5),
                      onChanged: vm.togglePush,
                    ),
                    const SizedBox(height: 12),
                    SettingsSwitch(
                      title: 'Sound',
                      subtitle: 'Play sound with notifications',
                      value: state.notificationSound,
                      activeColor: const Color(0xFF4F46E5),
                      onChanged: vm.toggleSound,
                    ),
                  ],
                ),
              ),

            ],
          ),

          if (state.showLeaveClass)
            _LeaveClassModal(
              className: state.selectedClass ?? '',
              onCancel: vm.closeLeaveClass,
              onConfirm: vm.confirmLeaveClass,
            ),
        ],
      ),
    );
  }
}


class _LeaveClassModal extends StatelessWidget {
  final String className;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const _LeaveClassModal({
    required this.className,
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
                  Text('Leave $className?',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text(
                    'You will stop receiving notifications from this class.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onCancel,
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onConfirm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Leave Class'),
                        ),
                      ),
                    ],
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

