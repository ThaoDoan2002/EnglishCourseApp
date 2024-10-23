import 'package:courses_app/common/models/course_entities.dart';

import '../../../../common/models/base_entities.dart';
import '../../../../common/services/http_util.dart';

class CoursesBoughtRepo {
  static Future<CourseListResponseEntity> courseBought(
      {CourseRequestEntity? rq}) async {
    var response = await HttpUtil().get('/courses/courses_bought/');
    return CourseListResponseEntity.fromJson(response['data']);
  }
}
