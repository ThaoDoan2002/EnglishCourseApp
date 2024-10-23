import 'package:courses_app/common/utils/app_colors.dart';
import 'package:courses_app/common/widgets/app_shadow.dart';
import 'package:courses_app/common/widgets/image_widgets.dart';
import 'package:courses_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget thirdPartyLogin() {
  return Container(
    margin: EdgeInsets.only(left: 140, right: 140, top: 40, bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _loginButton("assets/icons/google.png"),
        _loginButton("assets/icons/facebook.png"),
      ],
    ),
  );
}

Widget _loginButton(String imagePath) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 40,
      height: 40,
      child: Image.asset(imagePath),
    ),
  );
}


