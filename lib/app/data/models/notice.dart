class Notice {
  String date;
  String title;
  String content;

  Notice({
    required this.date,
    required this.title,
    required this.content,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      date: json['date'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'title': title,
      'content': content,
    };
  }
}
