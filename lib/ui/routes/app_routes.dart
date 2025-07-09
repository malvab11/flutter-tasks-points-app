import 'package:flutter/material.dart';
import 'package:mission_up/ui/screens/home/activities/activities_screen.dart';
import 'package:mission_up/ui/screens/home/activities/create_activity_screen.dart';
import 'package:mission_up/ui/screens/home/main_screen.dart';
import 'package:mission_up/ui/screens/loading/loading_screen.dart';
import 'package:mission_up/ui/screens/login/login_tutor_screen.dart';
import 'package:mission_up/ui/screens/login/login_user_screen.dart';
import 'package:mission_up/ui/screens/register/register_tutor_screen.dart';

class AppRoutes {
  static const String loginTutor = '/loginTutor';
  static const String registerTutor = '/registerTutor';
  static const String loginUser = '/loginUser';
  static const String loading = '/loading';
  static const String home = '/home';
  static const String activities = '/activities';
  static const String createActivity = '/createActivity';

  static Map<String, WidgetBuilder> get routes => {
    loginTutor: (context) => const LoginTutorScreen(),
    registerTutor: (context) => const RegisterTutorScreen(),
    loginUser: (context) => const LoginUserScreen(),
    loading: (context) => const LoadingScreen(),
    home: (context) => MainScreen(),
    activities: (context) => const ActivitiesScreen(),
    createActivity: (context) => const CreateActivityScreen(),
  };
}
