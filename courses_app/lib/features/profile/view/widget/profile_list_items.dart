import 'package:courses_app/common/routes/app_routes_names.dart';
import 'package:courses_app/common/utils/app_colors.dart';
import 'package:courses_app/common/utils/image_res.dart';
import 'package:courses_app/common/widgets/image_widgets.dart';
import 'package:courses_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListItems extends StatelessWidget {
  const ProfileListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
      child: Column(
        children: [
          ListItem(
            text: "Cài đặt",
            imagePath: ImageRes.settings,
            func:()=>Navigator.of(context).pushNamed(AppRoutesNames.SETTINGS)
          ),
          ListItem(
            text: "Chi tiết hoá đơn",
            imagePath: ImageRes.creditCard,
          ),
          ListItem(
            text: "Khoá học hoàn thành",
            imagePath: ImageRes.award,
          ),
          ListItem(
            text: "Yêu thích",
            imagePath: ImageRes.love,
          ),
          ListItem(
            text: "Nhắc nhở",
            imagePath: ImageRes.reminder,
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback? func;

  const ListItem({super.key, required this.imagePath, required this.text, this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            padding: EdgeInsets.all(7.w),
            margin: EdgeInsets.only(bottom: 15.h),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryElement),
            ),
            child: AppImage(
              imagePath: imagePath,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.w, bottom: 15.h),
            child: Text13Normal(
              textAlign: TextAlign.center,
              text: text,
            ),
          )
        ],
      ),
    );
  }
}
