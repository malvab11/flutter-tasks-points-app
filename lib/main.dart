import 'package:flutter/material.dart';
import 'package:mission_up/features/loading/screens/loading_screen.dart';
import 'package:mission_up/features/login/screens/login_screen.dart';
import 'package:mission_up/features/presentation/screens/presentation_screen.dart';
import 'package:mission_up/features/register_tutor/screens/register_tutor_screen.dart';
import 'package:mission_up/features/register_user/screens/register_user_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mission Up',
      debugShowCheckedModeBanner: false,
      initialRoute: 'loading',
      routes: {
        'loading': (context) => const LoadingScreen(),
        'presentation': (context) => const PresentationScreen(),
        'login': (context) => const LoginScreen(),
        'registerTutor': (context) => const RegisterTutorScreen(),
        'registerUser': (context) => const RegisterUserScreen(),
      },
    );
  }
}
