class Lesson {
  final String time;
  final String subject;
  final String room;
  final String teacher;

  Lesson({
    required this.time,
    required this.subject,
    required this.room,
    required this.teacher,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      time: json['time'] ?? '',
      subject: json['subject'] ?? '',
      room: json['room'] ?? '',
      teacher: json['teacher'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'subject': subject,
      'room': room,
      'teacher': teacher,
    };
  }
}
