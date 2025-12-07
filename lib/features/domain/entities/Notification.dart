enum NotificationType { promotion, orderStatus, system }

class Notification {
  final String notificationID;
  final String userID;
  final String title;
  final NotificationType type;
  final String logoURL;
  final String body;
  final DateTime timestamp;
  bool isRead;

  Notification({
    required this.notificationID,
    required this.userID,
    required this.title,
    required this.type,
    required this.logoURL,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });

  void markAsRead() {
    isRead = true;
    // Logic to update backend
  }
}