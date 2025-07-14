import 'package:flutter/material.dart';
import 'package:mission_up/di/service_locator.dart';
import 'package:mission_up/domain/entity/task_type_entity.dart';
import 'package:mission_up/ui/screens/home/activities/activities_screen.dart';
import 'package:mission_up/ui/screens/home/activities/create_activity_screen.dart';
import 'package:mission_up/ui/screens/home/main_screen.dart';
import 'package:mission_up/ui/screens/presentation/loading/loading_screen.dart';
import 'package:mission_up/ui/screens/presentation/login/login_tutor_screen.dart';
import 'package:mission_up/ui/screens/presentation/login/login_user_screen.dart';
import 'package:mission_up/ui/screens/presentation/register/register_tutor_screen.dart';
import 'package:mission_up/ui/viewmodels/home/main_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/home/activities_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/login_tutor_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/login_user_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/register_tutor_viewmodel.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static const String loginTutor = '/loginTutor';
  static const String registerTutor = '/registerTutor';
  static const String loginUser = '/loginUser';
  static const String loading = '/loading';
  static const String home = '/home';
  static const String activities = '/activities';
  static const String createActivity = '/createActivity';

  static Map<String, WidgetBuilder> get routes => {
    loginTutor:
        (context) => ChangeNotifierProvider(
          create: (_) => di<LoginTutorViewmodel>(),
          child: const LoginTutorScreen(),
        ),
    registerTutor:
        (context) => ChangeNotifierProvider(
          create: (_) => di<RegisterTutorViewModel>(),
          child: const RegisterTutorScreen(),
        ),
    loginUser:
        (context) => ChangeNotifierProvider(
          create: (_) => di<LoginUserViewmodel>(),
          child: const LoginUserScreen(),
        ),
    loading: (context) => const LoadingScreen(),
    home:
        (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => di<MainViewmodel>()),
            ChangeNotifierProvider(create: (_) => di<ActivitiesViewModel>()),
          ],
          child: const MainScreenWrapper(),
        ),
    activities: (context) => const ActivitiesScreen(),

    createActivity: (context) {
      final args = ModalRoute.of(context)!.settings.arguments;
      return CreateActivityScreen(activity: args as TaskTypeEntity?);
    },
  };
}
