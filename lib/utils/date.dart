bool isDateEqual(DateTime date1 , DateTime date2){
  if (date1.isBefore(date2)) {
    return false;
  } 
  else if (date1.isAfter(date2)) {
    return false;
  }
  return true;
}