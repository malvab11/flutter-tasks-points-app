import 'package:flutter/material.dart';
import 'package:mission_up/features/presentation/widgets/carrousel.dart';
import 'package:mission_up/features/presentation/widgets/footer.dart';

class PresentationScreen extends StatelessWidget {
  const PresentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(child: PresentationCarousel()),
            PresentationFooter(
              onTutorTap: () => Navigator.pushNamed(context, 'login'),
              onUserTap: () => Navigator.pushNamed(context, 'registerUser'),
            ),
          ],
        ),
      ),
    );
  }
}
