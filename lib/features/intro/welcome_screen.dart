import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/enum/user_type.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/auth/presentation/pages/login_screen.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/welcome.png',
          fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
              top: 100,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('أهلا بك',
                  style: getTitleStyle(
                    fontSize: 36,
                  ),
                  ),
                  const Gap(10),
                  Text('سجل واحجز عند دكتورك وانت فالبيت',style: getBodyStyle(
                    color: AppColors.black,
                    fontSize: 20
                  ),)

                ],
              ),),
          Positioned(
              bottom: 70,
              right: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      blurRadius: 15,
                      offset: const Offset(5, 5),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text('سجل دلوقتي ك',style: getTitleStyle(color: AppColors.white),),
                    Gap(30),
                    GestureDetector(
                      onTap: (){
                        navigateTo(context, LoginScreen(userType: UserType.doctor,));
                      },
                      child: Container(
                        width: double.infinity,
                        height:70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.accentColor.withOpacity(.5),
                        ),
                        child: Center(
                          child: Text('دكتور',
                          style: getTitleStyle(
                            color: AppColors.black
                          ),
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                    GestureDetector(
                      onTap: (){
                        navigateTo(context, LoginScreen(userType: UserType.patient));
                      },
                      child: Container(
                        width: double.infinity,
                        height:70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.accentColor.withOpacity(.5),
                        ),
                        child: Center(
                          child: Text('مريض',
                            style: getTitleStyle(
                                color: AppColors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(10)
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
