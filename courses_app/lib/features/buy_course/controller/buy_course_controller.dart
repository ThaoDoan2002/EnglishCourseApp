import 'package:courses_app/common/models/course_entities.dart';
import 'package:courses_app/common/models/lesson_entities.dart';
import 'package:courses_app/features/course_detail/repo/course_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repo/buy_course_repo.dart';

part 'buy_course_controller.g.dart';

@riverpod
Future<String?> buyCourseController(
    BuyCourseControllerRef ref, {required int index}) async {
  CourseRequestEntity courseRequestEntity = CourseRequestEntity();
  courseRequestEntity.id = index;
  final response = await BuyCourseRepo.buyCourse(rq: courseRequestEntity);
  if (response!={}) {
    return response.data;
  } else {
    print('request failed');
    return null;
  }
  return null;
}