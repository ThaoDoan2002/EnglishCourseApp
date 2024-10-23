import 'package:courses_app/common/global_loader/global_loader.dart';
import 'package:courses_app/common/utils/image_res.dart';
import 'package:courses_app/common/widgets/button_widgets.dart';
import 'package:courses_app/common/widgets/text_widgets.dart';
import 'package:courses_app/features/sign_in/provider/sign_in_notifier.dart';
import 'package:courses_app/features/sign_in/controller/sign_in_controller.dart';
import 'package:courses_app/features/sign_in/view/widgets/sign_in_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/app_colors.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/app_textfield.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  late SignInController _controller;

  @override
  void didChangeDependencies() {
    _controller = SignInController();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  //Phương thức này được gọi ngay sau initState() và bất cứ khi nào một dependency mà widget dựa vào thay đổi.

  @override
  Widget build(BuildContext context) {
    // final signInProvider = ref.watch(signInNotifierProvider);
    final loader = ref.watch(appLoaderProvider);
    return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          appBar: buildAppbar(title: "Đăng nhập"),
          backgroundColor: Colors.white,
          body: loader == false
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //top login button
                      thirdPartyLogin(),
                      //more login options
                      const Center(
                          child: Text14Normal(
                              text: "Đăng nhập bằng tài khoản khác của bạn")),
                      const SizedBox(height: 50),
                      //email text box
                      appTextField(
                          controller: _controller.usernameController,
                          text: "Tên đăng nhập",
                          iconName: ImageRes.user,
                          hintText: "Nhập tên đăng nhập",
                          func: (value) => ref
                              .read(signInNotifierProvider.notifier)
                              .onUsernameChange(value)),

                      const SizedBox(height: 20),
                      //password text box
                      appTextField(
                        controller: _controller.passwordController,
                        text: "Mật khẩu",
                        iconName: ImageRes.lock,
                        hintText: "Nhập mật khẩu",
                        obscureText: true,
                        func: (value) => ref
                            .read(signInNotifierProvider.notifier)
                            .onPasswordChange(value),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      //forgot text
                      Container(
                        margin: EdgeInsets.only(left: 25.w),
                        child: textUnderline(text: "Quên mật khẩu"),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      //app login button
                      Center(
                          child: AppButton(
                        buttonName: "Đăng nhập",
                        func: () => _controller.handleSignIn(ref),
                      )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                          child: AppButton(
                              buttonName: "Đăng ký",
                              isLogin: false,
                              context: context,
                              func: () =>
                                  Navigator.pushNamed(context, '/register'))),
                      //app register button
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      color: AppColors.primaryElement),
                ),
        )));
  }
}
