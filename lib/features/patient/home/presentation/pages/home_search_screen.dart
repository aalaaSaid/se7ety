import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/widgets/doctor_card.dart';
import 'package:se7ety/features/auth/data/doctor_model.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/text_style.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key, required this.searchName});
  final String searchName;

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          'ابحث عن دكتورك',
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('doctors')
              .orderBy('name')
              .startAt([widget.searchName.trim()]).endAt(
                  ['${widget.searchName.trim()}\uf8ff']).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return snapshot.data!.docs.isEmpty
                  ? Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/no_scheduled.svg',
                              width: 250,
                            ),
                            Text(
                              'لا يوجد دكتور بهذا الاسم',
                              style: getBodyStyle(),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          DoctorModel doctorModel = DoctorModel.fromJson(
                              snapshot.data!.docs[index].data());
                          return DoctorCard(doctorModel: doctorModel);
                        },
                        separatorBuilder: (context, index) {
                          return const Gap(10);
                        },
                        itemCount: snapshot.data!.docs.length),
                  );
            }
          }),
    );
  }
}
