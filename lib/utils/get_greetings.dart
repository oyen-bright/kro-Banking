String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour < 12) {
    return 'Good morning';
  } else if (hour < 17) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}
