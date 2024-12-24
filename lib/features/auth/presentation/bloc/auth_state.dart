class AuthState {}
class AuthInitialState extends AuthState{}
//login
class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{
  //to know where user go we should know user type
  final String userType ;

  LoginSuccessState({required this.userType});

}
class LoginErrorState extends AuthState{
  final String error ;
  LoginErrorState(this.error);
}
//register
class RegisterLoadingState extends AuthState{}
class RegisterSuccessState extends AuthState{}
class RegisterErrorState extends AuthState{
  final String error ;
  RegisterErrorState(this.error);

}
//doctor register
class DoctorRegisterLoadingState extends AuthState{}
class DoctorRegisterSuccessState extends AuthState{}
class DoctorRegisterErrorState extends AuthState{
  final String? error ;

  DoctorRegisterErrorState({required this.error});
}
