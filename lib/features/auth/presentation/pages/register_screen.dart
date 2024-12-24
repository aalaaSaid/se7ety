import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/dialog.dart';
import 'package:se7ety/features/patient/nav_bar.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_event.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_state.dart';
import 'package:se7ety/features/auth/presentation/pages/doctor_register.dart';
import 'package:se7ety/features/auth/presentation/pages/login_screen.dart';

import '../../../../core/enum/user_type.dart';
import '../../../../core/functions/email_validation.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_button.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key,required this.userType});
  final UserType? userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController =TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = false ;
  String handleUserType() {
    return widget.userType == UserType.doctor ? 'دكتور' : 'مريض';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if(state is RegisterLoadingState){
      showLoadingDialog(context);
    }else if(state is RegisterErrorState){
      Navigator.pop(context);
      showErrorDialog(context, state.error);
    }else if(state is RegisterSuccessState){
      //Navigator.pop(context);
      if(widget.userType==UserType.patient){
        navigateWithRemoveUntil(context, const PatientNavBar());
      }else if(widget.userType==UserType.doctor){
        navigateWithRemoveUntil(context, const DoctorRegister());
      }
    }
  },
  child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/logo.png',
                    height: 250,
                    width: 250,
                  ),
                  const Gap(20),
                  Text('سجل حساب جديد كـ "${handleUserType()}"',style: getTitleStyle(),),
                  const Gap(40),
                  TextFormField(
                    controller:nameController ,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'الاسم',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'من فضلك أدخل الاسم';
                      }else{
                        return null ;
                      }
                    },
                  ),
                  const Gap(20),
                  TextFormField(
                    controller:emailController ,
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'aalaa@example.com',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'من فضلك أدخل الايميل';
                      }else if(emailValidation(value)==false){
                        return 'من فضلك اكتب الايميل بطريقة صحيحة';
                      }else{
                        return null ;
                      }
                    },
                  ),
                  const Gap(20),
                  TextFormField(
                    controller:passwordController ,
                    textAlign: TextAlign.end,
                    obscureText: obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: '********',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            obscureText =!obscureText;
                          });
                        },
                            icon: Icon(obscureText?Icons.remove_red_eye:Icons.visibility_off))
                    ),
                    validator: (value){
                      if(value!.length<8){
                        return 'كلمة السر لا تقل عن ثمانية حرف';
                      }else if (value.isEmpty){
                        return 'من فضلك ادخل كلمة المرور';
                      }else{
                        return null ;
                      }
                    },
                  ),
                  const Gap(20),
                  CustomButton(text: 'تسجيل حساب', onPressed:(){
                    if(formKey.currentState!.validate()){
                      context.read<AuthBloc>().add(
                          RegisterEvent(name:nameController.text ,
                              email: emailController.text,
                              password: passwordController.text,
                            userType: widget.userType!,
                          ));
                    }
                  }),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('هل لديك حساب بالفعل؟'),
                      TextButton(onPressed: (){
                      navigateWithReplacement(context, LoginScreen(userType: widget.userType));
                      }, child: Text('سحل الان',style: getBodyStyle(color: AppColors.primaryColor),))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
),
    );
  }
}
