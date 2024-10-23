import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/services/http_util.dart';

class SignUpRep{

  static Future<UserCredential> firebaseSignUp(String email, String password) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
    return credential;
  }

  static Future<dynamic> signUpUserOnServer({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
  }) async {
    try {
      var data = {
        "email": email,
        "phone": phone,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "username": username
      };
      var response = await HttpUtil().post("/users/", data: data, isFormData: true);
      return response; // Server response after registration
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }
}