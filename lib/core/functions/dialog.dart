import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/colors.dart';

showErrorDialog(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.redColor,
    content: Text(text),
  ));
}

showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/icons/loading.json',
            width: 200,
            height: 200,
          ),
        ],
      ));
}

showSuccessDialog(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.primaryColor,
    content: Text(text),
  ));
}