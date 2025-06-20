import 'package:flutter/material.dart';
import 'package:mission_up/features/presentation/screens/presentation_view_model.dart';
import 'package:provider/provider.dart';

class PresentationCarousel extends StatelessWidget {
  const PresentationCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PresentationViewModel(),
      child: const _CarouselView(),
    );
  }
}

class _CarouselView extends StatefulWidget {
  const _CarouselView();

  @override
  State<_CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<_CarouselView> {
  late PresentationViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<PresentationViewModel>();
    _viewModel.startCarrousel();
  }

  @override
  void dispose() {
    _viewModel.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PresentationViewModel>();

    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: viewModel.controller,
            onPageChanged: viewModel.setCurrentIndex,
            children: viewModel.slides,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(viewModel.slides.length, (index) {
            final selected = viewModel.currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: selected ? 12 : 8,
              height: selected ? 12 : 8,
              decoration: BoxDecoration(
                color: selected ? Colors.green : Colors.blueGrey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
