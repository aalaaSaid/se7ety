import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety/features/doctor/appointments/presentation/pages/doctor_appointments_screen.dart';
import 'package:se7ety/features/doctor/profile/presentation/pages/doctor_profile_screen.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/text_style.dart';

class DoctorNavBar extends StatefulWidget {
  const DoctorNavBar({super.key});

  @override
  State<DoctorNavBar> createState() => _DoctorNavBarState();
}

class _DoctorNavBarState extends State<DoctorNavBar> {
  List<Widget>screens =[
    const DoctorAppointmentsScreen(),
    const DoctorProfileScreen(),

  ];
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.2),
            ),
          ],
        ),
        child: GNav(
          curve: Curves.easeOutExpo,
          rippleColor: Colors.grey,
          hoverColor: Colors.grey,
          haptic: true,
          tabBorderRadius: 20,
          gap: 5,
          activeColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.primaryColor,
          textStyle: getBodyStyle(color: AppColors.white),
          tabs: const [
            GButton(
              icon: Icons.calendar_month,
              text: 'المواعيد',
              iconSize: 28,
            ),
            GButton(
              icon: Icons.person,
              text: 'الحساب',
              iconSize: 28,
            )
          ],
          selectedIndex: selectIndex,
          onTabChange: (value) {
            setState(() {
              selectIndex = value;
            });
          },
        ),
      ),
    );
  }
}
