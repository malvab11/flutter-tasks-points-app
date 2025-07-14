import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mission_up/di/service_locator.dart';
import 'package:mission_up/firebase_options.dart';
import 'package:mission_up/ui/routes/app_routes.dart';
import 'package:mission_up/ui/screens/presentation/carrousel_screens/presentation_screen.dart';
import 'package:mission_up/ui/viewmodels/presentation/presentation_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mission Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.dark()),
      initialRoute: '/presentation',
      routes: {
        '/presentation':
            (context) => ChangeNotifierProvider(
              create: (_) => di<PresentationViewmodel>(),
              child: const PresentationScreen(),
            ),
        ...AppRoutes.routes,
      },
    );
  }
}
