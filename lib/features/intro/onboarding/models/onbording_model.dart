class OnboardingModel {
  final String? image ;
  final String? title ;
  final String? subtitle ;

  OnboardingModel({required this.image, required this.title, required this.subtitle});


}
List<OnboardingModel> onboardingPages = [
  OnboardingModel(
      image: 'assets/images/on1.svg',
      title: 'ابحث عن دكتور متخصص',
      subtitle:
      'اكتشف مجموعة واسعة من الأطباء الخبراء والمتخصصين في مختلف المجالات.'),
  OnboardingModel(
      image: 'assets/images/on2.svg',
      title: 'سهولة الحجز',
      subtitle: 'احجز المواعيد بضغطة زرار في أي وقت وفي أي مكان.'),
  OnboardingModel(
      image: 'assets/images/on3.svg',
      title: 'آمن وسري',
      subtitle: 'كن مطمئنًا لأن خصوصيتك وأمانك هما أهم أولوياتنا.')
];