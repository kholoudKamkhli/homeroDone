class AdModel{
  static const String COLLECTION_NAME  = "Ads";
  String title;
  String imagePath;
  String backgroundImagePath;
  String id;
  AdModel({required this.id,required this.title,required this.imagePath,required this.backgroundImagePath});
  AdModel.fromJson(Map<String,dynamic>json):this(
      id: json["id"],
      title:json["title"],
      imagePath:json["imagePath"],
      backgroundImagePath:json["backgroundImagePath"],
  );
  Map<String,dynamic>toJson(){
    return {
      "id":id,
      "title":title,
      "imagePath":imagePath,
      "backgroundImagePath":backgroundImagePath
    };
  }
}