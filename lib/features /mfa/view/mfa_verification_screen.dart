import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reminder_app_parent/features%20/join_success/view/join_success_screen.dart';
import '../viewmodel/mfa_view_model.dart';
import '../viewmodel/mfa_state.dart';
import '../widgets/mfa_widgets.dart';

class MfaVerificationScreen extends ConsumerStatefulWidget {
  const MfaVerificationScreen({super.key});

  @override
  ConsumerState<MfaVerificationScreen> createState() => _MfaVerificationScreenState();
}

class _MfaVerificationScreenState extends ConsumerState<MfaVerificationScreen> {
  late final List<TextEditingController> controllers;
  late final List<FocusNode> nodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (_) => TextEditingController());
    nodes = List.generate(6, (_) => FocusNode());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in controllers) c.dispose();
    for (final n in nodes) n.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mfaViewModelProvider);
    final vm = ref.read(mfaViewModelProvider.notifier);

    ref.listen<MfaState>(mfaViewModelProvider, (prev, next) {
      if (next.status == MfaStatus.success) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => _SuccessDialog(
            onContinue: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/parent-home');
            },
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Verification', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shield, size: 64, color: Color(0xFF4F46E5)),
                const SizedBox(height: 24),
                const Text(
                  'Enter Verification Code',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  "We've sent a 6-digit code to your phone ending in ***-1234",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: OtpBox(
                        controller: controllers[i],
                        focusNode: nodes[i],
                        next: i < 5 ? nodes[i + 1] : null,
                        prev: i > 0 ? nodes[i - 1] : null,
                        hasError: state.status == MfaStatus.error,
                        onChanged: (v) => vm.updateDigit(i, v),
                      ),
                    );
                  }),
                ),

                if (state.status == MfaStatus.error) ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Invalid verification code. Please try again.',
                    style: TextStyle(color: Colors.red),
                  ),
                ],

                const SizedBox(height: 24),

                TextButton(
                  onPressed: state.canResend ? vm.startTimer : null,
                  child: state.canResend
                      ? const Text('Resend Code')
                      : Text('Resend Code (${state.resendSeconds}s)'),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: /*state.canVerify && state.status != MfaStatus.verifying
                        ? vm.verifyCode
                        : null,*/(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> JoinSuccessScreen()));
                    }
                    ,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF4F46E5),
                    ),
                    child: state.status == MfaStatus.verifying
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Verify Code', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  final VoidCallback onContinue;
  const _SuccessDialog({required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Verification Successful!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "You've successfully joined Grade 5A.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onContinue,
                child: const Text('Go to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
