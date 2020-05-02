import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';

class DiaryAPI {
  static Future<APIResponse<List<DiaryEntity>>> getDiaryList({
    int petId,
  }) {
    return HttpUtil().get("/diary", params: {
      "pet_id": petId,
    }).then((response) {
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        return APIResponse<List<DiaryEntity>>(
            data: data.map((item) => DiaryEntity.fromJson(item)).toList());
      }
      return APIResponse<List<DiaryEntity>>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<List<DiaryEntity>>(
          error: true, errorMessage: "An error occurred");
    });
  }

  static Future<APIResponse<DiaryEntity>> getDiaryByDiaryId({
    int diaryId,
  }) {
    return HttpUtil().get("/diary/$diaryId").then((response) {
      if (response.statusCode == 200) {
        return APIResponse<DiaryEntity>(
            data: DiaryEntity.fromJson(response.data['data']));
      }
      return APIResponse<DiaryEntity>(
          error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<DiaryEntity>(
          error: true, errorMessage: "An error occurred");
    });
  }

  static Future<APIResponse<bool>> insertDiary({
    DiaryEntity diary,
  }) {
    return HttpUtil().post("/diary", params: diary.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }

  static Future<APIResponse<bool>> deleteDiary({
    int diaryId,
  }) {
    return HttpUtil().delete("/diary", params: {
      "diary_id": diaryId,
    }).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }

  static Future<APIResponse<bool>> updateDiary({
    DiaryEntity diary,
  }) {
    return HttpUtil().put("/diary", params: diary.toJson()).then((response) {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    }).catchError((_) {
      return APIResponse<bool>(error: true, errorMessage: "An error occurred");
    });
  }
}
