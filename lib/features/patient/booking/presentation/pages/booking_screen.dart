import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widgets/alert_dialog.dart';
import 'package:se7ety/core/widgets/custom_button.dart';
import 'package:se7ety/core/widgets/doctor_card.dart';
import 'package:se7ety/features/auth/data/doctor_model.dart';
import 'package:se7ety/features/patient/booking/data/available_hours_list.dart';
import 'package:se7ety/features/patient/nav_bar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.doctorModel});
  final DoctorModel doctorModel;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  User? user;
  int selectedIndex = 1;
  String? bookingHour ;
  List<int> times = [];
  //select date
  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    ).then((value) {
      if (value != null) {
        setState(() {
          dateController.text = DateFormat('yyyy-MM-dd').format(value);
        });
        times = availableHours(
            date: value,
            openHour: widget.doctorModel.openHour ?? '0',
            endHour: widget.doctorModel.closeHour ?? '0');
      }
    });
  }

  //get user
  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'احجز مع دكتورك الان',
          style: getTitleStyle(color: AppColors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DoctorCard(
                  doctorModel: widget.doctorModel,
                ),
                const Gap(20),
                Center(
                    child: Text(
                  'تفاصيل الحجز',
                  style: getTitleStyle(),
                )),
                const Gap(30),
                //name of patient
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    'اسم المريض',
                    style: getBodyStyle(color: AppColors.primaryColor),
                  ),
                ),
                const Gap(10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء ادخال اسم رقم الهاتف';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                //phone
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    'رقم الهاتف',
                    style: getBodyStyle(color: AppColors.primaryColor),
                  ),
                ),
                const Gap(10),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء ادخال اسم المريض';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                //bio
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    'شرح الحالة',
                    style: getBodyStyle(color: AppColors.primaryColor),
                  ),
                ),
                const Gap(10),
                TextFormField(
                  controller: bioController,
                  textInputAction: TextInputAction.newline,
                  maxLines: 4,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء ادخال شرح الحالة';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                //date of booking
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    'تاريخ الحجز',
                    style: getBodyStyle(color: AppColors.primaryColor),
                  ),
                ),
                const Gap(10),
                TextFormField(
                  readOnly: true,
                  controller: dateController,
                  onTap: () async {
                    await selectDate(context);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء ادخال تاريخ الحجز';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: 'ادخل تاريخ الحجز',
                      hintStyle: getSmallStyle(color: AppColors.black),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(
                            Icons.date_range,
                            color: AppColors.white,
                          ),
                        ),
                      )),
                ),
                const Gap(15),
                //time of booking
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    'وقت الحجز',
                    style: getBodyStyle(color: AppColors.primaryColor),
                  ),
                ),
                const Gap(10),
                Center(
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 3,
                    children: times.map((hour) {
                      return ChoiceChip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: AppColors.accentColor),
                        ),
                          backgroundColor: AppColors.accentColor,
                         // showCheckmark: true,
                          checkmarkColor: AppColors.white,
                         // avatar: const Icon(Icons.check_box_outline_blank),
                          selectedColor: AppColors.primaryColor,
                          label: Text(
                            '${(hour < 10) ? '0' : ''}${hour.toString()}:00',
                            style: TextStyle(
                              color: hour == selectedIndex
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                          selected: hour == selectedIndex,
                          onSelected: (selected) {
                            setState(() {
                              selectedIndex = hour;
                              bookingHour=  '${(hour < 10) ? '0' : ''}${hour.toString()}:00';
                            });
                          });
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(text: 'احجز الان', onPressed: () {
          if(formKey.currentState!.validate()&& selectedIndex>=1){
            createAppointments();
           showAlertDialg(context,
               title:'لقد تم تأكيد الحجز',
               onTapOK: (){
             Navigator.pop(context);
               },
               ok: 'حسنا',
               no: 'الانتقال للصفحة الرئيسية',
               onTapNo: (){
             navigateWithRemoveUntil(context, const PatientNavBar());
               });
          }
        }),
      ),
    );
  }

  //collection of collection
  Future<void> createAppointments() async {
    //pending collection
    FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('pending')
        .doc()
        .set({
      'patientID': user!.email,
      'doctorID': widget.doctorModel.email,
      'name': nameController.text,
      'phone': phoneController.text,
      'description': bioController.text,
      'doctor': widget.doctorModel.name,
      'location': widget.doctorModel.address,
      // yyyy-MM-dd HH:mm:ss>> is the style send to firebase
      'date': DateTime.parse('${dateController.text} ${bookingHour!}:00'),
      'isComplete': false,
      'rating': null
    }, SetOptions(merge: true));
    //all appointments collection
    FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('all')
        .doc()
        .set(
      {
        'patientID': user!.email,
        'doctorID': widget.doctorModel.email,
        'name': nameController.text,
        'phone': phoneController.text,
        'description': bioController.text,
        'doctor': widget.doctorModel.name,
        'location': widget.doctorModel.address,
        // yyyy-MM-dd HH:mm:ss>> is the style send to firebase
        'date': DateTime.parse('${dateController.text} ${bookingHour!}:00'),
        'isComplete': false,
        'rating': null
      },
      SetOptions(merge: true),
    );
  }
}
