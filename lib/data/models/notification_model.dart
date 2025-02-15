class NotificationModel {
  final String title;
  final String message;
  final String imageUrl;
  final DateTime timestamp;

  NotificationModel({
    required this.title,
    required this.message,
    required this.imageUrl,
    required this.timestamp,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      message: json['message'],
      imageUrl: json['imageUrl'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
