import 'package:courses_app/common/api/course_api.dart';
import 'package:courses_app/common/models/course_entities.dart';
import 'package:courses_app/common/models/entities.dart';
import 'package:courses_app/global.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeScreenBannerDots extends _$HomeScreenBannerDots {
  @override
  int build() => 0;

  void setIndex(int value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class HomeUserProfile extends _$HomeUserProfile {
  FutureOr<UserProfile> build() {
    return Global.storageService.getUserProfile();
  }
}

@Riverpod(keepAlive: true)
class HomeCourseList extends _$HomeCourseList {
  Future<List<CourseItem>?> fetchCourseList() async {
    var result = await CourseAPI.courseList();
    if (result.results != []) {
      return result.results;
    }
    return null;
  }

  @override
  FutureOr<List<CourseItem>?> build() {
    return fetchCourseList();
  }
}
