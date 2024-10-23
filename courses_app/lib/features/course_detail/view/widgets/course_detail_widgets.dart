import 'package:courses_app/common/models/lesson_entities.dart';
import 'package:courses_app/common/widgets/button_widgets.dart';
import 'package:courses_app/features/lesson_detail/controller/lesson_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/models/course_entities.dart';
import '../../../../common/utils/app_colors.dart';
import '../../../../common/utils/constants.dart';
import '../../../../common/utils/image_res.dart';
import '../../../../common/widgets/app_shadow.dart';
import '../../../../common/widgets/image_widgets.dart';
import '../../../../common/widgets/text_widgets.dart';
import '../../controller/course_controller.dart';

class CourseDetailThumbnail extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailThumbnail({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return AppBoxDecorationImage(
      imagePath: "${AppConstants.IMAGE_UPLOADS_PATH}${courseItem.thumbnail}",
      width: 325.w,
      height: 200.h,
      fit: BoxFit.fitWidth,
    );
  }
}

class CourseDetailIconText extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailIconText({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      width: 325.w,
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              decoration: appBoxShadow(radius: 7),
              child: const Text10Normal(
                text: "Author Page",
                color: AppColors.primaryElementText,
              ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(left: 30.w),
          //   child: Row(
          //     children: [
          //       const AppImage(imagePath: ImageRes.people),
          //       Text11Normal(
          //         text: courseItem.follow == null
          //             ? "0"
          //             : courseItem.follow.toString(),
          //         color: AppColors.primaryThreeElementText,
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(left: 30.w),
          //   child: Row(
          //     children: [
          //       const AppImage(imagePath: ImageRes.star),
          //       Text11Normal(
          //         text: courseItem.score == null
          //             ? "0"
          //             : courseItem.score.toString(),
          //         color: AppColors.primaryThreeElementText,
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class CourseDetailDescription extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailDescription({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text16Normal(
            text: courseItem.name ?? "No name found",
            color: AppColors.primaryText,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
          ),
          Container(
            child: Text11Normal(
              text: courseItem.description ?? "No description found",
              color: AppColors.primaryThreeElementText,
            ),
          ),

        ],
      ),
    );
  }
}



class CourseDetailPrice extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailPrice({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text16Normal(
            text: "${courseItem.price.toString()} triệu"  ?? "No name found",
            color: AppColors.primaryText,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}

class CourseDetailGoBuyButton extends StatelessWidget {
  final CourseItem courseItem;
  final WidgetRef ref;

  const CourseDetailGoBuyButton(
      {super.key, required this.courseItem, required this.ref});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          "/buy_course",
          arguments: {
            "id": courseItem.id,
          },
        ).then((_) {
          // Refresh lại courseDetailControllerProvider với index tương ứng
          ref.refresh(courseDetailControllerProvider(index: courseItem.id!));
          ref.refresh(courseLessonListControllerProvider(index: courseItem.id!));
        });
      },
      child: Container(
          margin: EdgeInsets.only(top: 20.h),
          child: const AppButton(buttonName: "Mua")),
    );
  }
}

class CourseDetailIncludes extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailIncludes({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text14Normal(
          //   text: "Khoá học bao gồm",
          //   color: AppColors.primaryText,
          //   fontWeight: FontWeight.bold,
          // ),
          // SizedBox(
          //   height: 12.h,
          // ),
        ],
      ),
    );
  }
}

class CourseInfo extends StatelessWidget {
  final String imagePath;
  final String? length;
  final String? infoText;

  const CourseInfo(
      {super.key,
      this.infoText = "item",
      required this.imagePath,
      this.length});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: AppImage(
            imagePath: imagePath,
            width: 30,
            height: 30,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w),
          child: Text11Normal(
            color: AppColors.primarySecondaryElementText,
            text: length == null ? "0 $infoText" : "${length} $infoText",
          ),
        )
      ],
    );
  }
}

class LessonInfo extends StatelessWidget {
  final List<LessonItem> lessonData;
  final WidgetRef ref;

  const LessonInfo(
      {super.key,
      required this.lessonData,
      required this.ref,
     });

  @override
  Widget build(BuildContext context) {
    print('my course lesson number ${lessonData.length}');
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          lessonData.isNotEmpty
              ? const Text14Normal(
                  text: "Danh sách bài học",
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                )
              : const Text14Normal(
                  text: "Không có bài học nào",
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
          SizedBox(
            height: 10.h,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: lessonData.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.only(top: 10.h),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  width: 325.w,
                  height: 80.h,
                  decoration: appBoxShadow(
                    radius: 10,
                    sR: 2,
                    bR: 3,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (lessonData[index].status != false) {
                        ref.watch(lessonDetailControllerProvider(
                            index: lessonData[index].id!));
                        Navigator.of(context).pushNamed("/lesson_detail",
                            arguments: {"id": lessonData[index].id!});
                      }
                    },
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppBoxDecorationImage(
                          width: 60.w,
                          height: 60.h,
                          fit: BoxFit.fill,
                          imagePath:
                              "${AppConstants.IMAGE_UPLOADS_PATH}${lessonData[index].thumbnail}",
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text13Normal(
                                text: lessonData[index].subject,
                              ),
                              Text10Normal(
                                text: lessonData[index].description!,
                              ),
                            ],
                          ),
                        ),
                        // Expanded(child: Container()),
                        const AppImage(
                          imagePath: ImageRes.arrowRight,
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
