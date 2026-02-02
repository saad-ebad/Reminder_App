import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  static const primary = Color(0xFF4F46E5);
  static const secondary = Color(0xFF7C3AED);
  static const accent = Color(0xFFEC4899);

  static const bg = Color(0xFFF9FAFB); // gray-50
  static const text800 = Color(0xFF1F2937); // gray-800
  static const text700 = Color(0xFF374151); // gray-700
  static const text600 = Color(0xFF4B5563); // gray-600
  static const text500 = Color(0xFF6B7280); // gray-500
  static const border200 = Color(0xFFE5E7EB); // gray-200
  static const border300 = Color(0xFFD1D5DB); // gray-300
}

class GradientIconCircle extends StatelessWidget {
  final IconData icon;
  final double size;
  const GradientIconCircle({super.key, required this.icon, this.size = 96});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            offset: Offset(0, 8),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: Center(
        child: Icon(icon, color: Colors.white, size: size * 0.42),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // rounded-2xl feel
          ),
          elevation: enabled ? 2 : 0,
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}

class LabeledTextField extends StatelessWidget {
  final String label;
  final String helper;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final List<TextInputFormatter>? inputFormatters; // 👈 ADD

  const LabeledTextField({
    super.key,
    required this.label,
    required this.helper,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.text700,
            )),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          textAlign: TextAlign.center,
          textCapitalization: TextCapitalization.characters,
          maxLength: 8, // HTML maxlength="8"
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 2, // tracking-wider vibe
          ),
          decoration: InputDecoration(
            counterText: '',
            hintText: 'e.g., CLS-4829',
            hintStyle: TextStyle(
              color: AppColors.text500.withOpacity(0.8),
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppColors.border300, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text(
            helper,
            style: const TextStyle(fontSize: 12, color: AppColors.text500),
          ),
        ),
      ],
    );
  }
}

class HelpCard extends StatelessWidget {
  final String title;
  final String body;
  const HelpCard({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // blue-50
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDBEAFE)), // blue-100
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFDBEAFE),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.info, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: AppColors.text600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BenefitRow extends StatelessWidget {
  final Color bg;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String desc;

  const BenefitRow({
    super.key,
    required this.bg,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text800,
                  )),
              const SizedBox(height: 2),
              Text(desc,
                  style: const TextStyle(fontSize: 12, color: AppColors.text600)),
            ],
          ),
        ),
      ],
    );
  }
}

/// A reusable modal that matches the HTML: dark overlay + white rounded card + scale-in.
class AppScaleDialog extends StatefulWidget {
  final Widget child;
  const AppScaleDialog({super.key, required this.child});

  static Future<T?> show<T>(BuildContext context, Widget child) {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => AppScaleDialog(child: child),
    );
  }

  @override
  State<AppScaleDialog> createState() => _AppScaleDialogState();
}

class _AppScaleDialogState extends State<AppScaleDialog> {
  double _scale = 0.95;

  @override
  void initState() {
    super.initState();
    // mimic HTML setTimeout(...) scale-95 -> scale-100
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _scale = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 384), // max-w-sm
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24), // rounded-3xl
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
