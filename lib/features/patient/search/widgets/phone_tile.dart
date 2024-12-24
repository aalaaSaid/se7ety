import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
class PhoneTile extends StatelessWidget {
  const PhoneTile({super.key, required this.backColor, required this.onTap, required this.num, required this.imgAssetPath});
  final Color backColor ;
  final Function() onTap ;
  final String num ;
  final IconData imgAssetPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(num),
            Icon(
              imgAssetPath,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
