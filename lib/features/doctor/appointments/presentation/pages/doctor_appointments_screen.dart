import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widgets/appointment_item.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});
  @override
  State<DoctorAppointmentsScreen> createState() => _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  User? user;
  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  //date format
  String dateFormatter(String timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(timestamp));
    return formattedDate;
  }

//time format
  String timeFormatter(String timestamp) {
    String formattedTime =
        DateFormat('hh:mm').format(DateTime.parse(timestamp));
    return formattedTime;
  }

  //compare the date to know we are today or not
  bool isToday(String date) {
    if (dateFormatter(DateTime.now().toString())
            .compareTo(dateFormatter(date)) ==
        0) {
      return true;
    }
    return false;
  }
// compare the time to make delete automatically
  bool isNow(DateTime date){
    var diff = DateTime.now().difference(date).inHours;
    if(diff>2){
      return true;
    }
    return false ;
  }
// delete appointments from pending collection
  Future<void> deleteAppointments(String uid) async {
    FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('pending')
        .doc(uid)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'مواعيد الحجز',
            style: getTitleStyle(color: AppColors.white),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('appointments')
                .doc('appointments')
                .collection('pending')
                .where('doctorID', isEqualTo: user!.email)
                .orderBy('date', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return snapshot.data!.docs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/no_scheduled.svg',
                              width: 250),
                          Text('لا يوجد حجوزات قادمة', style: getBodyStyle()),
                        ],
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        if(isNow(data['date'].toDate())){
                          deleteAppointments(data.id);
                        }
                        return AppointmentItem(
                            onTap: () async {
                              deleteAppointments(data.id);
                              Navigator.pop(context);
                            },
                            today: isToday(data['date'].toDate().toString()) ? 'اليوم' : '',
                            doctorName: data['doctor'],
                            date: dateFormatter(data['date'].toDate().toString()),
                            time: timeFormatter(data['date'].toDate().toString()),
                            patientName: data['name'],
                            location: data['location']);
                      });
            }));
  }
}
