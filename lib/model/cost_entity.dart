class CostEntity {
  int id;
  int petId;
  String costContent;
  double costValue;
  DateTime createTime;
  DateTime updateTime;

  CostEntity({
    this.id,
    this.petId,
    this.costContent,
    this.costValue,
    this.createTime,
    this.updateTime,
  });

  factory CostEntity.fromJson(Map<String, dynamic> json) => CostEntity(
    id: json["id"],
    petId: json["petId"],
    costContent: json["costContent"],
    costValue: json["costValue"],
    createTime: DateTime.parse(json["createTime"]),
    updateTime: DateTime.parse(json["updateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "petId": petId,
    "costContent": costContent,
    "costValue": costValue,
    "createTime": createTime == null ? "" : createTime.toIso8601String(),
    "updateTime": updateTime == null ? "" : updateTime.toIso8601String(),
  };
}
