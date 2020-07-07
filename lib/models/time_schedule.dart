class TimeSchedule {
  DateTime currentTime = DateTime.now();

  overNextMinute() {
    final scheduleNotificationTime = currentTime.add(Duration(seconds: 60));
    return scheduleNotificationTime;
  }

  overNextTenMinutes() {
    final scheduleNotificationTime = currentTime.add(Duration(minutes: 10));
    return scheduleNotificationTime;
  }

  overNextHour() {
    final scheduleNotificationTime = currentTime.add(Duration(hours: 1));
    return scheduleNotificationTime;
  }

  overNextDay() {
    final scheduleNotificationTime = currentTime.add(Duration(days: 1));
    return scheduleNotificationTime;
  }
}
