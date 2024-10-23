import 'dart:convert';

import 'package:courses_app/common/models/entities.dart';
import 'package:courses_app/common/services/http_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInRepo {
  static Future<UserCredential> firebaseSignIn(
      String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential;
  }

  static Future<dynamic> getToken(
      {required String username, required String password}) async {
    var data = {
      "username": username,
      "password": password,
      "client_id": "OnNASdcLjUQKr7m2r4Z8o5eHJqnsgaAMTWtVB3eW",
      "client_secret":"ucdM4hAIcDL2bXKGz0hPwwRPN3Op6V6ysD4pAXG6Zrs4ZrzKKbdTujfUM79QFOOhafTCnxQLX0OtEJg8z6ZRHrp6q3x21kRxISD3ehHt5OFPf5fGosQT2ixerdzckdkq",
      "grant_type": "password"
    };
    var response = await HttpUtil().post("/o/token/", data: data);
    return response;
  }

  static Future<dynamic> getUser() async {
    var response = await HttpUtil().get(
      "/users/current_user/",
    );
    return response;
  }
}
