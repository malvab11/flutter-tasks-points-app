import 'dart:async';

import 'package:flutter/material.dart';

class PresentationViewmodel extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  int get currentPage => _currentPage;

  void startCarrousel({required int pages}) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 5), (time) {
      _currentPage = (_currentPage + 1) % pages;
      pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    });
  }

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void disposeValues() {
    _timer?.cancel();
    notifyListeners();
  }
}
