import 'package:flutter/material.dart';
import 'package:mission_up/ui/screens/home/activities/activities_screen.dart';
import 'package:mission_up/ui/screens/home/init/init_screen.dart';
import 'package:mission_up/ui/screens/home/profile/profile_screen.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/viewmodels/main/main_viewmodel.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _screens = [
    InitScreen(),
    ActivitiesScreen(),
    ProfileScreen(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewmodel>();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _MyButtonNavigationBar(viewModel: viewModel),
        floatingActionButton:
            viewModel.currentScreen == 1
                ? FloatingActionButton(
                  onPressed:
                      () => Navigator.pushNamed(context, '/createActivity'),
                  backgroundColor: AppColors.greenColor,
                  child: Icon(Icons.add, color: AppColors.whiteColor),
                )
                : null,
        body: IndexedStack(index: viewModel.currentScreen, children: _screens),
      ),
    );
  }
}

class _MyButtonNavigationBar extends StatelessWidget {
  final MainViewmodel viewModel;
  const _MyButtonNavigationBar({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.blackColor,
      currentIndex: viewModel.currentScreen,
      onTap: viewModel.changeScreen,
      selectedItemColor: AppColors.coinColor,
      unselectedItemColor: AppColors.whiteColor,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.home_filled),
          ),
          label: "Inicio",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.list),
          ),
          label: "Actividades",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.account_circle_rounded),
          ),
          label: "Perfil",
        ),
      ],
    );
  }
}
