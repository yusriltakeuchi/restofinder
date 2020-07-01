
class CollectionModel {
  int id;
  String title;
  String description;
  int count;
  String imgURL;

  CollectionModel({
    this.id, this.title, 
    this.description, this.count, 
    this.imgURL
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: int.parse(json["collection_id"].toString()) ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      count: int.parse(json["res_count"].toString()) ?? 0,
      imgURL: json["image_url"] ?? ""
    );
  }
}