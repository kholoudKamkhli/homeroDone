class PackageModel {
  static const String COLLECTION_NAME = "Packages";
  String id;
  String title;
  String color;
  double cost;
  PackageModel({
    required this.cost,
    required this.color,
    required this.id,
    required this.title,
  });
  PackageModel.fromJson(Map<String, dynamic> json)
      : this(id: json["id"], title: json["title"],color:json["color"]
       ,cost: double.parse(json["cost"].toString()));
  Map<String, dynamic> toJson() {
    return {"id": id, "title": title,"color":color,"cost":cost};
  }
}
