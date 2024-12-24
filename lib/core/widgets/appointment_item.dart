import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/widgets/alert_dialog.dart';

import '../utils/colors.dart';
import '../utils/text_style.dart';
import 'custom_button.dart';

class AppointmentItem extends StatelessWidget {
  const AppointmentItem(
      {super.key,
      required this.doctorName,
      required this.date,
      required this.time,
      required this.patientName,
      required this.location,
      required this.onTap,
        required this.today,
      });
  final String? doctorName;
  final String? date;
  final String? time;
  final String? patientName;
  final String? location;
  final String? today;
  final Function() onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(-3, 0),
            blurRadius: 15,
            color: Colors.grey.withOpacity(.1),
          )
        ],
      ),
      child: Theme(
        //to change the color of the divider
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.end,
          backgroundColor: AppColors.accentColor,
          collapsedBackgroundColor: AppColors.accentColor,
          title: Row(
            //name of the doctor
            children: [
              Text(
                'د: ',
                style: getTitleStyle(color: AppColors.primaryColor),
              ),
              Text(
                doctorName!,
                style: getTitleStyle(color: AppColors.primaryColor),
              ),
            ],
          ),
          subtitle: Column(
            children: [
              const Gap(10),
              //date
              Row(
                children: [
                  const Icon(
                    Icons.date_range,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const Gap(10),
                  Text(
                    date!,
                    style: getBodyStyle(),
                  ),
                  const Gap(20),
                  Text(today!,style: getBodyStyle(color: AppColors.primaryColor),)
                ],
              ),
              const Gap(15),
              //time
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const Gap(10),
                  Text(
                    time!,
                    style: getBodyStyle(),
                  )
                ],
              ),
              const Gap(10)
            ],
          ),
          children: [
            Column(children: [
              //name of the patient
              Row(
                children: [
                  Text(
                    '  اسم المريض:',
                    style: getBodyStyle(),
                  ),
                  Text(
                    patientName!,
                    style: getBodyStyle(),
                  ),
                ],
              ),
              const Gap(10),
              //location
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const Gap(10),
                  Text(
                    location!,
                    style: getBodyStyle(),
                  ),
                ],
              ),
              const Gap(10),
              CustomButton(text: 'حذف الحجز', onPressed: () {
                showAlertDialg(context,
                    title: 'هل تريد حذف الحجز؟',
                    onTapOK: onTap,
                    ok: 'نعم',
                    no:  'لا',
                    onTapNo: (){
                      Navigator.pop(context);
                    });
              }),
              const Gap(10),
            ]),
          ],
        ),
      ),
    );

  }
}
