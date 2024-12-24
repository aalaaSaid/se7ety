import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widgets/item_tile.dart';
import 'package:se7ety/features/patient/profile/presentation/pages/setting_screen.dart';
import 'package:se7ety/features/patient/profile/presentation/widgets/appointments_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String path = '';
  String? userId;
  //upload photo from camera
  Future<void> uploadFromCamera() async {
    final imagePath = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagePath != null) {
      setState(() {
        path = imagePath.path;
      });
    }
  }

  //get the current user id
  Future<void> getUser() async {
    userId = FirebaseAuth.instance.currentUser!.uid;
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
          'الحساب الشخصي',
          style: getTitleStyle(color: AppColors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {
                navigateTo(context, const SettingScreen());
              },
              icon: const Icon(
                Icons.settings,
                color: AppColors.white,
              ))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('patients')
              .doc(userId).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var userData = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //header
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                  backgroundColor: AppColors.accentColor,
                                  radius: 60,
                                  backgroundImage: path != ''
                                      ? FileImage(File(path)) as ImageProvider
                                      : const NetworkImage(
                                          'https://tse3.mm.bing.net/th?id=OIP.ZwgJv5gztOn2jHbTWgIWngHaHa&pid=Api&P=0&h=220')),
                              GestureDetector(
                                onTap: uploadFromCamera,
                                child: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppColors.white,
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    size: 20,
                                    // color: AppColors.color1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userData!['name'],
                                  style: getBodyStyle(
                                      color: AppColors.primaryColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const Gap(10),
                                Text(
                                  userData['city'] == ''
                                      ? 'لم تضاف بعد'
                                      : userData['city'],
                                  style: getBodyStyle(color: AppColors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      //bio
                      const Gap(20),
                      Text(
                        'نبذة تعريفية',
                        style: getTitleStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                      const Gap(10),
                      Text(
                        userData['bio'] == '' ? 'لم تضاف بعد' : userData['bio'],
                        style: getSmallStyle(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const Gap(20),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const Gap(10),
                      //info of connect
                      Text(
                        'معلومات الاتصال',
                        style: getTitleStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                      const Gap(10),
                      Container(
                        padding: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.accentColor,
                        ),
                        child: Column(
                          children: [
                            ItemTile(
                                icon: Icons.email,
                                text: userData['email'] == ''
                                    ? 'لم تضاف بعد'
                                    : userData['email']),
                            const Gap(5),
                            const Divider(
                              color: AppColors.white,
                            ),
                            const Gap(5),
                            ItemTile(
                                icon: Icons.phone,
                                text: userData['phone'] == ''
                                    ? 'لم تضاف بعد'
                                    : userData['phone'])
                          ],
                        ),
                      ),
                      const Gap(10),
                      //booking
                      Text(
                        'حجوزاتي',
                        style: getTitleStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                      const Gap(10),
                      const AppointmentsList(),

                    ]),
              ),
            );
          }),
    );
  }
}
