class NotificationModel {
  final String title;
  final String time;
  final String content;
  final List<String> links;

  NotificationModel({
    required this.title,
    required this.time,
    required this.content,
    required this.links,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      time: json['time'],
      content: json['content'],
      links: List<String>.from(json['links'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time,
      'content': content,
      'links': links,
    };
  }
}
