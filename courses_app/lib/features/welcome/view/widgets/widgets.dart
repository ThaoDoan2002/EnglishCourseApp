import 'package:courses_app/common/utils/constants.dart';
import 'package:courses_app/common/widgets/app_shadow.dart';
import 'package:courses_app/common/widgets/text_widgets.dart';
import 'package:courses_app/global.dart';
import 'package:courses_app/features/sign_in/view/sign_in.dart';
import 'package:flutter/material.dart';

Widget appOnboardingPage(PageController controller,
    {String imagePath = "assets/images/reading.png",
    String title = "",
    String subTitle = "",
    int index = 0,
    required BuildContext context}) {
  return Column(
    children: [
      Image.asset(
        imagePath,
        fit: BoxFit.fitWidth,
      ),
      Container(
        margin: const EdgeInsets.only(top: 15),
        child: text24Normal(text: title),
      ),
      Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Text16Normal(text: subTitle),
      ),
      _nextButton(
        index,
        controller,context
      )
    ],
  );
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      bool deviceFirstTime=Global.storageService.getDeviceFirstOpen();
      print("from tab ${deviceFirstTime}");
      if (index < 3) {
        controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      } else {
        Global.storageService.setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_KEY, true);
       Navigator.pushNamed(context, "/sign_in");
      }
    },
    child: Container(
      width: 200,
      height: 50,
      margin: const EdgeInsets.only(top: 70, left: 25, right: 25),
      decoration: appBoxShadow(),
      child: Center(
          child: Text16Normal(
              text: index == 3 ? 'Bắt đầu' : 'Tiếp tục', color: Colors.white)),
    ),
  );
}
