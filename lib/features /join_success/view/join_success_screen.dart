// lib/features/join_success/view/join_success_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/join_success_model.dart';
import '../viewmodel/join_success_viewmodel.dart';
import '../widgets/join_success_widget.dart';

class JoinSuccessScreen extends ConsumerStatefulWidget {
  const JoinSuccessScreen({super.key});

  @override
  ConsumerState<JoinSuccessScreen> createState() =>
      _JoinSuccessScreenState();
}

class _JoinSuccessScreenState extends ConsumerState<JoinSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> opacity;
  late final Animation<Offset> slide;

  final JoinedClassInfo classInfo = const JoinedClassInfo(
    grade: 'Grade 5A',
    teacher: 'Mrs. Sarah Johnson',
    studentCount: 24,
  );

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    slide = Tween(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 100), controller.forward);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(joinSuccessViewModelProvider);
    final vm = ref.read(joinSuccessViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: FadeTransition(
                opacity: opacity,
                child: SlideTransition(
                  position: slide,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SuccessIcon(),
                      const SizedBox(height: 24),

                      const Text(
                        'Successfully Joined!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "You're now connected to your child's class",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),

                      const SizedBox(height: 24),

                      InfoCard(
                        icon: const Icon(Icons.school,
                            color: Color(0xFF4F46E5), size: 28),
                        content: Column(
                          children: [
                            Text(
                              classInfo.grade,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Class Teacher: ${classInfo.teacher}',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.people, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  '${classInfo.studentCount} students enrolled',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border:
                          Border.all(color: Colors.blue.shade100),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.info, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "You'll receive important announcements and updates from your child's teacher.",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isLoadingHome
                              ? null
                              : () => vm.goToHome(
                                () => Navigator.pushReplacementNamed(
                              context,
                              '/parent-home',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F46E5),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: state.isLoadingHome
                              ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text('Go to Home', style: TextStyle(color: Colors.white),),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          '/enter-class-code',
                        ),
                        child: const Text('Join Another Class'),
                      ),

                      const SizedBox(height: 32),

                      Column(
                        children: const [
                          Text('Need help?',
                              style: TextStyle(fontSize: 12)),
                          SizedBox(height: 4),
                          Text(
                            'Contact School Support',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF4F46E5),
                              fontWeight: FontWeight.w500,
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
        ),
      ),
    );
  }
}
