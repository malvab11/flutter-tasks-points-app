import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mission_up/ui/screens/presentation/first_presentation_screen.dart';
import 'package:mission_up/ui/screens/presentation/second_presentation_screen.dart';
import 'package:mission_up/ui/screens/presentation/third_presentation_screen.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/widgets/common_button.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  int _currentPage = 0;

  void updatePage(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CarrouselPresentations(onPageChanged: updatePage),
              ),
            ),
            CarrouselIconos(currentPage: _currentPage),
            const SizedBox(height: 12),
            const ButtonsSection(),
          ],
        ),
      ),
    );
  }
}

class CarrouselPresentations extends StatefulWidget {
  final Function(int) onPageChanged;
  const CarrouselPresentations({super.key, required this.onPageChanged});

  @override
  State<CarrouselPresentations> createState() => _CarrouselPresentationsState();
}

class _CarrouselPresentationsState extends State<CarrouselPresentations> {
  late final PageController _pageController;
  late final Timer _timer;
  int _currentPresentation = 0;

  final List<Widget> _presentaciones = const [
    FirstPresentationScreen(),
    SecondPresentationScreen(),
    ThirdPresentationScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(const Duration(seconds: 5), (it) {
      _currentPresentation++;
      if (_currentPresentation >= _presentaciones.length) {
        _currentPresentation = 0;
      }
      _pageController.animateToPage(
        _currentPresentation,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: _presentaciones,
      onPageChanged: (index) {
        setState(() {
          _currentPresentation = index;
        });
        widget.onPageChanged(index);
      },
    );
  }
}

class CarrouselIconos extends StatelessWidget {
  final int currentPage;
  const CarrouselIconos({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == currentPage;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.greenColor : AppColors.whiteColor,
          ),
        );
      }),
    );
  }
}

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: AppColors.blackColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          CommonButton(texto: "Soy Tutor", fondo: AppColors.greenColor),
          SizedBox(width: 12),
          CommonButton(texto: "Soy Alumno", fondo: AppColors.grayColor),
        ],
      ),
    );
  }
}
