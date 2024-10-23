import 'dart:convert';

import 'package:courses_app/common/global_loader/global_loader.dart';
import 'package:courses_app/common/utils/constants.dart';
import 'package:courses_app/common/widgets/popup_messages.dart';
import 'package:courses_app/features/sign_in/repo/sign_in_repo.dart';
import 'package:courses_app/global.dart';
import 'package:courses_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sign_in_notifier.dart';

class SignInController {
  // WidgetRef ref;

  SignInController();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleSignIn(WidgetRef ref) async {
    var state = ref.watch(signInNotifierProvider);
    String username = state.username;
    String password = state.password;

    usernameController.text = username;
    passwordController.text = password;

    if (state.username.isEmpty || username.isEmpty) {
      toastInfo("Hãy nhập tên đăng nhập!");
      return;
    }
    if ((state.password.isEmpty) || password.isEmpty) {
      toastInfo("Hãy nhập mật khẩu!");
      return;
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    try {
      asyncPostAllData(username: username, password: password);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    ref.read(appLoaderProvider.notifier).setLoaderValue(false);
  }

  Future<void> asyncPostAllData(
      {required String username, required String password}) async {
    // Gọi đến server để lấy token
    var resToken =
        await SignInRepo.getToken(username: username, password: password);
    print(resToken);
    var token = "";
    if (resToken["statusCode"] == 200) {
      token = resToken["data"]["access_token"];
    } else if (resToken["statusCode"] == 400) {
      toastInfo("Đăng nhập thất bại!.");
    }

    if (token != null && token != "") {
      // Lưu thông tin token vào local storage
      try {
        Global.storageService
            .setString(AppConstants.STORAGE_USER_TOKEN_KEY, token);

        // Lấy thông tin người dùng
        var userRes = await SignInRepo.getUser();
        if (userRes["statusCode"] ==200) {
          Global.storageService.setString(
              AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(userRes["data"]));

          // Chuyển đến trang ứng dụng chính
          navKey.currentState
              ?.pushNamedAndRemoveUntil("/application", (route) => false);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    } else {
      // Hiển thị thông báo lỗi đăng nhập
      toastInfo("Login error");
    }
  }
}
