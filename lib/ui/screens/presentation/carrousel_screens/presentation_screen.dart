import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mission_up/ui/screens/presentation/carrousel_screens/first_presentation_screen.dart';
import 'package:mission_up/ui/screens/presentation/carrousel_screens/second_presentation_screen.dart';
import 'package:mission_up/ui/screens/presentation/carrousel_screens/third_presentation_screen.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/widgets/common_button.dart';
import 'package:mission_up/ui/viewmodels/presentation/presentation_viewmodel.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  late PresentationViewmodel _viewmodel;

  final List<Widget> _pages = const [
    FirstPresentationScreen(),
    SecondPresentationScreen(),
    ThirdPresentationScreen(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewmodel = context.read<PresentationViewmodel>();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewmodel.startCarrousel(pages: _pages.length);
    });
  }

  @override
  void dispose() {
    _viewmodel.disposeValues();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.watch<PresentationViewmodel>();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PageView(
                  controller: viewmodel.pageController,
                  onPageChanged: viewmodel.onPageChanged,
                  children: _pages,
                ),
              ),
            ),
            CarrouselIconos(currentPage: viewmodel.currentPage),
            const SizedBox(height: 12),
            const ButtonsSection(),
          ],
        ),
      ),
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
          width: 12,
          height: 12,
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
        children: [
          Expanded(
            child: CommonButton(
              texto: "Soy Tutor",
              fondo: AppColors.greenColor,
              onPressed: () => Navigator.pushNamed(context, '/loginTutor'),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: CommonButton(
              texto: "Soy Alumno",
              fondo: AppColors.grayColor,
              onPressed: () => Navigator.pushNamed(context, '/loginUser'),
            ),
          ),
        ],
      ),
    );
  }
}
