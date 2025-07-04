import 'package:flutter/material.dart';
import 'package:mission_up/core/constants/activities_constants.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';
import 'package:mission_up/ui/widgets/common_button.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CarrouselPresentaciones(),
              ),
            ),
            const CarrouselIconos(),
            const SizedBox(height: 12),
            const ButtonsSection(),
          ],
        ),
      ),
    );
  }
}

class CarrouselPresentaciones extends StatelessWidget {
  const CarrouselPresentaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [PrimeraPresentacion()],
    );
  }
}

class PrimeraPresentacion extends StatelessWidget {
  const PrimeraPresentacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Pequeñas tareas, grandes hábitos",
          style: TextStyles.title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activitiesConstants.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CommonActivityCard(activities: activitiesConstants[index]),
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class CarrouselIconos extends StatelessWidget {
  const CarrouselIconos({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greenColor,
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteColor,
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: AppColors.blackColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonButton(texto: "Soy Tutor", fondo: AppColors.greenColor),
          SizedBox(width: 12),
          CommonButton(texto: "Soy Alumno", fondo: AppColors.grayColor),
        ],
      ),
    );
  }
}
