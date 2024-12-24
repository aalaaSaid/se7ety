import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/colors.dart';
import '../utils/text_style.dart';

showAlertDialg(BuildContext context,
    {required String title, required void Function()? onTapOK,
    required String ok , required String no ,required void Function()? onTapNo,
    }) {
  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.accentColor,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    title,
                    style: getTitleStyle(color: AppColors.black),
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: onTapOK,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.accentColor),
                          child: Text(
                            ok,
                            style: getBodyStyle(color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:onTapNo,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.accentColor),
                          child: Text(no,
                            style: getBodyStyle(color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
