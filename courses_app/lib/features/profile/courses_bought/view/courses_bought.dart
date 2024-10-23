import 'package:courses_app/common/models/course_entities.dart';
import 'package:courses_app/common/routes/app_routes_names.dart';
import 'package:courses_app/common/utils/app_colors.dart';
import 'package:courses_app/common/utils/constants.dart';
import 'package:courses_app/common/widgets/app_bar.dart';
import 'package:courses_app/common/widgets/text_widgets.dart';
import 'package:courses_app/features/profile/courses_bought/controller/courses_bought_controller.dart';
import 'package:courses_app/features/profile/courses_bought/widget/courses_bought_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesBought extends ConsumerWidget {
  const CoursesBought({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesList = ref.watch(coursesBoughtControllerProvider);
    return Scaffold(
      appBar: buildGlobalAppbar(title: "Khoá học của bạn"),
      body: switch (coursesList) {
        AsyncData(:final value) => value == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CoursesBoughtWidget(value: value),
        AsyncError(:final error) => Text('Error $error'),
        _ => const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.black26,
                strokeWidth: 2,
              ),
            ),
          )
      },
    );
  }
}
