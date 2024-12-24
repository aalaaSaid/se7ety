import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/features/patient/search/widgets/search_list.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});


  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String doctorSearch='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ابحث عن دكتور',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
            child: TextField(
              onChanged: (value){
                setState(() {
                  doctorSearch = value;
                });
              },
              decoration: InputDecoration(
                hintText: "البحث",
                hintStyle: getBodyStyle(),
                suffixIcon: const SizedBox(
                    width: 50,
                    child: Icon(Icons.search,
                        color: AppColors.primaryColor)),
              ),
            ),
        ),
            const Gap(20),
            Expanded(
                child: SearchList(searchKey: doctorSearch)),

            ],),
    ),
    );
  }
}
