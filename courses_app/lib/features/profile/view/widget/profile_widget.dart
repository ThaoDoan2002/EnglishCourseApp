import 'package:courses_app/common/widgets/text_widgets.dart';
import 'package:courses_app/features/profile/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/utils/constants.dart';
import '../../../../common/utils/image_res.dart';
import '../../../../common/widgets/image_widgets.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      var profileImage = ref.read(profileControllerProvider);
      return Container(
        alignment: Alignment.bottomRight,
        width: 80.w,
        height: 80.h,
        decoration: profileImage.avatar == null
            ? BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20.w),
                image:
                    const DecorationImage(image: AssetImage(ImageRes.headPic)),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                image: DecorationImage(
                    image: NetworkImage("${profileImage.avatar}")),
              ),
        child:
            AppImage(width: 25.w, height: 25.h, imagePath: ImageRes.editImage),
      );
    });
  }
}

class ProfileNameWidget extends StatelessWidget {
  const ProfileNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      var profileName = ref.read(profileControllerProvider);
      return Container(
          margin: EdgeInsets.only(top: 12.h),
          child: Text13Normal(
              fontWeight: FontWeight.bold,
              text: profileName.username != null
                  ? "${profileName.username}"
                  : ""));
    });
  }
}

// class ProfileDescriptionWidget extends StatelessWidget {
//   const ProfileDescriptionWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//         builder: (BuildContext context, WidgetRef ref, Widget? child) {
//           var profileName = ref.read(profileControllerProvider);
//           return Container(
//               margin: EdgeInsets.only(top: 12.h),
//               child:Text13Normal(fontWeight: FontWeight.bold,text:profileName.username!=null?"${profileName.username}":"")
//           );
//         });
//   }
// }
