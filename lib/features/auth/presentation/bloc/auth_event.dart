import 'package:se7ety/core/enum/user_type.dart';
import 'package:se7ety/features/auth/data/doctor_model.dart';

class AuthEvent {}

//login
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

//register
class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final UserType userType;

  RegisterEvent(
      {required this.userType,
      required this.name,
      required this.email,
      required this.password});
}

//doctor register
class DoctorRegisterEvent extends AuthEvent {
  final DoctorModel doctorModel;

  DoctorRegisterEvent({required this.doctorModel});
}
