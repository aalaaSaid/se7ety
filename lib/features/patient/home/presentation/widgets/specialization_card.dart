import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/features/patient/home/data/specliation_model.dart';
import 'package:se7ety/features/patient/home/presentation/pages/speciliation_screen.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/item_speclization.dart';

class SpecializationCard extends StatelessWidget {
  const SpecializationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const Gap(10);
        },
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: specializationModel.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigateTo(
                  context,
                  SpeciliationScreen(
                      specilization:
                          specializationModel[index].specialization!));
            },
            child: ItemSpeclization(
                specilization: specializationModel[index].specialization,
                dark: specializationModel[index].background,
                light: specializationModel[index].circle),
          );
        },
      ),
    );
  }
}
