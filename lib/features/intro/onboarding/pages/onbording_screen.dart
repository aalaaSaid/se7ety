import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/services/local/local_storge.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widgets/custom_button.dart';
import 'package:se7ety/features/intro/onboarding/models/onbording_model.dart';
import 'package:se7ety/features/intro/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageController = PageController();
  int currentPage =0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){
            AppLocalStorage.cacheData(key: AppLocalStorage.onboarding,
                value: true);
           navigateWithReplacement(context, WelcomeScreen());
            }, child: Text('تخطي',
          style: getTitleStyle(),
          )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Expanded(child: PageView.builder(itemBuilder: (context,index){
              return Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset('${onboardingPages[index].image}',
                  width: 300,
                  ),
                  const Spacer(),
                  Text('${onboardingPages[index].title}',
                  style: getTitleStyle(),
                  ),
                  Gap(10),
                  Text('${onboardingPages[index].subtitle}',
                  style: getBodyStyle(),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 2,),

                ],
              );

            },
            itemCount: onboardingPages.length,
            controller: pageController,
              onPageChanged: (value){
              currentPage= value ;
              setState(() {

              });
              },
            ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmoothPageIndicator(controller: pageController,
                      count: 3,
                  effect: const ScaleEffect(
                    activeDotColor: AppColors.primaryColor,
                    dotColor: AppColors.accentColor,
                    dotHeight: 20,
                    dotWidth: 20,
                  ),
                  ),
                  const Spacer(),
                  if(currentPage ==onboardingPages.length-1)
                  CustomButton(text: 'هيا بنا', onPressed: (){
                    AppLocalStorage.cacheData(key: AppLocalStorage.onboarding,
                        value: true);
                    navigateWithReplacement(context, WelcomeScreen());
                  },
                  height: 50,
                    width: 150,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
