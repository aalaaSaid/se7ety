//list of available hours

List<int> availableHours ({DateTime? date , String? openHour , String? endHour}){
  List<int> hours = [];
  int start = int.parse(openHour!);
  int end = int.parse(endHour!);
  for(int i = start ; i <= end-1 ; i++){
    int diffDays = date!.difference(DateTime.now()).inDays;
    if(diffDays != 0){
      hours.add(i);
    }else {
      if(i > DateTime.now().hour){
        hours.add(i);
      }
    }
  }
  return hours;
}
