import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/widgets/doctor_card.dart';
import '../../../../auth/data/doctor_model.dart';
class TopRated extends StatefulWidget {
  const TopRated({super.key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .orderBy('rating',descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                value: .9,
                color: Colors.black12,
              ),
            );
          } else {
            return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context,index){
                  return const Gap(10);
                },
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DoctorModel doctor = DoctorModel.fromJson(
                      snapshot.data!.docs[index].data()
                      as Map<String, dynamic>);
                  return DoctorCard(doctorModel: doctor);
                });
          }
        });
  }
}
