import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/patient/home/presentation/pages/home_search_screen.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/specialization_card.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/top_rated.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  final searchController = TextEditingController();
  //String path = AppLocalStorage.getCachedData(key: 'userPhoto');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_active_rounded,
                color: AppColors.white,
              ))
        ],
        title: Text(
          'صحتي',
          style: getTitleStyle(color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(text: 'مرحبا,  ', style: getBodyStyle()),
                TextSpan(
                    text: user?.displayName,
                    style: getBodyStyle(
                        color: AppColors.primaryColor, fontSize: 20)),
              ])),
              const Gap(10),
              Text(
                'احجز الآن وكن جزءًا من رحلتك الصحية.',
                style: getTitleStyle(color: AppColors.black, fontSize: 25),
              ),
              const Gap(20),
              //البحث عن دكتور
              Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      blurRadius: 15,
                      offset: const Offset(5, 5),
                    )
                  ],
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: searchController,
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن دكتور',
                    filled: true,
                    hintStyle: getBodyStyle(),
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (searchController.text.isNotEmpty) {
                            navigateTo(
                                context,
                                HomeSearchScreen(
                                    searchName: searchController.text));
                          }
                        },
                        icon: const Icon(
                          Icons.search,
                          color: AppColors.white,
                        ),
                        iconSize: 25,
                        splashRadius: 20,
                      ),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    if (searchController.text.isNotEmpty) {
                      navigateTo(context,
                          HomeSearchScreen(searchName: searchController.text));
                    }
                  },
                ),
              ),
              const Gap(20),
              Text(
                'التخصصات',
                style: getTitleStyle(),
              ),
              const Gap(10),
              //التخصصات
              const SpecializationCard(),
              const Gap(20),
              Text(
                'الأعلي تقييما',
                style: getTitleStyle(),
              ),
              const Gap(10),
              //الاعلي تقييما
              const TopRated(),
            ],
          ),
        ),
      ),
    );
  }
}
