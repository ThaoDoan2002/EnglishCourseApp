import 'package:courses_app/common/global_loader/global_loader.dart';
import 'package:courses_app/common/widgets/popup_messages.dart';
import 'package:courses_app/features/sign_up/repo/sign_up_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/register_notifier.dart';

class SignUpController {
  final WidgetRef ref;

  SignUpController({required this.ref});

  Future<void> handleSignUp() async {
    var state = ref.read(registerNotifierProvider);

    String fname = state.firstName;
    String lname = state.lastName;
    String email = state.email;
    String phone = state.phone;
    String username = state.username;
    String password = state.password;
    String rePassword = state.rePassword;
    // Regular expression for validating a general email address
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (state.firstName.isEmpty || fname.isEmpty) {
      toastInfo("Bạn chưa nhập tên!");
      return;
    }

    if (state.lastName.isEmpty || lname.isEmpty) {
      toastInfo("Bạn chưa nhập họ!");
      return;
    }

    if (state.username.isEmpty || username.isEmpty) {
      toastInfo("Bạn chưa nhập tên đăng nhập!");
      return;
    }

    if (state.email.isEmpty || email.isEmpty) {
      toastInfo("Bạn chưa nhập địa chỉ email!");
      return;
    }
    if (!emailRegex.hasMatch(state.email) || !emailRegex.hasMatch(email)) {
      toastInfo("Email của bạn không hợp lệ");
      return;
    }
    if (state.phone.isEmpty || phone.isEmpty) {
      toastInfo("Bạn chưa nhập số điện thoại!");
      return;
    }
    if (!RegExp(r'^(03|05|07|08|09)\d{8}$').hasMatch(state.phone)|| !RegExp(r'^(03|05|07|08|09)\d{8}$').hasMatch(phone)) {
      toastInfo("Số điện thoại không hợp lệ!");
      return;
    }

    if ((state.password.isEmpty || state.rePassword.isEmpty) ||
        password.isEmpty ||
        rePassword.isEmpty) {
      toastInfo("Bạn chưa nhập mật khẩu!");
      return;
    }
    if ((state.password != state.rePassword) ||
        password.isEmpty ||
        rePassword.isEmpty) {
      toastInfo("Mật khẩu của bạn không khớp nhau!");
      return;
    }

    var context = Navigator.of(ref.context);
    try {
      // Call the server to register the user
      var response = await SignUpRep.signUpUserOnServer(
        email: email,
        username: username,
        password: password,
        firstName: fname,
        lastName: lname,
        phone: phone,

      );
      print('----------------------------------');
      print(response["statusCode"]);
      if (response["statusCode"] == 201) {
        toastInfo("Đăng ký thành công!");
        context.pop();
      } else if(response["statusCode"]== 400){
        toastInfo("Đăng ký thất bại!.");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    //show the register page
    ref.watch(appLoaderProvider.notifier).setLoaderValue(false);
  }
}
