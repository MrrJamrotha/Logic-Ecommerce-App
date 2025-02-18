class AppFormat {
  static int toInt(dynamic value) {
    if (value == null) return 0; // Default to 0 if null
    if (value is int) return value; // If already an int, return it
    if (value is String && value.isNotEmpty) {
      return int.tryParse(value) ?? 0; // Try parsing, default to 0 if fails
    }
    throw FormatException(
        'Cannot convert value to int: $value (${value.runtimeType})');
  }

  static double toDouble(dynamic value) {
    String cleanValue = value.toString().replaceAll(RegExp(r'[^0-9.]'), '');
    return double.parse(cleanValue);
  }

  static String toStr(dynamic value) {
    if (value == null) return "";
    return value.toString();
  }

  static String formatDuration(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    seconds = seconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
