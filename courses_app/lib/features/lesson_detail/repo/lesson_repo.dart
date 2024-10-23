import '../../../common/models/lesson_entities.dart';
import '../../../common/services/http_util.dart';

class LessonRepo {

  static Future<LessonDetailResponseEntity?> courseLessonDetail(
      {LessonRequestEntity? rq}) async {
    print('---------------request${rq?.id}');
    var response = await HttpUtil().get(
      "/lessons/${rq?.id}/videos/",
    );
    return LessonDetailResponseEntity.fromJson(response["data"]);
  }
}