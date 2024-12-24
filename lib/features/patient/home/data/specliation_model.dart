import 'package:flutter/material.dart';

import '../../../auth/data/speciliation_list.dart';

const Color darkBlue = Color(0xff71b4fb);
const Color lightBlue = Color(0xff7fbcfb);
const Color darkOrange = Color(0xfffa8c73);
const Color lightOrange = Color(0xfffa9881);
const Color darkPurple = Color(0xff8873f4);
const Color lightPurple = Color(0xff9489f4);
const Color darkGreen = Color(0xff4cd1bc);
const Color lightGreen =Color(0xff5ed6c3) ;


class SpecializationsModel {
final String? specialization ;
final Color? background;
final Color? circle;

  SpecializationsModel({required this.specialization, required this.background, required this.circle});
}

List<SpecializationsModel>specializationModel =[
  SpecializationsModel(specialization:specializations[0] , background: darkBlue, circle: lightBlue),
  SpecializationsModel(specialization:specializations[1] , background: darkGreen, circle: lightGreen),
  SpecializationsModel(specialization:specializations[2] , background: darkOrange, circle: lightOrange),
  SpecializationsModel(specialization:specializations[3] , background: darkPurple, circle: lightPurple),
  SpecializationsModel(specialization:specializations[4] , background: darkBlue, circle: lightBlue),
  SpecializationsModel(specialization:specializations[5] , background: darkGreen, circle: lightGreen),
  SpecializationsModel(specialization:specializations[6] , background: darkOrange, circle: lightOrange),
  SpecializationsModel(specialization:specializations[7] , background: darkPurple, circle: lightPurple),
  SpecializationsModel(specialization:specializations[8] , background: darkBlue, circle: lightBlue),
  SpecializationsModel(specialization:specializations[9] , background: darkGreen, circle: lightGreen),
  //SpecializationsModel(specialization:specializations[10] , background: darkOrange, circle: lightOrange),

];