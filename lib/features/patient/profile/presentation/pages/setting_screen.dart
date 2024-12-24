import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widgets/custom_button.dart';
import 'package:se7ety/features/intro/welcome_screen.dart';
import 'package:se7ety/features/patient/profile/presentation/pages/user_detials_screen.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/widgets/setting_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  //sign out method
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الاعدادات',style: getTitleStyle(
          color: AppColors.white
        ),),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            splashRadius: 25,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            //person
            SettingsListItem(
              icon: Icons.person,
              text:'اعدادات الحساب',
              hasNavigation: true,
              onTap: () {
                navigateTo(context, const UserDetialsScreen());
              },
            ),
            const Gap(5),
            SettingsListItem(
                icon: Icons.security,
                text: 'كلمة السر',
                onTap: (){}),
            const Gap(5),
            SettingsListItem(
                icon: Icons.notifications,
                text:'اعدادات الاشعارات',
                onTap: (){}),
            const Gap(5),
            SettingsListItem(
                icon: Icons.privacy_tip,
                text:'الخصوصية',
                onTap: (){}),
            const Gap(5),
            SettingsListItem(
                icon: Icons.question_mark,
                text: 'المساعدة والدعم',
                onTap: (){}),
            const Gap(5),
            SettingsListItem(
                icon: Icons.person_add,
                text: 'دعوة صديق',
                onTap: (){}),
            const Spacer(),
            CustomButton(
                text: 'تسجيل الخروج',
                onPressed: (){
                  signOut();
                  navigateWithRemoveUntil(context, const WelcomeScreen());
                }

            ),

          ],
        ),
      ),

    );
  }
}
