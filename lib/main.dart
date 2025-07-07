import 'package:flutter/material.dart';
import 'package:mission_up/ui/screens/loading/loading_screen.dart';
import 'package:mission_up/ui/screens/login/login_tutor_screen.dart';
import 'package:mission_up/ui/screens/login/login_user_screen.dart';
import 'package:mission_up/ui/screens/presentation/presentation_screen.dart';
import 'package:mission_up/ui/screens/register/register_tutor_screen.dart';
import 'package:mission_up/ui/viewmodels/login_tutor_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/login_user_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/register_tutor_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PresentationViewmodel()),
        ChangeNotifierProvider(create: (_) => LoginTutorViewmodel()),
        ChangeNotifierProvider(create: (_) => RegisterTutorViewModel()),
        ChangeNotifierProvider(create: (_) => LoginUserViewmodel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mission Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.dark()),
      routes: {
        '/loginTutor': (context) => LoginTutorScreen(),
        '/registerTutor': (context) => RegisterTutorScreen(),
        '/loginUser': (context) => LoginUserScreen(),
        '/loading': (context) => LoadingScreen(),
      },
      home: PresentationScreen(),
    );
  }
}
