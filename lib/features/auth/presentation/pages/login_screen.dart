import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/enum/user_type.dart';
import 'package:se7ety/core/functions/dialog.dart';
import 'package:se7ety/core/functions/email_validation.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widgets/custom_button.dart';
import 'package:se7ety/features/doctor/doctor_nav_bar.dart';
import 'package:se7ety/features/patient/nav_bar.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_event.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_state.dart';
import 'package:se7ety/features/auth/presentation/pages/doctor_register.dart';
import 'package:se7ety/features/auth/presentation/pages/register_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key,required this.userType});
  final UserType? userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = false ;
  String handleUserType() {
    return widget.userType == UserType.doctor ? 'دكتور' : 'مريض';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),
      body: BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if(state is LoginLoadingState){
      showLoadingDialog(context);
    }else if(state is LoginErrorState){
      Navigator.pop(context);
      showErrorDialog(context, state.error);
    }else if (state is LoginSuccessState){
      //Navigator.pop(context);
      if(state.userType==UserType.patient.toString()){
        navigateWithRemoveUntil(context, const PatientNavBar());
      }else if(state.userType ==UserType.doctor.toString()){
        navigateWithRemoveUntil(context, const DoctorNavBar());
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
                  Text('سجل دخول الان كـ "${handleUserType()}"',style: getTitleStyle(),),
                  const Gap(40),
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
                  Row(
                    children: [
                     TextButton(onPressed: (){},
                         child:  Text('هل نسيت كلمة السر؟',
                         style: getBodyStyle(),
                         )),
                    ],
                  ),
                  const Gap(20),
                  CustomButton(text: 'تسجيل الدخول', onPressed:(){
                    if(formKey.currentState!.validate()){
                      context.read<AuthBloc>().add(
                          LoginEvent(email:emailController.text ,
                              password: passwordController.text,
                              ));
                    }
                  }),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('هل لديك اي حساب؟'),
                      TextButton(onPressed: (){
                        navigateWithReplacement(context, RegisterScreen(userType: widget.userType,));
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
