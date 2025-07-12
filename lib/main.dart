import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mission_up/domain/usecases/auth/login_with_code_usecase.dart';
import 'package:provider/provider.dart';

import 'package:mission_up/firebase_options.dart';
import 'package:mission_up/ui/routes/app_routes.dart';
import 'package:mission_up/ui/screens/presentation/presentation_screen.dart';

// Viewmodels
import 'package:mission_up/ui/viewmodels/main/main_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/presentation_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/login_user_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/register_tutor_viewmodel.dart';

// Data y dominio
import 'package:mission_up/data/datasources/auth/auth_datasource_impl.dart';
import 'package:mission_up/data/repositories/auth_repositoryImpl.dart';
import 'package:mission_up/domain/usecases/auth/register_with_email_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authDatasource = AuthDatasourceImpl();
  final authRepository = AuthRepositoryImpl(authDatasource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PresentationViewmodel()),
        ChangeNotifierProvider(
          create:
              (_) => RegisterTutorViewModel(
                RegisterWithEmailUseCase(authRepository),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (_) => LoginUserViewmodel(LoginWithCodeUsecase(authRepository)),
        ),
        ChangeNotifierProvider(create: (_) => MainViewmodel()),
      ],
      child: const MyApp(),
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
