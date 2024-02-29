DateTime extractDateTime(DateTime dateTime) {
  // 2024-2-26 04:12:90 am
  // 2024-2-26 00:00:00 am
  return DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
  );
}
