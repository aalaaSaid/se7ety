import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/text_style.dart';
class ItemSpeclization extends StatelessWidget {
  const ItemSpeclization({super.key, required this.specilization,
    required this.dark,
    required this.light});
  final String? specilization ;
  final Color? dark ;
  final Color? light ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
        color: dark,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: light!.withOpacity(.8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top:-20,
                right: -20,
                child: CircleAvatar(
                  backgroundColor:light,
                  radius: 60,
                )),
            SvgPicture.asset('assets/images/doctor-card.svg', width: 140,),
            Positioned(
                bottom: 20,
                child: Center(child: Text(specilization!,style: getBodyStyle(color: AppColors.white),))
        
            ),
        
          ],
        
        ),
      ),
    );
  }
}
