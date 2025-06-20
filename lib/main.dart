import 'package:flutter/material.dart';
import 'package:mission_up/features/loading/screens/loading_screen.dart';
import 'package:mission_up/features/presentation/screens/presentation_screen.dart';

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
      },
    );
  }
}
