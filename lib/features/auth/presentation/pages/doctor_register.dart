import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/core/functions/dialog.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/services/local/local_storge.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widgets/custom_button.dart';
import 'package:se7ety/features/doctor/doctor_nav_bar.dart';
import 'package:se7ety/features/patient/nav_bar.dart';
import 'package:se7ety/features/auth/data/doctor_model.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_event.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_state.dart';

import '../../data/speciliation_list.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({super.key});

  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  final formKey = GlobalKey<FormState>();
  String specialization = specializations[0];
  final bioController = TextEditingController();
  final addressController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  String startTime = DateFormat('hh').format(DateTime.now());
  String endTime = DateFormat('hh').format(DateTime.now().add(const Duration(minutes: 15)));
  String? path;
  late String? userId ;


  uploadImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        path = image.path;
      });
    }
  }
  Future<void> getUser() async {
    userId = FirebaseAuth.instance.currentUser!.uid;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  //select start time
Future<void>selectStartTime()async{
    final timePicker =await showTimePicker(context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if(timePicker != null) {
      setState(() {
        startTime = timePicker.hour.toString();
      });
    }
}
  //select end time
  Future<void>selectEndTime()async{
    final timePicker =await showTimePicker(context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now().add(
          const Duration(hours: 8),
        )
        ));
    if(timePicker != null) {
      setState(() {
        endTime = timePicker.hour.toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
         if(state is DoctorRegisterLoadingState){
           showLoadingDialog(context);
         }else if(state is DoctorRegisterErrorState){
           Navigator.pop(context);
           showErrorDialog(context, 'state.error');
         }else if (state is DoctorRegisterSuccessState){
           //Navigator.pop(context);
           AppLocalStorage.cacheData(key: 'doctorInfo', value: true);
           navigateWithRemoveUntil(context, const DoctorNavBar());
         }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'اكمل التسجيل الان',
              style: getTitleStyle(color: AppColors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        CircleAvatar(
                          backgroundColor: AppColors.white,
                          backgroundImage: (path != null)
                              ? FileImage(File(path!)) as ImageProvider
                              : const AssetImage('assets/images/doc.png'),
                          radius: 60,
                        ),
                        InkWell(
                          onTap: uploadImageFromGallery,
                          child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.accentColor,
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: AppColors.primaryColor,
                              )),
                        )
                      ]),
                    ),
                    const Gap(10),
                    //التخصص
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            'التخصص',
                            style: getBodyStyle(),
                          ),
                        ),
                        const Gap(5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: DropdownButton(
                            isExpanded: true,
                            dropdownColor: AppColors.primaryColor,
                            icon: const Icon(
                              Icons.expand_circle_down_rounded,
                              color: AppColors.primaryColor,
                            ),
                            value: specialization,
                            onChanged: (String? value) {
                              setState(() {
                                specialization = value ?? specializations[0];
                              });
                            },
                            items: specializations.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),

                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    //النبذة
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            'نبذة تعريفية',
                            style: getBodyStyle(),
                          ),
                        ),
                        const Gap(5),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          controller: bioController,
                          decoration: const InputDecoration(
                            hintText:
                            'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي وخبراتك السابقة...',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل النبذة التعريفية';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                    const Gap(10),
                    const Divider(),
                    //العنوان
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            'العنوان',
                            style: getBodyStyle(),
                          ),
                        ),
                        const Gap(5),
                        TextFormField(
                          //maxLines: 5,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          controller: addressController,
                          decoration: const InputDecoration(
                            hintText: '5شارع كذا -المنطقة- المحافظة',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل العنوان';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                    const Gap(10),
                    //الوقت
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                'ساعات العمل من',
                                style: getBodyStyle(),
                              ),
                            )),
                        const Gap(10),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                'الي',
                                style: getBodyStyle(),
                              ),
                            )),
                      ],
                    ),
                    const Gap(10),
                    //بقية الوقت
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: startTime,
                                  suffixIcon: IconButton(
                                      onPressed:()async{
                                        await selectStartTime();

                                      },
                                      icon: const Icon(
                                        Icons.watch_later,
                                        color: AppColors.primaryColor,
                                      ))),
                            )),
                        const Gap(10),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: endTime,
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                     await selectEndTime();
                                    },
                                    icon: const Icon(
                                      Icons.watch_later,
                                      color: AppColors.primaryColor,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    //التليفون1
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            'رقم الهاتف 1',
                            style: getBodyStyle(),
                          ),
                        ),
                        const Gap(5),
                        TextFormField(
                          //maxLines: 5,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          controller: phone1Controller,
                          decoration: const InputDecoration(
                            hintText: '+20 xxxxxxxxxxx',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل الرقم ';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                    const Gap(10),
                    //التليفون2
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            'رقم الهاتف 2 (اختياري)',
                            style: getBodyStyle(),
                          ),
                        ),
                        const Gap(5),
                        TextFormField(
                          //maxLines: 5,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          controller: phone2Controller,
                          decoration: const InputDecoration(
                            hintText: '+20 xxxxxxxxxxx',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
              padding: const EdgeInsets.all(16),
              child: CustomButton(
                  text: 'التسجيل',
                  onPressed: () {
                    if (formKey.currentState!.validate()&& path!= null) {
                      AppLocalStorage.cacheData(key: 'userPhoto', value: path);
                      context.read<AuthBloc>().add(DoctorRegisterEvent(
                        doctorModel: DoctorModel(
                          uid: userId,
                          //because it require firebase firestore storge
                          image: "no image found",
                          bio: bioController.text,
                          address: addressController.text,
                          openHour: startTime,
                          closeHour: endTime,
                          phone1: phone1Controller.text,
                          phone2: phone2Controller.text,
                          specialization: specialization,
                        ),
                      ));

                    }else{
                      ScaffoldMessenger.of(context).
                      showSnackBar(const SnackBar(content: Text('من فلك اخل الصورة')));
                    }
                  })),
        ),
      ),
    );
  }
}
