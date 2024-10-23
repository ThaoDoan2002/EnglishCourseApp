import 'package:courses_app/common/utils/app_colors.dart';
import 'package:courses_app/common/utils/constants.dart';
import 'package:courses_app/common/utils/image_res.dart';
import 'package:courses_app/common/widgets/app_bar.dart';
import 'package:courses_app/common/widgets/app_shadow.dart';
import 'package:courses_app/common/widgets/image_widgets.dart';
import 'package:courses_app/common/widgets/text_widgets.dart';
import 'package:courses_app/features/course_detail/controller/course_controller.dart';
import 'package:courses_app/features/course_detail/view/widgets/course_detail_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetail extends ConsumerStatefulWidget {
  const CourseDetail({super.key});

  @override
  ConsumerState<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends ConsumerState<CourseDetail> {
  late var args;

  @override
  void didChangeDependencies() {
    var id = ModalRoute.of(context)!.settings.arguments as Map;
    args = id["id"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var courseData =
        ref.watch(courseDetailControllerProvider(index: args.toInt()));
    var lessonData =
        ref.watch(courseLessonListControllerProvider(index: args.toInt()));

    return Scaffold(
      appBar: buildGlobalAppbar(title: "Chi tiết khoá học"),
      body: Padding(
        padding: EdgeInsets.only(left: 25.w, right: 25.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              courseData.when(
                  data: (data) {
                    if (data == null) {
                      return const SizedBox();
                    }
                    // In giá trị của data.status ra console để kiểm tra
                    print('data.status: ${data.status}');

                    return Column(
                      children: [
                        CourseDetailThumbnail(courseItem: data),
                        // CourseDetailIconText(courseItem: data),
                        CourseDetailDescription(courseItem: data),


                        // Kiểm tra điều kiện và hiển thị các widget nếu data.status là false
                        if (data.status == false) ...[
                          CourseDetailPrice(courseItem: data),
                          CourseDetailGoBuyButton(courseItem: data, ref: ref),
                        ],
                        CourseDetailIncludes(courseItem: data),
                      ],
                    );
                  },
                  error: (error, traceStack) =>
                      Text("Error loading the course data"),
                  loading: () => SizedBox(
                    height: 500.h,
                    child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                  )),
              lessonData.when(
                  data: (data) => data == null
                      ? const SizedBox()
                      : LessonInfo(lessonData: data, ref:ref),
                  error: (error, traceStack) =>
                      Text("Error loading the lesson data"),
                  loading: () => SizedBox(
                    height: 500.h,
                    child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
