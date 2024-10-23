import 'package:courses_app/common/models/course_entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/routes/app_routes_names.dart';
import '../../../../common/utils/app_colors.dart';
import '../../../../common/utils/constants.dart';
import '../../../../common/utils/image_res.dart';
import '../../../../common/widgets/image_widgets.dart';
import '../../../../common/widgets/text_widgets.dart';

class CoursesBoughtWidget extends StatelessWidget {
  final List<CourseItem> value;
  const CoursesBoughtWidget({super.key, required this.value});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: value.length,
        itemBuilder: (_, index) {
          return Container(
            width: 325.w,
            height: 80.h,
            margin: EdgeInsets.only(bottom: 15.h),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 1))
            ]),
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                  AppRoutesNames.COURSE_DETAIL,
                  arguments: {"id": value.elementAt(index).id}),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60.h,
                        width: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(
                                    "${AppConstants.IMAGE_UPLOADS_PATH}${value.elementAt(index).thumbnail}"))),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 6.w),
                            width: 180.w,
                            child: Text14Normal(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              text: value.elementAt(index).name.toString(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: 55.w,
                    alignment: Alignment.centerRight,
                    child: AppImage(
                      imagePath: ImageRes.arrowRight,
                      width: 24,
                      height: 24,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
