import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            icon,
            color: AppColors.white,
            size: 17,
          ),
        ),
        const Gap(20),
        Expanded(
            child: Text(
          text,
          style: getBodyStyle(),
        ))
      ],
    );
  }
}
