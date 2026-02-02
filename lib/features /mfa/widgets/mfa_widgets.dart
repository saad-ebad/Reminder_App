// lib/features/mfa/widgets/mfa_widgets.dart
import 'package:flutter/material.dart';

class OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? next;
  final FocusNode? prev;
  final bool hasError;
  final ValueChanged<String> onChanged;

  const OtpBox({
    super.key,
    required this.controller,
    required this.focusNode,
    this.next,
    this.prev,
    required this.hasError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 56,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 2,
              color: hasError ? Colors.red : Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 2, color: Color(0xFF4F46E5)),
          ),
        ),
        onChanged: (v) {
          if (v.isNotEmpty) {
            onChanged(v);
            next?.requestFocus();
          }
        },
        onSubmitted: (_) => next?.requestFocus(),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
