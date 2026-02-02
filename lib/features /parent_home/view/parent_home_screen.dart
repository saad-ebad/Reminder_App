// lib/features/parent_home/view/parent_home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reminder_app_parent/features%20/reminder_detail/view/reminder_detail_screen.dart';
import '../view_model/parent_home_state.dart';
import '../view_model/parent_home_view_model.dart';
import '../widgets/parent_home_widget.dart';

class ParentHomeScreen extends ConsumerWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(parentHomeViewModelProvider);
    final vm = ref.read(parentHomeViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('School Reminders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/parent-settings');

            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _HeaderCard(),
              const SizedBox(height: 16),

              // Filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ReminderFilter.values.map((f) {
                    final selected = state.activeFilter == f;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        selected: selected,
                        label: Text(f.name.toUpperCase()),
                        onSelected: (_) => vm.changeFilter(f),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // Reminders
              ...state.reminders.map(
                    (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ReminderCard(
                    reminder: r,
                    onTap: () {
                      vm.openReminder(r);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (_) => ReminderDetailScreen(reminder: r,),
                      ).then((_) => vm.closeReminder());
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome back!',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("Sarah's Parent",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          Column(
            children: [
              Text('8',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              Text('New reminders',
                  style: TextStyle(color: Colors.white70, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}


