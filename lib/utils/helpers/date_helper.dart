int getLastDateOfMonth(int year, int month) {
  DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
  return lastDayOfMonth.day;
}

int setIndexOfFirstDay(String dayName) {
  switch (dayName) {
    case "Monday":
      {
        return 0;
      }
    case "Tuesday":
      {
        return 1;
      }
    case "Wednesday":
      {
        return 2;
      }
    case "Thursday":
      {
        return 3;
      }
    case "Friday":
      {
        return 4;
      }
    case "Saturday":
      {
        return 5;
      }
    default:
      {
        return 6;
      }
  }
}

List<String> monthLong = [
  "Januari",
  "Februari",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember"
];

List<String> monthShort = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "Mei",
  "Jun",
  "Jul",
  "Agu",
  "Sept",
  "Okt",
  "Nov",
  "Des",
];

List<String> dayName = [
  "Senin",
  "Selasa",
  "Rabu",
  "Kamis",
  "Jum'at",
  "Sabtu",
  "Minggu",
];
