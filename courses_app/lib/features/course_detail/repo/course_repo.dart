import 'package:courses_app/common/models/course_entities.dart';
import 'package:courses_app/common/models/lesson_entities.dart';
import 'package:courses_app/common/services/http_util.dart';

class CourseRepo {
  static Future<CourseDetailResponseEntity?> courseDetail(
      {CourseRequestEntity? id}) async {
    var response = await HttpUtil().get(
      "/courses/${id?.id}/",
    );
    return CourseDetailResponseEntity.fromJson(response["data"]);
  }

  static Future<LessonListResponseEntity?> courseLessonList(
      {LessonRequestEntity? id}) async {
    var response = await HttpUtil().get(
      "/courses/${id?.id}/lessons/",
    );
    return LessonListResponseEntity.fromJson(response["data"]);
  }
}


