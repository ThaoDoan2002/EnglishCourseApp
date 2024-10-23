import '../../../common/models/course_entities.dart';
import '../../../common/services/http_util.dart';

class CoursesSearchRepos{
  static Future<CourseListResponseEntity> coursesDefaultSearch(
      {CourseRequestEntity? rq}) async {
    var response = await HttpUtil().get('/courses/');
    return CourseListResponseEntity.fromJson(response['data']);
  }

  static Future<CourseListResponseEntity> coursesSearch(
      {CourseRequestEntity? rq}) async {
    var response = await HttpUtil().get('/courses/courses_bought/');
    return CourseListResponseEntity.fromJson(response['data']);
  }
}