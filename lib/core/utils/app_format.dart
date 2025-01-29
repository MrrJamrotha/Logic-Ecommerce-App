class AppFormat {
  static int toInt(dynamic value) {
    return int.parse(value);
  }

  static double toDouble(dynamic value) {
    return double.parse(value);
  }

  static String toStr(dynamic value) {
    return value.toString();
  }

  static String formatDuration(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    seconds = seconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
