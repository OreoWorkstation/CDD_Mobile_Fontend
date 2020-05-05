class PhotoEntity {
  int id;
  int petId;
  String photoPath;
  String description;
  DateTime createTime;
  DateTime updateTime;

  PhotoEntity({
    this.id,
    this.petId,
    this.photoPath,
    this.description,
    this.createTime,
    this.updateTime,
  });

  factory PhotoEntity.fromJson(Map<String, dynamic> json) => PhotoEntity(
        id: json["id"],
        petId: json["petId"],
        photoPath: json["photoPath"],
        description: json["description"],
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "petId": petId,
        "photoPath": photoPath,
        "description": description,
        "createTime": createTime == null ? "" : createTime.toIso8601String(),
        "updateTime": updateTime == null ? "" : updateTime.toIso8601String(),
      };
}
