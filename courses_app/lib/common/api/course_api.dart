import 'package:courses_app/common/models/course_entities.dart';
import 'package:courses_app/common/services/http_util.dart';

class CourseAPI{
  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().get('/courses/');
    return CourseListResponseEntity.fromJson(response["data"]);

  }
}
