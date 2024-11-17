class NotificationData {
  final String? title;
  final String? body;
  final String? deepLink;

  NotificationData({
    this.title,
    this.body,
    this.deepLink,
  });

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      title: map['title']?.toString(),
      body: map['body']?.toString(),
      deepLink: map['deepLink']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'deepLink': deepLink,
    };
  }
}
