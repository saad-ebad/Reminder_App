import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/join_class_state.dart';
import '../view_model/join_class_view_model.dart';
import '../widgets/join_class_widget.dart';

class JoinClassScreen extends ConsumerStatefulWidget {
  const JoinClassScreen({super.key});

  @override
  ConsumerState<JoinClassScreen> createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends ConsumerState<JoinClassScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _syncControllerText(String newText) {
    if (_controller.text == newText) return;
    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(joinClassViewModelProvider);
    final vm = ref.read(joinClassViewModelProvider.notifier);

    // Keep controller in sync with state when we clear input on modal close
    _syncControllerText(state.classCode);

    // Show dialogs based on state changes
    ref.listen<JoinClassState>(joinClassViewModelProvider, (prev, next) {
      if (prev?.dialogType == next.dialogType) return;

      if (next.dialogType == JoinClassDialogType.error) {
        AppScaleDialog.show<void>(
          context,
          _ErrorDialog(
            onTryAgain: () {
              Navigator.of(context).pop();
              vm.closeDialog(clearInput: true);
              _focusNode.requestFocus();
            },
          ),
        );
      }

      if (next.dialogType == JoinClassDialogType.success) {
        final info = next.verifiedInfo;
        AppScaleDialog.show<void>(
          context,
          _SuccessDialog(
            grade: info?.grade ?? '',
            school: info?.school ?? '',
            onContinue: () {
              Navigator.of(context).pop();
              vm.closeDialog();
              Navigator.of(context).pushNamed('/mfa-verification');
            },
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Join Class',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.text800,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text700),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border200),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 700 ? 24.0 : 16.0;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16,
                  horizontalPadding,
                  24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // HERO (centered like HTML)
                        const SizedBox(height: 8),
                        Column(
                          children: const [
                            SizedBox(height: 8),
                            GradientIconCircle(icon: Icons.school),
                            SizedBox(height: 24),
                            Text(
                              'Enter Class Code',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppColors.text800,
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "Enter the code provided by your school to join your child's class",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.text600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Form container width like max-w-sm
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 384),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                LabeledTextField(
                                  label: 'Class Code',
                                  helper: 'Code format: CLS-XXXX',
                                  controller: _controller,
                                  focusNode: _focusNode,
                                  onChanged: (val) => vm.onCodeChanged(val),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow( RegExp(r'[A-Za-z0-9-]')),
                                    LengthLimitingTextInputFormatter(8),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Press Enter to submit (like HTML keypress)
                                Shortcuts(
                                  shortcuts: const {
                                    SingleActivator(LogicalKeyboardKey.enter):
                                    ActivateIntent(),
                                  },
                                  child: Actions(
                                    actions: {
                                      ActivateIntent: CallbackAction<Intent>(
                                        onInvoke: (_) {
                                          if (state.isJoinEnabled) vm.submit();
                                          return null;
                                        },
                                      ),
                                    },
                                    child: Focus(
                                      autofocus: true,
                                      child: PrimaryButton(
                                        text: 'Join Class',
                                        enabled: state.isJoinEnabled,
                                        onPressed: vm.submit,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Help card
                        const HelpCard(
                          title: 'Need Help?',
                          body:
                          "If you don't have a class code, please contact your school administration or your child's teacher to get one.",
                        ),

                        const SizedBox(height: 24),

                        // Benefits
                        const Text(
                          "What you'll get:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const BenefitRow(
                          bg: Color(0xFFD1FAE5), // green-100
                          icon: Icons.notifications,
                          iconColor: Color(0xFF16A34A), // green-600-ish
                          title: 'Instant Notifications',
                          desc:
                          'Receive important updates from school directly on your phone',
                        ),
                        const SizedBox(height: 12),
                        const BenefitRow(
                          bg: Color(0xFFEDE9FE), // purple-100
                          icon: Icons.event_available,
                          iconColor: Color(0xFF7C3AED),
                          title: 'Never Miss Events',
                          desc:
                          'Stay informed about meetings, holidays, and special events',
                        ),
                        const SizedBox(height: 12),
                        const BenefitRow(
                          bg: Color(0xFFFCE7F3), // pink-100
                          icon: Icons.verified_user,
                          iconColor: Color(0xFFEC4899),
                          title: 'Secure & Private',
                          desc:
                          'Your information is protected and only used for school communication',
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ErrorDialog extends StatelessWidget {
  final VoidCallback onTryAgain;
  const _ErrorDialog({required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Color(0xFFFEE2E2), // red-100
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.error, color: Color(0xFFEF4444), size: 32),
        ),
        const SizedBox(height: 16),
        const Text(
          'Invalid Class Code',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.text800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          "The code you entered doesn't match any class. Please check and try again.",
          style: TextStyle(fontSize: 14, color: AppColors.text600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onTryAgain,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  final String grade;
  final String school;
  final VoidCallback onContinue;

  const _SuccessDialog({
    required this.grade,
    required this.school,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Color(0xFFD1FAE5), // green-100
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle,
              color: Color(0xFF22C55E), size: 32),
        ),
        const SizedBox(height: 16),
        const Text(
          'Code Verified!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.text800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          "You're joining:",
          style: TextStyle(fontSize: 14, color: AppColors.text600),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                grade,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                school,
                style: const TextStyle(fontSize: 12, color: AppColors.text500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "We'll send a verification code to your phone number to complete the setup.",
          style: TextStyle(fontSize: 14, color: AppColors.text600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onContinue,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
