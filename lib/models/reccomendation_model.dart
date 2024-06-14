class RecommendationModel {
  static const String COLLECTION_NAME = "Recommendations";
  String imagePath;
  String id;
  RecommendationModel({required this.imagePath, this.id = ""});
  RecommendationModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          imagePath: json["imagePath"],
        );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "imagePath": imagePath,
    };
  }
}
