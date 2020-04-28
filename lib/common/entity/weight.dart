class WeightEntity {
  int id;
  int petId;
  double weightValue;
  DateTime createTime;
  DateTime updateTime;

  WeightEntity({
    this.id = 0,
    this.petId,
    this.weightValue,
    this.createTime,
    this.updateTime,
  });

  factory WeightEntity.fromJson(Map<String, dynamic> json) => WeightEntity(
        id: json["id"],
        petId: json["petId"],
        weightValue: json["weightValue"],
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "petId": petId,
        "weightValue": weightValue,
        "createTime": createTime == null ? "" : createTime.toIso8601String(),
        "updateTime": updateTime == null ? "" : updateTime.toIso8601String(),
      };
}
