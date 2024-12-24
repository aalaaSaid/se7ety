import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/widgets/custom_button.dart';
import 'package:se7ety/features/auth/data/doctor_model.dart';
import 'package:se7ety/core/widgets/item_tile.dart';
import 'package:se7ety/features/patient/booking/presentation/pages/booking_screen.dart';
import 'package:se7ety/features/patient/search/widgets/phone_tile.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key, required this.doctorModel});
  final DoctorModel doctorModel;

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بيانات الدكتور'),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //header
              Row(
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        'https://tse4.mm.bing.net/th?id=OIP.Vy9dRvTExXb8k5cXQkztZgHaHa&pid=Api&P=0&h=220'),
                  ),
                  const Gap(30),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "د. ${widget.doctorModel.name ?? ''}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getTitleStyle(),
                          ),
                          Text(
                            widget.doctorModel.specialization ?? '',
                            style: getBodyStyle(),
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Text(
                                widget.doctorModel.rating.toString(),
                                style: getBodyStyle(),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.star_rounded,
                                size: 20,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              PhoneTile(
                                  backColor: AppColors.accentColor,
                                  onTap: () {},
                                  num: '1',
                                  imgAssetPath: Icons.phone),
                              if (widget.doctorModel.phone2 != '') ...[
                                const SizedBox(
                                  width: 15,
                                ),
                                PhoneTile(
                                  onTap: () {},
                                  backColor: AppColors.accentColor,
                                  imgAssetPath: Icons.phone,
                                  num: '2',
                                ),
                              ]
                            ],
                          ),
                        ]),
                  )
                ],
              ),
              const Gap(30),
              //bio
              Text(
                'النبذة التعريفية',
                style: getTitleStyle(),
              ),
              const Gap(10),
              Text(widget.doctorModel.bio ?? '', style: getBodyStyle()),
              const Gap(30),
              //place and time
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.accentColor,
                ),
                child: Column(
                  children: [
                    ItemTile(
                        icon: Icons.watch_later,
                        text:
                            '${widget.doctorModel.openHour} - ${widget.doctorModel.closeHour}'),
                    const Gap(5),
                    const Divider(
                      color: AppColors.white,
                    ),
                    const Gap(5),
                    ItemTile(
                        icon: Icons.location_on_rounded,
                        text: widget.doctorModel.address!)
                  ],
                ),
              ),
              const Gap(10),
              const Divider(
                color: AppColors.accentColor,
              ),
              const Gap(20),
              //phone and email
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'معلومات الاتصال',
                  style: getTitleStyle(),
                ),
              ),
              const Gap(10),
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.accentColor,
                ),
                child: Column(
                  children: [
                    ItemTile(
                        icon: Icons.email, text: widget.doctorModel.email!),
                    const Gap(5),
                    const Divider(
                      color: AppColors.white,
                    ),
                    const Gap(5),
                    ItemTile(
                        icon: Icons.phone, text: widget.doctorModel.phone1!),
                    if (widget.doctorModel.phone2!.isNotEmpty) ...[
                      const Gap(5),
                      const Divider(
                        color: AppColors.white,
                      ),
                      const Gap(5),
                      ItemTile(
                          icon: Icons.phone, text: widget.doctorModel.phone2!),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(text: 'احجز الموعد الان', onPressed: () {
          navigateTo(context,BookingScreen(
            doctorModel:widget.doctorModel ,
          ));
        }),
      ),
    );
  }
}
