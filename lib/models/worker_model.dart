class WorkerModel {
  static const String COLLECTION_NAME = "Workers";

  String name;
  String jobTitle;
  int numOfTasks;
  int numOfRatings;
  String imagePath;
  String serviceName;
  String latestReview;
  WorkerModel(
      {required this.latestReview,
      required this.imagePath,
      required this.numOfRatings,
      required this.jobTitle,
      required this.name,
      required this.numOfTasks,
      required this.serviceName});
  WorkerModel.fromJson(Map<String, dynamic> json)
      : this(
          latestReview: json["latestReview"],
          name: json["name"],
          jobTitle: json["jobTitle"],
          numOfTasks: json["numOfTasks"],
          imagePath: json["imagePath"],
          numOfRatings: json["numOfRatings"],
          serviceName: json["serviceName"],
        );
  Map<String, dynamic> toJson() {
    return {
      "latestReview": latestReview,
      "name": name,
      "jobTitle": jobTitle,
      "numOfTasks": numOfTasks,
      "numOfRatings": numOfRatings,
      "imagePath": imagePath,
      "serviceName": serviceName,
    };
  }
}
