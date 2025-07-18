import 'package:flutter/material.dart';
import 'package:mission_up/di/service_locator.dart';
import 'package:mission_up/ui/routes/app_routes.dart';
import 'package:mission_up/ui/screens/home/activities/activities_screen.dart';
import 'package:mission_up/ui/screens/home/init/init_screen.dart';
import 'package:mission_up/ui/screens/home/profile/profile_screen.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/viewmodels/home/activities_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/home/main_viewmodel.dart';
import 'package:provider/provider.dart';

class MainScreenWrapper extends StatelessWidget {
  const MainScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di<MainViewmodel>(),
      child: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewmodel>();

    if (viewModel.user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<MainViewmodel>().getCurrentUser();
      });
      return const Center(child: CircularProgressIndicator());
    }
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _MyButtonNavigationBar(viewModel: viewModel),
        floatingActionButton:
            viewModel.currentScreen == 1
                ? FloatingActionButton(
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      AppRoutes.createActivity,
                    );
                    if (result == true) {
                      final activityViewModel =
                          context.read<ActivitiesViewModel>();
                      await activityViewModel.getTasksList();
                    }
                  },
                  backgroundColor: AppColors.greenColor,
                  child: Icon(Icons.add, color: AppColors.whiteColor),
                )
                : null,
        body: IndexedStack(
          index: viewModel.currentScreen,
          children: [
            InitScreen(
              user: viewModel.user!.user,
              code: viewModel.user!.familyCode,
            ),
            ActivitiesScreen(uid: viewModel.user!.id),
            ProfileScreen(
              user: viewModel.user!.user,
              email: viewModel.user!.email,
            ),
          ],
        ),
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
