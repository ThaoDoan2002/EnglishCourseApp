import 'package:courses_app/common/utils/constants.dart';
import 'package:dio/dio.dart';

import '../../../common/models/base_entities.dart';
import '../../../common/models/course_entities.dart';
import '../../../common/services/http_util.dart';

class BuyCourseRepo {
  static Future<BaseResponseEntity> buyCourse({CourseRequestEntity? rq}) async {
    var response = await HttpUtil().post(
      "payments/${rq?.id}/checkout/",
    );

    return BaseResponseEntity.fromJson(response['data']);
  }
}
