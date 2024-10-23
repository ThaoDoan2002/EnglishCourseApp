import 'package:courses_app/common/utils/app_colors.dart';
import 'package:courses_app/common/utils/image_res.dart';
import 'package:courses_app/common/widgets/app_shadow.dart';
import 'package:courses_app/common/widgets/app_textfield.dart';
import 'package:courses_app/common/widgets/image_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key, this.func});
  final VoidCallback? func;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //search text box
        Container(
          width: 280.w,
          height: 40.h,
          decoration: appBoxShadow(
              color: AppColors.primaryBackground,
              boxBorder: Border.all(color: AppColors.primaryFourElementText)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 17.w),
                child: AppImage(imagePath: ImageRes.searchIcon),
              ),
              Container(
                width: 240.w,
                height: 40.h,
                child: appTextFieldOnly(
                    width: 240, height: 40, hintText: 'Tìm kiếm khoá học...'),
              )
            ],
          ),
        ),

        //search button
        GestureDetector(
          onTap: func,
          child: Container(
            padding: EdgeInsets.all(5.w),
            width: 40.w,
            height: 40.h,
            decoration: appBoxShadow(
                boxBorder: Border.all(color: AppColors.primaryElement)),
            child: AppImage(imagePath: ImageRes.searchButton),
          ),
        ),
      ],
    );
  }
}

