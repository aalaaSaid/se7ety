import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/core/widgets/appointment_item.dart';

import '../../../../../core/utils/text_style.dart';
class AppointmentsList extends StatefulWidget {
  const AppointmentsList({super.key});

  @override
  State<AppointmentsList> createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  User? user;
  Future<void>getUser()async{
    user = FirebaseAuth.instance.currentUser;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  String dateFormatter(String date){
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
    return formattedDate;
  }
  String timeFormatter(String date){
    String formattedDate = DateFormat('hh:mm').format(DateTime.parse(date));
    return formattedDate;
  }
  bool isToday(DateTime date){
    var diff = DateTime.now().difference(date).inDays;
    if(diff ==0){
      return true ;
    }
    return false ;
  }
  bool isNow(DateTime date){
    var dif = DateTime.now().difference(date).inHours;
    if(dif>2){
      return true ;
    }
    return false ;
  }
  Future<void>deleteAppointments(String uid) async {
    FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('all')
        .doc(uid)
        .delete();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('appointments').
        doc('appointments').collection('all').
        where('patientID',isEqualTo: user!.email).
        orderBy('date',descending: false).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
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
                 Text(
                   'لا يوجد مواعيد',
                   style: getBodyStyle(),
                 ),
               ],
             ),
           )
             : ListView.builder(
           shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
           itemCount: snapshot.data!.docs.length,
           itemBuilder: (context,index){
             var data = snapshot.data!.docs[index];
             if(isNow(data['date'].toDate())){
               deleteAppointments(data.id);

             }
             return AppointmentItem(
                 doctorName: data['doctor'],
                 date: dateFormatter(data['date'].toDate().toString()),
                 time: timeFormatter(data['date'].toDate().toString()),
                 patientName: data['name'],
                 location: data['location'],
                 onTap: ()async{
                   deleteAppointments(data.id);
                   Navigator.pop(context);

                 },
                 today: isToday(data['date'].toDate())?'اليوم':''
             );

         });
        });
  }
}
