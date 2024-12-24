import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety/features/patient/appointments/presentation/pages/appointments_screen.dart';
import 'package:se7ety/features/patient/profile/presentation/pages/profile_screen.dart';
import 'package:se7ety/features/patient/search/page/search_screen.dart';
import 'home/presentation/pages/home_screen.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/text_style.dart';

class PatientNavBar extends StatefulWidget {
  const PatientNavBar({super.key});

  @override
  State<PatientNavBar> createState() => _PatientNavBarState();
}

class _PatientNavBarState extends State<PatientNavBar> {
  List<Widget>screens =[
    const HomeScreen(),
    const SearchScreen(),
    const AppointmentsScreen(),
    const ProfileScreen(),
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
              icon: Icons.home,
              text: 'الرئيسية',
              iconSize: 28,
            ),
            GButton(
              icon: Icons.search,
              text: 'البحث',
              iconSize: 28,
            ),
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
