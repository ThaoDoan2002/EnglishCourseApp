import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_app/common/models/course_entities.dart';
import 'package:courses_app/common/utils/app_colors.dart';
import 'package:courses_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import '../utils/image_res.dart';

BoxDecoration appBoxShadow({
  Color color = AppColors.primaryElement,
  double radius = 15,
  double sR = 1,
  double bR = 2,
  BoxBorder? boxBorder,
}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: boxBorder,
      boxShadow: [
        BoxShadow(
          color: Colors.red.withOpacity(0.1),
          offset: const Offset(0, 1),
          spreadRadius: sR,
          blurRadius: bR,
        )
      ]);
}

BoxDecoration appBoxShadowWithRadius(
    {Color color = AppColors.primaryElement,
    double radius = 15,
    double sR = 1,
    double bR = 2,
    BoxBorder? border}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.h), topRight: Radius.circular(20.h)),
      border: border,
      boxShadow: [
        BoxShadow(
          color: Colors.red.withOpacity(0.1),
          offset: const Offset(0, 1),
          spreadRadius: sR,
          blurRadius: bR,
        )
      ]);
}

BoxDecoration appBoxDecorationTextField(
    {Color color = AppColors.primaryBackground,
    double radius = 15,
    Color borderColor = AppColors.primaryFourElementText}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor));
}

class AppBoxDecorationImage extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final BoxFit fit;
  final CourseItem? courseItem;
  final Function()? func;

  const AppBoxDecorationImage(
      {super.key,
      this.width = 40,
      this.height = 40,
      this.imagePath = ImageRes.profile,
      this.fit = BoxFit.fitHeight,
      this.courseItem,
      this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: CachedNetworkImage(
        imageUrl: imagePath,
        imageBuilder: (context, imgProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: fit,
                image: imgProvider,
              ),
              borderRadius: BorderRadius.circular(20.w)),
          child: courseItem == null
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 20.w,
                      ),
                      child: FadeText(
                        text: courseItem!.name!,
                        color: Colors.black,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 20.w, bottom: 30.h),
                      child: FadeText(
                        text: "${courseItem!.price!} triệu",
                        color: Colors.black,
                        fontSize: 8,
                      ),
                    )
                  ],
                ),
        ),
        placeholder: (context, url) => Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
          // you can add pre loader iamge as well to show loading.
        ),
        errorWidget: (context, url, error) => Image.asset(ImageRes.defaultImg),)
    );
  }
}

BoxDecoration networkImageDecoration({required String imagepath}) {
  return BoxDecoration(image: DecorationImage(image: NetworkImage(imagepath)));
}
