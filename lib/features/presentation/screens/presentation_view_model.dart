import 'package:flutter/material.dart';
import 'package:mission_up/features/presentation/widgets/primera_presentacion.dart';
import 'package:mission_up/features/presentation/widgets/segunda_presentacion.dart';
import 'package:mission_up/features/presentation/widgets/tercera_presentacion.dart';

class PresentationViewModel extends ChangeNotifier {
  final PageController controller = PageController();
  int currentIndex = 0;

  final List<Widget> slides = const [FirstSlide(), SecondSlide(), ThirdSlide()];

  bool _isDisposed = false;

  void startCarrousel() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 5));
      if (_isDisposed || !controller.hasClients) return false;

      final nextPage = (currentIndex + 1) % slides.length;
      controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      setCurrentIndex(nextPage);
      return true;
    });
  }

  void setCurrentIndex(int index) {
    if (_isDisposed) return;
    currentIndex = index;
    notifyListeners();
  }

  void disposeController() {
    _isDisposed = true;
    controller.dispose();
    super.dispose();
  }
}
