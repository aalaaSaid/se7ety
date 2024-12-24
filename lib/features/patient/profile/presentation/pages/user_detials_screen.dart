import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/widgets/custom_button.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/text_style.dart';

class UserDetialsScreen extends StatefulWidget {
  const UserDetialsScreen({super.key});

  @override
  State<UserDetialsScreen> createState() => _UserDetialsScreenState();
}

class _UserDetialsScreenState extends State<UserDetialsScreen> {
  User? user;
  List labelName = ["الاسم", "رقم الهاتف", "المدينة", "نبذه تعريفية", "العمر"];
  List values = ["name", "phone", "city", "bio", "age"];
  //get current user
  Future<void>getUser()async{
    user = FirebaseAuth.instance.currentUser;
  }

  //update data in firestore
  Future<void>updateData(String key,dynamic value)async{
      FirebaseFirestore.instance.collection('patients').doc(user!.uid).update({key:value});
       if(key =='name'){
        await user!.updateDisplayName(value);
       }
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
        title: Text('اعدادات الحساب',style: getTitleStyle(
            color: AppColors.white
        ),),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            splashRadius: 25,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: StreamBuilder(
        stream:FirebaseFirestore.instance.
        collection('patients').doc(user!.uid).snapshots() ,
          builder:(context,snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            var userData = snapshot.data;
            return  Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        showDialog(context: context,
                            builder: (context){
                              var controller = TextEditingController(
                                text: userData?[values[index]]==''?
                                    'لم تضاف بعد':userData?[values[index]]
                              );
                              var formKey = GlobalKey<FormState>();
                              return SimpleDialog(
                                alignment: Alignment.center,
                                contentPadding: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                children: [
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        //name
                                        Text('ادخل${labelName[index]}',style: getBodyStyle()),
                                        const Gap(5),
                                        TextFormField(
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.accentColor,
                                          ),
                                          controller: controller,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'ادخل ${labelName[index]}';
                                            }
                                            return null;
                                          },

                                        ),
                                        const Gap(20),
                                        CustomButton(text: 'حفظ',
                                            onPressed: (){
                                          if(formKey.currentState!.validate()){
                                            updateData(values[index], controller.text);
                                            Navigator.pop(context);
                                          }

                                            })
                                      ],
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.accentColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              labelName[index],
                              style: getBodyStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(userData?[values[index]]==''?
                            'لم تضاف بعد':userData?[values[index]],
                              style: getBodyStyle(),
                            ),
                          ],
                        ),

                      ),
                    );
                  },
                  separatorBuilder: (context,index)=>const Gap(10),
                  itemCount: labelName.length),
            );
          }

          })
    );

  }
}
