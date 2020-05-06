import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';

Map<DateTime, List> cddConvertDiaryMap(List<DiaryEntity> diaryList) {
  Map<DateTime, List> res = {};
  List list = [];
  for (DiaryEntity diary in diaryList) {
    list.add(diary.imagePath);
    list.add(diary.videoPath);
    list.add(diary.audioPath);
    list.add(diary.content);
    list.add(diary.id);
    res.putIfAbsent(cddFormatDatetime(diary.createTime), () => list);
    list = [];
  }
  return res;
}
