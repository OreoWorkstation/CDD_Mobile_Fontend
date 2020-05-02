class DiaryEntity {
  int id;
  int petId;
  String title;
  String content;
  String imagePath;
  String videoPath;
  String audioPath;
  DateTime createTime;
  DateTime updateTime;

  DiaryEntity({
    this.id,
    this.petId,
    this.title,
    this.content,
    this.imagePath,
    this.videoPath,
    this.audioPath,
    this.createTime,
    this.updateTime,
  });

  factory DiaryEntity.fromJson(Map<String, dynamic> json) => DiaryEntity(
        id: json["id"],
        petId: json["petId"],
        title: json["title"],
        content: json["content"],
        imagePath: json["imagePath"],
        videoPath: json["videoPath"],
        audioPath: json["audioPath"],
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "petId": petId,
        "title": title,
        "content": content,
        "imagePath": imagePath,
        "videoPath": videoPath,
        "audioPath": audioPath,
        "createTime": createTime == null ? "" : createTime.toIso8601String(),
        "updateTime": updateTime == null ? "" : updateTime.toIso8601String(),
      };
}
