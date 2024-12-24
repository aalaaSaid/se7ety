
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/features/auth/data/doctor_model.dart';
import 'package:se7ety/features/patient/search/page/doctor_profile_screen.dart';

import '../utils/colors.dart';
import '../utils/text_style.dart';
class DoctorCard extends StatelessWidget {
   const DoctorCard({super.key, required this.doctorModel});
  final DoctorModel? doctorModel;
//String path = AppLocalStorage.getCachedData(key: 'userPhoto');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateTo(context, DoctorProfileScreen(doctorModel: doctorModel!,));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
            color: AppColors.accentColor,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              child: Container(
                height: 75,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.white),
                child:Image.network('https://tse4.mm.bing.net/th?id=OIP.Vy9dRvTExXb8k5cXQkztZgHaHa&pid=Api&P=0&h=220',
                  fit: BoxFit.cover,),
              ),
              ),
            const Gap(10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctorModel!.name!,
                    style: getBodyStyle(color: AppColors.primaryColor,fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(5),
                  Text(doctorModel!.specialization!,style: getSmallStyle(
                    color: AppColors.black
                  ),),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(doctorModel!.rating!.toString(),style: getBodyStyle(),),
                const Gap(5),
                const Icon(Icons.star,color: Colors.amberAccent,size: 25,)
              ],
            ),



          ],
        ),
      ),
    );
  }
}
