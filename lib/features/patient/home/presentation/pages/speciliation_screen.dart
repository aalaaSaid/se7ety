import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/widgets/doctor_card.dart';
import 'package:se7ety/features/auth/data/doctor_model.dart';

import '../../../../../core/utils/text_style.dart';
class SpeciliationScreen extends StatefulWidget {
  const SpeciliationScreen({super.key,required this.specilization});
  final String specilization ;

  @override
  State<SpeciliationScreen> createState() => _SpeciliationScreenState();
}

class _SpeciliationScreenState extends State<SpeciliationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        title: Text(widget.specilization),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future:FirebaseFirestore.instance.
          collection('doctors').
          where('specialization',isEqualTo: widget.specilization)
              .get() ,
          builder: (context,snapshot){
           if(!snapshot.hasData){
             return const Center(
               child: CircularProgressIndicator(),
             );
           }else {
            return snapshot.data!.docs.isEmpty?
            Center(
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
                      'لا يوجد دكتور بهذا التخصص حاليا',
                      style: getBodyStyle(),
                    ),
                  ],
                ),
              ),
            )
                :Padding(
                  padding: const EdgeInsets.all(12),
                  child: ListView.separated(
                                physics: const ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                    DoctorModel doctor = DoctorModel.
                    fromJson(snapshot.data?.docs[index].
                    data()as Map<String,dynamic>) ;
                    return DoctorCard(doctorModel: doctor);
                  },
                  separatorBuilder: (context , index){
                    return const Gap(10);
                  },
                  itemCount: snapshot.data!.docs.length,
                              ),
                );
           }
          }),
    );
  }
}
