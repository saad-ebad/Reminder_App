// lib/features/join_success/widgets/join_success_widgets.dart
import 'package:flutter/material.dart';

class SuccessIcon extends StatefulWidget {
  const SuccessIcon({super.key});

  @override
  State<SuccessIcon> createState() => _SuccessIconState();
}

class _SuccessIconState extends State<SuccessIcon> {
  double scale = 1;

  void animate() {
    setState(() => scale = 1.2);
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => scale = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: animate,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 32),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final Widget icon;
  final Widget content;

  const InfoCard({super.key, required this.icon, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          icon,
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }
}
