import 'package:flutter/material.dart';
import 'package:mission_up/shared/widgets/common_text.dart';
import 'package:mission_up/shared/widgets/common_user_card.dart';

class ThirdSlide extends StatelessWidget {
  const ThirdSlide();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CommonText(
            text: 'Supervisa a todos desde tu celular',
            fontSize: 35,
            fontWeight: FontWeight.bold,
            maxLines: 2,
          ),
          const SizedBox(height: 50),
          ...[
            ('Marlon', true, 2),
            ('Paolo', false, 3),
            ('Kiara', false, 1),
            ('Pedro', false, 5),
          ].map(
            (e) => CommonUserCard(name: e.$1, selected: e.$2, points: e.$3),
          ),
        ],
      ),
    );
  }
}
