import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reminder_app_parent/features%20/join_success/view/join_success_screen.dart';
import 'package:reminder_app_parent/features%20/mfa/view/mfa_verification_screen.dart';
import 'package:reminder_app_parent/features%20/parent_settings/view/parent_settings_screen.dart';
import 'features /join_class/views/join_class_screen.dart';
import 'features /parent_home/view/parent_home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        fontFamily: 'Inter', // optional (see note below)
      ),
      routes: {
        '/': (_) => const JoinClassScreen(),
        '/mfa-verification': (_) => MfaVerificationScreen(),
        '/join-success': (_) => JoinSuccessScreen(),
        '/parent-home': (_) => ParentHomeScreen(),
        '/parent-settings': (_) => ParentSettingsScreen(),

      },
    );
  }
}
