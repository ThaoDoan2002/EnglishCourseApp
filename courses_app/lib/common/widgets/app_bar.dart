import 'package:courses_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

AppBar buildAppbar({String title = ""}) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        color: Colors.grey.withOpacity(0.3),
        height: 1,
      ),
    ),
    centerTitle: true,
    title: Text16Normal(
      text: title,
      color: AppColors.primaryText,
    ),
  );
}

AppBar buildGlobalAppbar({String title = ""}) {
  return AppBar(
    title: Text16Normal(
      text: title,
      color: AppColors.primaryText,fontWeight: FontWeight.bold,
    ),
  );
}
