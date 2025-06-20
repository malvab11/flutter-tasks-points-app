import 'package:flutter/material.dart';
import 'package:mission_up/features/loading/domain/loading_usecase.dart';
import 'package:mission_up/features/loading/screens/loading_view_model.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoadingViewModel(LoadingUsecase()),
      child: const _LoadingView(),
    );
  }
}

class _LoadingView extends StatefulWidget {
  const _LoadingView();

  @override
  State<_LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<_LoadingView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;

      final viewModel = context.read<LoadingViewModel>();
      final isLoggedIn = await viewModel.startLoading();

      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        isLoggedIn ? 'home' : 'presentation',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo_app.png'),
              const SizedBox(height: 50),
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
