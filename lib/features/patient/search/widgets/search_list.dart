import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/widgets/doctor_card.dart';
import 'package:se7ety/features/auth/data/doctor_model.dart';

import '../../../../core/utils/text_style.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key, required this.searchKey});
  final String searchKey;

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .orderBy('name')
            .startAt([widget.searchKey]).endAt(
                ['${widget.searchKey}\uf8ff']).snapshots(),
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
                  padding: const EdgeInsets.all(10),
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
        });
  }
}
