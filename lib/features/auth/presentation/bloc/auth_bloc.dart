import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/enum/user_type.dart';
import 'package:se7ety/core/services/local/local_storge.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_event.dart';
import 'package:se7ety/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc():super(AuthInitialState()) {
    on<LoginEvent>(login);
    on<RegisterEvent>(register);
    on<DoctorRegisterEvent>(updateDoctorInfo);
  }

  Future<void>login(LoginEvent event,Emitter<AuthState>emit)async{
   emit(LoginLoadingState());
   try {
     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: event.email,
         password: event.password
     );
     AppLocalStorage.cacheData(key: AppLocalStorage.userType,
         value: credential.user?.photoURL??'');
     emit(LoginSuccessState(userType:credential.user?.photoURL??''));
   } on FirebaseAuthException catch (e) {
     if (e.code == 'user-not-found') {
       emit(LoginErrorState('No user found for that email.'));
     } else if (e.code == 'wrong-password') {
       emit(LoginErrorState('Wrong password provided for that user'));
     }
   }
  }
  Future<void>register(RegisterEvent event,Emitter<AuthState>emit)async{
    emit(RegisterLoadingState());
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      User? user ;
      user = credential.user!;
      user.updateDisplayName(event.name);
      //deal with photo as usertype
      user.updatePhotoURL(event.userType.toString());
          if(event.userType == UserType.patient) {
        FirebaseFirestore.instance.collection('patients').doc(user.uid).set({
          'name': event.name,
          'image': '',
          'age': '',
          'email': event.email,
          'phone': '',
          'bio': '',
          'city': '',
          'uid': user.uid,
        }

        );
      }else if (event.userType == UserType.doctor){
        FirebaseFirestore.instance.collection('doctors').doc(user.uid).set({
          'name': event.name,
          'image': '',
          'specialization': '',
          'rating': 3,
          'email': event.email,
          'phone1': '',
          'phone2': '',
          'bio': '',
          'openHour': '',
          'closeHour': '',
          'address': '',
          'uid': user.uid,
        });
      }
      AppLocalStorage.cacheData(key: AppLocalStorage.userType,
          value: credential.user?.photoURL??'');
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState('you Enter weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState('The account already exists for that email.'));
      }else{
        emit(RegisterErrorState('Error'));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void>updateDoctorInfo (DoctorRegisterEvent event , Emitter<AuthState>emit)async{
    emit(DoctorRegisterLoadingState());
    try{
      FirebaseFirestore.instance.
      collection('doctors').
      doc(event.doctorModel.uid).
      update(event.doctorModel.toJson());
      AppLocalStorage.cacheData(key: 'doctorInfo', value: true);
      emit(DoctorRegisterSuccessState());
      
    }on Exception catch(e){
      emit(DoctorRegisterErrorState(error: e.toString()));
    }

  }
}