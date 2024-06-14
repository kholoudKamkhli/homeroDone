class NotificationModel {
  static const String COLLECTION_NAME = "Notifications";
  String content;
  DateTime date;
  NotificationModel({
    required this.content,
    required this.date,
  });
  NotificationModel.fromJson(Map<String, dynamic> json)
      : this(content:json["content"]
      ,date:DateTime.fromMillisecondsSinceEpoch(json['date']),);
  Map<String, dynamic> toJson() {
    return {"content": content, "date":date.millisecondsSinceEpoch,};
  }
}