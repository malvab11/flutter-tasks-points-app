import 'package:flutter/material.dart';
import 'package:mission_up/ui/routes/app_routes.dart';
import 'package:mission_up/ui/screens/presentation/presentation_screen.dart';
import 'package:mission_up/ui/viewmodels/main/main_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/login_tutor_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/login_user_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/presentation_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/register_tutor_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PresentationViewmodel()),
        ChangeNotifierProvider(create: (_) => LoginTutorViewmodel()),
        ChangeNotifierProvider(create: (_) => RegisterTutorViewModel()),
        ChangeNotifierProvider(create: (_) => LoginUserViewmodel()),
        ChangeNotifierProvider(create: (_) => MainViewmodel()),
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
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
        ...AppRoutes.routes,
      },
    );
  }
}
