import 'package:courses_app/common/models/course_entities.dart';
import 'package:courses_app/common/models/lesson_entities.dart';
import 'package:courses_app/features/course_detail/repo/course_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_controller.g.dart';

@riverpod
Future<CourseItem?> courseDetailController(
    CourseDetailControllerRef ref, {required int index}) async {
  CourseRequestEntity courseRequestEntity = CourseRequestEntity();
  courseRequestEntity.id = index;
  final response = await CourseRepo.courseDetail(id: courseRequestEntity);
  if (response != {}) {
    print(response?.data?.thumbnail);
    return response?.data;
  } else {
    print('request failed');
  }
  return null;
}

@riverpod
Future<List<LessonItem>?> courseLessonListController(
    CourseLessonListControllerRef ref, {required int index}) async {
  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;
  final response = await CourseRepo.courseLessonList(id: lessonRequestEntity);
  if (response != []) {
    print(response);
    return response?.data;
  } else {
    print('request failed');
  }
  return null;
}
