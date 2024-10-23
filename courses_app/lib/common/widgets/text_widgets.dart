import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget text24Normal(
    {String text = "",
    Color color = AppColors.primaryText,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: 24,
      fontWeight: fontWeight,
    ),
  );
}

class Text13Normal extends StatelessWidget {
  final String? text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final int maxLines;

  const Text13Normal(
      {super.key,
        this.text = "",
        this.color = AppColors.primaryText,
        this.fontWeight = FontWeight.bold,
        this.textAlign = TextAlign.start,
      this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text!,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: 13.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}

class Text16Normal extends StatelessWidget {
  final String? text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const Text16Normal(
      {super.key,
      this.text = "",
      this.color = AppColors.primarySecondaryElementText,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 16.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}

class Text14Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight? fontWeight;

  const Text14Normal(
      {super.key,
      this.text = "",
      this.color = AppColors.primaryThreeElementText,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}

class Text10Normal extends StatelessWidget {
  final String text;
  final Color color;

  const Text10Normal(
      {super.key,
      this.text = "",
      this.color = AppColors.primaryThreeElementText});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.start,
      style: TextStyle(

        color: color,
        fontSize: 10.sp,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class Text9Normal extends StatelessWidget {
  final String text;
  final Color color;

  const Text9Normal(
      {super.key,
        this.text = "",
        this.color = AppColors.primaryThreeElementText});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.start,
      style: TextStyle(

        color: color,
        fontSize: 9.sp,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}


class Text11Normal extends StatelessWidget {
  final String? text;
  final Color color;
  final FontWeight? fontWeight;

  const Text11Normal(
      {super.key, this.text = "", this.color = AppColors.primaryElementText, this.fontWeight=FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: 11.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}

Widget textUnderline({String text = "Your text"}) {
  return GestureDetector(
    onTap: () {},
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.primaryText,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.sp,
      ),
    ),
  );
}

class FadeText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const FadeText(
      {super.key,
      this.text = "",
      this.color = AppColors.primaryElementText,
      this.fontSize = 10});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: false,
      maxLines: 1,
      textAlign: TextAlign.left,
      overflow: TextOverflow.fade,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
