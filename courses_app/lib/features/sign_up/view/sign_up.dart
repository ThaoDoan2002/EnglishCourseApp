import 'package:courses_app/common/global_loader/global_loader.dart';
import 'package:courses_app/common/utils/app_colors.dart';
import 'package:courses_app/common/utils/image_res.dart';
import 'package:courses_app/common/widgets/button_widgets.dart';
import 'package:courses_app/common/widgets/text_widgets.dart';
import 'package:courses_app/features/sign_up/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/app_textfield.dart';
import '../provider/register_notifier.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  late SignUpController _controller;

  @override
  void initState() {
    _controller = SignUpController(ref: ref);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final regProvider = ref.watch(registerNotifierProvider);
    //regProvider.
    final loader = ref.watch(appLoaderProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppbar(title: "Đăng ký"),
            backgroundColor: Colors.white,
            body: loader == false
                ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  //more login options message
                  const Center(
                      child:  Text14Normal(
                          text:
                          "Nhập thông tin của bạn để đăng ký tài khoản")),
                  SizedBox(
                    height: 50.h,
                  ),
                  //first name text box
                  appTextField(
                    text: "Tên",
                    iconName: ImageRes.user,
                    hintText: "Nhập tên của bạn",
                    func: (value) => ref
                        .read(registerNotifierProvider.notifier)
                        .onFirstNameChange(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //last name text box
                  appTextField(
                    text: "Họ",
                    iconName: ImageRes.user,
                    hintText: "Nhập họ của bạn",
                    func: (value) => ref
                        .read(registerNotifierProvider.notifier)
                        .onLastNameChange(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //username text box
                  appTextField(
                    text: "Tên đăng nhập",
                    iconName: ImageRes.user,
                    hintText: "Nhập tên đăng nhập của bạn",
                    func: (value) => ref
                        .read(registerNotifierProvider.notifier)
                        .onUsernameChange(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //email text box
                  appTextField(
                    text: "Email",
                    iconName:  ImageRes.user,
                    hintText: "Nhập địa chỉ email của bạn",
                    func: (value) => ref
                        .read(registerNotifierProvider.notifier)
                        .onUserEmailChange(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //email text box
                  appTextField(
                    text: "Số điện thoại",
                    iconName:  ImageRes.phone,
                    hintText: "Nhập số điện thoại của bạn",
                    func: (value) => ref
                        .read(registerNotifierProvider.notifier)
                        .onPhoneChange(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //password text box
                  appTextField(
                    text: "Mật khẩu",
                    iconName:  ImageRes.lock,
                    hintText: "Nhập mật khẩu của bạn",
                    obscureText: true,
                    func: (value) => ref
                        .read(registerNotifierProvider.notifier)
                        .onUserPasswordChange(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //password text box
                  appTextField(
                      text: "Xác nhận mật khẩu",
                      iconName:  ImageRes.lock,
                      hintText: "Nhập lại mật khẩu",
                      func: (value) => ref
                          .read(registerNotifierProvider.notifier)
                          .onUserRePasswordChange(value),
                      obscureText: true),
                  SizedBox(
                    height: 20.h,
                  ),
                  //forgot text
                  Container(
                      margin: EdgeInsets.only(left: 25.w),
                      child: const Text14Normal(
                          text:
                          "Bằng cách tạo một tài khoản, bạn đồng ý với các điều khoản và điều kiện của chúng tôi")),
                  SizedBox(
                    height: 100.h,
                  ),

                  Center(
                      child: AppButton(
                          buttonName: "Đăng ký",
                          isLogin: true,
                          context: context,
                          func: () => _controller.handleSignUp()))
                  //app register button
                ],
              ),
            )
                : const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
                color: AppColors.primaryElement,
              ),
            )),
      ),
    );
  }
}

