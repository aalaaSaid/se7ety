import 'package:flutter/material.dart';
import 'package:se7ety/core/enum/user_type.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/services/local/local_storge.dart';
import 'package:se7ety/features/auth/presentation/pages/doctor_register.dart';
import 'package:se7ety/features/doctor/doctor_nav_bar.dart';
import 'package:se7ety/features/patient/nav_bar.dart';
import 'package:se7ety/features/intro/onboarding/pages/onbording_screen.dart';
import 'package:se7ety/features/intro/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      String? userType =
          AppLocalStorage.getCachedData(key: AppLocalStorage.userType);
      bool isOnboardingShown =
          AppLocalStorage.getCachedData(key: AppLocalStorage.onboarding) ??
              false;
      bool doctorInfo = AppLocalStorage.getCachedData(key: 'doctorInfo')??false;
     if (userType != null) {
        if (userType == UserType.patient.toString()) {
          navigateWithReplacement(context, const PatientNavBar());
        } else {
         navigateWithRemoveUntil(context, DoctorNavBar());
        }
      } else {
        if (isOnboardingShown) {
          navigateWithReplacement(context, const WelcomeScreen());
        } else {
          navigateTo(context, const OnboardingScreen());
        }
      }


     // navigateWithReplacement(context, WelcomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/icons/logo.png',
        width: 250,
        height: 200,
      )),
    );
  }
}
