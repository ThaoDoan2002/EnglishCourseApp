import 'dart:async';

import 'package:courses_app/features/profile/courses_bought/repo/courses_bought_repo.dart';
import 'package:flutter/foundation.dart';

import '../../../../common/models/course_entities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'courses_bought_controller.g.dart';

@riverpod
class CoursesBoughtController extends _$CoursesBoughtController {
  @override
  FutureOr<List<CourseItem>?> build() async {
    final response = await CoursesBoughtRepo.courseBought();
    if (response.results != []) {
      return response.results;
    } else {
      if (kDebugMode) {
        print("Request failed");
      }
    }

    return null;
  }
}
